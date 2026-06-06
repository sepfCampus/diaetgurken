import 'package:app/config/layout/app_spacing.dart';
import 'package:app/vo/conversation.dart';
import 'package:app/vo/util/formatter.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:flutter/material.dart';

class ConversationNotesWidget extends StatefulWidget
{
  const ConversationNotesWidget({ super.key });

  @override
  State<ConversationNotesWidget> createState() => _ConversationNotesWidgetState();
}

class _ConversationNotesWidgetState extends State<ConversationNotesWidget>
{
  late Conversation _conversation;
  late TextEditingController _notesController;

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

    _notesController = TextEditingController(
      text: _conversation.notizen,
    );

    _initialized = true;
  }

  @override
  void dispose()
  {
    _notesController.dispose();
    super.dispose();
  }

  void _saveNotes()
  {
    _conversation.notizen = _notesController.text;
  }

  @override
  Widget build(BuildContext context)
  {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final int clientId = args?['clientId'] ?? -1;
    final String date = args?['date'] ?? _conversation.datum ?? '?';

    return AppPageScaffold(
      title: 'Notizen (${Formatter.formatClientId(clientId)}) $date',
      drawer: LayoutUtil.getStandardAppDrawer(context),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Container(
            height: 350,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextField(
              controller: _notesController,
              maxLines: null,
              expands: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
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
                  _saveNotes();

                  Navigator.pop(
                    context,
                    _conversation,
                  );
                },
              ),

              AppSpacing.SPACED_BOX_W_SMALL,

              AppPrimaryButton(
                buttonText: 'Speichern',
                onPressed: ()
                {
                  _saveNotes();

                  Navigator.pop(
                    context,
                    _conversation,
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}