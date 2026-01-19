import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/keys/spotstock_app_keys.dart';

class SpotstockNavigation {
  static late GoRouter router;

  static BuildContext? get context => spotstockNavigatorKey.currentContext;

  static void init(GoRouter r) {
    router = r;
  }

  static Future<T?> goTo<T extends Object?>(String route, [T? arguments]) {
    return router.push<T>(route, extra: arguments);
  }

  static void replace<T extends Object?>(String route, [T? arguments]) {
    router.go(route, extra: arguments);
  }

  static void goBack<T extends Object?>([T? result]) {
    router.pop(result);
  }
}
