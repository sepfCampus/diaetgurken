import 'package:app/config/layout/app_sizes.dart';
import 'package:app/config/layout/app_spacing.dart';
import 'package:app/vo/assessment/assessment.dart';
import 'package:app/vo/goal/goals.dart';
import 'package:app/vo/goal/intervention_goal.dart';
import 'package:app/vo/goal/sub_goal.dart';
import 'package:app/vo/util/goal_suggestion_util.dart';
import 'package:app/widgets/forms/buttons/app_notes_button.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/sections/app_expandable_section.dart';
import 'package:app/widgets/tiles/app_combo_field.dart';
import 'package:app/widgets/tiles/app_combo_side_button_field.dart';
import 'package:app/widgets/tiles/app_navigation_tile.dart';
import 'package:flutter/material.dart';

class GoalEditorWidget extends StatefulWidget
{
  const GoalEditorWidget({super.key});

  @override
  State<GoalEditorWidget> createState() => _GoalEditorWidgetState();
}

class _GoalEditorWidgetState extends State<GoalEditorWidget>
{
  late Map<String, dynamic> _conversation;
  late InterventionGoal _goal;
  late Goals _goals;
  late Assessment _assessment;

  late TextEditingController _goalTitleController;

  final List<_GoalEntry> _actionGoals = [];
  final List<_GoalEntry> _measureGoals = [];

  bool _initialized = false;

  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();

    if(_initialized)
    {
      return;
    }

    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    _conversation = args?['conversation'] as Map<String, dynamic>;

    _goal = args?['goal'] as InterventionGoal? ?? InterventionGoal();
    _goals = args?['goals'] as Goals;
    _assessment = args?['assessment'] as Assessment? ?? Assessment([]);

    _goalTitleController = TextEditingController(text: _goal.text);

    _actionGoals.addAll(_goal.handlungsziele.map((goal) => _GoalEntry(text: goal.text)));
    _measureGoals.addAll(_goal.massnahmenziele.map((goal) => _GoalEntry(text: goal.text)));

    _initialized = true;
  }

  @override
  void dispose()
  {
    _goalTitleController.dispose();

    for(final goal in _actionGoals)
    {
      goal.dispose();
    }

    for(final goal in _measureGoals)
    {
      goal.dispose();
    }

    super.dispose();
  }

  List<String> _getSuggestions(String key)
  {
    return GoalSuggestionUtil.getSuggestionsToShow(_goals.suggestions[key] ?? [], _assessment);
  }

  void _addActionGoal()
  {
    setState(()
    {
      _actionGoals.add(_GoalEntry());
    });
  }

  void _removeActionGoal(int index)
  {
    setState(() {
      _actionGoals[index].dispose();
      _actionGoals.removeAt(index);
    });
  }

  void _addMeasureGoal()
  {
    setState(() {
      _measureGoals.add(_GoalEntry());
    });
  }

  void _removeMeasureGoal(int index)
  {
    setState(() {
      _measureGoals[index].dispose();
      _measureGoals.removeAt(index);
    });
  }

  InterventionGoal _buildGoalFromUi()
  {
    return InterventionGoal(
      text: _goalTitleController.text,
      handlungsziele: _actionGoals
          .map((entry) => SubGoal(text: entry.controller.text))
          .where((goal) => goal.text.trim().isNotEmpty)
          .toList(),
      massnahmenziele: _measureGoals
          .map((entry) => SubGoal(text: entry.controller.text))
          .where((goal) => goal.text.trim().isNotEmpty)
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String clientId = args?['clientId'] ?? '?';
    final String date = args?['date'] ?? '?';

    return AppPageScaffold(
      title: 'Interventionsziel erstellen ($clientId)',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      trailing: AppNotesButton(conversation: _conversation, clientId: clientId, date: date),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppComboField(
            controller: _goalTitleController,
            options: _getSuggestions('interventionsziele'),
            hintText: 'Interventionsziel ...',
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppExpandableSection(
            title: 'Handlungsziele',
            initiallyExpanded: true,
            child: Column(
              children: [
                ...List.generate(_actionGoals.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.SM),
                    child: AppComboSideButtonField(
                      controller: _actionGoals[index].controller,
                      options: _getSuggestions('handlungsziele'),
                      hintText: 'Handlungsziel ...',
                      sideIcon: Icons.delete_outline,
                      onSidePressed: () {
                        _removeActionGoal(index);
                      },
                    ),
                  );
                }),

                AppNavigationTile(
                  title: 'Neu',
                  trailingIcon: Icons.add,
                  onTap: _addActionGoal,
                ),
              ],
            ),
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          AppExpandableSection(
            title: 'Maßnahmenziele',
            initiallyExpanded: false,
            child: Column(
              children: [
                ...List.generate(_measureGoals.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.SM),
                    child: AppComboSideButtonField(
                      controller: _measureGoals[index].controller,
                      options: _getSuggestions('massnahmenziele'),
                      hintText: 'Maßnahmenziel ...',
                      sideIcon: Icons.delete_outline,
                      onSidePressed: () {
                        _removeMeasureGoal(index);
                      },
                    ),
                  );
                }),

                AppNavigationTile(
                  title: 'Neu',
                  trailingIcon: Icons.add,
                  onTap: _addMeasureGoal,
                ),
              ],
            ),
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          Align(
            alignment: Alignment.centerRight,
            child: AppSecondaryButton(
              buttonText: 'Löschen',
              width: AppSizes.BUTTON_WIDTH_MEDIUM,
              onPressed: ()
              {
                Navigator.pop(context, 'delete');
              },
            ),
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppSecondaryButton(
                buttonText: 'Abbrechen',
                width: AppSizes.BUTTON_WIDTH_MEDIUM,
                onPressed: ()
                {
                  Navigator.pop(context);
                },
              ),

              AppSpacing.SPACED_BOX_W_SMALL,

              AppPrimaryButton(
                buttonText: 'Speichern',
                width: AppSizes.BUTTON_WIDTH_MEDIUM,
                onPressed: ()
                {
                  Navigator.pop(context, _buildGoalFromUi());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GoalEntry {
  final TextEditingController controller;

  _GoalEntry({String text = ''})
      : controller = TextEditingController(text: text);

  void dispose() {
    controller.dispose();
  }
}
