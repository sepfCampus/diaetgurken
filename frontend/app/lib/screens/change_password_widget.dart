import 'package:app/config/layout/app_spacing.dart';
import 'package:app/service/user_service.dart';
import 'package:app/widgets/forms/app_labeled_field.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordWidget extends StatefulWidget
{
  const ChangePasswordWidget({ super.key });

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidget();
}

class _ChangePasswordWidget extends State<ChangePasswordWidget>
{
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _save() async
  {
    final String oldPassword = _oldPasswordController.text.trim();
    final String newPassword = _newPasswordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    if(oldPassword.isEmpty)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte das alte Passwort eingeben.'),
        ),
      );

      return;
    }

    if(newPassword.isEmpty)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte ein neues Passwort eingeben.'),
        ),
      );

      return;
    }

    if(newPassword != confirmPassword)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Die neuen Passwörter stimmen nicht überein.'),
        ),
      );

      return;
    }

    setState(()
    {
      _isLoading = true;
    });

    try
    {
      final UserService userService = Provider.of<UserService>(
        context,
        listen: false,
      );

      await userService.changePassword(
        oldPassword,
        newPassword,
      );

      if(!mounted)
      {
        return;
      }

      Navigator.pop(context);
    }
    catch(error)
    {
      if(!mounted)
      {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
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

  @override
  void dispose()
  {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return AppPageScaffold(
      title: 'Passwort ändern',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          AppLabeledField(
            label: 'Altes Passwort',
            controller: _oldPasswordController,
            obscureText: true,
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppLabeledField(
            label: 'Neues Passwort',
            controller: _newPasswordController,
            obscureText: true,
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppLabeledField(
            label: 'Neues Passwort bestätigen',
            controller: _confirmPasswordController,
            obscureText: true,
          ),

          AppSpacing.SPACED_BOX_H_LARGE,

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:
            [
              AppSecondaryButton(
                buttonText: 'Abbrechen',
                onPressed: _isLoading
                    ? null
                    : ()
                    {
                      Navigator.pop(context);
                    },
              ),

              AppSpacing.SPACED_BOX_W_SMALL,

              AppPrimaryButton(
                buttonText: _isLoading
                    ? 'Speichern...'
                    : 'Speichern',
                onPressed: _isLoading
                    ? null
                    : _save,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/*import 'package:app/config/layout/app_spacing.dart';
import 'package:app/widgets/forms/app_labeled_field.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:flutter/material.dart';

class ChangePasswordWidget extends StatefulWidget
{
  const ChangePasswordWidget({ super.key });

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidget();
}

class _ChangePasswordWidget extends State<ChangePasswordWidget>
{
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose()
  {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return AppPageScaffold(
      title: 'Passwort ändern',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          AppLabeledField(
            label: 'Altes Passwort',
            controller: _oldPasswordController,
            obscureText: true
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppLabeledField(
            label: 'Neues Passwort',
            controller: _newPasswordController,
            obscureText: true
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppLabeledField(
            label: 'Neues Passwort bestätigen',
            controller: _confirmPasswordController,
            obscureText: true
          ),

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
                }
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
      )
    );
  }
}
*/