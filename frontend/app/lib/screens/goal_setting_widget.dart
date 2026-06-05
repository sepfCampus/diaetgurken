import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/vo/assessment/assessment.dart';
import 'package:app/vo/conversation.dart';
import 'package:app/vo/goal/goals.dart';
import 'package:app/vo/goal/intervention_goal.dart';
import 'package:app/widgets/forms/buttons/app_notes_button.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/tiles/app_navigation_tile.dart';
import 'package:app/widgets/tiles/app_standard_tile_card.dart';
import 'package:flutter/material.dart';

class GoalSettingWidget extends StatefulWidget
{
  const GoalSettingWidget({super.key});

  @override
  State<GoalSettingWidget> createState() => _GoalSettingWidgetState();
}

class _GoalSettingWidgetState extends State<GoalSettingWidget>
{
  late Conversation _conversation;
  late Goals _goals;
  late Assessment _assessment;

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

    _conversation = args?['conversation'] as Conversation;

    _assessment = _conversation.assessment;
    _goals = _conversation.ziele;

    _initialized = true;
  }

  Future<void> _openGoalEditor(int index, String clientId, String date) async
  {
    final result = await Navigator.pushNamed(context, Routes.PAGE_GOAL_EDITOR,
                                             arguments: { 'conversation': _conversation, 'clientId': clientId, 'date': date, 'goal': _goals.elements[index], 'goals': _goals, 'assessment': _assessment });

    if(result is InterventionGoal)
    {
      setState(()
      {
        _goals.elements[index] = result;
        _conversation.ziele = _goals;
      });
    }

    else if(result == 'delete')
    {
      setState(()
      {
        _goals.elements.removeAt(index);
        _conversation.ziele = _goals;
      });
    }
  }

  Future<void> _addGoal(String clientId, String date) async
  {
    final result = await Navigator.pushNamed(context, Routes.PAGE_GOAL_EDITOR,
                                             arguments: { 'conversation': _conversation,  'clientId': clientId, 'date': date, 'goal': InterventionGoal(), 'goals': _goals, 'assessment': _assessment });

    if(result is InterventionGoal)
    {
      setState(()
      {
        _goals.elements.add(result);
        _conversation.ziele = _goals;
      });
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String clientId = args?['clientId'] ?? '?';
    final String date = args?['date'] ?? '?';

    return AppPageScaffold(
      title: 'Zielsetzung ($clientId) - $date',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      trailing: AppNotesButton(conversation: _conversation, clientId: clientId, date: date),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          ...List.generate(_goals.elements.length, (index) {
            final goal = _goals.elements[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.SM),
              child: AppStandardTileCard(
                title: goal.text.trim().isEmpty ? 'Unbenanntes Interventionsziel' : goal.text,
                trailing: Icon(Icons.arrow_forward, color: Theme.of(context).colorScheme.onSurface),
                onTap: ()
                {
                  _openGoalEditor(index, clientId, date);
                }
              )
            );
          }),

          AppNavigationTile(
            title: 'Neu',
            trailingIcon: Icons.add,
            onTap: ()
            {
              _addGoal(clientId, date);
            }
          ),

          AppSpacing.SPACED_BOX_H_LARGE,

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppSecondaryButton(
                buttonText: 'Zurück',
                onPressed: ()
                {
                  _conversation.ziele = _goals;

                  Navigator.pushReplacementNamed(context, Routes.PAGE_OUTCOME_EVALUATION,
                                                 arguments: { 'clientId': clientId, 'date': date, 'conversation': _conversation });
                },
              ),

              AppSpacing.SPACED_BOX_W_SMALL,

              AppPrimaryButton(
                buttonText: 'Abschließen',
                onPressed: ()
                {
                  _conversation.ziele = _goals;

                  Navigator.pushReplacementNamed(context, Routes.PAGE_CONVERSATION,
                                                 arguments: { 'clientId': clientId, 'date': date, 'conversation': _conversation });
                }
              )
            ]
          )
        ]
      )
    );
  }
}
