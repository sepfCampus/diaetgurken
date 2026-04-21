import 'package:app/config/layout/app_sizes.dart';
import 'package:app/config/layout/app_spacing.dart';
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
  const GoalEditorWidget({ super.key });

  @override
  State<GoalEditorWidget> createState() => _GoalEditorWidgetState();
}

class _GoalEditorWidgetState extends State<GoalEditorWidget>
{
  final TextEditingController _goalTitleController = TextEditingController(text: 'Reduktion der Kalorienzunahme');

  final List<String> _goalTitleOptions =
  [
    'Reduktion der Kalorienaufnahme',
    'Reduktion der Fettaufnahme',
    'Steigerung der Proteinzufuhr',
    'Gewichtsstabilisierung',
  ];

  final List<_GoalEntry> _actionGoals =
  [
    _GoalEntry(text: '5 x in der Woche selbst kochen'),
    _GoalEntry(text: 'Täglich 1 x Obst essen'),
  ];

  final List<_GoalEntry> _measureGoals = [];

  final List<String> _actionGoalOptions =
  [
    '5 x in der Woche selbst kochen',
    'Täglich 1 x Obst essen',
    '3 x in der Woche Vollkorn essen',
    '2 Liter Wasser pro Tag trinken',
  ];

  final List<String> _measureGoalOptions =
  [
    'Essensplan vorbereiten',
    'Einkaufsliste schreiben',
    'Portionsgrößen besprechen',
    'Zwischenmahlzeiten planen',
  ];

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

  void _addActionGoal()
  {
    setState(()
    {
      _actionGoals.add(_GoalEntry());
    });
  }

  void _removeActionGoal(int index)
  {
    setState(()
    {
      _actionGoals[index].dispose();
      _actionGoals.removeAt(index);
    });
  }

  void _addMeasureGoal()
  {
    setState(()
    {
      _measureGoals.add(_GoalEntry());
    });
  }

  void _removeMeasureGoal(int index)
  {
    setState(()
    {
      _measureGoals[index].dispose();
      _measureGoals.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context)
  {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String clientId = args?['clientId'] ?? '000009';
    final String date = args?['date'] ?? '14.01.2026';
    final String goalTitle = args?['goalTitle'] ?? 'Reduktion der Kalorienzunahme';

    return AppPageScaffold(
      title: 'Interventionsziel erstellen ($clientId)',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      trailing: AppNotesButton(clientId: clientId, date: date),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          AppComboField(
            controller: _goalTitleController,
            options: _goalTitleOptions,
            hintText: 'Interventionsziel ...',
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppExpandableSection(
            title: 'Handlungsziele',
            initiallyExpanded: true,
            child: Column(
              children:
              [
                ...List.generate(_actionGoals.length, (index)
                {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.SM),
                    child: AppComboSideButtonField(
                      controller: _actionGoals[index].controller,
                      options: _actionGoalOptions,
                      hintText: 'Handlungsziel ...',
                      sideIcon: Icons.delete_outline,
                      onSidePressed: ()
                      {
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
              children:
              [
                ...List.generate(_measureGoals.length, (index)
                {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.SM),
                    child: AppComboSideButtonField(
                      controller: _measureGoals[index].controller,
                      options: _measureGoalOptions,
                      hintText: 'Maßnahmenziel ...',
                      sideIcon: Icons.delete_outline,
                      onSidePressed: ()
                      {
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
                Navigator.pop(context);
              },
            ),
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:
            [
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
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _GoalEntry
{
  final TextEditingController controller;

  _GoalEntry({ String text = '' })
      : controller = TextEditingController(text: text);

  void dispose()
  {
    controller.dispose();
  }
}
