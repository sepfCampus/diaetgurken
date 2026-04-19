import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/widgets/forms/buttons/app_notes_button.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/tiles/app_standard_tile_card.dart';
import 'package:flutter/material.dart';

class OutcomeEvaluationWidget extends StatelessWidget
{
  const OutcomeEvaluationWidget({ super.key });

  @override
  Widget build(BuildContext context)
  {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String clientId = args?['clientId'] ?? '000009';
    final String date = args?['date'] ?? '14.01.2026';

    return AppPageScaffold(
      title: 'Outcome-Evaluation ($clientId) - $date',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      trailing: AppNotesButton(clientId: clientId, date: date),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          AppStandardTileCard(
            title: 'Reduktion der Kalorienzunahme',
            trailing: Icon(Icons.arrow_forward, color: Theme.of(context).colorScheme.onSurface),
            onTap: ()
            {
              Navigator.pushNamed(
                context,
                Routes.PAGE_OUTCOME_EVALUATION_DETAIL,
                arguments:
                {
                  'clientId': clientId,
                  'date': date,
                  'outcomeTitle': 'Reduktion der Kalorienzunahme'
                }
              );
            },
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          AppStandardTileCard(
            title: 'Reduktion der Fettaufnahme',
            trailing: Icon(
              Icons.arrow_forward,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onTap: ()
            {
              Navigator.pushNamed(
                context,
                Routes.PAGE_OUTCOME_EVALUATION_DETAIL,
                arguments:
                {
                  'clientId': clientId,
                  'date': date,
                  'outcomeTitle': 'Reduktion der Fettaufnahme'
                }
              );
            },
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
                buttonText: 'Zielsetzung →',
                onPressed: ()
                {
                  Navigator.pushNamed(
                    context,
                    Routes.PAGE_GOAL_SETTING,
                    arguments:
                    {
                      'clientId': clientId,
                      'date': date,
                    }
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
