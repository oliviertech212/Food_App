import 'package:flutter/material.dart';
import 'package:foodapp/utils/colors.dart';

final ThemeData foodApptheme = ThemeData(
  primaryColor: AppColors.bgprimaryColor,
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: AppColors.accentColor),
  errorColor: AppColors.colorError,
  appBarTheme: const AppBarTheme(
    foregroundColor: Colors.black,
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      color: AppColors.textPrimarycolor,
      fontFamily: 'Roboto',
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    // Regular
    bodyText1: TextStyle(
      color: AppColors.textPrimarycolor,
      fontFamily: 'Roboto',
      fontSize: 16, // Adjust font size as needed
      fontWeight: FontWeight.w400,
    ),

    // Bold
    bodyText2: TextStyle(
      color: AppColors.textPrimarycolor,
      fontFamily: 'Roboto',
      fontSize: 14, // Adjust font size as needed
      fontWeight: FontWeight.w500,
    ),

    // Italic
    subtitle1: TextStyle(
      color: AppColors.textWhitecolor,
      fontFamily: 'Roboto',
      fontSize: 12, // Adjust font size as needed
      fontStyle: FontStyle.italic,
    ),

    // Bold Italic
    subtitle2: TextStyle(
      color: AppColors.textWhitecolor,
      fontFamily: 'Roboto',
      fontSize: 18, // Adjust font size as needed
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.bgprimaryColor,
    ),
  ),
);
