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

    return SizedBox(
      width: AppSizes.TRAILING_BUTTON_WIDTH,
      height: AppSizes.SQUARE_ACTION_SIZE,
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
        child: Icon(icon),
      ),
    );
  }
}
