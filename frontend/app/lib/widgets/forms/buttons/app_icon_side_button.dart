import 'package:app/config/layout/app_radius.dart';
import 'package:app/config/layout/app_sizes.dart';
import 'package:flutter/material.dart';

class AppSideButton extends StatelessWidget
{
  final IconData icon;
  final VoidCallback? onPressed;

  const AppSideButton({ super.key, required this.icon, required this.onPressed });

  @override
  Widget build(BuildContext context)
  {
    final theme = Theme.of(context);
    final bool largeFont = theme.textTheme.bodyMedium!.fontSize! > 15;

    return SizedBox(
      width: largeFont ? AppSizes.TRAILING_BUTTON_WIDTH + 24 : AppSizes.TRAILING_BUTTON_WIDTH,
      height: largeFont ? AppSizes.SQUARE_ACTION_SIZE + 24 : AppSizes.SQUARE_ACTION_SIZE,
      child: OutlinedButton(
        onPressed: onPressed,
        style: theme.outlinedButtonTheme.style?.copyWith(
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: AppRadius.BORDER_RADIUS_MEDIUM,
            ),
          ),
        ),
        child: Icon(
        icon,
        size: largeFont ? 36 : 24,
      ),
      ),
    );
  }
}
