import 'package:app/screens/einstellungen_widget.dart';
import 'package:app/screens/home_page_widget.dart';
import 'package:app/screens/klarnamen_widget.dart';
import 'package:app/screens/klientenakten_widget.dart';
import 'package:app/screens/login_widget.dart';
import 'package:app/screens/passwort_aendern_widget.dart';
import 'package:app/screens/profil_loeschen_widget.dart';
import 'package:app/screens/register_widget.dart';
import 'package:app/screens/settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:app/config/theme/app_theme.dart';
import 'package:app/config/navigation/routes.dart';

void main()
{
  runApp(const MainApp());
}

class MainApp extends StatelessWidget
{
  const MainApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.PAGE_HOME,
      routes:
      {
        Routes.PAGE_HOME : (context) => HomePageWidget(),
        Routes.PAGE_LOGIN: (context) => LoginWidget(),
        Routes.PAGE_REGISTER: (context) => RegisterWidget(),
        Routes.PAGE_SETTINGS: (context) => SettingsWidget(),
        Routes.PAGE_CLEAR_NAME: (context) => KlarnamenWidget(),
        Routes.PAGE_CLIENT_FOLDER: (context) => KlientenaktenWidget(),
        Routes.PAGE_CHANGE_PASSWORD: (context) => PasswortAendernWidget(),
        Routes.PAGE_DELETE_PROFILE: (context) => ProfilLoeschenWidget()
      },
      theme: AppTheme.LIGHT,  // LIGHT oder HIGH_CONTRAST
      home: const LoginWidget()
    );
  }
}
