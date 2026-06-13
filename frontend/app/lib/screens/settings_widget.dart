import 'package:app/config/layout/app_spacing.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/config/theme/theme_controller.dart';
import 'package:app/service/settings_service.dart';
import 'package:app/service/user_service.dart';
import 'package:app/vo/settings.dart';
import 'package:app/vo/user.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _registerNrController = TextEditingController();

  String _selectedColorMode = 'Standard';
  String _selectedFontSize = 'Standard';

  bool _isLoading = true;
  User? _currentUser;

  @override
  void initState()
  {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async
  {
    try
    {
      print("---load data---");
      final userService = Provider.of<UserService>(context, listen: false);
      final settingsService = Provider.of<SettingsService>(context, listen: false);

      final user = await userService.getCurrentUser();
      final settings = await settingsService.getSettings(user.id);

      if(!mounted)
      {
        return;
      }

      setState(()
      {
        _currentUser = user;

        _emailController.text = user.email;
        _registerNrController.text = user.registerNr;

        _selectedColorMode = settings.colorMode;
        _selectedFontSize = settings.fontSize;

        print("selected color mode: $_selectedColorMode");
        print("selected font size: $_selectedFontSize");
      });
    }
    
    catch(error)
    {
      debugPrint('Fehler beim Laden der Einstellungen: $error');
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

  Future<void> _save() async
  {
    final userService = Provider.of<UserService>(context, listen: false);
    final settingsService = Provider.of<SettingsService>(context, listen: false);
    final themeController = Provider.of<ThemeController>(context, listen: false);

    final user = _currentUser;

    if(user == null)
    {
      return;
    }

    user.email = _emailController.text;
    user.registerNr = _registerNrController.text;

    await userService.updateUser(user);

    final settings = Settings(
      _selectedColorMode,
      _selectedFontSize,
    );

    await settingsService.updateSettings(user.id, settings);

    themeController.setColorSelection(_selectedColorMode);
    themeController.setFontSizeSelection(_selectedFontSize);

    if(!mounted)
    {
      return;
    }

    Navigator.pop(context);
  }

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
    if(_isLoading)
    {
      return AppPageScaffold(
        title: 'Einstellungen',
        drawer: LayoutUtil.getStandardAppDrawer(context),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return AppPageScaffold(
      title: 'Einstellungen',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          AppLabeledField(
            label: 'E-Mail-Adresse:',
            controller: _emailController,
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppLabeledField(
            label: 'Registernr.:',
            controller: _registerNrController,
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppRadioGroup<String>(
            title: 'Farbdarstellung',
            options: const ['Standard', 'Hoher Kontrast'],
            groupValue: _selectedColorMode,
            onChanged: (value)
            {
              if(value == null)
              {
                return;
              }

              setState(()
              {
                _selectedColorMode = value;
              });
            },
            labelBuilder: (value) => value,
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          AppRadioGroup<String>(
            title: 'Schriftgröße',
            options: const ['Standard', 'Groß'],
            groupValue: _selectedFontSize,
            onChanged: (value)
            {
              if(value == null)
              {
                return;
              }

              setState(()
              {
                _selectedFontSize = value;
              });
            },
            labelBuilder: (value) => value,
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
                },
              ),
            ),
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
                },
              ),
            ),
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
                },
              ),

              AppSpacing.SPACED_BOX_W_MEDIUM,

              AppPrimaryButton(
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

/*class SettingsWidget extends StatefulWidget
{
  const SettingsWidget({ super.key });

  @override
  State<SettingsWidget> createState() => _SettingsWidget();
}

class _SettingsWidget extends State<SettingsWidget>
{
  final TextEditingController _emailController = TextEditingController(
    text: 'vorname.nachname@email.at',
  );

  final TextEditingController _registerNrController = TextEditingController(
    text: 'AA-BBB-123456',
  );

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
    final String colorSelection = themeController.colorSelection;
    final String fontSizeSelection = themeController.fontSizeSelection;

    return AppPageScaffold(
      title: 'Einstellungen',
      drawer: LayoutUtil.getStandardAppDrawer(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          AppLabeledField(
            label: 'E-Mail-Adresse:',
            controller: _emailController,
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppLabeledField(
            label: 'Registernr.:',
            controller: _registerNrController,
          ),

          AppSpacing.SPACED_BOX_H_MEDIUM,

          AppRadioGroup<String>(
            title: 'Farbdarstellung',
            options: const ['Standard', 'Hoher Kontrast'],
            groupValue: colorSelection,
            onChanged: (value)
            {
              if(value == null)
              {
                return;
              }

              final themeController = Provider.of<ThemeController>(
                context,
                listen: false,
              );

              themeController.setColorSelection(value);
            },
            labelBuilder: (value) => value,
          ),

          AppSpacing.SPACED_BOX_H_SMALL,

          AppRadioGroup<String>(
            title: 'Schriftgröße',
            options: const ['Standard', 'Groß'],
            groupValue: fontSizeSelection,
            onChanged: (value)
            {
              if(value == null)
              {
                return;
              }

              final themeController = Provider.of<ThemeController>(
                context,
                listen: false,
              );

              themeController.setFontSizeSelection(value);
            },
            labelBuilder: (value) => value,
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
                },
              ),
            ),
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
                },
              ),
            ),
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
                },
              ),

              AppSpacing.SPACED_BOX_W_MEDIUM,

              AppPrimaryButton(
                buttonText: 'Speichern',
                onPressed: ()
                {
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}*/