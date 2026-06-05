import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/service/client_file_service.dart';
import 'package:app/service/conversation_service.dart';
import 'package:app/vo/conversation.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/tiles/app_navigation_tile.dart';
import 'package:app/widgets/tiles/app_side_button_tile.dart';
import 'package:app/widgets/tiles/app_standard_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientFileWidget extends StatefulWidget
{
  const ClientFileWidget({ super.key });

  @override
  State<ClientFileWidget> createState() => _ClientFileWidgetState();
}

class _ClientFileWidgetState extends State<ClientFileWidget>
{
  List<Conversation> _conversations = [];

  bool _isLoading = true;
  String? _errorMessage;
  int? _loadedClientFileId;

  int _getClientFileId(BuildContext context)
  {
    final argument = ModalRoute.of(context)?.settings.arguments;

    if(argument is int)
    {
      return argument;
    }

    if(argument is String)
    {
      return int.tryParse(argument) ?? 0;
    }

    return 0;
  }

  String _formatId(int id)
  {
    return id.toString().padLeft(4, '0');
  }

  String _formatDate(String rawDate)
  {
    final date = DateTime.tryParse(rawDate);

    if(date == null)
    {
      return rawDate;
    }

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day.$month.$year';
  }

  String _toIsoDate(DateTime date)
  {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  Future<void> _loadConversations(int klientenAkteId) async
  {
    setState(()
    {
      _isLoading = true;
      _errorMessage = null;
    });

    try
    {
      final conversationService = context.read<ConversationService>();
     
      final conversations = await conversationService.getAll(klientenAkteId);

      if(mounted)
      {
        setState(()
        {
          _conversations = conversations;
        });
      }
    }

    catch(e)
    {
      if(mounted)
      {
        setState(()
        {
          _errorMessage = 'Fehler beim Laden der Gespräche.';
        });
      }
    }

    finally
    {
      if(mounted)
      {
        setState(()
        {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _deleteClientFile(int klientenAkteId) async
  {
    try
    {
      final clientFileService = context.read<ClientFileService>();

      await clientFileService.delete(klientenAkteId);

      if(mounted)
      {
        Navigator.pop(context, true);
      }
    }

    catch(e)
    {
      if(mounted)
      {
        setState(()
        {
          _errorMessage = 'Fehler beim Löschen der Klientenakte.';
        });
      }
    }
  }

  Future<void> _openConversation(int klientenAkteId, String clientId, Conversation conversation) async
  {
    final result = await Navigator.pushNamed(
      context,
      Routes.PAGE_CONVERSATION,
      arguments:
      {
        'clientId': clientId,
        'klientenAkteId': klientenAkteId,
        'gespraechId': conversation.id,
        'date': _formatDate(conversation.datum),
        'datum': conversation.datum,
        'conversation': conversation,
      },
    );

    if(result is Conversation)
    {
      setState(()
      {
        final index = _conversations.indexWhere((existingConversation)
        {
          return existingConversation.id == result.id;
        });

        if(index >= 0)
        {
          _conversations[index] = result;
        }
      });
    }

    else if(result is Map<String, dynamic> && result['deletedConversation'] is Conversation)
    {
      final deletedConversation = result['deletedConversation'] as Conversation;

      setState(()
      {
        _conversations.removeWhere((conversation)
        {
          return conversation.id == deletedConversation.id;
        });
      });
    }

    if(mounted)
    {
      _loadConversations(klientenAkteId);
    }
  }

  Future<void> _createConversation(int klientenAkteId, String clientId) async
  {
    try
    {
      final conversationService = context.read<ConversationService>();

      final datum = _toIsoDate(DateTime.now());

      final conversation = await conversationService.create(
        klientenAkteId,
        datum,
      );

      if(mounted)
      {
        setState(()
        {
          _conversations.add(conversation);
        });
      }

      await _openConversation(
        klientenAkteId,
        clientId,
        conversation,
      );
    }

    catch(e)
    {
      if(mounted)
      {
        setState(()
        {
          _errorMessage = 'Fehler beim Erstellen des Gesprächs.';
        });
      }
    }
  }

  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();

    final klientenAkteId = _getClientFileId(context);

    if(klientenAkteId > 0)
    {
      if(_loadedClientFileId == klientenAkteId)
      {
        return;
      }

      _loadedClientFileId = klientenAkteId;
      _loadConversations(klientenAkteId);
    }

    else
    {
      _isLoading = false;
      _errorMessage = 'Ungültige Klientenakte.';
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final int klientenAkteId = _getClientFileId(context);
    final String clientId = _formatId(klientenAkteId);

    return AppPageScaffold(
      title: 'Klientenakte ($clientId)',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          AppStandardTileCard(title: clientId),

          AppSpacing.SPACED_BOX_H_LARGE,

          Text(
            'Gespräche:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          if(_isLoading)
            const Center(child: CircularProgressIndicator())

          else if(_errorMessage != null)
            Text(
              _errorMessage!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            )

          else if(_conversations.isEmpty)
            const Text('Noch keine Gespräche vorhanden.')

          else
            ..._conversations.map((conversation)
            {
              final String conversationDate = _formatDate(conversation.datum);

              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.SM),
                child: AppSideButtonTile(
                  title: conversationDate,
                  onTap: ()
                  {
                    _openConversation(
                      klientenAkteId,
                      clientId,
                      conversation,
                    );
                  },
                  sideIcon: Icons.download_outlined,
                  onSidePressed: ()
                  {
                    Navigator.pushNamed(
                      context,
                      Routes.PAGE_EXPORT_CONVERSATION,
                      arguments:
                      {
                        'clientId': clientId,
                        'klientenAkteId': klientenAkteId,
                        'gespraechId': conversation.id,
                        'date': conversationDate,
                        'conversation': conversation,
                      },
                    );
                  },
                ),
              );
            }),

          AppSpacing.SPACED_BOX_H_SMALL,

          AppNavigationTile(
            title: 'Neu',
            trailingIcon: Icons.add,
            onTap: ()
            {
              _createConversation(
                klientenAkteId,
                clientId,
              );
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
                  _deleteClientFile(klientenAkteId);
                },
              ),

              AppSpacing.SPACED_BOX_W_SMALL,

              AppPrimaryButton(
                buttonText: 'Zurück',
                onPressed: ()
                {
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
