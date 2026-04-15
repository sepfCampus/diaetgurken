import 'package:app/config/layout/app_sizes.dart';
import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/widgets/forms/app_labeled_field.dart';
import 'package:app/widgets/forms/app_radio_group.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/LayoutUtil.dart';
import 'package:app/widgets/layout/app_drawer.dart';
import 'package:app/widgets/layout/app_drawer_item.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget
{
  const SettingsWidget({ super.key });

  @override
  State<SettingsWidget> createState() => _SettingsWidget();
}

class _SettingsWidget extends State<SettingsWidget>
{
  //controller for the email text field
  final TextEditingController _emailController = TextEditingController(text: 'vorname.nachname@email.at');
  
  //controller for the registerNr text field
  final TextEditingController _registerNrController = TextEditingController(text: 'AA-BBB-123456');

  String _colorSelection = 'Standard';
  String _fontSizeSelection = 'Standard';

  @override
  void dispose()
  {
    _emailController.dispose();
    _registerNrController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return AppPageScaffold(
      title: 'Einstellungen',
      drawer: Layoututil.getStandardAppDrawer(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          AppLabeledField(label: 'E-Mail-Adresse:', controller: _emailController),
          AppSpacing.SPACED_BOX_H_MEDIUM,
          AppLabeledField(label: 'Registernr.:', controller: _registerNrController),
          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppRadioGroup<String>(
            title: 'Farbdarstellung',
            options: const ['Standard', 'Hoher Kontrast'],
            groupValue: _colorSelection,
            onChanged: (value)
            {
              setState(()
              {
                _colorSelection = value!; //the selection is updated  
              });
            },
            labelBuilder: (value) => value
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          AppRadioGroup<String>(
            title: 'Schriftgröße',
            options: const ['Standard', 'Groß'],
            groupValue: _fontSizeSelection,
            onChanged: (value)
            {
              setState(()
              {
                _fontSizeSelection = value!;
              });
            },
            labelBuilder: (value) => value
          ),

          AppSpacing.SPACED_BOX_H_LARGE,

          Align(
            alignment: Alignment.centerRight,
            child: IntrinsicWidth(
              child: AppSecondaryButton(
                buttonText: 'Passwort ändern',
                onPressed: ()
                {
                  Navigator.pushNamed(context, Routes.PAGE_CHANGE_PASSWORD);
                }
              )
            )
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          Align(
            alignment: Alignment.centerRight,
            child: IntrinsicWidth(
              child: AppSecondaryButton(
                buttonText: 'Profil löschen',
                onPressed: ()
                {
                  Navigator.pushNamed(context, Routes.PAGE_DELETE_PROFILE);
                }
              )
            )
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

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

              AppSpacing.SPACED_BOX_W_MEDIUM,

              AppPrimaryButton(
                buttonText: 'Speichern',
                onPressed: ()
                {

                })
            ],
          )
        ]
      )
    );
  }
}
