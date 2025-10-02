import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/apps/presentation/view_model/select_app_view_model.dart';
import '../../features/auth/data/datasources/local/last_login_time_datasource.dart';
import '../../features/auth/data/datasources/local/token_datasource.dart';
import '../../features/auth/data/datasources/local/user_datasource.dart';
import '../../features/auth/data/datasources/remote/login_datasource.dart';
import '../../features/auth/data/repositories/last_login_time_repository_impl.dart';
import '../../features/auth/data/repositories/login_repository_impl.dart';
import '../../features/auth/data/repositories/token_repository_impl.dart';
import '../../features/auth/data/repositories/user_repository_impl.dart';
import '../../features/auth/domain/repositories/last_login_time_repository.dart';
import '../../features/auth/domain/repositories/login_repository.dart';
import '../../features/auth/domain/repositories/token_repository.dart';
import '../../features/auth/domain/repositories/user_repository.dart';
import '../../features/auth/domain/usecases/get_last_login_time.dart';
import '../../features/auth/domain/usecases/get_spotstock_user.dart';
import '../../features/auth/domain/usecases/get_token.dart';
import '../../features/auth/domain/usecases/login.dart';
import '../../features/auth/domain/usecases/remove_last_login_time.dart';
import '../../features/auth/domain/usecases/remove_spotstock_user.dart';
import '../../features/auth/domain/usecases/remove_token.dart';
import '../../features/auth/domain/usecases/save_last_login_time.dart';
import '../../features/auth/domain/usecases/save_spotstock_user.dart';
import '../../features/auth/domain/usecases/save_token.dart';
import '../../features/auth/presentation/view_model/login_view_model.dart';
import '../../features/history/presentation/view_model/history_view_model.dart';
import '../../features/home/presentation/view_model/home_view_model.dart';
import '../../features/home/presentation/view_model/root_view_model.dart';
import '../../features/network_info/data/repositories/network_info_repository_impl.dart';
import '../../features/network_info/domain/repositories/network_info_repository.dart';
import '../../features/network_info/domain/usecases/listen_for_network_change.dart';
import '../../features/network_info/network_info_service.dart';
import '../../features/network_info/presentation/view_model/spotstock_network_aware_view_model.dart';
import '../../features/platform/platform_service.dart';
import '../../features/profile/presentation/view_model/profile_view_model.dart';
import '../../features/splash/presentation/view_model/splash_view_model.dart';
import '../../features/summary/presentation/view_model/summary_view_model.dart';
import '../../features/sync/presentation/view_model/sync_view_model.dart';
import '../../features/webview/presentation/view_model/webview_view_model.dart';
import '../local_storage/local_storage_client.dart';
import '../networking/dio_client.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ============ CORE DEPENDENCIES ============
  getIt.registerLazySingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  getIt.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());

  // ============ SERVICES ============
  getIt.registerLazySingleton<PlatformService>(() => PlatformService());
  getIt.registerLazySingleton<DioClient>(() => DioClient());
  getIt.registerSingletonAsync<LocalStorageClient>(() async {
    final prefs = await getIt.getAsync<SharedPreferences>();
    return LocalStorageClient(
      sharedPreferences: prefs,
      secureStorage: getIt<FlutterSecureStorage>(),
    );
  });
  getIt.registerLazySingleton<NetworkInfoService>(() => NetworkInfoService()..start());

  // ============ DATASOURCES ============
  getIt.registerLazySingleton<LoginDatasource>(() => LoginDatasource(getIt<DioClient>()));
  getIt.registerLazySingleton<LastLoginTimeDatasource>(
    () => LastLoginTimeDatasource(getIt<LocalStorageClient>()),
  );
  getIt.registerLazySingleton<TokenDatasource>(
    () => TokenDatasource(getIt<LocalStorageClient>()),
  );
  getIt.registerLazySingleton<UserDatasource>(
    () => UserDatasource(getIt<LocalStorageClient>()),
  );

  // ============ REPOSITORIES ============
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(getIt<LoginDatasource>()),
  );
  getIt.registerLazySingleton<LastLoginTimeRepository>(
    () => LastLoginTimeRepositoryImpl(getIt<LastLoginTimeDatasource>()),
  );
  getIt.registerLazySingleton<TokenRepository>(
    () => TokenRepositoryImpl(getIt<TokenDatasource>()),
  );
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt<UserDatasource>()),
  );
  getIt.registerLazySingleton<NetworkInfoRepository>(
    () => NetworkInfoRepositoryImpl(getIt<NetworkInfoService>()),
  );

  // ============ USE CASES ============
  getIt.registerLazySingleton<Login>(() => Login(getIt<LoginRepository>()));
  getIt.registerLazySingleton<GetToken>(() => GetToken(getIt<TokenRepository>()));
  getIt.registerLazySingleton<GetSpotstockUser>(() => GetSpotstockUser(getIt<UserRepository>()));
  getIt.registerLazySingleton<GetLastLoginTime>(
      () => GetLastLoginTime(getIt<LastLoginTimeRepository>()));
  getIt.registerLazySingleton<SaveToken>(() => SaveToken(getIt<TokenRepository>()));
  getIt.registerLazySingleton<SaveSpotstockUser>(() => SaveSpotstockUser(getIt<UserRepository>()));
  getIt.registerLazySingleton<SaveLastLoginTime>(
      () => SaveLastLoginTime(getIt<LastLoginTimeRepository>()));
  getIt.registerLazySingleton<RemoveLastLoginTime>(
      () => RemoveLastLoginTime(getIt<LastLoginTimeRepository>()));
  getIt.registerLazySingleton<RemoveToken>(() => RemoveToken(getIt<TokenRepository>()));
  getIt.registerLazySingleton<RemoveSpotstockUser>(
      () => RemoveSpotstockUser(getIt<UserRepository>()));
  getIt.registerLazySingleton<ListenForNetworkChange>(
      () => ListenForNetworkChange(getIt<NetworkInfoRepository>()));

  // ============ VIEW MODELS ============
  // Register as factories so fresh instances are created each time
  getIt.registerFactory<SplashViewModel>(() => SplashViewModel(
        getIt<GetToken>(),
        getIt<GetSpotstockUser>(),
        getIt<GetLastLoginTime>(),
      ));

  getIt.registerFactory<LoginViewModel>(() => LoginViewModel(
        getIt<Login>(),
        getIt<SaveToken>(),
        getIt<SaveSpotstockUser>(),
        getIt<SaveLastLoginTime>(),
        getIt<GetSpotstockUser>(),
      ));

  getIt.registerFactory<WebviewViewModel>(() => WebviewViewModel(
        getIt<RemoveLastLoginTime>(),
        getIt<RemoveToken>(),
        getIt<RemoveSpotstockUser>(),
      ));

  getIt.registerFactory<HomeViewModel>(() => HomeViewModel(
        getIt<GetSpotstockUser>(),
      ));

  getIt.registerFactory<RootViewModel>(() => RootViewModel());

  getIt.registerFactory<HistoryViewModel>(() => HistoryViewModel());

  getIt.registerFactory<SyncViewModel>(() => SyncViewModel());

  getIt.registerFactory<SummaryViewModel>(() => SummaryViewModel());

  getIt.registerFactory<ProfileViewModel>(() => ProfileViewModel(
        getIt<RemoveLastLoginTime>(),
        getIt<GetSpotstockUser>(),
        getIt<RemoveToken>(),
      ));

  getIt.registerFactory<SpotstockNetworkAwareViewModel>(() => SpotstockNetworkAwareViewModel(
        getIt<ListenForNetworkChange>(),
      ));

  getIt.registerFactory<SelectAppViewModel>(() => SelectAppViewModel());

  await getIt.allReady();
}
