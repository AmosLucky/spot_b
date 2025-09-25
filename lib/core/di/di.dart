import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
import '../../features/platform/platform_service.dart';
import '../../features/splash/presentation/view_model/splash_view_model.dart';
import '../../features/webview/presentation/view_model/webview_view_model.dart';
import '../local_storage/local_storage_client.dart';
import '../networking/dio_client.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ============ CORE DEPENDENCIES ============
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  getIt.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());

  // ============ SERVICES ============
  getIt.registerLazySingleton<PlatformService>(() => PlatformService());
  getIt.registerLazySingleton<DioClient>(() => DioClient());
  getIt.registerLazySingleton<LocalStorageClient>(() => LocalStorageClient(
        sharedPreferences: getIt<SharedPreferences>(),
        secureStorage: getIt<FlutterSecureStorage>(),
      ));

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
}
