import 'package:app/config/layout/app_radius.dart';
import 'package:app/config/layout/app_sizes.dart';
import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget
{
  final String buttonText;

  //the onPressed function is nullable which allows the button to be disabled
  final VoidCallback? onPressed;
  final double? width;

  const AppPrimaryButton({ super.key, required this.buttonText, required this.onPressed, this.width });

  @override
  Widget build(BuildContext context)
  {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return SizedBox(
      width: width,
      height: AppSizes.BUTTON_HEIGHT,
      child: ElevatedButton(
        onPressed: onPressed,
        //taking the default style and changing only the necessary options
        style: theme.elevatedButtonTheme.style?.copyWith(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: AppRadius.BORDER_RADIUS_MEDIUM),
          ),

          backgroundColor: WidgetStatePropertyAll(colors.primary),
          foregroundColor: WidgetStatePropertyAll(colors.onPrimary)
        ),

        child: Text(buttonText)
      )
    );
  }
}
