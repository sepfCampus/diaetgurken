import 'package:flutter/material.dart';

//a tile that can link to other routes
class AppNavigationTile extends StatelessWidget
{
  final String title;
  final VoidCallback? onTap;
  final IconData trailingIcon;

  const AppNavigationTile({ super.key, required this.title, this.onTap,
                            this.trailingIcon = Icons.arrow_forward });

  @override
  Widget build(BuildContext context)
  {
    final ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: theme.colorScheme.tertiary,
          border: Border.all(
            color: theme.colorScheme.primary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyMedium,
              ),
            ),
            Icon(
              trailingIcon,
              color: theme.colorScheme.onSurface,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
