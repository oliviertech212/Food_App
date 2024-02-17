import 'package:flutter/material.dart';
import 'package:foodapp/utils/colors.dart';

final ThemeData foodApptheme = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: AppColors.bgprimaryColor,
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: AppColors.accentColor),
  errorColor: AppColors.colorError,
  appBarTheme: const AppBarTheme(
    foregroundColor: Colors.black,
  ),
  textTheme: TextTheme(
    // Regular
    bodyText1: TextStyle(
        color: AppColors.textPrimarycolor, fontFamily: 'Roboto', fontSize: 50),

    // Bold
    bodyText2: TextStyle(
        color: AppColors.textSecondarycolor,
        fontFamily: 'Roboto',
        fontSize: 20,
        fontWeight: FontWeight.w700),

    // Italic
    subtitle1: TextStyle(
        color: AppColors.textWhitecolor,
        fontFamily: 'Roboto',
        fontSize: 20,
        fontStyle: FontStyle.italic),

    // Bold Italic
    subtitle2: TextStyle(
        color: AppColors.textWhitecolor,
        fontFamily: 'Roboto',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
  ),
);
