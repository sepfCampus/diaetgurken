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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiary,
                border: Border.all(
                  color: theme.colorScheme.primary,
                  width: 1,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                ),
              ),
              child: Text(
                title,
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),

        const SizedBox(width: 1),
        SizedBox(
          width: AppSizes.TRAILING_BUTTON_WIDTH,
          child: InkWell(
            onTap: onSidePressed,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(6),
              bottomRight: Radius.circular(6),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiary,
                border: Border.all(
                  color: theme.colorScheme.primary,
                  width: 1,
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
              ),
              child: Icon(
                sideIcon,
                color: theme.colorScheme.onSurface,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
