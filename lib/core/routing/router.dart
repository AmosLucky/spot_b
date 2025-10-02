import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../features/apps/presentation/view/select_app.dart';
import '../../features/apps/presentation/view_model/select_app_view_model.dart';
import '../../features/auth/presentation/view/login.dart';
import '../../features/auth/presentation/view_model/login_view_model.dart';
import '../../features/home/presentation/view/home.dart';
import '../../features/home/presentation/view/root.dart';
import '../../features/home/presentation/view_model/root_view_model.dart';
import '../../features/splash/presentation/view/mobile/splash.dart';
import '../../features/splash/presentation/view_model/splash_view_model.dart';
import '../../features/webview/presentation/view/webview.dart';
import '../../features/webview/presentation/view_model/webview_view_model.dart';

class SpotstockMobileRoutes {
  static const String splash = '/';
  static const String login = '/mobile/login';
  static const String webview = '/mobile/webview';
  static const String home = '/mobile/home';
  static const String root = '/mobile/root';
  static const String selectApp = '/mobile/select-app';
}

class SpotstockDesktopRoutes {
  static const String splash = '/';
  static const String login = '/desktop/login';
  static const String dashboard = '/desktop/dashboard';
}

final GetIt getIt = GetIt.instance;

class SpotstockRouter {
  static final mobileRouter = GoRouter(
    routes: [
      GoRoute(
        path: SpotstockMobileRoutes.splash,
        builder: (context, state) {
          final viewModel = getIt<SplashViewModel>();
          return Splash(viewModel: viewModel);
        },
      ),
      GoRoute(
        path: SpotstockMobileRoutes.login,
        builder: (context, state) {
          final viewModel = getIt<LoginViewModel>();
          return Login(viewModel: viewModel);
        },
      ),
      GoRoute(
        path: SpotstockMobileRoutes.webview,
        builder: (context, state) {
          final viewModel = getIt<WebviewViewModel>();
          return Webview(viewModel: viewModel);
        },
      ),
      GoRoute(
        path: SpotstockMobileRoutes.root,
        builder: (context, state) {
          final viewModel = getIt<RootViewModel>();
          return Root(viewModel: viewModel);
        },
      ),
      GoRoute(
        path: SpotstockMobileRoutes.home,
        builder: (context, state) {
          return Home();
        },
      ),
      GoRoute(
        path: SpotstockMobileRoutes.selectApp,
        builder: (context, state) {
          final viewModel = getIt<SelectAppViewModel>();
          return SelectApp(viewModel: viewModel);
        },
      ),
    ],
  );

  static final desktopRouter = GoRouter(
    routes: [],
  );
}
