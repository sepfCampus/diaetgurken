import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/service/gespraech_http_service.dart';
import 'package:app/widgets/forms/buttons/app_notes_button.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/tiles/app_navigation_tile.dart';
import 'package:app/widgets/tiles/app_standard_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationWidget extends StatefulWidget {
  const ConversationWidget({ super.key });

  @override
  State<ConversationWidget> createState() => _ConversationWidgetState();
}

class _ConversationWidgetState extends State<ConversationWidget> {
  bool _isSaving = false;
  String? _errorMessage;
  DateTime? _selectedDate;

  Map<String, dynamic> _getArguments(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is Map<String, dynamic>) {
      return args;
    }

    return {};
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day.$month.$year';
  }

  String _toIsoDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  DateTime _initialDateFromArguments(Map<String, dynamic> args) {
    final rawDatum = args['datum'];

    if (rawDatum != null) {
      final parsed = DateTime.tryParse(rawDatum.toString());

      if (parsed != null) {
        return parsed;
      }
    }

    return DateTime.now();
  }

  Future<void> _pickDate() async {
    final currentDate = _selectedDate ?? DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _save() async {
    final args = _getArguments(context);
    final int? klientenAkteId = args['klientenAkteId'] as int?;
    final int? gespraechId = args['gespraechId'] as int?;
    final date = _selectedDate ?? _initialDateFromArguments(args);

    if (klientenAkteId == null || klientenAkteId <= 0) {
      setState(() => _errorMessage = 'Ungültige Klientenakte.');
      return;
    }

    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      final service = context.read<GespraechHttpService>();

      if (gespraechId == null) {
        await service.create(
          klientenAkteId: klientenAkteId,
          datum: _toIsoDate(date),
        );
      } else {
        await service.update(
          klientenAkteId: klientenAkteId,
          gespraechId: gespraechId,
          datum: _toIsoDate(date),
        );
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _errorMessage = 'Fehler beim Speichern des Gesprächs.');
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _delete() async {
    final args = _getArguments(context);
    final int? klientenAkteId = args['klientenAkteId'] as int?;
    final int? gespraechId = args['gespraechId'] as int?;

    if (klientenAkteId == null || gespraechId == null) {
      Navigator.pop(context);
      return;
    }

    try {
      final service = context.read<GespraechHttpService>();

      await service.delete(
        klientenAkteId: klientenAkteId,
        gespraechId: gespraechId,
      );

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _errorMessage = 'Fehler beim Löschen des Gesprächs.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = _getArguments(context);

    final String clientId = args['clientId']?.toString() ?? '0000';
    final int? gespraechId = args['gespraechId'] as int?;
    final DateTime date = _selectedDate ?? _initialDateFromArguments(args);
    final String formattedDate = _formatDate(date);

    return AppPageScaffold(
      title: 'Gespräch ($clientId) - $formattedDate',
      drawer: LayoutUtil.getStandardAppDrawer(context),

      trailing: AppNotesButton(clientId: clientId, date: formattedDate),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Text(
            'Klient/in:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          AppStandardTileCard(title: clientId),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          Text('Datum', style: Theme.of(context).textTheme.bodyMedium),

          AppSpacing.SPACED_BOX_H_SMALL,

          AppStandardTileCard(
            title: formattedDate,
            onTap: _pickDate,
          ),

          AppSpacing.SPACED_BOX_H_LARGE,

          AppNavigationTile(
            title: 'Assessment',
            onTap: ()
            {
              Navigator.pushNamed(
                context,
                Routes.PAGE_ASSESSMENT,
                arguments:
                {
                  'clientId': clientId,
                  'date': formattedDate,
                  'gespraechId': gespraechId,
                },
              );
            },
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppNavigationTile(
            title: 'Diagnose',
            onTap: ()
            {
              Navigator.pushNamed(
                context,
                Routes.PAGE_DIAGNOSIS,
                arguments:
                {
                  'clientId': clientId,
                  'date': formattedDate,
                  'gespraechId': gespraechId,
                },
              );
            },
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppNavigationTile(
            title: 'Outcome-Evaluation',
            onTap: ()
            {
              Navigator.pushNamed(
                context,
                Routes.PAGE_OUTCOME_EVALUATION,
                arguments:
                {
                  'clientId': clientId,
                  'date': formattedDate,
                  'gespraechId': gespraechId,
                },
              );
            },
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppNavigationTile(
            title: 'Zielsetzung',
            onTap: ()
            {
              Navigator.pushNamed(
                context,
                Routes.PAGE_GOAL_SETTING,
                arguments:
                {
                  'clientId': clientId,
                  'date': formattedDate,
                  'gespraechId': gespraechId,
                },
              );
            },
          ),

          if (_errorMessage != null) ...[
            AppSpacing.SPACED_BOX_H_LARGE,
            Text(
              _errorMessage!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],

          AppSpacing.SPACED_BOX_H_LARGE,

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:
            [
              AppSecondaryButton(
                buttonText: 'Gespräch löschen',
                onPressed: _delete,
              ),

              AppSpacing.SPACED_BOX_W_SMALL,

              _isSaving
                ? const CircularProgressIndicator()
                : AppPrimaryButton(
                    buttonText: 'Speichern',
                    onPressed: _save,
                  ),
            ]
          )
        ]
      )
    );
  }
}