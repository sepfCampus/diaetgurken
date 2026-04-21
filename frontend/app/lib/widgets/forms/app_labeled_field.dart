import 'package:app/config/layout/app_spacing.dart';
import 'package:app/widgets/forms/app_text_field.dart';
import 'package:flutter/material.dart';

class AppLabeledField extends StatelessWidget
{
  final String label; //is shown above the text field
  final TextEditingController? controller;
  final String hintText;
  final String? fieldLabelText;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final int maxLines;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const AppLabeledField({ super.key, required this.label, this.controller, this.hintText = '',
                          this.fieldLabelText, this.obscureText = false, this.readOnly = false,
                          this.enabled = true, this.maxLines = 1, this.keyboardType = TextInputType.text,
                          this.onChanged });

  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // left alignment
      children:
      [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),

        AppSpacing.SPACED_BOX_H_SMALL, //spacing between label and text field

        AppTextField(
          controller: controller,
          hintText: hintText,
          labelText: fieldLabelText,
          obscureText: obscureText,
          readOnly: readOnly,
          enabled: enabled,
          maxLines: maxLines,
          keyboardType: keyboardType,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
