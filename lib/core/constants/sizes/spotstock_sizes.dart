import 'package:flutter/material.dart';

class SpotstockSizes {
  static const double s0 = 0;
  static const double s0_05 = 0.05;
  static const double s0_1 = 0.1;
  static const double s0_2 = 0.2;
  static const double s0_25 = 0.25;
  static const double s0_3 = 0.3;
  static const double s0_4 = 0.4;
  static const double s0_5 = 0.5;
  static const double s0_6 = 0.6;
  static const double s0_7 = 0.7;
  static const double s0_8 = 0.8;
  static const double s0_9 = 0.9;
  static const double s1 = 1;
  static const double s1_2 = 1.2;
  static const double s1_5 = 1.5;
  static const double s2 = 2;
  static const double s2_1 = 2.1;
  static const double s2_2 = 2.2;
  static const double s2_3 = 2.3;
  static const double s2_4 = 2.4;
  static const double s2_5 = 2.5;
  static const double s2_6 = 2.6;
  static const double s2_7 = 2.7;
  static const double s2_8 = 2.8;
  static const double s2_9 = 2.9;
  static const double s3_0 = 3.0;
  static const double s3_1 = 3.1;
  static const double s3_2 = 3.2;
  static const double s3_3 = 3.3;
  static const double s3_4 = 3.4;
  static const double s3_5 = 3.5;
  static const double s3_6 = 3.6;
  static const double s3 = 3;
  static const double s4 = 4;
  static const double s5 = 5;
  static const double s6 = 6;
  static const double s7 = 7;
  static const double s8 = 8;
  static const double s10 = 10;
  static const double s11 = 11;
  static const double s12 = 12;
  static const double s13 = 13;
  static const double s14 = 14;
  static const double s15 = 15;
  static const double s16 = 16;
  static const double s18 = 18;
  static const double s20 = 20;
  static const double s22 = 22;
  static const double s24 = 24;
  static const double s25 = 25;
  static const double s26 = 26;
  static const double s27 = 27;
  static const double s30 = 30;
  static const double s32 = 32;
  static const double s33 = 33;
  static const double s34 = 34;
  static const double s35 = 35;
  static const double s36 = 36;
  static const double s37 = 37;
  static const double s38 = 38;
  static const double s40 = 40;
  static const double s42 = 42;
  static const double s45 = 45;
  static const double s48 = 48;
  static const double s50 = 50;
  static const double s54 = 54;
  static const double s57 = 57;
  static const double s60 = 60;
  static const double s64 = 64;
  static const double s65 = 65;
  static const double s70 = 70;
  static const double s72 = 72;
  static const double s80 = 80;
  static const double s98 = 98;
  static const double s100 = 100;
  static const double s110 = 110;
  static const double s120 = 120;
  static const double s128 = 128;
  static const double s130 = 130;
  static const double s150 = 150;
  static const double s200 = 200;
  static const double s250 = 250;
  static const double s255 = 255;
  static const double s256 = 256;
  static const double s1000 = 1000;
   static const double windowMinWidth = 1100;
    static const double windowMinHeight = 700;

  static double topSpacing(BuildContext context) {
    final notchHeight = MediaQuery.of(context).viewPadding.top;
    if (notchHeight < s40) {
      return s40;
    } else {
      return notchHeight + s12;
    }
  }

  static double bottomSpacing(BuildContext context) {
    final notchHeight = MediaQuery.of(context).viewPadding.bottom;
    if (notchHeight < s5) {
      return s12;
    }
    return notchHeight;
  }
}
