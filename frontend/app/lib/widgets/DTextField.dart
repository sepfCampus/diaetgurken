import 'package:flutter/material.dart';

/**
 * Diet Text Field
 * Custom text field that can be used in the whole application
 */
class DTextField extends StatelessWidget
{
  final String labelText;
  final bool hideInput;

  const DTextField({ super.key, this.labelText = '', this.hideInput = false });

  @override
  Widget build(BuildContext context)
  {
    return TextField(
      obscureText: this.hideInput, //for passwords
      maxLines: 1,
      decoration: InputDecoration(
        hintText: this.labelText,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18)
      )
    );
  }
}