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

    return ListTile(
      leading: Icon(icon, color: theme.appBarTheme.foregroundColor),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.appBarTheme.foregroundColor
        ),
      ),
      onTap: onPressed,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      minLeadingWidth: 24
    );
  }
}
