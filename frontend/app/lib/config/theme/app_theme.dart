import 'package:app/config/theme/app_color.dart';
import 'package:app/config/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme
{
  static ThemeData getTheme({
    required bool highContrast,
    required bool largeFont,
  })
  {
    return highContrast
      ? _getHighContrastTheme(largeFont: largeFont)
      : _getLightTheme(largeFont: largeFont);
  }

  // ================= LIGHT =================

  static ThemeData _getLightTheme({ required bool largeFont }) => ThemeData(
    brightness: Brightness.light,

    scaffoldBackgroundColor: AppColor.LIGHT_BODY,
    primaryColor: AppColor.LIGHT_PRIMARY,

    colorScheme: ColorScheme.light(
      primary: AppColor.LIGHT_PRIMARY,
      secondary: AppColor.LIGHT_SECONDARY,
      tertiary: AppColor.LIGHT_TERTIARY,
      surface: Colors.white,
      error: AppColor.LIGHT_TERTIARY,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black
    ),

    textTheme: AppTextTheme.getStandardTextTheme(
      textColor: Colors.black,
      large: largeFont,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.LIGHT_PRIMARY,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTextTheme.getTitleStyle(
        textColor: Colors.white,
        large: largeFont,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: false,

      contentPadding: EdgeInsets.symmetric(
        horizontal: largeFont ? 34 : 24,
        vertical: largeFont ? 28 : 16,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: AppColor.LIGHT_PRIMARY,
          width: 1,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: AppColor.LIGHT_SECONDARY,
          width: 2,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: AppColor.LIGHT_QUATERNARY,
          width: 1.5,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: AppColor.LIGHT_QUATERNARY,
          width: 2,
        ),
      ),

      labelStyle: AppTextTheme.getBodyStyle(
        textColor: Colors.black,
        large: largeFont,
      ),
      hintStyle: AppTextTheme.getBodyStyle(
        textColor: Colors.black,
        large: largeFont,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.LIGHT_PRIMARY,
        foregroundColor: Colors.white,

        textStyle: AppTextTheme.getButtonStyle(
          textColor: Colors.white,
          large: largeFont,
        ),

        minimumSize: Size(largeFont ? 190 : 140, largeFont ? 78 : 56),
        padding: EdgeInsets.symmetric(
          horizontal: largeFont ? 36 : 24,
          vertical: largeFont ? 26 : 16,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColor.LIGHT_PRIMARY,

        textStyle: AppTextTheme.getButtonStyle(
          textColor: AppColor.LIGHT_PRIMARY,
          large: largeFont,
        ),

        side: const BorderSide(
          color: AppColor.LIGHT_PRIMARY,
          width: 1,
        ),

        minimumSize: Size(largeFont ? 190 : 140, largeFont ? 78 : 56),
        padding: EdgeInsets.symmetric(
          horizontal: largeFont ? 36 : 24,
          vertical: largeFont ? 26 : 16,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states)
      {
        return AppColor.LIGHT_PRIMARY;
      }),
    ),

    dividerColor: Colors.black,
    cardColor: Colors.white,
    useMaterial3: true,
  );

  // ================= HIGH CONTRAST =================

  static ThemeData _getHighContrastTheme({ required bool largeFont }) => ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColor.HIGH_CONTRAST_BODY,
    primaryColor: AppColor.HIGH_CONTRAST_PRIMARY,

    colorScheme: ColorScheme.dark(
      primary: AppColor.HIGH_CONTRAST_PRIMARY,
      secondary: AppColor.HIGH_CONTRAST_SECONDARY,
      tertiary: AppColor.HIGH_CONTRAST_TERTIARY,
      surface: Colors.black,
      error: AppColor.HIGH_CONTRAST_TERTIARY,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.white,
    ),

    textTheme: AppTextTheme.getStandardTextTheme(
      textColor: Colors.white,
      large: largeFont,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.HIGH_CONTRAST_PRIMARY,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTextTheme.getTitleStyle(
        textColor: Colors.white,
        large: largeFont,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.HIGH_CONTRAST_BODY,

      contentPadding: EdgeInsets.symmetric(
        horizontal: largeFont ? 34 : 24,
        vertical: largeFont ? 28 : 16,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: AppColor.HIGH_CONTRAST_PRIMARY,
          width: 1.5,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: AppColor.HIGH_CONTRAST_SECONDARY,
          width: 2.5,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: AppColor.HIGH_CONTRAST_QUATERNARY,
          width: 2,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: AppColor.HIGH_CONTRAST_QUATERNARY,
          width: 2.5,
        ),
      ),

      labelStyle: AppTextTheme.getBodyStyle(
        textColor: Colors.white,
        large: largeFont,
      ),
      hintStyle: AppTextTheme.getBodyStyle(
        textColor: Colors.white,
        large: largeFont,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.HIGH_CONTRAST_PRIMARY,
        foregroundColor: Colors.black,

        textStyle: AppTextTheme.getButtonStyle(
          textColor: Colors.black,
          large: largeFont,
        ),

        minimumSize: Size(largeFont ? 190 : 140, largeFont ? 78 : 56),
        padding: EdgeInsets.symmetric(
          horizontal: largeFont ? 36 : 24,
          vertical: largeFont ? 26 : 16,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColor.HIGH_CONTRAST_PRIMARY,

        textStyle: AppTextTheme.getButtonStyle(
          textColor: AppColor.HIGH_CONTRAST_PRIMARY,
          large: largeFont,
        ),

        side: const BorderSide(
          color: AppColor.HIGH_CONTRAST_PRIMARY,
          width: 2,
        ),

        minimumSize: Size(largeFont ? 190 : 140, largeFont ? 78 : 56),
        padding: EdgeInsets.symmetric(
          horizontal: largeFont ? 36 : 24,
          vertical: largeFont ? 26 : 16,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states)
      {
        return AppColor.HIGH_CONTRAST_PRIMARY;
      }),
    ),

    dividerColor: Colors.white,
    cardColor: Colors.black,
    useMaterial3: true,
  );

  static final ThemeData LIGHT = AppTheme._getLightTheme(largeFont: false);
  static final ThemeData HIGH_CONTRAST = AppTheme._getHighContrastTheme(largeFont: false);
  static final ThemeData STANDARD = AppTheme.LIGHT;
}