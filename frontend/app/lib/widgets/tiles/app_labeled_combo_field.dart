import 'package:app/config/layout/app_spacing.dart';
import 'package:app/widgets/tiles/app_combo_field.dart';
import 'package:flutter/material.dart';

class AppLabeledComboField extends StatelessWidget
{
  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final List<String> options;
  final String hintText;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSelected;

  const AppLabeledComboField({ super.key, required this.label, required this.controller,
                               required this.options, this.focusNode, this.hintText = '',
                               this.enabled = true, this.onChanged, this.onSelected });

  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        AppSpacing.SPACED_BOX_H_EXTRA_EXTRA_SMALL,

        AppComboField(
          controller: controller,
          focusNode: focusNode,
          options: options,
          hintText: hintText,
          enabled: enabled,
          onChanged: onChanged,
          onSelected: onSelected,
        )
      ]
    );
  }
}
