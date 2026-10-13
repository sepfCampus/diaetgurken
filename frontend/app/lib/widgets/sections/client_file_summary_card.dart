import 'package:app/config/layout/app_spacing.dart';
import 'package:app/vo/client_file_summary.dart';
import 'package:app/widgets/sections/app_section_card.dart';
import 'package:flutter/material.dart';

class ClientFileSummaryCard extends StatelessWidget
{
  final ClientFileSummary summary;

  const ClientFileSummaryCard({ super.key, required this.summary });

  Widget _textSection(BuildContext context, String title, String value)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        AppSpacing.SPACED_BOX_H_EXTRA_SMALL,
        SelectableText(
          value.trim().isEmpty ? 'Keine Angaben dokumentiert.' : value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _listSection(BuildContext context, String title, List<String> values)
  {
    return _textSection(
      context,
      title,
      values.isEmpty ? '' : values.map((value) => '• $value').join('\n'),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    final theme = Theme.of(context);

    return AppSectionCard(
      padding: const EdgeInsets.all(AppSpacing.MD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(summary.reviewRequired) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.fact_check_outlined, color: theme.colorScheme.primary),
                AppSpacing.SPACED_BOX_W_EXTRA_SMALL,
                Expanded(
                  child: Text(
                    'Automatisch erstellter Entwurf. Bitte fachlich prüfen. Die Zusammenfassung wird nicht in der Akte gespeichert.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            AppSpacing.SPACED_BOX_H_MEDIUM,
          ],
          _textSection(context, 'Überblick', summary.summary),
          AppSpacing.SPACED_BOX_H_MEDIUM,
          _textSection(context, 'Entwicklung', summary.development),
          AppSpacing.SPACED_BOX_H_MEDIUM,
          _listSection(context, 'Aktuelle Ziele', summary.currentGoals),
          AppSpacing.SPACED_BOX_H_MEDIUM,
          _listSection(context, 'Offene Punkte', summary.openPoints),
        ],
      ),
    );
  }
}
