import 'package:go_router/go_router.dart';

class SpotstockMobileRoutes {
  static const String splash = '/';
  static const String login = '/mobile/login';
  static const String dashboard = '/mobile/dashboard';
}

class SpotstockDesktopRoutes {
  static const String splash = '/';
  static const String login = '/desktop/login';
  static const String dashboard = '/desktop/dashboard';
}

class SpotstockRouter {
  static final mobileRouter = GoRouter(
    routes: [
      // GoRoute(path: '/', builder: (context, state) => const Container()),
    ],
  );

  static final desktopRouter = GoRouter(
    routes: [
      // GoRoute(path: '/', builder: (context, state) => const Container()),
    ],
  );
}
