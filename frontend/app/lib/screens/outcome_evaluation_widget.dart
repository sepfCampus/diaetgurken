import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/vo/outcome/outcome.dart';
import 'package:app/widgets/forms/buttons/app_notes_button.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/tiles/app_standard_tile_card.dart';
import 'package:flutter/material.dart';

class OutcomeEvaluationWidget extends StatefulWidget
{
  const OutcomeEvaluationWidget({ super.key });

  @override
  State<OutcomeEvaluationWidget> createState() => _OutcomeEvaluationWidgetState();
}

class _OutcomeEvaluationWidgetState extends State<OutcomeEvaluationWidget>
{
  late Map<String, dynamic> _conversation;
  late Outcome _outcome;

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
    _outcome = Outcome.fromJson(_conversation['outcome']);

    _initialized = true;
  }

  @override
  Widget build(BuildContext context)
  {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String clientId = args?['clientId'] ?? '?';
    final String date = args?['date'] ?? _conversation['datum'] ?? '?';

    return AppPageScaffold(
      title: 'Outcome-Evaluation ($clientId) - $date',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      trailing: AppNotesButton(clientId: clientId, date: date),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          ...List.generate(_outcome.elements.length, (index)
          {
            final outcomeGoal = _outcome.elements[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.SM),
              child: AppStandardTileCard(
                title: outcomeGoal.text,
                trailing: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onTap: ()
                {
                  Navigator.pushNamed(context, Routes.PAGE_OUTCOME_EVALUATION_DETAIL,
                    arguments: { 'clientId': clientId, 'date': date, 'conversation': _conversation, 'outcomeIndex': index },
                  ).then((_)
                  {
                    setState(()
                    {
                      _outcome = Outcome.fromJson(_conversation['outcome']);
                    });
                  });
                },
              ),
            );
          }),

          if(_outcome.elements.isEmpty)
            Text(
              'Keine Ziele aus dem letzten Gespräch vorhanden.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

          AppSpacing.SPACED_BOX_H_LARGE,

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:
            [
              AppSecondaryButton(
                buttonText: 'Zurück',
                onPressed: ()
                {
                  _conversation['outcome'] = _outcome.toJson();

                  Navigator.pushReplacementNamed(context, Routes.PAGE_DIAGNOSIS,
                                                 arguments: { 'clientId': clientId, 'date': date, 'conversation': _conversation });
                },
              ),

              AppSpacing.SPACED_BOX_W_SMALL,

              AppPrimaryButton(
                buttonText: 'Zielsetzung →',
                onPressed: ()
                {
                  _conversation['outcome'] = _outcome.toJson();

                  Navigator.pushReplacementNamed(context, Routes.PAGE_GOAL_SETTING,
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
