import 'package:app/config/layout/app_spacing.dart';
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
  final TextEditingController _notesController = TextEditingController(text: 'Klient möchte Gewicht um mindestens 10 kg verringern\n\nsehr engagiert');

  @override
  void dispose()
  {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String clientId = args?['clientId'] ?? '000009';
    final String date = args?['date'] ?? '01.01.2026';

    return AppPageScaffold(
      title: 'Notizen ($clientId) $date',
      drawer: LayoutUtil.getStandardAppDrawer(context),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          //Text area
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

          // BUTTONS
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
                  
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
