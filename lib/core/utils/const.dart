// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:cloud_kitchen/core/utils/UI_helpers.dart';
import 'package:flutter/material.dart';

class Constants {
  static String appName = "Cloud kitchen";

  static ThemeData lightTheme = ThemeData(
    backgroundColor: appBgGreyColor,
    primaryColor: appWhiteColor,
    accentColor: appBlackColor,
    unselectedWidgetColor: appWhiteColor,
    scaffoldBackgroundColor: appBgGreyColor,
    textTheme: TextTheme(
        subtitle1: TextStyle(
      fontSize: 40.0,
      fontWeight: FontWeight.bold,
      color: appBlackColor,
    )),
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: appBlackColor,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: lightAccent,
//      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: appDarkBgColor,
    unselectedWidgetColor: appBlackColor,
    textTheme: TextTheme(
        subtitle1: TextStyle(
            fontSize: 40.0, fontWeight: FontWeight.bold, color: appWhiteColor)),
    primaryColor: appBgGreyColor,
    accentColor: appWhiteColor,
    scaffoldBackgroundColor: appDarkBgColor,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: appWhiteColor,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: darkAccent,
//      ),
    ),
  );
}
