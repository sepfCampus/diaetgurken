import 'package:app/config/layout/app_spacing.dart';
import 'package:flutter/material.dart';

class AppMultipleSelection<T> extends StatelessWidget
{
  final String title;
  final List<T> options;
  final List<T> selectedValues;
  final ValueChanged<List<T>> onChanged;
  final String Function(T) labelBuilder;

  const AppMultipleSelection({ super.key, required this.title, required this.options,
                               required this.selectedValues, required this.onChanged, required this.labelBuilder });

  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Text(title, style: Theme.of(context).textTheme.bodyMedium),

        AppSpacing.SPACED_BOX_H_EXTRA_EXTRA_SMALL,

        ...options.map((option)
        {
          final bool isSelected = selectedValues.contains(option);

          return CheckboxListTile(
            title: Text(
              labelBuilder(option),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            value: isSelected,
            contentPadding: EdgeInsets.zero,
            dense: false,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (checked) {
              final updatedValues = [...selectedValues];

              if(checked == true)
              {
                if(!updatedValues.contains(option))
                {
                  updatedValues.add(option);
                }
              }
              
              else
              {
                updatedValues.remove(option);
              }

              onChanged(updatedValues);
            }
          );
        })
      ]
    );
  }
}
