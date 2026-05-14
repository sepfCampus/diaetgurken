import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/widgets/forms/buttons/app_notes_button.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/tiles/app_navigation_tile.dart';
import 'package:app/widgets/tiles/app_standard_tile_card.dart';
import 'package:flutter/material.dart';

class ConversationWidget extends StatelessWidget
{
  const ConversationWidget({ super.key });

  @override
  Widget build(BuildContext context)
  {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String clientId = args?['clientId'] ?? '?';
    final String date = args?['date'] ?? '?';

    final Map<String, dynamic>? conversation = args?['conversation'];

    return AppPageScaffold(
      title: 'Gespräch ($clientId) - $date',
      drawer: LayoutUtil.getStandardAppDrawer(context),

      trailing: AppNotesButton(clientId: clientId, date: date),

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

          AppStandardTileCard(title: date),

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
                  'date': date,
                  'conversation': conversation
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
                  'date': date,
                  'conversation': conversation
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
                  'date': date,
                  'conversation': conversation
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
                  'date': date,
                  'conversation': conversation
                },
              );
            },
          ),

          AppSpacing.SPACED_BOX_H_LARGE,

          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 16,
            children:
            [
              AppSecondaryButton(
                buttonText: 'Gespräch löschen',
                onPressed: ()
                {
                },
              ),
              AppPrimaryButton(
                buttonText: 'Speichern',
                onPressed: ()
                {
                },
              ),
            ],
          ),
        ]
      )
    );
  }
}
