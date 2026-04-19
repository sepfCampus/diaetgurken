import 'package:app/config/layout/app_spacing.dart';
import 'package:app/widgets/forms/app_radio_group.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:flutter/material.dart';

class ExportConversationWidget extends StatefulWidget
{
  const ExportConversationWidget({ super.key });

  @override
  State<ExportConversationWidget> createState() => _ExportConversationWidgetState();
}

class _ExportConversationWidgetState extends State<ExportConversationWidget>
{
  String _format = 'PDF';
  String _colorMode = 'Standard';
  String _fontSize = 'Standard';

  @override
  Widget build(BuildContext context)
  {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String clientId = args?['clientId'] ?? '000009';
    final String date = args?['date'] ?? '01.01.2026';

    return AppPageScaffold(
      title: 'Export Gespräch ($clientId) - $date',
      drawer: LayoutUtil.getStandardAppDrawer(context),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          AppRadioGroup<String>(
            title: 'Format',
            options: const ['PDF', 'Word'],
            groupValue: _format,
            onChanged: (value)
            {
              setState(() => _format = value!);
            },
            labelBuilder: (value) => value,
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppRadioGroup<String>(
            title: 'Farbdarstellung',
            options: const ['Standard', 'Hoher Kontrast'],
            groupValue: _colorMode,
            onChanged: (value)
            {
              setState(() => _colorMode = value!);
            },
            labelBuilder: (value) => value,
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppRadioGroup<String>(
            title: 'Schriftgröße',
            options: const ['Standard', 'Groß'],
            groupValue: _fontSize,
            onChanged: (value)
            {
              setState(() => _fontSize = value!);
            },
            labelBuilder: (value) => value,
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
                buttonText: 'Exportieren',
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
