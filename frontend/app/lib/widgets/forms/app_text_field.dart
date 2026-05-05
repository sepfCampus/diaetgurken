import 'package:app/config/layout/app_spacing.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget
{
  final TextEditingController? controller;
  final String hintText;
  final String? labelText;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final int maxLines;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const AppTextField({ super.key, this.controller, this.hintText = '', this.labelText,
                       this.obscureText = false, this.readOnly = false, this.enabled = true,
                       this.maxLines = 1, this.keyboardType = TextInputType.text, this.onChanged });

  @override
  Widget build(BuildContext context)
  {
    final bool largeFont = Theme.of(context).textTheme.bodyMedium!.fontSize! > 15;

    return TextField(
      style: Theme.of(context).textTheme.bodyLarge,
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      enabled: enabled,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        isDense: false,
        contentPadding: largeFont
            ? const EdgeInsets.symmetric(horizontal: 34, vertical: 28)
            : AppSpacing.INPUT_PADDING,
      ),
    );
  }
}
