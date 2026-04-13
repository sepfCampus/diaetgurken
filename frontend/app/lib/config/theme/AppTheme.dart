import 'package:app/config/theme/AppColor.dart';
import 'package:app/config/theme/AppTextTheme.dart';
import 'package:flutter/material.dart';

class AppTheme
{
  static final ThemeData LIGHT = ThemeData(
    brightness: Brightness.light,

    //background color of the app
    scaffoldBackgroundColor: AppColor.LIGHT_BODY,
    
    //main color of the app
    primaryColor: AppColor.LIGHT_PRIMARY,
    
    colorScheme: ColorScheme.light(
      primary: AppColor.LIGHT_PRIMARY,
      secondary: AppColor.LIGHT_SECONDARY,
      tertiary: AppColor.LIGHT_TERTIARY,
      
      surface: Colors.white,

      //text on primary color
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black
    ),

    //Text styles
    textTheme: AppTextTheme.getStandardTextTheme(textColor: Colors.black),

    //input fields
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      //fillColor: AppColor.LIGHT_BODY,

      //standard border
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4)
      ),

      //focused border
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: AppColor.LIGHT_PRIMARY
        )
      ),

      //border when clicking
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: AppColor.LIGHT_SECONDARY,
          width: 2
        )
      ),
    ),

    //buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.LIGHT_PRIMARY,
        foregroundColor: Colors.white,

        textStyle: AppTextTheme.getStandardTextStyle(),

        minimumSize: const Size(140, 56),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

        //border radius
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(6))
      )
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColor.LIGHT_PRIMARY,

        textStyle: AppTextTheme.getStandardTextStyle(),

        side: const BorderSide(
          color: AppColor.LIGHT_PRIMARY,
          width: 2
        ),

        minimumSize: const Size(140, 56),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

        //border radius
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
      )
    )
  );

  static final ThemeData HIGH_CONTRAST = ThemeData(
    brightness: Brightness.dark,

    //background color of the app
    scaffoldBackgroundColor: AppColor.HIGH_CONTRAST_BODY,
    
    //main color of the app
    primaryColor: AppColor.HIGH_CONTRAST_PRIMARY,
    
    colorScheme: ColorScheme.dark(
      primary: AppColor.HIGH_CONTRAST_PRIMARY,
      secondary: AppColor.HIGH_CONTRAST_SECONDARY,
      tertiary: AppColor.HIGH_CONTRAST_TERTIARY,
      
      surface: Colors.black,

      //text on primary color
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.white
    ),

    //Text styles
    textTheme: AppTextTheme.getStandardTextTheme(textColor: Colors.white),

    //input fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.HIGH_CONTRAST_BODY,

      //standard border
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4)
      ),

      //focused border
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: AppColor.HIGH_CONTRAST_PRIMARY
        )
      ),

      //border when clicking
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: AppColor.HIGH_CONTRAST_SECONDARY,
          width: 2
        )
      ),
    ),

    //buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.HIGH_CONTRAST_PRIMARY,
        foregroundColor: Colors.black,

        textStyle: AppTextTheme.getStandardTextStyle(),

        minimumSize: const Size(140, 56),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

        //border radius
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
      )
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColor.HIGH_CONTRAST_PRIMARY,

        textStyle: AppTextTheme.getStandardTextStyle(),

        side: const BorderSide(
          color: AppColor.HIGH_CONTRAST_PRIMARY,
          width: 2
        ),

        minimumSize: const Size(140, 56),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

        //border radius
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
      )
    )
  );

  static final ThemeData STANDARD = AppTheme.LIGHT;
}
