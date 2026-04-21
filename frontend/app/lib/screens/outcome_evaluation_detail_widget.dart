import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/widgets/forms/app_labeled_field.dart';
import 'package:app/widgets/forms/buttons/app_notes_button.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/sections/app_expandable_section.dart';
import 'package:app/widgets/tiles/app_standard_tile_card.dart';
import 'package:flutter/material.dart';

class OutcomeEvaluationDetailWidget extends StatefulWidget
{
  const OutcomeEvaluationDetailWidget({ super.key });

  @override
  State<OutcomeEvaluationDetailWidget> createState() => _OutcomeEvaluationDetailWidgetState();
}

class _OutcomeEvaluationDetailWidgetState extends State<OutcomeEvaluationDetailWidget>
{
  double _interventionProgress = 55;

  final TextEditingController _interventionNoteController = TextEditingController();

  final List<_GoalEvaluationEntry> _actionGoals =
  [
    _GoalEvaluationEntry(
      title: '4 x in der Woche selbst kochen',
      progress: 40,
    ),

    _GoalEvaluationEntry(
      title: 'Täglich 2 x Gemüse essen',
      progress: 40,
    ),
  ];

  final List<_GoalEvaluationEntry> _measureGoals =
  [
    _GoalEvaluationEntry(
      title: 'Wöchentlichen Essensplan erstellen',
      progress: 20,
    ),

    _GoalEvaluationEntry(
      title: 'Einkaufsliste vorbereiten',
      progress: 60,
    ),
  ];

  @override
  void dispose()
  {
    _interventionNoteController.dispose();

    for(final entry in _actionGoals)
    {
      entry.dispose();
    }

    for(final entry in _measureGoals)
    {
      entry.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String clientId = args?['clientId'] ?? '000009';
    final String date = args?['date'] ?? '14.01.2026';
    final String outcomeTitle = args?['outcomeTitle'] ?? 'Reduktion der Kalorienzunahme';

    return AppPageScaffold(
      title: 'Outcome-Evaluation ($clientId)',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      trailing: AppNotesButton(clientId: clientId, date: date),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          AppStandardTileCard(title: outcomeTitle),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          Text(
            'Interventionsziel erreicht?',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),

          AppSpacing.SPACED_BOX_H_EXTRA_SMALL,

          _ProgressSlider(
            value: _interventionProgress,
            onChanged: (value)
            {
              setState(()
              {
                _interventionProgress = value;
              });
            },
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          AppLabeledField(
            label: 'Notiz',
            controller: _interventionNoteController,
            maxLines: 2,
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppExpandableSection(
            title: 'Handlungsziele',
            initiallyExpanded: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                ...List.generate(_actionGoals.length, (index)
                {
                  final _GoalEvaluationEntry entry = _actionGoals[index];

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == _actionGoals.length - 1 ? 0 : AppSpacing.MD,
                    ),
                    child: _GoalEvaluationCard(
                      entry: entry,
                      questionLabel: 'Handlungsziel erreicht?',
                      onChanged: ()
                      {
                        setState(() {});
                      },
                    ),
                  );
                }),
              ],
            ),
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppExpandableSection(
            title: 'Maßnahmenziele',
            initiallyExpanded: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                ...List.generate(_measureGoals.length, (index)
                {
                  final _GoalEvaluationEntry entry = _measureGoals[index];

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == _measureGoals.length - 1 ? 0 : AppSpacing.MD,
                    ),
                    child: _GoalEvaluationCard(
                      entry: entry,
                      questionLabel: 'Maßnahmenziel erreicht?',
                      onChanged: ()
                      {
                        setState(() {});
                      },
                    ),
                  );
                }),
              ],
            ),
          ),

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

              AppPrimaryButton(
                buttonText: 'Speichern',
                onPressed: ()
                {
                  Navigator.pushNamed(
                    context,
                    Routes.PAGE_OUTCOME_EVALUATION,
                    arguments:
                    {
                      'clientId': clientId,
                      'date': date,
                    }
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GoalEvaluationCard extends StatelessWidget
{
  final _GoalEvaluationEntry entry;
  final String questionLabel;
  final VoidCallback? onChanged;

  const _GoalEvaluationCard({ required this.entry, required this.questionLabel, this.onChanged});

  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        AppStandardTileCard(title: entry.title),

        AppSpacing.SPACED_BOX_H_SMALL,

        Text(
          questionLabel,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          )
        ),

        AppSpacing.SPACED_BOX_H_EXTRA_SMALL,

        _ProgressSlider(
          value: entry.progress,
          onChanged: (value)
          {
            entry.progress = value;

            if(onChanged != null)
            {
              onChanged!();
            }
          },
        ),

        AppSpacing.SPACED_BOX_H_SMALL,

        AppLabeledField(
          label: 'Notiz',
          controller: entry.noteController,
          maxLines: 2,
        ),
      ],
    );
  }
}

class _ProgressSlider extends StatelessWidget
{
  final double value;
  final ValueChanged<double> onChanged;

  const _ProgressSlider({ required this.value, required this.onChanged });

  @override
  Widget build(BuildContext context)
  {
    final ThemeData theme = Theme.of(context);

    return Row(
      children:
      [
        Text(
          '0 %',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),

        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 14,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
              activeTrackColor: theme.colorScheme.primary,
              inactiveTrackColor: theme.colorScheme.secondary.withOpacity(0.5),
              thumbColor: theme.colorScheme.primary,
              overlayColor: theme.colorScheme.primary.withOpacity(0.12),
            ),
            child: Slider(
              value: value,
              min: 0,
              max: 100,
              onChanged: onChanged,
            ),
          ),
        ),

        Text(
          '100 %',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _GoalEvaluationEntry
{
  final String title;
  double progress;
  final TextEditingController noteController;

  _GoalEvaluationEntry({ required this.title, required this.progress, String note = '' }) : noteController = TextEditingController(text: note);

  void dispose()
  {
    noteController.dispose();
  }
}
