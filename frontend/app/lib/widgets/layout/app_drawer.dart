import 'package:app/widgets/layout/app_drawer_item.dart';
import 'package:app/widgets/layout/layout_util.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget
{
  final List<AppDrawerItem> items;

  const AppDrawer({ super.key, required this.items });

  @override
  Widget build(BuildContext context)
  {
    final theme = Theme.of(context);
    final appBarTheme = theme.appBarTheme;

    //bigger on big screens, smaller on small ones
    final double drawerWidth = LayoutUtil.getDrawerWidth(MediaQuery.of(context).size.width);

    return Drawer(
      width: drawerWidth,
      backgroundColor: appBarTheme.backgroundColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Container(
              height: 1,
              color: appBarTheme.foregroundColor?.withOpacity(0.25),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 8),
                children: items,
              )
            )
          ]
        )
      )
    );
  }
}
