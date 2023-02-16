import 'package:asm/app/constant/color.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: sgRed,
  scaffoldBackgroundColor: appWhite,
  // primaryColor: Colors.blue,
  // appBarTheme: AppBarTheme(
  //   backgroundColor: sgBlueVeryLight,
  // ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: sgRed,
  ),
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ButtonStyle(
  //     padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
  //         EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
  //     shape: MaterialStateProperty.all<OutlinedBorder>(
  //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
  //     backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
  //   ),
  // ),
  // inputDecorationTheme: InputDecorationTheme(
  //   border: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide.none),
  //   filled: true,
  //   fillColor: Colors.grey.withOpacity(0.1),
  // ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: sgRed,
  scaffoldBackgroundColor: appWhite,
  // appBarTheme: AppBarTheme(
  //   backgroundColor: sgBlueDark,
  // ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: sgRed,
  ),
  // switchTheme: SwitchThemeData(
  //   trackColor: MaterialStateProperty.all<Color>(Colors.grey),
  //   thumbColor: MaterialStateProperty.all<Color>(Colors.white),
  // ),
  // inputDecorationTheme: InputDecorationTheme(
  //   border: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide.none),
  //   filled: true,
  //   fillColor: Colors.grey.withOpacity(0.1),
  // ),
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ButtonStyle(
  //     padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
  //       EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
  //     ),
  //     shape: MaterialStateProperty.all<OutlinedBorder>(
  //       RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20.0),
  //       ),
  //     ),
  //     backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
  //     foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
  //     overlayColor: MaterialStateProperty.all<Color>(Colors.black26),
  //   ),
  // ),
);