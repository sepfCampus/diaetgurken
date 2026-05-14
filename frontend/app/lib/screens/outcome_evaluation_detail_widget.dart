import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/vo/outcome/outcome.dart';
import 'package:app/vo/outcome/outcome_goal.dart';
import 'package:app/vo/outcome/outcome_sub_goal.dart';
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
  late Map<String, dynamic> _conversation;
  late Outcome _outcome;
  late OutcomeGoal _outcomeGoal;
  late int _outcomeIndex;

  late TextEditingController _interventionNoteController;

  final List<_GoalEvaluationEntry> _actionGoals = [];
  final List<_GoalEvaluationEntry> _measureGoals = [];

  bool _initialized = false;

  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();

    if(_initialized)
    {
      return;
    }

    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    _conversation = args?['conversation'] as Map<String, dynamic>;
    _outcomeIndex = args?['outcomeIndex'] ?? 0;

    _outcome = Outcome.fromJson(_conversation['outcome']);
    _outcomeGoal = _outcome.elements[_outcomeIndex];

    _interventionNoteController = TextEditingController(text: _outcomeGoal.note);

    _actionGoals.addAll(_outcomeGoal.handlungsziele.map((goal) => _GoalEvaluationEntry.fromOutcomeSubGoal(goal)));
    _measureGoals.addAll(_outcomeGoal.massnahmenziele.map((goal) => _GoalEvaluationEntry.fromOutcomeSubGoal(goal),));

    _initialized = true;
  }

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

  void _saveToConversation()
  {
    _outcomeGoal.note = _interventionNoteController.text;

    _outcomeGoal.handlungsziele = _actionGoals.map((entry)
    {
      return OutcomeSubGoal(text: entry.title, success: entry.progress, note: entry.noteController.text);
    }).toList();

    _outcomeGoal.massnahmenziele = _measureGoals.map((entry)
    {
      return OutcomeSubGoal(text: entry.title, success: entry.progress, note: entry.noteController.text);
    }).toList();

    _outcome.elements[_outcomeIndex] = _outcomeGoal;
    _conversation['outcome'] = _outcome.toJson();
  }

  @override
  Widget build(BuildContext context)
  {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String clientId = args?['clientId'] ?? '000009';
    final String date = args?['date'] ?? _conversation['datum'] ?? '14.01.2026';

    return AppPageScaffold(
      title: 'Outcome-Evaluation ($clientId)',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      trailing: AppNotesButton(clientId: clientId, date: date),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          AppStandardTileCard(title: _outcomeGoal.text),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          Text(
            'Interventionsziel erreicht?',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),

          AppSpacing.SPACED_BOX_H_EXTRA_SMALL,

          _ProgressSlider(
            value: _outcomeGoal.success,
            onChanged: (value)
            {
              setState(()
              {
                _outcomeGoal.success = value;
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
                  _saveToConversation();

                  Navigator.pushNamed(
                    context,
                    Routes.PAGE_OUTCOME_EVALUATION,
                    arguments:
                    {
                      'clientId': clientId,
                      'date': date,
                      'conversation': _conversation,
                    },
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

  const _GoalEvaluationCard({
    required this.entry,
    required this.questionLabel,
    this.onChanged,
  });

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
          ),
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

  const _ProgressSlider({
    required this.value,
    required this.onChanged,
  });

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

  factory _GoalEvaluationEntry.fromOutcomeSubGoal(OutcomeSubGoal goal)
  {
    return _GoalEvaluationEntry(title: goal.text, progress: goal.success, note: goal.note);
  }

  void dispose()
  {
    noteController.dispose();
  }
}
