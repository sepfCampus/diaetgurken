import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/data/daos/memory/mock_conversation_repository.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/tiles/app_navigation_tile.dart';
import 'package:app/widgets/tiles/app_side_button_tile.dart';
import 'package:app/widgets/tiles/app_standard_tile_card.dart';
import 'package:flutter/material.dart';

class ClientFileWidget extends StatefulWidget
{
  const ClientFileWidget({ super.key });

  @override
  State<ClientFileWidget> createState() => _ClientFileWidgetState();
}

class _ClientFileWidgetState extends State<ClientFileWidget>
{
  late Future<List<Map<String, dynamic>>> _conversationsFuture;

  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();

    final String clientId = (ModalRoute.of(context)?.settings.arguments as String) ?? '?';
    _conversationsFuture = MockConversationRepository.getConversationsForClient(clientId);
  }

  @override
  Widget build(BuildContext context)
  {
    final String clientId = (ModalRoute.of(context)?.settings.arguments as String) ?? '?';
    
    return AppPageScaffold(
      title: 'Klientenakte ($clientId)',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      child: FutureBuilder(
        future: this._conversationsFuture,
        builder: (context, snapshot)
        {
          if(snapshot.connectionState == ConnectionState.waiting)
          {
            return const Center(child: CircularProgressIndicator());
          }

          if(snapshot.hasError)
          {
            return Center(child: Text('Daten konnten nicht geladen werden :('));
          }

          final conversations = snapshot.data ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              AppStandardTileCard(title: clientId),

              AppSpacing.SPACED_BOX_H_LARGE,

              Text('Gespräche:', style: Theme.of(context).textTheme.bodyMedium),

              AppSpacing.SPACED_BOX_H_SMALL,

              ...conversations.map((conversation)
              {
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.SM),
                  child: AppSideButtonTile(
                    title: conversation['datum'] ?? '?',
                    onTap: ()
                    {
                      Navigator.pushNamed(context, Routes.PAGE_CONVERSATION, arguments:
                                          { 'clientId': clientId, 'date': conversation['datum'] ?? '?', 'conversation': conversation });
                    },
                    sideIcon: Icons.download_outlined,
                    onSidePressed: ()
                    {
                      Navigator.pushNamed(context, Routes.PAGE_EXPORT_CONVERSATION, arguments:
                                          { 'clientId': clientId, 'date': conversation['datum'] ?? '?', 'conversation': conversation });
                    }
                  )
                );
              }),

              AppSpacing.SPACED_BOX_H_SMALL,

              AppNavigationTile(
                title: 'Neu',
                trailingIcon: Icons.add,
                onTap: () async
                {
                  final conversations = await _conversationsFuture;

                  final newConversation = MockConversationRepository.createConversation(conversations: conversations, datum: '2026-04-04');

                  Navigator.pushNamed(context, Routes.PAGE_CONVERSATION, arguments: { 'clientId': clientId, 'date': newConversation['datum'], 'conversation': newConversation });
                },
              ),

              AppSpacing.SPACED_BOX_H_LARGE,

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:
                [
                  AppSecondaryButton(
                    buttonText: 'Akte löschen',
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

                    }
                  )
                ]
              )
            ]
          );
        }
      )
    );
  }
}
