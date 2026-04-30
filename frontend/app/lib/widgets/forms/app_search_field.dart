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
    return TextField(
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hintText,
        isDense: true,
        contentPadding: AppSpacing.INPUT_PADDING,
        suffixIcon: IconButton(
          onPressed: onSearchPressed,
          icon: const Icon(Icons.search)
        ),
      ),
    );
  }
}
