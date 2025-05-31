import 'package:flutter/material.dart';
import 'common/helpers/colors_res.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Mulish",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    // inputDecorationTheme: inputDecorationTheme(),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(Colors.white),
      fillColor: WidgetStateProperty.all(ColorsRes.appcolor),
    ),
    radioTheme: RadioThemeData(
        fillColor:
            WidgetStateColor.resolveWith((states) => ColorsRes.appcolor)),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyLarge: TextStyle(color: ColorsRes.appcolor),
    bodyMedium: TextStyle(color: ColorsRes.appcolor),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    // brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    // textTheme: TextTheme(
    //   headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    // ),
  );
}
