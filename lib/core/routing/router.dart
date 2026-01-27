import 'package:go_router/go_router.dart';

import '../../features/apps/presentation/view/select_app.dart';
import '../../features/apps/presentation/view_model/select_app_view_model.dart';
import '../../features/auth/presentation/view/login.dart';
import '../../features/auth/presentation/view_model/login_view_model.dart';
import '../../features/holds/presentation/view/holds.dart';
import '../../features/holds/presentation/view_model/holds_view_model.dart';
import '../../features/home/presentation/view/home.dart';
import '../../features/home/presentation/view/root.dart';
import '../../features/home/presentation/view_model/root_view_model.dart';
import '../../features/hotel/home/presentation/view/hotel_home.dart';
import '../../features/hotel/home/presentation/view_model/hotel_home_viewmodel.dart';
import '../../features/pos/presentation/view/pos.dart';
import '../../features/pos/presentation/view_model/pos_view_model.dart';
import '../../features/register_management/presentation/view/register_management.dart';
import '../../features/register_management/presentation/view/register_summary.dart';
import '../../features/register_management/presentation/view_model/register_management_view_model.dart';
import '../../features/register_management/presentation/view_model/register_summary_view_model.dart';
import '../../features/splash/presentation/view/mobile/splash.dart';
import '../../features/splash/presentation/view_model/splash_view_model.dart';
import '../../features/webview/presentation/view/webview.dart';
import '../../features/webview/presentation/view_model/webview_view_model.dart';
import '../constants/keys/spotstock_app_keys.dart';
import '../constants/strings/spotstock_strings.dart';
import '../di/di.dart';

class SpotstockMobileRoutes {
  static const String splash = '/';
  static const String login = '/mobile/login';
  static const String webview = '/mobile/webview';
  static const String home = '/mobile/home';
  static const String root = '/mobile/root';
  static const String selectApp = '/mobile/select-app';
  static const String pos = '/mobile/pos';
  static const String holds = '/mobile/holds';
  static const String registerSummary = '/mobile/register-summary';
  static const String registerManagement = '/mobile/register-management';
}

class SpotstockDesktopRoutes {
  static const String splash = '/';
  static const String login = '/mobile/login';
  //static const String login = '/desktop/login';
  static const String dashboard = '/desktop/dashboard';
  static const String hotel = '/desktop/hotel';
  static const String amenities = '/desktop/amenities';
  static const String facilities = '/desktop/facilities';
  static const String bedTypes = '/desktop/bed_type';

  static const String roomTypes = '/desktop/room_type';

  static const String premiumTypes = '/desktop/premium_types';
  static const String hotelRooms = '/desktop/hotel_rooms';
}

class SpotstockRouteParams {
  static const String registerId = 'registerId';
}

class SpotstockRouter {
  static final mobileRouter = GoRouter(
    navigatorKey: spotstockNavigatorKey,
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
      GoRoute(
        path: SpotstockMobileRoutes.pos,
        builder: (context, state) {
          final viewModel = getIt<PosViewModel>();
          return Pos(viewModel: viewModel);
        },
      ),
      GoRoute(
        path: SpotstockMobileRoutes.holds,
        builder: (context, state) {
          final viewModel = getIt<HoldsViewModel>();
          return Holds(viewModel: viewModel);
        },
      ),
      GoRoute(
        path: SpotstockMobileRoutes.registerSummary,
        builder: (context, state) {
          final viewModel = getIt<RegisterSummaryViewModel>();
          final registerId = int.tryParse(
              state.uri.queryParameters[SpotstockRouteParams.registerId] ??
                  SpotstockStrings.EMPTY);
          return RegisterSummary(viewModel: viewModel, registerId: registerId);
        },
      ),
      GoRoute(
        path: SpotstockMobileRoutes.registerManagement,
        builder: (context, state) {
          final viewModel = getIt<RegisterManagementViewModel>();
          return RegisterManagement(viewModel: viewModel);
        },
      ),
    ],
  );

  static final desktopRouter = GoRouter(
    navigatorKey: spotstockNavigatorKey,
    routes: [
      GoRoute(
        path: SpotstockMobileRoutes.splash,
        builder: (context, state) {
          final viewModel = getIt<SplashViewModel>();
          return Splash(viewModel: viewModel);
        },
      ),
      GoRoute(
        path: SpotstockDesktopRoutes.login,
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
      GoRoute(
        path: SpotstockDesktopRoutes.hotel,
        builder: (context, state) {
          final viewModel = getIt<HotelHomeViewmodel>();
          return HotelHome(
            homeViewmodel: viewModel,
          );
        },
      ),
    ],
  );
}
