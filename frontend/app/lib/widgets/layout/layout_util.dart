import 'dart:math' as math;
import 'package:app/config/layout/app_sizes.dart';
import 'package:app/config/navigation/routes.dart';
import 'package:app/service/user_http_service.dart';
import 'package:app/widgets/layout/app_drawer.dart';
import 'package:app/widgets/layout/app_drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LayoutUtil
{
  static double getDrawerWidth(double screenWidth)
  {
    return math.min(AppSizes.DRAWER_MAX_WIDTH, math.max(AppSizes.DRAWER_MIN_WIDTH, screenWidth * 0.35));
  }

  static AppDrawer getStandardAppDrawer(BuildContext context)
  {
    return AppDrawer(items:
    [
      AppDrawerItem(icon: Icons.settings, title: 'Einstellungen', onPressed: () { Navigator.pushNamed(context, Routes.PAGE_SETTINGS); }),
      AppDrawerItem(icon: Icons.folder, title: 'Klientenakten', onPressed: () { Navigator.pushNamed(context, Routes.PAGE_CLIENT_FILES); }),
      AppDrawerItem(icon: Icons.person_outline, title: 'Klarnamen', onPressed: () { Navigator.pushNamed(context, Routes.PAGE_CLEAR_NAME); }),
      AppDrawerItem(icon: Icons.logout, title: 'Abmelden', onPressed: () async
      {
        try
        {
          final userService = context.read<UserHttpService>();
          await userService.logout();
        }
        catch (e) {}

        if (context.mounted)
        {
          Navigator.pushNamedAndRemoveUntil(context, Routes.PAGE_LOGIN, (route) => false);
        }
      })
    ]);
  }
}