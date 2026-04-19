import 'package:flutter/material.dart';

//used like a checkbox to select or deselect options
class AppFilterChipTile extends StatelessWidget
{
  final String label; //text inside the chip
  final bool selected;
  final VoidCallback? onPressed;

  const AppFilterChipTile({ super.key, required this.label, this.selected = false, this.onPressed });

  @override
  Widget build(BuildContext context)
  {
    final ThemeData theme = Theme.of(context);

    return OutlinedButton(
      onPressed: onPressed,
      style: theme.outlinedButtonTheme.style?.copyWith(
        backgroundColor: WidgetStatePropertyAll(
          selected ? theme.colorScheme.primary : theme.scaffoldBackgroundColor,
        ),
        side: WidgetStatePropertyAll(
          BorderSide(
            color: theme.colorScheme.primary,
            width: 1,
          ),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),

      child: Text(
        label,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: selected ? theme.colorScheme.onPrimary : theme.textTheme.bodyMedium?.color,
        )
      )
    );
  }
}
