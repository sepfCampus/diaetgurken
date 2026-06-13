import 'package:app/config/layout/app_sizes.dart';
import 'package:flutter/material.dart';

//a tile consisting of text and a button
class AppSideButtonTile extends StatelessWidget
{
  final String title; //text shown in the main area
  final VoidCallback? onTap; //callback for tapping the main area
  final IconData sideIcon; //icon shown in the side button area
  final VoidCallback? onSidePressed; //callback for tapping the side button area

  const AppSideButtonTile({ super.key, required this.title, this.onTap,
                            required this.sideIcon, this.onSidePressed });

  @override
  Widget build(BuildContext context)
  {
    final ThemeData theme = Theme.of(context);
    final bool largeFont = theme.textTheme.bodyMedium!.fontSize! > 15;
    final double tileHeight = largeFont ? AppSizes.TILE_HEIGHT + 28 : AppSizes.TILE_HEIGHT;
    final double sideWidth = largeFont ? AppSizes.TRAILING_BUTTON_WIDTH + 24 : AppSizes.TRAILING_BUTTON_WIDTH;

    return Row(
      children:
      [
        Expanded(
          child: InkWell(
            onTap: onTap,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
            child: SizedBox(
              height: tileHeight,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  /*border: Border(
                    left: BorderSide(color: theme.colorScheme.primary, width: 1),
                    top: BorderSide(color: theme.colorScheme.primary, width: 1),
                    bottom: BorderSide(color: theme.colorScheme.primary, width: 1),
                  ),*/
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
                ),
                child: Text(
                  title,
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                )
              )
            )
          )
        ),

        SizedBox(
          width: sideWidth,
          height: tileHeight,
          child: InkWell(
            onTap: onSidePressed,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(6),
              bottomRight: Radius.circular(6),
            ),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary,
                border: Border(
                  left: BorderSide(color: theme.colorScheme.primary, width: 1),
                  right: BorderSide(color: theme.colorScheme.primary, width: 1),
                  top: BorderSide(color: theme.colorScheme.primary, width: 1),
                  bottom: BorderSide(color: theme.colorScheme.primary, width: 1),
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
              ),
              child: Icon(
                sideIcon,
                color: theme.colorScheme.onSurface,
                size: largeFont ? 38 : 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}