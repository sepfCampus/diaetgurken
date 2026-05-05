import 'package:app/config/layout/app_spacing.dart';
import 'package:flutter/material.dart';

class AppSearchField extends StatelessWidget
{
  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSearchPressed;
  final bool enabled;

  const AppSearchField({ super.key, this.controller, this.hintText = 'Suchen ...',
                         this.onChanged, this.onSearchPressed, this.enabled = true });

  @override
  Widget build(BuildContext context)
  {
    final bool largeFont = Theme.of(context).textTheme.bodyMedium!.fontSize! > 15;

    return TextField(
      style: Theme.of(context).textTheme.bodyLarge,
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hintText,
        isDense: false,
        contentPadding: largeFont
            ? const EdgeInsets.symmetric(horizontal: 34, vertical: 28)
            : AppSpacing.INPUT_PADDING,
        suffixIcon: IconButton(
          onPressed: onSearchPressed,
          icon: Icon(
            Icons.search,
            size: largeFont ? 34 : 24,
          )
        ),
      ),
    );
  }
}
