import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/keys/spotstock_app_keys.dart';

class SpotstockNavigation {
  static late GoRouter router;

  static BuildContext? get context => spotstockNavigatorKey.currentContext;

  static void init(GoRouter r) {
    router = r;
  }

  static void goTo(String route) {
    router.push(route);
  }

  static void replace(String route) {
    router.go(route);
  }

  static void goBack<T extends Object?>([T? result]) {
    router.pop(result);
  }
}
