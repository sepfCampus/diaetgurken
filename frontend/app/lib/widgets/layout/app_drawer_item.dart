import 'package:flutter/material.dart';

class AppDrawerItem extends StatelessWidget
{
  final IconData icon; //icon displayed on the left side
  final String title;
  final VoidCallback onPressed;

  const AppDrawerItem({ super.key, required this.icon, required this.title, required this.onPressed });

  @override
  Widget build(BuildContext context)
  {
    final theme = Theme.of(context);
    final bool largeFont = theme.textTheme.bodyMedium!.fontSize! > 15;

    return ListTile(
      leading: Icon(
        icon,
        color: theme.appBarTheme.foregroundColor,
        size: largeFont ? 34 : 24,
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.appBarTheme.foregroundColor
        ),
      ),
      onTap: onPressed,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: largeFont ? 16 : 6,
      ),
      minLeadingWidth: 24
    );
  }
}
