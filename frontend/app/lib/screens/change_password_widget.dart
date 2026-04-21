import 'package:app/config/layout/app_spacing.dart';
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
