import 'package:app/config/navigation/routes.dart';
import 'package:app/widgets/layout/app_drawer.dart';
import 'package:app/widgets/layout/app_drawer_item.dart';
import 'package:flutter/material.dart';

class Layoututil
{
  static AppDrawer getStandardAppDrawer(BuildContext context)
  {
    return AppDrawer(items:
    [
      AppDrawerItem(icon: Icons.settings, title: 'Einstellungen', onPressed: () { Navigator.pushNamed(context, Routes.PAGE_SETTINGS); }),
      AppDrawerItem(icon: Icons.folder, title: 'Klientenakten', onPressed: () { Navigator.pushNamed(context, Routes.PAGE_CLIENT_FOLDER); }),
      AppDrawerItem(icon: Icons.person_outline, title: 'Klarnamen', onPressed: () { Navigator.pushNamed(context, Routes.PAGE_CLEAR_NAME); }),
      AppDrawerItem(icon: Icons.logout, title: 'Abmelden', onPressed: () { Navigator.pushNamedAndRemoveUntil(context, Routes.PAGE_LOGIN, (route) => false); })
    ]);
  }
}
