import 'package:flutter/material.dart'; // Importiert die Flutter-Material-Klassen für TextStyle und TextTheme.

class AppTextTheme
{
  static TextTheme getStandardTextTheme({Color textColor = Colors.black})
  {
    return TextTheme(
      headlineSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }

  //default text style for the body
  static TextStyle getBodyStyle({Color textColor = Colors.black})
  {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: textColor,
    );
  }

  //default for titles, appbars, ...
  static TextStyle getTitleStyle({Color textColor = Colors.black})
  {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: textColor,
    );
  }

  //default style for buttons
  static TextStyle getButtonStyle({Color textColor = Colors.white})
  {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: textColor,
    );
  }
}
