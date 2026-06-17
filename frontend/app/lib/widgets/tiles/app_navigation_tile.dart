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
    final bool largeFont = theme.textTheme.bodyMedium!.fontSize! > 15;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: largeFont ? 26 : 14,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          /*border: Border.all(
            color: theme.colorScheme.primary,
            width: 1,
          ),*/
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
              size: largeFont ? 38 : 28,
            ),
          ],
        ),
      ),
    );
  }
}
