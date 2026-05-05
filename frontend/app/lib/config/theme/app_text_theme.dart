import 'package:flutter/material.dart';

class AppTextTheme
{
  static TextTheme getStandardTextTheme({
    Color textColor = Colors.black,
    bool large = false,
  })
  {
    final double factor = large ? 1.45 : 1.0;

    return TextTheme(
      headlineSmall: TextStyle(
        fontSize: 22 * factor,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleLarge: TextStyle(
        fontSize: 18 * factor,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16 * factor,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 15 * factor,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      bodySmall: TextStyle(
        fontSize: 13 * factor,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      labelLarge: TextStyle(
        fontSize: 16 * factor,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }

  static TextStyle getBodyStyle({
    Color textColor = Colors.black,
    bool large = false,
  })
  {
    return TextStyle(
      fontSize: large ? 23 : 16,
      fontWeight: FontWeight.w400,
      color: textColor,
    );
  }

  static TextStyle getTitleStyle({
    Color textColor = Colors.black,
    bool large = false,
  })
  {
    return TextStyle(
      fontSize: large ? 26 : 18,
      fontWeight: FontWeight.w500,
      color: textColor,
    );
  }

  static TextStyle getButtonStyle({
    Color textColor = Colors.white,
    bool large = false,
  })
  {
    return TextStyle(
      fontSize: large ? 23 : 16,
      fontWeight: FontWeight.w500,
      color: textColor,
    );
  }
}