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

class GoalSettingWidget extends StatelessWidget
{
  const GoalSettingWidget({ super.key });

  @override
  Widget build(BuildContext context)
  {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String clientId = args?['clientId'] ?? '000009';
    final String date = args?['date'] ?? '14.01.2026';

    final List<String> goals =
    [
      'Reduktion der Kalorienzunahme',
    ];

    return AppPageScaffold(
      title: 'Zielsetzung ($clientId) - $date',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      trailing: AppNotesButton(clientId: clientId, date: date),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          ...List.generate(goals.length, (index)
          {
            return Padding(
              padding: EdgeInsets.only(
                bottom: AppSpacing.SM,
              ),
              child: AppStandardTileCard(
                title: goals[index],
                trailing: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onTap: ()
                {
                  Navigator.pushNamed(
                    context,
                    Routes.PAGE_GOAL_EDITOR,
                    arguments:
                    {
                      'clientId': clientId,
                      'date': date,
                      'goalTitle': goals[index],
                    }
                  );
                }
              )
            );
          }),

          AppNavigationTile(
            title: 'Neu',
            trailingIcon: Icons.add,
            onTap: ()
            {
              Navigator.pushNamed(
                context,
                Routes.PAGE_GOAL_EDITOR,
                arguments:
                {
                  'clientId': clientId,
                  'date': date,
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
                buttonText: 'Speichern',
                onPressed: ()
                {
                  Navigator.pushNamed(
                    context,
                    Routes.PAGE_CLIENT_FILE,
                    arguments: clientId,
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
