import 'dart:html' as html;
import 'dart:typed_data';

import 'package:app/config/layout/app_spacing.dart';
import 'package:app/service/conversation_service.dart';
import 'package:app/vo/util/formatter.dart';
import 'package:app/widgets/forms/app_radio_group.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  bool _isLoading = false;
  String? _errorMessage;

  void _triggerDownload(Uint8List bytes, String filename, String mimeType)
  {
    final blob = html.Blob([bytes], mimeType);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = filename;
    html.document.body!.children.add(anchor);
    anchor.click();
    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  Future<void> _export(Map<String, dynamic> args) async
  {
    final int? clientId = args['clientId'] as int?;
    final int? conversationId    = args['conversationId']    as int?;

    if(clientId == null || conversationId == null)
    {
      setState(() => _errorMessage = 'Ungültige Gesprächsdaten.');
      return;
    }

    setState(() {
      _isLoading    = true;
      _errorMessage = null;
    });

    try
    {
      final service = context.read<ConversationService>();

      final cleanDate = (args['date']?.toString() ?? 'export').replaceAll('.', '-');
      
      if(_format == 'PDF')
      {
        final bytes = await service.exportPdf(clientId: clientId, conversationId: conversationId, fontSize: _fontSize, theme: _colorMode);
        _triggerDownload(bytes, '${cleanDate}_${clientId}_gespraech.pdf', 'application/pdf');
      }

      else
      {
        final bytes = await service.exportDocx(clientId: clientId, conversationId: conversationId, fontSize: _fontSize, theme: _colorMode);
        _triggerDownload(bytes, '${cleanDate}_${clientId}_gespraech.docx',
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document');
      }

      if (mounted) Navigator.pop(context);
    }
    catch (e)
    {
      if (mounted) setState(() => _errorMessage = 'Export fehlgeschlagen: $e');
    }
    finally
    {
      if (mounted) setState(() => _isLoading = false);
    }
  }  

  @override
  Widget build(BuildContext context)
  {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final int clientId = args?['clientId'] ?? -1;
    final String date = args?['date'] ?? '?';

    return AppPageScaffold(
      title: 'Export Gespräch (${Formatter.formatClientId(clientId)}) - $date',
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

          if (_errorMessage != null) ...[
            AppSpacing.SPACED_BOX_H_MEDIUM,
            Text(
              _errorMessage!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],

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

              _isLoading
                ? const CircularProgressIndicator()
                : AppPrimaryButton(
                    buttonText: 'Exportieren',
                    onPressed: () => _export(args ?? {}),
                  )
            ],
          )
        ],
      ),
    );
  }
}
