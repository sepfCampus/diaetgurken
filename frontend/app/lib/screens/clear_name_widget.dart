import 'package:app/config/layout/app_spacing.dart';
import 'package:app/service/client_file_service.dart';
import 'package:app/vo/client_file.dart';
import 'package:app/widgets/forms/app_text_field.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/tiles/app_navigation_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClearNameWidget extends StatefulWidget
{
  const ClearNameWidget({ super.key });

  @override
  State<ClearNameWidget> createState() => _ClearNameWidgetState();
}

class _ClearNameWidgetState extends State<ClearNameWidget>
{
  final TextEditingController _passwordController = TextEditingController();

  List<ClientFile> _clientFiles = [];
  ClientFile? _selectedFile;
  String? _klarname;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState()
  {
    super.initState();
    _loadClientFiles();
  }

  Future<void> _loadClientFiles() async
  {
    try
    {
      final service = context.read<ClientFileService>();
      final files = await service.getAll();
      setState(()
      {
        _clientFiles = files;
        if (files.isNotEmpty) _selectedFile = files.first;
      });
    }
    catch (e)
    {
      setState(() => _errorMessage = 'Fehler beim Laden der Klientenakten.');
    }
  }

  String _formatId(ClientFile file)
  {
    final id = file.id as int? ?? 0;
    return id.toString().padLeft(4, '0');
  }

  Future<void> _showKlarname() async
  {
    if (_selectedFile == null)
    {
      setState(() => _errorMessage = 'Bitte eine Klientenakte auswählen.');
      return;
    }

    if (_passwordController.text.isEmpty)
    {
      setState(() => _errorMessage = 'Bitte Passwort eingeben.');
      return;
    }

    setState(() { _isLoading = true; _errorMessage = null; _klarname = null; });

    try
    {
      final service = context.read<ClientFileService>();
      final name = await service.getClearName(_selectedFile!.id.toString(), _passwordController.text);
      setState(() => _klarname = name);
    }
    catch (e)
    {
      setState(() => _errorMessage = 'Fehler: Passwort falsch oder kein Zugriff.');
    }
    finally
    {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showDropdown(BuildContext context) async
  {
    final selected = await showModalBottomSheet<ClientFile>(
      context: context,
      builder: (ctx) => ListView(
        children: _clientFiles.map((file)
        {
          return ListTile(
            title: Text(_formatId(file)),
            onTap: () => Navigator.pop(ctx, file),
          );
        }).toList(),
      ),
    );

    if (selected != null)
    {
      setState(()
      {
        _selectedFile = selected;
        _klarname = null;
        _errorMessage = null;
      });
    }
  }

  @override
  void dispose()
  {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final theme = Theme.of(context);

    return AppPageScaffold(
      title: 'Klarnamen',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Text('Klientenakte', style: theme.textTheme.bodyMedium),

          AppSpacing.SPACED_BOX_H_SMALL,

          AppNavigationTile(
            title: _selectedFile != null ? _formatId(_selectedFile!) : 'Bitte auswählen ...',
            trailingIcon: Icons.keyboard_arrow_down,
            onTap: () => _showDropdown(context),
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppTextField(
            controller: _passwordController,
            hintText: 'Passwort',
            obscureText: true,
          ),

          if (_klarname != null) ...[
            AppSpacing.SPACED_BOX_H_MEDIUM,
            Container(
              width: double.infinity,
              height: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                border: Border.all(color: theme.colorScheme.primary, width: 1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(_klarname!, style: theme.textTheme.bodyMedium),
            ),
          ],

          if (_errorMessage != null) ...[
            AppSpacing.SPACED_BOX_H_MEDIUM,
            Text(_errorMessage!, style: TextStyle(color: theme.colorScheme.error)),
          ],

          AppSpacing.SPACED_BOX_H_LARGE,

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppSecondaryButton(
                buttonText: 'Abbrechen',
                onPressed: () => Navigator.pop(context),
              ),

              AppSpacing.SPACED_BOX_W_SMALL,

              _isLoading
                ? const CircularProgressIndicator()
                : AppPrimaryButton(
                    buttonText: 'Anzeigen',
                    onPressed: _showKlarname,
                  ),
            ],
          ),
        ],
      ),
    );
  }
}