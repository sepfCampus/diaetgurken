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
            decoration: InputDecoration(hintText: this.labelText)
           );
  }
}
