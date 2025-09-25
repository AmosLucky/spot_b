import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SpotstockNavigation {
  static void goTo(String route, BuildContext context) {
    context.push(route);
  }

  static void goBack(BuildContext context) {
    context.pop();
  }

  static void replace(String route, BuildContext context) {
    context.go(route);
  }
}
