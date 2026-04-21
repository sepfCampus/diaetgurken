import 'package:app/config/layout/app_spacing.dart';
import 'package:app/widgets/forms/app_text_field.dart';
import 'package:app/widgets/forms/buttons/app_icon_side_button.dart';
import 'package:flutter/material.dart';

class AppLabeledSideTextField extends StatelessWidget
{
  final String label;
  final TextEditingController? controller;
  final String hintText;
  final IconData sideIcon;
  final VoidCallback? onSidePressed;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const AppLabeledSideTextField({ super.key, required this.label, this.controller,
                                  this.hintText = '', required this.sideIcon, this.onSidePressed,
                                  this.keyboardType = TextInputType.text, this.onChanged });

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

        AppSpacing.SPACED_BOX_H_SMALL,

        Row(
          children:
          [
            Expanded(
              child: AppTextField(
                controller: controller,
                hintText: hintText,
                keyboardType: keyboardType,
                onChanged: onChanged,
              )
            ),

            AppSpacing.SPACED_BOX_W_SMALL,

            AppSideButton(
              icon: sideIcon,
              onPressed: onSidePressed,
            )
          ]
        )
      ]
    );
  }
}
