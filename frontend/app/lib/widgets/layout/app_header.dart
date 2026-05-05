import 'package:app/config/layout/app_sizes.dart';
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget
{
  final String title; //title shown in the header
  final Widget? leading; //optional widget on the left side
  final Widget? trailing; //optional widget on the right side

  const AppHeader({ super.key, required this.title, this.leading, this.trailing,});

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.APP_BAR_HEIGHT + 24);

  @override
  Widget build(BuildContext context)
  {
    final theme = Theme.of(context);
    final bool largeFont = theme.textTheme.bodyMedium!.fontSize! > 15;

    return AppBar(
      toolbarHeight: largeFont ? AppSizes.APP_BAR_HEIGHT + 24 : AppSizes.APP_BAR_HEIGHT,
      leading: leading != null
    ? IconTheme(
        data: IconThemeData(
          size: largeFont ? 38 : 24,
          color: theme.appBarTheme.foregroundColor,
        ),
        child: leading!,
      )
    : null,
      title: Text(
        title,
        style: theme.appBarTheme.titleTextStyle,
      ),
      actions: trailing != null
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 12), //keeps right icon from sticking to the edge
                child: trailing!,
              ),
            ]
          : null,

      elevation: theme.appBarTheme.elevation,
      backgroundColor: theme.appBarTheme.backgroundColor,
      foregroundColor: theme.appBarTheme.foregroundColor,
      centerTitle: theme.appBarTheme.centerTitle ?? false
    );
  }
}
