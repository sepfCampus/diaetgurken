import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/service/klienten_akte_http_service.dart';
import 'package:app/widgets/forms/app_text_field.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateClientFileWidget extends StatefulWidget
{
  const CreateClientFileWidget({ super.key });

  @override
  State<CreateClientFileWidget> createState() => _CreateClientFileWidgetState();
}

class _CreateClientFileWidgetState extends State<CreateClientFileWidget>
{
  final TextEditingController _nameController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose()
  {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async
  {
    setState(() { _isLoading = true; _errorMessage = null; });

    try
    {
      final service = context.read<KlientenAkteHttpService>();
      await service.create(name: _nameController.text.trim());

      if (mounted)
      {
        Navigator.pushNamedAndRemoveUntil(context, Routes.PAGE_CLIENT_FILES, (route) => false);
      }
    }
    catch (e)
    {
      setState(() => _errorMessage = 'Fehler beim Anlegen der Klientenakte.');
    }
    finally
    {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return AppPageScaffold(
      title: 'Neue Klientenakte',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          AppTextField(
            controller: _nameController,
            hintText: 'Name',
          ),

          if (_errorMessage != null) ...[
            AppSpacing.SPACED_BOX_H_LARGE,
            Text(
              _errorMessage!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],

          AppSpacing.SPACED_BOX_H_LARGE,

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
                    buttonText: 'Speichern',
                    onPressed: _save,
                  ),
            ],
          ),
        ],
      ),
    );
  }
}