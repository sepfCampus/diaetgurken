import 'package:flutter/material.dart';

class AppTextTheme
{
  static TextTheme getStandardTextTheme({ Color textColor = Colors.black })
  {
    return TextTheme(
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor
      ));
  }

  static TextStyle getStandardTextStyle()
  {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400
    );
  }
}
