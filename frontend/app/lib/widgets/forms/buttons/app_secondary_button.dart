import 'package:app/config/layout/app_radius.dart';
import 'package:app/config/layout/app_sizes.dart';
import 'package:flutter/material.dart';

class AppSecondaryButton extends StatelessWidget
{
  final String buttonText;
  final VoidCallback? onPressed;
  final double? width;

  const AppSecondaryButton({ super.key, required this.buttonText, required this.onPressed, this.width });

  @override
  Widget build(BuildContext context)
  {
    final theme = Theme.of(context);

    return SizedBox(
      width: width,
      height: AppSizes.BUTTON_HEIGHT,
      child: OutlinedButton(
        onPressed: onPressed,
        style: theme.outlinedButtonTheme.style?.copyWith(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: AppRadius.BORDER_RADIUS_MEDIUM,
            ),
          ),
        ),
        child: Text(buttonText),
      ),
    );
  }
}
