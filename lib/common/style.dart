import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// Primary Color with Opacity 20 - 80 %
Color primaryColor = Color(0xff473069);
// HexColor('#2196f3');
Color primaryColor80 = HexColor('#36abe0');
Color primaryColor50 = HexColor('#50c8ff');
Color primaryColor20 = HexColor('#36abe0');

// Secondary Color with Opacity 20 - 80 %
Color secondaryColor = HexColor('#f87d47');
Color secondaryColor80 = HexColor('#2e3649');
Color secondaryColor50 = HexColor('#2e3649');
Color secondaryColor20 = HexColor('#2e3649');

// Orange Color with Opacity 20 - 80 %
// Color primaryColor = HexColor('#FE724C');
// Color primaryColor80 = HexColor('#FE8160');
// Color primaryColor50 = HexColor('#FEA58D');
// Color primaryColor20 = HexColor('#FED2C7');

// Yellow Color with Opacity 20 - 80 %
Color yellowColor = HexColor('#FFC529');
Color yellowColor80 = HexColor('#FFD050');
Color yellowColor50 = HexColor('#FFDF8B');
Color yellowColor20 = HexColor('#FFEFC3');

// Black Color with Opacity 20 - 80 %
Color blackColor = HexColor('#1A1D26');
Color blackColor80 = HexColor('#2A2F3D');
Color blackColor50 = HexColor('#4D5364');
Color blackColor20 = HexColor('#6E7489');

// Gray Color with Opacity 20 - 80 % 0xfff1f1f1
Color grayColor = HexColor('#9A9FAE');
Color grayColor80 = HexColor('#A8ACB9');
Color grayColor50 = HexColor('#C4C7D0');
Color grayColor20 = HexColor('#EBEBEB');
Color orangeColor = Color(0xffFFA500);
//  const Color(0xff94d500)

const Color whiteColor = Color(0xffffffff);

const Color backgroundColor = Color(0xffDDDDE2);
const Color secondColor = Color(0xff2e3649);

const String sofia = 'inter';
const String mulish = "inter";

const TextTheme textTheme = TextTheme(
  headlineMedium: TextStyle(
    fontFamily: sofia,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.25,
  ),
  headlineSmall: TextStyle(
    fontFamily: sofia,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  ),
  titleLarge: TextStyle(
    fontFamily: sofia,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.15,
  ),
  titleMedium: TextStyle(
    fontFamily: sofia,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  titleSmall: TextStyle(
    fontFamily: sofia,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyLarge: TextStyle(
    fontFamily: sofia,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyMedium: TextStyle(
    fontFamily: sofia,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  bodySmall: TextStyle(
    fontFamily: sofia,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  ),
  labelLarge: TextStyle(
    fontFamily: sofia,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.25,
  ),
);
