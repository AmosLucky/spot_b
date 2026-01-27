import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/app/presentation/view_models/app_view_model.dart';
import '../../features/auth/domain/usecases/check_is_admin.dart';
import '../../features/auth/domain/usecases/save_offline_user.dart';
import '../../features/auth/services/password_hashing_service.dart';
import '../../features/auth/services/salt_generation_service.dart';
import '../../features/holds/data/repositories/deleted_hold_ids_repository_impl.dart';
import '../../features/holds/domain/repositories/deleted_hold_ids_repository.dart';
import '../../features/holds/domain/usecases/delete_hold.dart';
import '../../features/holds/domain/usecases/get_hold.dart';
import '../../features/home/presentation/view_model/spotstock_close_register_form_view_model.dart';
import '../../features/hotel/home/presentation/view_model/hotel_home_viewmodel.dart';
import '../../features/platform/domain/usecases/check_if_is_mobile.dart';
import '../../features/pos/domain/repositories/custom_product_repository.dart';
import '../../features/pos/domain/usecases/get_custom_product_code.dart';
import '../../features/pos/domain/usecases/get_custom_product_id.dart';
import '../../features/apps/presentation/view_model/select_app_view_model.dart';
import '../../features/auth/data/datasources/local/last_login_time_datasource.dart';
import '../../features/auth/data/datasources/local/login_local_datasource.dart';
import '../../features/auth/data/datasources/local/token_datasource.dart';
import '../../features/auth/data/datasources/local/user_datasource.dart';
import '../../features/auth/data/datasources/remote/login_remote_datasource.dart';
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
import '../../features/holds/data/datasources/local/deleted_hold_ids_datasource.dart';
import '../../features/holds/data/datasources/local/holds_local_datasource.dart';
import '../../features/holds/data/datasources/remote/holds_remote_datasource.dart';
import '../../features/holds/data/repositories/grouped_holds_repository_impl.dart';
import '../../features/holds/data/repositories/holds_repository_impl.dart';
import '../../features/holds/domain/repositories/grouped_holds_repository.dart';
import '../../features/holds/domain/repositories/holds_repository.dart';
import '../../features/holds/domain/usecases/create_hold.dart';
import '../../features/holds/domain/usecases/delete_holds.dart';
import '../../features/holds/domain/usecases/get_grouped_holds.dart';
import '../../features/holds/domain/usecases/get_holds.dart';
import '../../features/holds/domain/usecases/sync_deleted_holds.dart';
import '../../features/holds/presentation/view_model/holds_view_model.dart';
import '../../features/holds/presentation/view_model/spotstock_create_hold_form_view_model.dart';
import '../../features/holds/presentation/view_model/spotstock_holds_form_view_model.dart';
import '../../features/home/presentation/view_model/home_view_model.dart';
import '../../features/home/presentation/view_model/root_view_model.dart';
import '../../features/home/presentation/view_model/spotstock_open_register_form_view_model.dart';
import '../../features/network_info/data/repositories/network_info_repository_impl.dart';
import '../../features/network_info/domain/repositories/network_info_repository.dart';
import '../../features/network_info/domain/usecases/check_and_update_network_status.dart';
import '../../features/network_info/domain/usecases/listen_for_network_change.dart';
import '../../features/network_info/network_info_service.dart';
import '../../features/network_info/presentation/view_model/spotstock_network_aware_view_model.dart';
import '../../features/platform/services/platform_service.dart';
import '../../features/pos/data/datasources/local/attendants_local_datasource.dart';
import '../../features/pos/data/datasources/local/bar_tables_local_datasource.dart';
import '../../features/pos/data/datasources/local/customers_local_datasource.dart';
import '../../features/pos/data/datasources/local/product_categories_local_datasource.dart';
import '../../features/pos/data/datasources/local/products_local_datasource.dart';
import '../../features/pos/data/datasources/local/sales_local_datasource.dart';
import '../../features/pos/data/datasources/local/warehouses_local_datasource.dart';
import '../../features/pos/data/datasources/remote/attendants_remote_datasource.dart';
import '../../features/pos/data/datasources/remote/bar_tables_remote_datasource.dart';
import '../../features/pos/data/datasources/remote/customers_remote_datasource.dart';
import '../../features/pos/data/datasources/remote/product_categories_remote_datasource.dart';
import '../../features/pos/data/datasources/remote/products_remote_datasource.dart';
import '../../features/pos/data/datasources/remote/sales_remote_datasource.dart';
import '../../features/pos/data/datasources/remote/warehouses_remote_datasource.dart';
import '../../features/pos/data/repositories/attendants_repository_impl.dart';
import '../../features/pos/data/repositories/bar_tables_repository_impl.dart';
import '../../features/pos/data/repositories/custom_product_repository_impl.dart';
import '../../features/pos/data/repositories/customers_repository_impl.dart';
import '../../features/pos/data/repositories/product_categories_repository_impl.dart';
import '../../features/pos/data/repositories/products_repository_impl.dart';
import '../../features/pos/data/repositories/sales_repository_impl.dart';
import '../../features/pos/data/repositories/warehouse_repository_impl.dart';
import '../../features/pos/domain/repositories/attendants_repository.dart';
import '../../features/pos/domain/repositories/bar_tables_repository.dart';
import '../../features/pos/domain/repositories/customers_repository.dart';
import '../../features/pos/domain/repositories/product_categories_repository.dart';
import '../../features/pos/domain/repositories/products_repository.dart';
import '../../features/pos/domain/repositories/sales_repository.dart';
import '../../features/pos/domain/repositories/warehouses_repository.dart';
import '../../features/pos/domain/usecases/create_customer.dart';
import '../../features/pos/domain/usecases/create_sale.dart';
import '../../features/pos/domain/usecases/get_attendants.dart';
import '../../features/pos/domain/usecases/get_bar_tables.dart';
import '../../features/pos/domain/usecases/get_customers.dart';
import '../../features/pos/domain/usecases/get_product_categories.dart';
import '../../features/pos/domain/usecases/get_products.dart';
import '../../features/pos/domain/usecases/get_warehouses.dart';
import '../../features/pos/domain/usecases/sync_customers.dart';
import '../../features/pos/presentation/view_model/pos_view_model.dart';
import '../../features/pos/presentation/view_model/spotstock_add_custom_product_form_view_model.dart';
import '../../features/pos/presentation/view_model/spotstock_add_new_customer_form_view_model.dart';
import '../../features/pos/presentation/view_model/spotstock_cart_tab_view_model.dart';
import '../../features/pos/presentation/view_model/spotstock_edit_sale_item_form_view_model.dart';
import '../../features/pos/presentation/view_model/spotstock_payment_form_view_model.dart';
import '../../features/pos/presentation/view_model/spotstock_products_tab_view_model.dart';
import '../../features/pos/presentation/view_model/spotstock_select_attendant_form_view_model.dart';
import '../../features/pos/presentation/view_model/spotstock_select_bar_table_form_view_model.dart';
import '../../features/pos/presentation/view_model/spotstock_select_branch_form_view_model.dart';
import '../../features/pos/presentation/view_model/spotstock_select_customer_form_view_model.dart';
import '../../features/profile/presentation/view_model/profile_view_model.dart';
import '../../features/receipt/data/repositories/local_receipt_reference_no_repository_impl.dart';
import '../../features/receipt/data/services/pdf_sale_receipt_service.dart';
import '../../features/receipt/data/services/receipt_reference_no_service_impl.dart';
import '../../features/receipt/domain/repositories/local_receipt_reference_no_repository.dart';
import '../../features/receipt/domain/services/receipt_reference_no_service.dart';
import '../../features/receipt/domain/usecases/generate_receipt_reference_no.dart';
import '../../features/receipt/domain/usecases/print_pdf_receipt.dart';
import '../../features/receipt/domain/usecases/share_pdf_receipt.dart';
import '../../features/register_management/data/datasources/local/get_register_details_local_datasource.dart';
import '../../features/register_management/data/datasources/local/register_local_datasource.dart';
import '../../features/register_management/data/datasources/remote/register_remote_datasource.dart';
import '../../features/register_management/data/repositories/register_repository_impl.dart';
import '../../features/register_management/domain/repositories/register_repository.dart';
import '../../features/register_management/domain/usecases/check_if_register_is_open.dart';
import '../../features/register_management/domain/usecases/close_register.dart';
import '../../features/register_management/domain/usecases/get_pos_registers.dart';
import '../../features/register_management/domain/usecases/get_pos_registers_stream.dart';
import '../../features/register_management/domain/usecases/get_register_details.dart';
import '../../features/register_management/domain/usecases/open_register.dart';
import '../../features/register_management/presentation/view_model/register_management_view_model.dart';
import '../../features/register_management/presentation/view_model/register_summary_view_model.dart';
import '../../features/register_management/presentation/view_model/spotstock_filter_register_form_view_model.dart';
import '../../features/splash/presentation/view_model/splash_view_model.dart';
import '../../features/staff_pin/data/datasources/local/staff_pin_local_datasource.dart';
import '../../features/staff_pin/data/datasources/remote/staff_pin_remote_datasource.dart';
import '../../features/staff_pin/data/repositories/staff_pin_repository_impl.dart';
import '../../features/staff_pin/domain/repositories/staff_pin_repository.dart';
import '../../features/staff_pin/domain/usecases/verify_staff_pin.dart';
import '../../features/staff_pin/presentation/view_model/spotstock_staff_pin_form_view_model.dart';
import '../../features/stock/data/datasources/local/stock_item_local_datasource.dart';
import '../../features/stock/data/datasources/remote/stock_item_remote_datasource.dart';
import '../../features/stock/data/repositories/stock_item_repository_impl.dart';
import '../../features/stock/domain/repositories/stock_item_repository.dart';
import '../../features/stock/domain/usecases/get_stock_items.dart';
import '../../features/summary/presentation/view_model/summary_view_model.dart';
import '../../features/holds/domain/usecases/sync_holds.dart';
import '../../features/sync/domain/usecases/sync_offline_data.dart';
import '../../features/sync/presentation/view_model/sync_view_model.dart';
import '../../features/theme/data/datasources/theme_datasource.dart';
import '../../features/theme/data/repositories/theme_repository_impl.dart';
import '../../features/theme/domain/repositories/theme_repository.dart';
import '../../features/theme/domain/usecases/get_theme.dart';
import '../../features/theme/domain/usecases/set_theme.dart';
import '../../features/webview/presentation/view_model/webview_view_model.dart';
import '../database/database_client.dart';
import '../local_storage/local_storage_client.dart';
import '../networking/dio_client.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ============ CORE DEPENDENCIES ============
  getIt.registerLazySingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  getIt.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());

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
  getIt.registerLazySingleton<DatabaseClient>(() => DatabaseClient());
  getIt.registerLazySingleton<NetworkInfoService>(
      () => NetworkInfoService()..start());
  getIt.registerLazySingleton<PdfSaleReceiptService>(
      () => PdfSaleReceiptService());
  getIt.registerLazySingleton<ReceiptReferenceNoService>(
      () => ReceiptReferenceNoServiceImpl());
  getIt.registerLazySingleton<SaltGenerationService>(
      () => SaltGenerationService());
  getIt.registerLazySingleton<PasswordHashingService>(
      () => PasswordHashingService());

  // ============ DATASOURCES ============
  getIt.registerLazySingleton<LoginRemoteDatasource>(
      () => LoginRemoteDatasource(getIt<DioClient>()));
  getIt.registerLazySingleton<LastLoginTimeDatasource>(
    () => LastLoginTimeDatasource(getIt<LocalStorageClient>()),
  );
  getIt.registerLazySingleton<TokenDatasource>(
    () => TokenDatasource(getIt<LocalStorageClient>()),
  );
  getIt.registerLazySingleton<UserDatasource>(
    () => UserDatasource(getIt<LocalStorageClient>()),
  );
  getIt.registerLazySingleton<BarTablesRemoteDatasource>(
    () => BarTablesRemoteDatasource(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<WarehousesRemoteDatasource>(
    () => WarehousesRemoteDatasource(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<ProductsRemoteDatasource>(
    () => ProductsRemoteDatasource(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<ProductCategoriesRemoteDatasource>(
    () => ProductCategoriesRemoteDatasource(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<CustomersRemoteDatasource>(
    () => CustomersRemoteDatasource(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<AttendantsRemoteDatasource>(
    () => AttendantsRemoteDatasource(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<AttendantsLocalDatasource>(
    () => AttendantsLocalDatasource(getIt<DatabaseClient>()),
  );
  getIt.registerLazySingleton<CustomersLocalDatasource>(
    () => CustomersLocalDatasource(getIt<DatabaseClient>()),
  );
  getIt.registerLazySingleton<BarTablesLocalDatasource>(
    () => BarTablesLocalDatasource(getIt<DatabaseClient>()),
  );
  getIt.registerLazySingleton<WarehousesLocalDatasource>(
    () => WarehousesLocalDatasource(getIt<DatabaseClient>()),
  );
  getIt.registerLazySingleton<ProductsLocalDatasource>(
    () => ProductsLocalDatasource(getIt<DatabaseClient>()),
  );
  getIt.registerLazySingleton<ProductCategoriesLocalDatasource>(
    () => ProductCategoriesLocalDatasource(getIt<DatabaseClient>()),
  );
  getIt.registerLazySingleton<GetRegisterDetailsLocalDatasource>(
    () => GetRegisterDetailsLocalDatasource(getIt<DatabaseClient>()),
  );
  getIt.registerLazySingleton<RegisterLocalDatasource>(
    () => RegisterLocalDatasource(
      getIt<DatabaseClient>(),
      getIt<GetRegisterDetailsLocalDatasource>(),
      getIt<UserDatasource>(),
    ),
  );
  getIt.registerLazySingleton<SalesLocalDatasource>(
    () => SalesLocalDatasource(getIt<DatabaseClient>()),
  );
  getIt.registerLazySingleton<SalesRemoteDatasource>(
    () => SalesRemoteDatasource(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<StaffPinLocalDatasource>(
    () => StaffPinLocalDatasource(getIt<LocalStorageClient>()),
  );
  getIt.registerLazySingleton<StaffPinRemoteDatasource>(
    () => StaffPinRemoteDatasource(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<HoldsLocalDatasource>(
    () => HoldsLocalDatasource(getIt<DatabaseClient>()),
  );
  getIt.registerLazySingleton<HoldsRemoteDatasource>(
    () => HoldsRemoteDatasource(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<DeletedHoldIdsDatasource>(
    () => DeletedHoldIdsDatasource(getIt<LocalStorageClient>()),
  );
  getIt.registerLazySingleton<LoginLocalDatasource>(
    () => LoginLocalDatasource(
      getIt<SaltGenerationService>(),
      getIt<PasswordHashingService>(),
      getIt<LocalStorageClient>(),
    ),
  );
  getIt.registerLazySingleton<ThemeDatasource>(
    () => ThemeDatasource(getIt<LocalStorageClient>()),
  );
  getIt.registerLazySingleton<RegisterRemoteDatasource>(
    () => RegisterRemoteDatasource(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<StockItemRemoteDatasource>(
    () => StockItemRemoteDatasource(getIt<DioClient>()),
  );
  getIt.registerLazySingleton<StockItemLocalDatasource>(
    () => StockItemLocalDatasource(getIt<DatabaseClient>()),
  );

  // ============ REPOSITORIES ============
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      getIt<LoginRemoteDatasource>(),
      getIt<LoginLocalDatasource>(),
      getIt<NetworkInfoRepository>(),
    ),
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
  getIt.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(
      getIt<RegisterLocalDatasource>(),
      getIt<RegisterRemoteDatasource>(),
      getIt<NetworkInfoRepository>(),
    ),
  );
  getIt.registerLazySingleton<AttendantsRepository>(
    () => AttendantsRepositoryImpl(
      getIt<AttendantsLocalDatasource>(),
      getIt<AttendantsRemoteDatasource>(),
      getIt<NetworkInfoRepository>(),
    ),
  );
  getIt.registerLazySingleton<BarTablesRepository>(
    () => BarTablesRepositoryImpl(
      getIt<BarTablesLocalDatasource>(),
      getIt<BarTablesRemoteDatasource>(),
      getIt<NetworkInfoRepository>(),
    ),
  );
  getIt.registerLazySingleton<CustomersRepository>(
    () => CustomersRepositoryImpl(
      getIt<CustomersLocalDatasource>(),
      getIt<CustomersRemoteDatasource>(),
      getIt<NetworkInfoRepository>(),
    ),
  );
  getIt.registerLazySingleton<ProductCategoriesRepository>(
    () => ProductCategoriesRepositoryImpl(
      getIt<ProductCategoriesLocalDatasource>(),
      getIt<ProductCategoriesRemoteDatasource>(),
      getIt<NetworkInfoRepository>(),
    ),
  );
  getIt.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(
      getIt<ProductsLocalDatasource>(),
      getIt<ProductsRemoteDatasource>(),
      getIt<NetworkInfoRepository>(),
    ),
  );
  getIt.registerLazySingleton<WarehousesRepository>(
    () => WarehousesRepositoryImpl(
      getIt<WarehousesLocalDatasource>(),
      getIt<WarehousesRemoteDatasource>(),
      getIt<NetworkInfoRepository>(),
    ),
  );
  getIt.registerLazySingleton<LocalReceiptReferenceNoRepository>(
    () => LocalReceiptReferenceNoRepositoryImpl(
        getIt<ReceiptReferenceNoService>()),
  );
  getIt.registerLazySingleton<SalesRepository>(
    () => SalesRepositoryImpl(
      getIt<SalesLocalDatasource>(),
      getIt<SalesRemoteDatasource>(),
      getIt<LocalReceiptReferenceNoRepository>(),
      getIt<NetworkInfoRepository>(),
    ),
  );
  getIt.registerLazySingleton<StaffPinRepository>(
    () => StaffPinRepositoryImpl(
      getIt<StaffPinLocalDatasource>(),
      getIt<StaffPinRemoteDatasource>(),
      getIt<NetworkInfoRepository>(),
    ),
  );
  getIt.registerLazySingleton<HoldsRepository>(
    () => HoldsRepositoryImpl(
      getIt<HoldsRemoteDatasource>(),
      getIt<HoldsLocalDatasource>(),
      getIt<DeletedHoldIdsDatasource>(),
      getIt<LocalReceiptReferenceNoRepository>(),
      getIt<NetworkInfoRepository>(),
    ),
  );
  getIt.registerLazySingleton<GroupedHoldsRepository>(
    () => GroupedHoldsRepositoryImpl(
      getIt<HoldsRepository>(),
    ),
  );
  getIt.registerLazySingleton<DeletedHoldIdsRepository>(
    () => DeletedHoldIdsRepositoryImpl(
      getIt<DeletedHoldIdsDatasource>(),
      getIt<HoldsRemoteDatasource>(),
    ),
  );
  getIt.registerLazySingleton<CustomProductRepository>(
    () => CustomProductRepositoryImpl(),
  );
  getIt.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(getIt<ThemeDatasource>()),
  );
  getIt.registerLazySingleton<StockItemRepository>(
    () => StockItemRepositoryImpl(
      getIt<StockItemRemoteDatasource>(),
      getIt<StockItemLocalDatasource>(),
      getIt<NetworkInfoRepository>(),
    ),
  );

  // ============ USE CASES ============
  getIt.registerLazySingleton<Login>(() => Login(getIt<LoginRepository>()));
  getIt.registerLazySingleton<GetToken>(
      () => GetToken(getIt<TokenRepository>()));
  getIt.registerLazySingleton<GetSpotstockUser>(
      () => GetSpotstockUser(getIt<UserRepository>()));
  getIt.registerLazySingleton<GetLastLoginTime>(
      () => GetLastLoginTime(getIt<LastLoginTimeRepository>()));
  getIt.registerLazySingleton<SaveToken>(
      () => SaveToken(getIt<TokenRepository>()));
  getIt.registerLazySingleton<SaveSpotstockUser>(
      () => SaveSpotstockUser(getIt<UserRepository>()));
  getIt.registerLazySingleton<SaveLastLoginTime>(
      () => SaveLastLoginTime(getIt<LastLoginTimeRepository>()));
  getIt.registerLazySingleton<RemoveLastLoginTime>(
      () => RemoveLastLoginTime(getIt<LastLoginTimeRepository>()));
  getIt.registerLazySingleton<RemoveToken>(
      () => RemoveToken(getIt<TokenRepository>()));
  getIt.registerLazySingleton<RemoveSpotstockUser>(
      () => RemoveSpotstockUser(getIt<UserRepository>()));
  getIt.registerLazySingleton<ListenForNetworkChange>(
      () => ListenForNetworkChange(getIt<NetworkInfoRepository>()));
  getIt.registerLazySingleton<CheckIfRegisterIsOpen>(
      () => CheckIfRegisterIsOpen(getIt<RegisterRepository>()));
  getIt.registerLazySingleton<OpenRegister>(
      () => OpenRegister(getIt<RegisterRepository>()));
  getIt.registerLazySingleton<CloseRegister>(
      () => CloseRegister(getIt<RegisterRepository>()));
  getIt.registerLazySingleton<CheckAndUpdateNetworkStatus>(
      () => CheckAndUpdateNetworkStatus(getIt<NetworkInfoRepository>()));
  getIt.registerLazySingleton<GetAttendants>(
      () => GetAttendants(getIt<AttendantsRepository>()));
  getIt.registerLazySingleton<GetBarTables>(
      () => GetBarTables(getIt<BarTablesRepository>()));
  getIt.registerLazySingleton<GetCustomers>(
      () => GetCustomers(getIt<CustomersRepository>()));
  getIt.registerLazySingleton<GetProductCategories>(
      () => GetProductCategories(getIt<ProductCategoriesRepository>()));
  getIt.registerLazySingleton<GetProducts>(
      () => GetProducts(getIt<ProductsRepository>()));
  getIt.registerLazySingleton<GetWarehouses>(
      () => GetWarehouses(getIt<WarehousesRepository>()));
  getIt.registerLazySingleton<CreateSale>(
      () => CreateSale(getIt<SalesRepository>()));
  getIt.registerLazySingleton<PrintPdfReceipt>(() => PrintPdfReceipt(
      getIt<PdfSaleReceiptService>(), getIt<GetSpotstockUser>()));
  getIt.registerLazySingleton<SharePdfReceipt>(() => SharePdfReceipt(
      getIt<PdfSaleReceiptService>(), getIt<GetSpotstockUser>()));
  getIt.registerLazySingleton<GenerateReceiptReferenceNo>(
      () => GenerateReceiptReferenceNo(getIt<ReceiptReferenceNoService>()));
  getIt.registerLazySingleton<VerifyStaffPin>(
      () => VerifyStaffPin(getIt<StaffPinRepository>()));
  getIt.registerLazySingleton<GetGroupedHolds>(
      () => GetGroupedHolds(getIt<GroupedHoldsRepository>()));
  getIt.registerLazySingleton<GetHolds>(
      () => GetHolds(getIt<HoldsRepository>()));
  getIt.registerLazySingleton<CreateHold>(
      () => CreateHold(getIt<HoldsRepository>()));
  getIt.registerLazySingleton<SyncHolds>(
      () => SyncHolds(getIt<HoldsRepository>()));
  getIt.registerLazySingleton<SyncCustomers>(
      () => SyncCustomers(getIt<CustomersRepository>()));
  getIt.registerLazySingleton<SyncOfflineData>(
    () => SyncOfflineData(
      [
        getIt<SyncHolds>(),
        getIt<SyncDeletedHolds>(),
        getIt<SyncCustomers>(),
      ],
    ),
  );
  getIt.registerLazySingleton<DeleteHold>(
      () => DeleteHold(getIt<HoldsRepository>()));
  getIt.registerLazySingleton<DeleteHolds>(
      () => DeleteHolds(getIt<HoldsRepository>()));
  getIt.registerLazySingleton<GetHold>(() => GetHold(getIt<HoldsRepository>()));
  getIt.registerLazySingleton<SyncDeletedHolds>(
      () => SyncDeletedHolds(getIt<DeletedHoldIdsRepository>()));
  getIt.registerLazySingleton<CheckIsAdmin>(
      () => CheckIsAdmin(getIt<UserRepository>()));
  getIt.registerLazySingleton<SaveOfflineUser>(
      () => SaveOfflineUser(getIt<LoginLocalDatasource>()));
  getIt.registerLazySingleton<GetCustomProductId>(
      () => GetCustomProductId(getIt<CustomProductRepository>()));
  getIt.registerLazySingleton<GetCustomProductCode>(
      () => GetCustomProductCode(getIt<CustomProductRepository>()));
  getIt.registerLazySingleton<CreateCustomer>(
      () => CreateCustomer(getIt<CustomersRepository>()));
  getIt.registerLazySingleton<CheckIfIsMobile>(
      () => CheckIfIsMobile(getIt<PlatformService>()));
  getIt.registerLazySingleton<GetTheme>(
      () => GetTheme(getIt<ThemeRepository>()));
  getIt.registerLazySingleton<SetTheme>(
      () => SetTheme(getIt<ThemeRepository>()));
  getIt.registerLazySingleton<GetRegisterDetails>(
      () => GetRegisterDetails(getIt<RegisterRepository>()));
  getIt.registerLazySingleton<GetStockItems>(
      () => GetStockItems(getIt<StockItemRepository>()));
  getIt.registerLazySingleton<GetPOSRegisters>(
      () => GetPOSRegisters(getIt<RegisterRepository>()));
  getIt.registerLazySingleton<GetPOSRegistersStream>(
      () => GetPOSRegistersStream(getIt<RegisterRepository>()));

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
        getIt<SaveOfflineUser>(),
      ));

  getIt.registerFactory<WebviewViewModel>(() => WebviewViewModel(
        getIt<RemoveLastLoginTime>(),
        getIt<RemoveToken>(),
        getIt<RemoveSpotstockUser>(),
      ));

  getIt.registerLazySingleton<HomeViewModel>(() => HomeViewModel(
        getIt<GetSpotstockUser>(),
      ));

  getIt.registerFactory<RootViewModel>(() => RootViewModel());

  getIt.registerFactory<HistoryViewModel>(() => HistoryViewModel());

  getIt.registerFactory<SyncViewModel>(() => SyncViewModel());

  getIt.registerFactory<SummaryViewModel>(() => SummaryViewModel());

  getIt.registerFactory<SpotstockNetworkAwareViewModel>(
      () => SpotstockNetworkAwareViewModel(
            getIt<ListenForNetworkChange>(),
            getIt<SyncOfflineData>(),
          ));

  getIt.registerFactory<SelectAppViewModel>(
    () => SelectAppViewModel(
      getIt<GetSpotstockUser>(),
      getIt<CheckAndUpdateNetworkStatus>(),
      getIt<CheckIfRegisterIsOpen>(),
    ),
  );

  getIt.registerLazySingleton<PosViewModel>(() => PosViewModel(
        getIt<CheckAndUpdateNetworkStatus>(),
        getIt<GetAttendants>(),
        getIt<GetBarTables>(),
        getIt<GetCustomers>(),
        getIt<GetProductCategories>(),
        getIt<GetProducts>(),
        getIt<GetWarehouses>(),
        getIt<CreateSale>(),
        getIt<PrintPdfReceipt>(),
        getIt<SharePdfReceipt>(),
        getIt<GetGroupedHolds>(),
        getIt<CreateHold>(),
        getIt<DeleteHold>(),
        getIt<DeleteHolds>(),
        getIt<CreateCustomer>(),
      ));
  getIt.registerFactory<SpotstockProductsTabViewModel>(
      () => SpotstockProductsTabViewModel());
  getIt.registerFactory<SpotstockCartTabViewModel>(
      () => SpotstockCartTabViewModel(getIt<GetHold>()));
  getIt.registerFactory<HoldsViewModel>(() => HoldsViewModel(
        getIt<GetHolds>(),
        getIt<DeleteHold>(),
        getIt<GetSpotstockUser>(),
      ));
  getIt.registerLazySingleton<AppViewModel>(() => AppViewModel(
      getIt<GetTheme>(), getIt<SetTheme>(), getIt<CheckIfIsMobile>()));

  getIt.registerFactory<ProfileViewModel>(() => ProfileViewModel(
        getIt<AppViewModel>(),
        getIt<RemoveLastLoginTime>(),
        getIt<GetSpotstockUser>(),
        getIt<RemoveToken>(),
        getIt<GetTheme>(),
        getIt<SetTheme>(),
      ));

  getIt
      .registerFactory<RegisterSummaryViewModel>(() => RegisterSummaryViewModel(
            getIt<GetRegisterDetails>(),
            getIt<GetStockItems>(),
          ));

  getIt.registerFactory<RegisterManagementViewModel>(
      () => RegisterManagementViewModel(
            getIt<GetPOSRegisters>(),
            getIt<GetPOSRegistersStream>(),
          ));

  ////DESKTOP////
  ///HOTEL ///
  getIt.registerFactory<HotelHomeViewmodel>(() => HotelHomeViewmodel());

  // ============ FORM VIEW MODELS ============
  // Register as factories so fresh instances are created each time
  getIt.registerFactory<SpotstockOpenRegisterFormViewModel>(
      () => SpotstockOpenRegisterFormViewModel(getIt<OpenRegister>()));
  getIt.registerFactory<SpotstockSelectAttendantFormViewModel>(
      () => SpotstockSelectAttendantFormViewModel());
  getIt.registerFactory<SpotstockSelectBranchFormViewModel>(
      () => SpotstockSelectBranchFormViewModel());
  getIt.registerFactory<SpotstockSelectBarTableFormViewModel>(
      () => SpotstockSelectBarTableFormViewModel());
  getIt.registerFactory<SpotstockSelectCustomerFormViewModel>(
      () => SpotstockSelectCustomerFormViewModel(getIt<GetCustomers>()));
  getIt.registerFactory<SpotstockEditSaleItemFormViewModel>(
      () => SpotstockEditSaleItemFormViewModel());
  getIt.registerFactory<SpotstockPaymentFormViewModel>(
      () => SpotstockPaymentFormViewModel());
  getIt.registerFactory<SpotstockStaffPinFormViewModel>(
      () => SpotstockStaffPinFormViewModel(getIt<VerifyStaffPin>()));
  getIt.registerFactory<SpotstockHoldsFormViewModel>(
      () => SpotstockHoldsFormViewModel(getIt<GetGroupedHolds>()));
  getIt.registerFactory<SpotstockCreateHoldFormViewModel>(
      () => SpotstockCreateHoldFormViewModel());
  getIt.registerFactory<SpotstockAddCustomProductFormViewModel>(
    () => SpotstockAddCustomProductFormViewModel(
      getIt<GetCustomProductId>(),
      getIt<GetCustomProductCode>(),
    ),
  );
  getIt.registerFactory<SpotstockAddNewCustomerFormViewModel>(
      () => SpotstockAddNewCustomerFormViewModel());
  getIt.registerFactory<SpotstockCloseRegisterFormViewModel>(
      () => SpotstockCloseRegisterFormViewModel(getIt<CloseRegister>()));
  getIt.registerFactory<SpotstockFilterRegisterFormViewModel>(
      () => SpotstockFilterRegisterFormViewModel());

  await getIt.allReady();
}
