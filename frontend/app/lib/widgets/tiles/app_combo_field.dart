import 'package:app/config/layout/app_radius.dart';
import 'package:app/config/layout/app_sizes.dart';
import 'package:flutter/material.dart';

//a combination of dropdown and text field
class AppComboField extends StatelessWidget
{
  final TextEditingController controller;
  final FocusNode? focusNode;
  final List<String> options;
  final String hintText;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSelected;

  const AppComboField({ super.key, required this.controller, required this.options,
                        this.focusNode, this.hintText = '', this.enabled = true,
                        this.onChanged, this.onSelected });

  @override
  Widget build(BuildContext context)
  {
    final ThemeData theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints)
      {
        return DropdownMenu<String>(
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          width: constraints.maxWidth,
          hintText: hintText,
          requestFocusOnTap: true,
          enableFilter: true,
          enableSearch: true,
          inputDecorationTheme: theme.inputDecorationTheme.copyWith(
            constraints: const BoxConstraints(
              minHeight: AppSizes.INPUT_HEIGHT
            ),
            filled: theme.inputDecorationTheme.filled,
            fillColor: theme.inputDecorationTheme.fillColor,
            contentPadding: theme.inputDecorationTheme.contentPadding,
            border: OutlineInputBorder(
              borderRadius: AppRadius.BORDER_RADIUS_SMALL,
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.BORDER_RADIUS_SMALL,
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.BORDER_RADIUS_SMALL,
              borderSide: BorderSide(
                color: theme.inputDecorationTheme.focusedBorder is OutlineInputBorder
                    ? (theme.inputDecorationTheme.focusedBorder as OutlineInputBorder).borderSide.color
                    : theme.colorScheme.secondary,
                width: theme.inputDecorationTheme.focusedBorder is OutlineInputBorder
                    ? (theme.inputDecorationTheme.focusedBorder as OutlineInputBorder).borderSide.width
                    : 2,
              ),
            ),
          ),
          dropdownMenuEntries: options.map((option)
          {
            return DropdownMenuEntry<String>(
              value: option,
              label: option,
            );
          }).toList(),
          onSelected: (value)
          {
            if(value == null)
            {
              return;
            }

            controller.text = value;

            if(onChanged != null)
            {
              onChanged!(value);
            }

            if(onSelected != null)
            {
              onSelected!(value);
            }
          },
        );
      },
    );
  }
}
