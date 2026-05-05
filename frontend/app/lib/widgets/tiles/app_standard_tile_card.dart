import 'package:flutter/material.dart';

//a simple standard tile
class AppStandardTileCard extends StatelessWidget
{
  final String title; //text shown inside the tile card
  final VoidCallback? onTap; // callback when the tile is tapped
  final Widget? trailing; // optional widget on the right side

  const AppStandardTileCard({ super.key, required this.title, this.onTap, this.trailing });

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
                textAlign:
                    trailing == null ? TextAlign.center : TextAlign.start,
              ),
            ),
            if (trailing != null) trailing!
          ]
        )
      )
    );
  }
}
