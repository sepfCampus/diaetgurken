import 'dart:math';

import 'package:app/config/theme/app_color.dart';
import 'package:app/config/theme/app_text_theme.dart';
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
      
      //default color for cards, dialogues, input fields, ...
      surface: Colors.white,

      //text on primary color
      onPrimary: Colors.white,
      onSecondary: Colors.black,

      //text on surfaces
      onSurface: Colors.black
    ),

    //Text styles
    textTheme: AppTextTheme.getStandardTextTheme(textColor: Colors.black),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.LIGHT_PRIMARY,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTextTheme.getTitleStyle(textColor: Colors.white)
    ),

    //input fields
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      //fillColor: AppColor.LIGHT_BODY,

      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

      //standard border
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4)
      ),
      
      //focused border
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: AppColor.LIGHT_PRIMARY,
          width: 1
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

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: AppColor.LIGHT_QUATERNARY,
          width: 1.5
        )
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: AppColor.LIGHT_QUATERNARY,
          width: 2
        )
      ),

      labelStyle: AppTextTheme.getBodyStyle(textColor: Colors.black),
      hintStyle: AppTextTheme.getBodyStyle(textColor: Colors.black),
    ),

    //buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.LIGHT_PRIMARY,
        foregroundColor: Colors.white,

        textStyle: AppTextTheme.getButtonStyle(),

        minimumSize: const Size(140, 56),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

        //border radius
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
      )
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColor.LIGHT_PRIMARY,

        textStyle: AppTextTheme.getButtonStyle(),

        side: const BorderSide(
          color: AppColor.LIGHT_PRIMARY,
          width: 1
        ),

        minimumSize: const Size(140, 56),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

        //border radius
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
      )
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states)
        {
          if(states.contains(WidgetState.selected))
          {
            return AppColor.LIGHT_PRIMARY;
          }

          return AppColor.LIGHT_PRIMARY;
        }        
      )
    ),

    dividerColor: Colors.black,
    cardColor: Colors.white,
    useMaterial3: true
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

    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.HIGH_CONTRAST_PRIMARY,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTextTheme.getTitleStyle(textColor: Colors.white)
    ),

    //input fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.HIGH_CONTRAST_BODY,

      //standard border
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4)
      ),

      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

      //focused border
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: AppColor.HIGH_CONTRAST_PRIMARY,
          width: 1.5
        )
      ),

      //border when clicking
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: AppColor.HIGH_CONTRAST_SECONDARY,
          width: 2.5
        )
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: AppColor.HIGH_CONTRAST_QUATERNARY,
          width: 2
        )
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: AppColor.HIGH_CONTRAST_QUATERNARY,
          width: 2.5
        )
      ),

      labelStyle: AppTextTheme.getBodyStyle(textColor: Colors.white),
      hintStyle: AppTextTheme.getBodyStyle(textColor: Colors.white)
    ),

    //buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.HIGH_CONTRAST_PRIMARY,
        foregroundColor: Colors.black,

        textStyle: AppTextTheme.getButtonStyle(),

        minimumSize: const Size(140, 56),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

        //border radius
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
      )
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColor.HIGH_CONTRAST_PRIMARY,

        textStyle: AppTextTheme.getButtonStyle(),

        side: const BorderSide(
          color: AppColor.HIGH_CONTRAST_PRIMARY,
          width: 2
        ),

        minimumSize: const Size(140, 56),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

        //border radius
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
      )
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states)
      {
        if(states.contains(WidgetState.selected))
        {
          return AppColor.HIGH_CONTRAST_PRIMARY;
        }

        return AppColor.HIGH_CONTRAST_PRIMARY;
      })
    ),

    dividerColor: Colors.white,
    cardColor: Colors.black,
    useMaterial3: true
  );

  static final ThemeData STANDARD = AppTheme.LIGHT;
}
