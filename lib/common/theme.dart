import 'package:flutter/material.dart';
import 'style.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primaryColor,
    onPrimary: blackColor,
    secondary: primaryColor,
  ),
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    elevation: 0,
  ),
  scaffoldBackgroundColor: whiteColor,
  textTheme: textTheme.apply(
    bodyColor: blackColor,
    decorationColor: blackColor,
    displayColor: blackColor,
  ),
  listTileTheme: const ListTileThemeData(
    tileColor: whiteColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      backgroundColor: MaterialStateProperty.all(primaryColor),
      foregroundColor: MaterialStateProperty.all(primaryColor),
    ),
  ),
  // inputDecorationTheme: InputDecorationTheme(
  //   border: OutlineInputBorder(
  //     borderSide: BorderSide(color: blackColor),
  //   ),
  //   focusedBorder: OutlineInputBorder(
  //     borderSide: BorderSide(color: primaryColor),
  //   ),
  //   enabledBorder: OutlineInputBorder(
  //     borderSide: BorderSide(color: blackColor),
  //   ),
  //   hintStyle: const TextStyle(
  //     fontFamily: mulish,
  //     fontSize: 16,
  //     fontWeight: FontWeight.w400,
  //     letterSpacing: 0.5,
  //   ),
  // ),
  // switchTheme: SwitchThemeData(
  //   thumbColor: MaterialStateProperty.all(primaryColor80),
  //   trackColor: MaterialStateProperty.all(primaryColor50),
  //   overlayColor: MaterialStateProperty.all(grayColor),
  // ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: blackColor,
    onPrimary: whiteColor,
    // secondary: primaryColor,
  ),
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    elevation: 0,
  ),
  scaffoldBackgroundColor: blackColor,
  textTheme: textTheme.apply(
    bodyColor: whiteColor,
    decorationColor: whiteColor,
    displayColor: whiteColor,
  ),
  listTileTheme: ListTileThemeData(
    tileColor: blackColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      backgroundColor: MaterialStateProperty.all(primaryColor),
      foregroundColor: MaterialStateProperty.all(primaryColor),
    ),
  ),
  // inputDecorationTheme: InputDecorationTheme(
  //   border: OutlineInputBorder(
  //     borderSide: BorderSide(color: blackColor),
  //   ),
  //   focusedBorder: OutlineInputBorder(
  //     borderSide: BorderSide(color: primaryColor),
  //   ),
  //   enabledBorder: OutlineInputBorder(
  //     borderSide: BorderSide(color: blackColor),
  //   ),
  //   hintStyle: const TextStyle(
  //     fontFamily: mulish,
  //     fontSize: 16,
  //     fontWeight: FontWeight.w400,
  //     letterSpacing: 0.5,
  //   ),
  // ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all(Colors.blue[800]),
    trackColor: MaterialStateProperty.all(Colors.blue[800]),
    overlayColor: MaterialStateProperty.all(grayColor),
  ),
);
