import 'package:app/config/layout/app_spacing.dart';
import 'package:flutter/material.dart';

class AppRadioGroup<T> extends StatelessWidget
{
  final String title;
  final List<T> options; //the selectable options
  final T groupValue; //the selected value
  final ValueChanged<T?> onChanged;
  final String Function(T) labelBuilder; //used for converting an option value into a display text

  const AppRadioGroup({
    super.key,
    required this.title,
    required this.options,
    required this.groupValue,
    required this.onChanged,
    required this.labelBuilder,
  });

  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, //left alignment
      children:
      [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        AppSpacing.SPACED_BOX_H_EXTRA_EXTRA_SMALL,

        ...options.map((option)
        {
          return RadioListTile<T>(
            value: option,
            groupValue: groupValue,
            onChanged: onChanged,
            title: Text(
              labelBuilder(option),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            contentPadding: EdgeInsets.zero,
            dense: false,
            visualDensity: VisualDensity.standard,
            controlAffinity: ListTileControlAffinity.leading,
          );
        }),
      ],
    );
  }
}