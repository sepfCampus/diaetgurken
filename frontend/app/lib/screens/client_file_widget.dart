import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/service/klienten_akte_http_service.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/tiles/app_navigation_tile.dart';
import 'package:app/widgets/tiles/app_side_button_tile.dart';
import 'package:app/widgets/tiles/app_standard_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/data/daos/memory/mock_conversation_repository.dart';

class ClientFileWidget extends StatefulWidget {
  const ClientFileWidget({super.key});

  @override
  State<ClientFileWidget> createState() => _ClientFileWidgetState();
}

class _ClientFileWidgetState extends State<ClientFileWidget> {
  //late Future<List<Map<String, dynamic>>> _conversationsFuture;
  List<Map<String, dynamic>> _conversations = [];
  bool _isLoading = true;
  String? _errorMessage;
  int? _loadedClientFileId;

  int _getClientFileId(BuildContext context) {
    final argument = ModalRoute.of(context)?.settings.arguments;

    if (argument is int) {
      return argument;
    }

    if (argument is String) {
      return int.tryParse(argument) ?? 0;
    }

    return 0;
  }

  String _formatId(int id) {
    return id.toString().padLeft(4, '0');
  }

  String _formatDate(dynamic rawDate) {
    if (rawDate == null) {
      return 'Kein Datum';
    }

    final date = DateTime.tryParse(rawDate.toString());

    if (date == null) {
      return rawDate.toString();
    }

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day.$month.$year';
  }

  String _toIsoDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  int _readConversationId(Map<String, dynamic> conversation, int index) {
    final rawId = conversation['id'];

    if (rawId is int) {
      return rawId;
    }

    if (rawId is String) {
      return int.tryParse(rawId) ?? index + 1;
    }

    return index + 1;
  }

  List<Map<String, dynamic>> _normalizeConversations(
    List<Map<String, dynamic>> conversations,
  ) {
    return conversations.indexed.map((entry) {
      final index = entry.$1;
      final conversation = entry.$2;

      return {
        ...conversation,
        'id': _readConversationId(conversation, index),
      };
    }).toList();
  }

  Future<void> _loadConversations(int klientenAkteId) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      /*final service = context.read<GespraechHttpService>();
      final conversations = await service.getAll(klientenAkteId: klientenAkteId);*/

      final conversations = await MockConversationRepository.getConversationsForClient("$klientenAkteId");
      
      if(mounted) {
        setState(() => _conversations = _normalizeConversations(conversations));
      }

/*
      if (mounted) {
        setState(() => _conversations = conversations);
    
      }*/
    } catch (e) {
      if (mounted) {
        setState(() => _errorMessage = 'Fehler beim Laden der Gespräche.');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _deleteClientFile(int klientenAkteId) async {
    try {
      final service = context.read<KlientenAkteHttpService>();
      await service.delete(id: klientenAkteId);

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _errorMessage = 'Fehler beim Löschen der Klientenakte.');
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final klientenAkteId = _getClientFileId(context);

    if (klientenAkteId > 0) {
      if (_loadedClientFileId == klientenAkteId) {
        return;
      }

      _loadedClientFileId = klientenAkteId;
      _loadConversations(klientenAkteId);
    } else {
      _isLoading = false;
      _errorMessage = 'Ungültige Klientenakte.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final int klientenAkteId = _getClientFileId(context);
    final String clientId = _formatId(klientenAkteId);

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

          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_errorMessage != null)
            Text(
              _errorMessage!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            )
          else if (_conversations.isEmpty)
            const Text('Noch keine Gespräche vorhanden.')
          else
            ..._conversations.indexed.map((entry) {
              final conversation = entry.$2;
              final int gespraechId = _readConversationId(conversation, entry.$1);
              final String conversationDate = _formatDate(conversation['datum']);

              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.SM),
                child: AppSideButtonTile(
                  title: conversationDate,
                  onTap: () async {
                    await Navigator.pushNamed(
                      context,
                      Routes.PAGE_CONVERSATION,
                      arguments: {
                        'clientId': clientId,
                        'klientenAkteId': klientenAkteId,
                        'gespraechId': gespraechId,
                        'date': conversationDate,
                        'datum': conversation['datum'],
                        'conversation': conversation,
                      },
                    );

                    if (mounted) {
                      _loadConversations(klientenAkteId);
                    }
                  },
                  sideIcon: Icons.download_outlined,
                  onSidePressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.PAGE_EXPORT_CONVERSATION,
                      arguments: {
                        'clientId': clientId,
                        'klientenAkteId': klientenAkteId,
                        'gespraechId': gespraechId,
                        'date': conversationDate,
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
            onTap: () async {
              final datum = _toIsoDate(DateTime.now());
              final conversation = MockConversationRepository.createConversation(
                conversations: _conversations,
                datum: datum,
              );

              await Navigator.pushNamed(
                context,
                Routes.PAGE_CONVERSATION,
                arguments: {
                  'clientId': clientId,
                  'klientenAkteId': klientenAkteId,
                  'date': _formatDate(datum),
                  'datum': datum,
                  'conversation': conversation,
                },
              );

              if (mounted) {
                _loadConversations(klientenAkteId);
              }
            },
          ),

          AppSpacing.SPACED_BOX_H_LARGE,

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppSecondaryButton(
                buttonText: 'Akte löschen',
                onPressed: () {
                  _deleteClientFile(klientenAkteId);
                },
              ),

              AppSpacing.SPACED_BOX_W_SMALL,

              AppPrimaryButton(
                buttonText: 'Zurück',
                onPressed: () {
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
