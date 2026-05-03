import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/config/theme/app_theme.dart';
import 'package:app/config/theme/theme_controller.dart';
import 'package:app/data/daos/http/api/api_client.dart';
import 'package:app/data/daos/http/api/memory_session_store.dart';
import 'package:app/data/daos/http/api/session_api_client.dart';
import 'package:app/data/daos/http/api/session_store.dart';
import 'package:app/data/daos/http/settings_http_dao.dart';
import 'package:app/data/daos/memory/settings_memory_dao.dart';
import 'package:app/service/settings_service.dart';
import 'package:app/service/user_http_service.dart';
import 'package:app/service/util/entity_vo_converter_http_util.dart';
import 'package:app/service/util/entity_vo_converter_memory_util.dart';
import 'package:app/vo/Settings.dart';
import 'package:app/widgets/forms/app_labeled_field.dart';
import 'package:app/widgets/forms/app_radio_group.dart';
import 'package:app/widgets/forms/buttons/app_primary_button.dart';
import 'package:app/widgets/forms/buttons/app_secondary_button.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:app/widgets/layout/app_page_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final ThemeController themeController = Provider.of<ThemeController>(context);
    final String colorSelection = identical(themeController.theme, AppTheme.STANDARD) ? 'Standard' : 'Hoher Kontrast';


    return AppPageScaffold(
      title: 'Einstellungen',
      drawer: LayoutUtil.getStandardAppDrawer(context),
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
            groupValue: colorSelection,
            onChanged: (value)
            {
              final themeController = Provider.of<ThemeController>(context, listen: false);
              themeController.setTheme((value == 'Standard') ? AppTheme.STANDARD : AppTheme.HIGH_CONTRAST);
            },
            labelBuilder: (value) => value,
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
