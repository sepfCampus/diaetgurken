import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/service/gespraech_http_service.dart';
import 'package:app/widgets/forms/buttons/app_notes_button.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/sections/app_expandable_section.dart';
import 'package:app/widgets/tiles/app_labeled_side_text_field.dart';
import 'package:app/widgets/tiles/app_navigation_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssessmentWidget extends StatefulWidget
{
  const AssessmentWidget({ super.key });

  @override
  State<AssessmentWidget> createState() => _AssessmentWidgetState();
}

class _AssessmentWidgetState extends State<AssessmentWidget>
{
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();

  bool _didLoad = false;
  bool _isLoading = true;
  bool _isSaving = false;
  String? _errorMessage;

  Map<String, dynamic> _getArguments(BuildContext context)
  {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is Map<String, dynamic>)
    {
      return args;
    }

    return {};
  }

  int? _getIntArgument(Map<String, dynamic> args, String key)
  {
    final value = args[key];

    if (value is int)
    {
      return value;
    }

    if (value is String)
    {
      return int.tryParse(value);
    }

    return null;
  }

  dynamic _fieldValue(String text)
  {
    final cleaned = text.trim();

    if (cleaned.isEmpty)
    {
      return null;
    }

    return num.tryParse(cleaned.replaceAll(',', '.')) ?? cleaned;
  }

  String _valueToText(dynamic value)
  {
    if (value == null)
    {
      return '';
    }

    return value.toString();
  }

  Map<String, dynamic> _buildAssessment()
  {
    return {
      'koerperfunktionUndStruktur': {
        'groesseCm': _fieldValue(_heightController.text),
        'gewichtKg': _fieldValue(_weightController.text),
        'taillenumfangCm': _fieldValue(_waistController.text),
      },
    };
  }

  Future<void> _loadAssessment() async
  {
    final args = _getArguments(context);

    final klientenAkteId = _getIntArgument(args, 'klientenAkteId');
    final gespraechId = _getIntArgument(args, 'gespraechId');

    if (klientenAkteId == null || gespraechId == null)
    {
      setState(()
      {
        _isLoading = false;
        _errorMessage = 'Bitte Gespräch zuerst speichern und erneut öffnen.';
      });
      return;
    }

    setState(()
    {
      _isLoading = true;
      _errorMessage = null;
    });

    try
    {
      final service = context.read<GespraechHttpService>();

      final conversation = await service.getById(
        klientenAkteId: klientenAkteId,
        gespraechId: gespraechId,
      );

      final assessmentRaw = conversation['assessment'];

      if (assessmentRaw is Map)
      {
        final assessment = Map<String, dynamic>.from(assessmentRaw);
        final sectionRaw = assessment['koerperfunktionUndStruktur'];

        if (sectionRaw is Map)
        {
          final section = Map<String, dynamic>.from(sectionRaw);

          _heightController.text = _valueToText(section['groesseCm']);
          _weightController.text = _valueToText(section['gewichtKg']);
          _waistController.text = _valueToText(section['taillenumfangCm']);
        }
      }
    }
    catch (e)
    {
      if (mounted)
      {
        setState(() => _errorMessage = 'Fehler beim Laden des Assessments.');
      }
    }
    finally
    {
      if (mounted)
      {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<bool> _saveAssessment() async
  {
    final args = _getArguments(context);

    final klientenAkteId = _getIntArgument(args, 'klientenAkteId');
    final gespraechId = _getIntArgument(args, 'gespraechId');

    if (klientenAkteId == null || gespraechId == null)
    {
      setState(() => _errorMessage = 'Bitte Gespräch zuerst speichern und erneut öffnen.');
      return false;
    }

    setState(()
    {
      _isSaving = true;
      _errorMessage = null;
    });

    try
    {
      final service = context.read<GespraechHttpService>();

      await service.updateAssessment(
        klientenAkteId: klientenAkteId,
        gespraechId: gespraechId,
        assessment: _buildAssessment(),
      );

      return true;
    }
    catch (e)
    {
      if (mounted)
      {
        setState(() => _errorMessage = 'Fehler beim Speichern des Assessments.');
      }

      return false;
    }
    finally
    {
      if (mounted)
      {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();

    if (!_didLoad)
    {
      _didLoad = true;
      _loadAssessment();
    }
  }

  @override
  void dispose()
  {
    _heightController.dispose();
    _weightController.dispose();
    _waistController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final args = _getArguments(context);

    final String clientId = args['clientId']?.toString() ?? '0000';
    final String date = args['date']?.toString() ?? '';

    return AppPageScaffold(
      title: 'Assessment ($clientId) - $date',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      trailing: AppNotesButton(clientId: clientId, date: date),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          AppNavigationTile(
            title: 'Filter',
            trailingIcon: Icons.filter_alt_outlined,
            onTap: ()
            {
              Navigator.pushNamed(
                context,
                Routes.PAGE_FILTER,
                arguments:
                {
                  'clientId': clientId,
                  'date': date,
                  'klientenAkteId': args['klientenAkteId'],
                  'gespraechId': args['gespraechId'],
                }
              );
            }
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else ...[
            AppExpandableSection(
              title: 'Körperfunktion und -struktur',
              initiallyExpanded: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  AppLabeledSideTextField(
                    label: 'Größe (cm)',
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    sideIcon: Icons.delete_outline,
                    onSidePressed: ()
                    {
                      setState(()
                      {
                        _heightController.clear();
                      });
                    }
                  ),

                  AppSpacing.SPACED_BOX_H_MEDIUM,

                  AppLabeledSideTextField(
                    label: 'Gewicht (kg)',
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    sideIcon: Icons.delete_outline,
                    onSidePressed: ()
                    {
                      setState(()
                      {
                        _weightController.clear();
                      });
                    }
                  ),

                  AppSpacing.SPACED_BOX_H_MEDIUM,

                  AppLabeledSideTextField(
                    label: 'Taillenumfang (cm)',
                    controller: _waistController,
                    keyboardType: TextInputType.number,
                    sideIcon: Icons.delete_outline,
                    onSidePressed: ()
                    {
                      setState(()
                      {
                        _waistController.clear();
                      });
                    }
                  )
                ]
              )
            ),

            AppSpacing.SPACED_BOX_H_MEDIUM,

            AppExpandableSection(
              title: 'Aktivitäten',
              initiallyExpanded: false,
              child: const SizedBox.shrink(),
            ),

            AppSpacing.SPACED_BOX_H_SMALL,

            AppExpandableSection(
              title: 'Partizipation',
              initiallyExpanded: false,
              child: const SizedBox.shrink(),
            ),

            AppSpacing.SPACED_BOX_H_SMALL,

            AppExpandableSection(
              title: 'Umweltfaktoren',
              initiallyExpanded: false,
              child: const SizedBox.shrink(),
            ),

            AppSpacing.SPACED_BOX_H_SMALL,

            AppExpandableSection(
              title: 'personenbez. Faktoren',
              initiallyExpanded: false,
              child: const SizedBox.shrink(),
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
                  buttonText: 'Abbrechen',
                  onPressed: ()
                  {
                    Navigator.pop(context);
                  },
                ),

                AppSpacing.SPACED_BOX_W_SMALL,

                _isSaving
                  ? const CircularProgressIndicator()
                  : AppPrimaryButton(
                      buttonText: 'Diagnose →',
                      onPressed: () async
                      {
                        final saved = await _saveAssessment();

                        if (!saved || !mounted)
                        {
                          return;
                        }

                        Navigator.pushNamed(
                          context,
                          Routes.PAGE_DIAGNOSIS,
                          arguments:
                          {
                            'clientId': clientId,
                            'date': date,
                            'klientenAkteId': args['klientenAkteId'],
                            'gespraechId': args['gespraechId'],
                          }
                        );
                      }
                    )
              ]
            )
          ],
        ]
      )
    );
  }
}