import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/service/conversation_service.dart';
import 'package:app/vo/conversation.dart';
import 'package:app/widgets/forms/app_labeled_field.dart';
import 'package:app/widgets/forms/buttons/app_notes_button.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/tiles/app_navigation_tile.dart';
import 'package:app/widgets/tiles/app_standard_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationWidget extends StatefulWidget
{
  const ConversationWidget({ super.key });

  @override
  State<ConversationWidget> createState() => _ConversationWidgetState();
}

class _ConversationWidgetState extends State<ConversationWidget>
{
  late Conversation _conversation;
  late TextEditingController _dateController;

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

    _dateController = TextEditingController(text: _conversation.datum);

    _initialized = true;
  }

  @override
  void dispose()
  {
    _dateController.dispose();
    super.dispose();
  }

  Conversation _buildConversationFromUi()
  {
    return Conversation(
      _conversation.id,
      _dateController.text,
      _conversation.formMetaData,
      _conversation.assessment,
      _conversation.diagnosen,
      _conversation.ziele,
      _conversation.outcome,
      _conversation.notizen,
      _conversation.selectedFilters,
    );
  }

  Future<void> _openPage(BuildContext context, String route, String clientId, int klientenAkteId) async
  {
    _conversation = _buildConversationFromUi();

    final result = await Navigator.pushNamed(
      context,
      route,
      arguments:
      {
        'clientId': clientId,
        'klientenAkteId': klientenAkteId,
        'date': _conversation.datum,
        'conversation': _conversation,
      },
    );

    if(result is Conversation)
    {
      setState(()
      {
        _conversation = result;
        _dateController.text = _conversation.datum;
      });
    }

    else
    {
      setState(() {});
    }
  }

  Future<void> _deleteConversation(BuildContext context, int klientenAkteId) async
  {
    final ConversationService conversationService = context.read<ConversationService>();

    await conversationService.delete(klientenAkteId, _conversation.id);

    if(!context.mounted)
    {
      return;
    }

    Navigator.pop(
      context,
      {
        'deletedConversation': _conversation,
      },
    );
  }

  Future<void> _saveConversation(BuildContext context, int klientenAkteId) async
  {
    final ConversationService conversationService = context.read<ConversationService>();

    _conversation = _buildConversationFromUi();

    final updatedConversation = await conversationService.update(_conversation, klientenAkteId);

    if(!context.mounted)
    {
      return;
    }

    Navigator.pop(context, updatedConversation);
  }

  @override
  Widget build(BuildContext context)
  {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String clientId = args?['clientId'] ?? '?';
    final int klientenAkteId = args?['klientenAkteId'] ?? 0;

    return AppPageScaffold(
      title: 'Gespräch ($clientId) - ${_dateController.text}',
      drawer: LayoutUtil.getStandardAppDrawer(context),

      trailing: AppNotesButton(
        conversation: _conversation,
        clientId: clientId,
        date: _dateController.text,
      ),

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

          AppLabeledField(
            label: 'Datum',
            controller: _dateController,
            keyboardType: TextInputType.datetime,
            onChanged: (value)
            {
              setState(() {});
            },
          ),

          AppSpacing.SPACED_BOX_H_LARGE,

          AppNavigationTile(
            title: 'Assessment',
            onTap: ()
            {
              _openPage(context, Routes.PAGE_ASSESSMENT, clientId, klientenAkteId);
            },
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppNavigationTile(
            title: 'Diagnose',
            onTap: ()
            {
              _openPage(context, Routes.PAGE_DIAGNOSIS, clientId, klientenAkteId);
            },
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppNavigationTile(
            title: 'Outcome-Evaluation',
            onTap: ()
            {
              _openPage(context, Routes.PAGE_OUTCOME_EVALUATION, clientId, klientenAkteId);
            },
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppNavigationTile(
            title: 'Zielsetzung',
            onTap: ()
            {
              _openPage(context, Routes.PAGE_GOAL_SETTING, clientId, klientenAkteId);
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
                  _deleteConversation(context, klientenAkteId);
                },
              ),

              AppPrimaryButton(
                buttonText: 'Speichern',
                onPressed: ()
                {
                  _saveConversation(context, klientenAkteId);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
