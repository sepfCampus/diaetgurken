import 'package:app/config/layout/app_radius.dart';
import 'package:app/config/layout/app_sizes.dart';
import 'package:app/widgets/tiles/app_combo_field.dart';
import 'package:flutter/material.dart';

class AppComboSideButtonField extends StatelessWidget
{
  final TextEditingController controller;
  final List<String> options;
  final String hintText;
  final IconData sideIcon;
  final VoidCallback? onSidePressed;
  final bool enabled;

  const AppComboSideButtonField({ super.key, required this.controller, required this.options,
                                  required this.sideIcon, this.hintText = '', this.onSidePressed,
                                  this.enabled = true });

  @override
  Widget build(BuildContext context)
  {
    final theme = Theme.of(context);

    return SizedBox(
      height: AppSizes.TILE_HEIGHT,
      child: Row(
        children:
        [
          Expanded(
            child: Theme(
              data: theme.copyWith(
                inputDecorationTheme: theme.inputDecorationTheme.copyWith(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppRadius.MD),
                      bottomLeft: Radius.circular(AppRadius.MD),
                      topRight: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppRadius.MD),
                      bottomLeft: Radius.circular(AppRadius.MD),
                      topRight: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppRadius.MD),
                      bottomLeft: Radius.circular(AppRadius.MD),
                      topRight: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 1,
                    ),
                  ),
                ),
              ),
              child: AppComboField(
                controller: controller,
                options: options,
                hintText: hintText,
                enabled: enabled,
              ),
            ),
          ),

          SizedBox(
            width: AppSizes.TRAILING_BUTTON_WIDTH,
            height: AppSizes.TILE_HEIGHT,
            child: OutlinedButton(
              onPressed: onSidePressed,
              style: theme.outlinedButtonTheme.style?.copyWith(
                padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                minimumSize: const WidgetStatePropertyAll(
                  Size(AppSizes.TRAILING_BUTTON_WIDTH, AppSizes.TILE_HEIGHT),
                ),
                shape: const WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(AppRadius.MD),
                      bottomRight: Radius.circular(AppRadius.MD),
                    ),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(
                  theme.colorScheme.secondary,
                ),
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: theme.colorScheme.primary,
                    width: 1,
                  ),
                ),
              ),
              child: Icon(
                sideIcon,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
