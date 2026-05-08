import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/tiles/app_navigation_tile.dart';
import 'package:app/widgets/tiles/app_side_button_tile.dart';
import 'package:app/widgets/tiles/app_standard_tile_card.dart';
import 'package:flutter/material.dart';

class ClientFileWidget extends StatefulWidget {
  const ClientFileWidget({super.key});

  @override
  State<ClientFileWidget> createState() => _ClientFileWidgetState();
}

class _ClientFileWidgetState extends State<ClientFileWidget> {
  final List<String> _conversations = [
    '01.01.2026',
    '14.01.2026',
    '20.02.2026',
  ];

  String _formatId(String rawId)
  {
    final id = int.tryParse(rawId) ?? 0;
    return id.toString().padLeft(4, '0');
  }

  @override
  Widget build(BuildContext context) {
    final String rawId =
        (ModalRoute.of(context)?.settings.arguments as String?) ?? '0';
    final String clientId = _formatId(rawId);

    return AppPageScaffold(
      title: 'Klientenakte ($clientId)',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppStandardTileCard(title: clientId),

          AppSpacing.SPACED_BOX_H_LARGE,

          Text('Gespräche:', style: Theme.of(context).textTheme.bodyMedium),

          AppSpacing.SPACED_BOX_H_SMALL,

          ..._conversations.map((conversationDate) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.SM),
              child: AppSideButtonTile(
                title: conversationDate,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.PAGE_CONVERSATION,
                    arguments: {'clientId': clientId, 'date': conversationDate},
                  );
                },
                sideIcon: Icons.download_outlined,
                onSidePressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.PAGE_EXPORT_CONVERSATION,
                    arguments: {'clientId': clientId, 'date': conversationDate},
                  );
                },
              ),
            );
          }),

          AppSpacing.SPACED_BOX_H_SMALL,

          AppNavigationTile(
            title: 'Neu',
            trailingIcon: Icons.add,
            onTap: () {
              Navigator.pushNamed(context, Routes.PAGE_HOME);
            },
          ),

          AppSpacing.SPACED_BOX_H_LARGE,

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppSecondaryButton(
                buttonText: 'Akte löschen',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              AppSpacing.SPACED_BOX_W_SMALL,

              AppPrimaryButton(buttonText: 'Speichern', onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}