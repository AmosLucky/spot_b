import 'dart:io' show Platform;

import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 800;


  static bool isWXGATablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Check if device falls within WXGA screen size range
    return width == 1280 && height == 800 || width == 800 && height == 1280;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Define general tablet range or include WXGA specifically
    return (width < 1100 && width >= 850) || isWXGATablet(context);
  }

  // static bool isTablet(BuildContext context) =>
  //     MediaQuery.of(context).size.width < 1100 &&
  //     MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) =>
      Platform.isWindows || Platform.isMacOS;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // If our width is more than 1100 then we consider it a desktop
    if ( Platform.isWindows || Platform.isMacOS) {
      return desktop;
    }
    // // If width it less then 1100 and more then 850 we consider it as tablet
    // else if (Platform.isAndroid || Platform.isIOS) {
    //   return mobile;
    // }
    // Or less then that we called it mobile
    else {
      return mobile;
    }
  }
}
