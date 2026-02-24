import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spotstock_inventory/core/routing/router.dart';
import 'dart:async';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/di/di.dart';
import '../../../../core/error_handling/app_error.dart';
import '../../../../core/networking/spotstock_status_code.dart';
import '../../../../core/presentation/banners/spotstock_dialog_warning_banner.dart';
import '../../../../core/presentation/bottom_sheets/spotstock_bottom_sheet.dart';
import '../../../../core/presentation/buttons/spotstock_floating_action_button.dart';
import '../../../../core/presentation/buttons/spotstock_primary_button.dart';
import '../../../../core/presentation/buttons/spotstock_secondary_button.dart';
import '../../../../core/presentation/dates/datetime_extension.dart';
import '../../../../core/presentation/dialogs/spotstock_dialog.dart';
import '../../../../core/presentation/progress_indicators/spotstock_progress_indicator.dart';
import '../../../../core/presentation/snackbars/spotstock_snackbar.dart';
import '../../../../core/presentation/snackbars/spotstock_snackbar_type.dart';
import '../../../../core/presentation/view_models/spotstock_view_model.dart';
import '../../../home/presentation/view_model/spotstock_close_register_form_view_model.dart';
import '../../../home/presentation/widgets/spotstock_close_register_form.dart';
import '../../../pos/domain/usecases/create_customer.dart';
import '../../../holds/data/models/create_hold_dto.dart';
import '../../../holds/data/models/grouped_hold.dart';
import '../../../holds/data/models/hold.dart';
import '../../../holds/domain/usecases/create_hold.dart';
import '../../../holds/domain/usecases/delete_hold.dart';
import '../../../holds/domain/usecases/delete_holds.dart';
import '../../../holds/domain/usecases/get_grouped_holds.dart';
import '../../../holds/presentation/view_model/spotstock_create_hold_form_view_model.dart';
import '../../../holds/presentation/view_model/spotstock_holds_form_view_model.dart';
import '../../../holds/presentation/widget/spotstock_create_hold_form.dart';
import '../../../holds/presentation/widget/spotstock_hold_created_bottom_sheet.dart';
import '../../../holds/presentation/widget/spotstock_holds_form.dart';
import '../../../staff_pin/presentation/view_model/spotstock_staff_pin_form_view_model.dart';
import '../../../../core/routing/navigation.dart';
import '../../../../core/shared/command.dart';
import '../../../../core/shared/result.dart';
import '../../../network_info/domain/usecases/check_and_update_network_status.dart';
import '../../../receipt/data/models/extra_receipt_details.dart';
import '../../../receipt/domain/usecases/print_pdf_receipt.dart';
import '../../../receipt/domain/usecases/share_pdf_receipt.dart';
import '../../../staff_pin/presentation/widget/spotstock_staff_pin_form.dart';
import '../../constants/spotstock_sale_creation_constant.dart';
import '../../data/enums/enums.dart';
import '../../data/mappers/sale_mapper.dart';
import '../../data/models/attendant.dart';
import '../../data/models/bar_table.dart';
import '../../data/models/create_customer_dto.dart';
import '../../data/models/create_sale_dto.dart';
import '../../data/models/customer.dart';
import '../../data/models/product.dart';
import '../../data/models/product_category.dart';
import '../../data/models/sellable_product.dart';
import '../../data/models/warehouse.dart';
import '../../domain/errors/errors.dart';
import '../../domain/usecases/create_sale.dart';
import '../../domain/usecases/get_attendants.dart';
import '../../domain/usecases/get_bar_tables.dart';
import '../../domain/usecases/get_customers.dart';
import '../../domain/usecases/get_product_categories.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/get_warehouses.dart';
import '../widget/spotstock_add_custom_product_form.dart';
import '../widget/spotstock_add_new_customer_form.dart';
import '../widget/spotstock_edit_sale_item_form.dart';
import '../widget/spotstock_payment_form.dart';
import '../widget/spotstock_sale_created_bottom_sheet.dart';
import '../widget/spotstock_select_attendant_form.dart';
import '../widget/spotstock_select_bar_table_form.dart';
import '../widget/spotstock_select_branch_form.dart';
import '../widget/spotstock_select_customer_form.dart';
import 'spotstock_add_custom_product_form_view_model.dart';
import 'spotstock_add_new_customer_form_view_model.dart';
import 'spotstock_edit_sale_item_form_view_model.dart';
import 'spotstock_payment_form_view_model.dart';
import 'spotstock_select_attendant_form_view_model.dart';
import 'spotstock_select_bar_table_form_view_model.dart';
import 'spotstock_select_branch_form_view_model.dart';
import 'spotstock_select_customer_form_view_model.dart';

class PosViewModel extends SpotstockViewModel with SpotstockDialogMixin, SpotstockSnackbarMixin, SpotstockBottomSheetMixin {
  final CheckAndUpdateNetworkStatus checkAndUpdateNetworkStatus;
  final GetAttendants getAttendants;
  final GetBarTables getBarTables;
  final GetCustomers getCustomers;
  final GetProductCategories getProductCategories;
  final GetProducts getProducts;
  final GetWarehouses getWarehouses;
  final CreateSale createSale;
  final PrintPdfReceipt printPdfReceipt;
  final SharePdfReceipt sharePdfReceipt;
  final GetGroupedHolds getGroupedHolds;
  final CreateHold createHold;
  final DeleteHold deleteHold;
  final DeleteHolds deleteHolds;
  final CreateCustomer createCustomer;

  PosViewModel(
    this.checkAndUpdateNetworkStatus,
    this.getAttendants,
    this.getBarTables,
    this.getCustomers,
    this.getProductCategories,
    this.getProducts,
    this.getWarehouses,
    this.createSale,
    this.printPdfReceipt,
    this.sharePdfReceipt,
    this.getGroupedHolds,
    this.createHold,
    this.deleteHold,
    this.deleteHolds,
    this.createCustomer,
  );

  CreateSaleDto _createSaleDto = CreateSaleDto(
    taxAmount: SpotstockSaleCreationConstant.taxAmount,
  );
  CreateSaleDto get createSaleDto => _createSaleDto;

  int get cartCount => _createSaleDto.saleItems?.length ?? 0;

  double get taxAmount => _createSaleDto.taxAmount ?? 0;

  double get subTotal {
    final saleItems = _createSaleDto.saleItems ?? [];
    return saleItems.fold<double>(0, (sum, item) => sum + (item.subTotal ?? 0));
  }

  double get grandTotal {
    final tax = taxAmount;
    final shipping = _createSaleDto.shipping ?? 0;
    final discount = _createSaleDto.discountAmount ?? 0;
    final total = (subTotal + tax + shipping) - discount;
    final grandTotal = total < 0 ? 0 : total;
    return grandTotal.toDouble();
  }

  List<Attendant> _attendants = [];
  List<Attendant> get attendants => _attendants;
  Attendant? get selectedAttendant {
    final id = _createSaleDto.attendantId;
    if (id == null) return null;
    return _attendants.where((a) => a.id == id).firstOrNull;
  }

  bool get isAttendantSelected => _createSaleDto.attendantId != null;

  List<Warehouse> _branches = [];
  List<Warehouse> get branches => _branches;
  Warehouse? get selectedBranch {
    final id = _createSaleDto.warehouseId;
    if (id == null) return null;
    return _branches.where((b) => b.id == id).firstOrNull;
  }

  bool get isBranchSelected => _createSaleDto.warehouseId != null;

  List<BarTable> _barTables = [];
  List<BarTable> get barTables => _barTables;

  BarTable? _selectedBarTable;
  BarTable? get selectedBarTable => _selectedBarTable;
  bool get isBarTableSelected => _selectedBarTable != null;

  List<Customer> _customers = [];
  List<Customer> get customers => _customers;

  Customer? get selectedCustomer {
    final id = _createSaleDto.customerId;

    if (id != null) {
      final matchingCustomer = _customers.where((c) => c.id == id).firstOrNull;
      if (matchingCustomer != null) {
        return matchingCustomer;
      }
    }

    final customerName = _createSaleDto.offlineCustomerName ?? _createSaleDto.customerName;
    if (customerName != null) {
      return Customer(
        id: id,
        name: customerName,
        isSynced: true,
      );
    }

    return null;
  }

  bool get isCustomerSelected => _createSaleDto.customerId != null || _createSaleDto.offlineCustomerName != null;

  List<ProductCategory> _productCategories = [];
  List<ProductCategory> get productCategories => _productCategories;

  List<Product> _products = [];
  List<Product> get products => _products;

  final List<Product> _customProducts = [];
  List<Product> get customProducts => _customProducts;

  List<Product> _allSpotstockProducts = [];
  List<Product> get allSpotstockProducts => _allSpotstockProducts;

  List<Product> get cartTabProducts {
    return <Product>[..._products, ..._allSpotstockProducts, ..._customProducts];
  }

  List<GroupedHold> _groupedHolds = [];
  List<GroupedHold> get groupedHolds => _groupedHolds;

  GroupedHold? _selectedGroupedHold;
  GroupedHold? get selectedGroupedHold => _selectedGroupedHold;

  Hold? _selectedHold;
  Hold? get selectedHold => _selectedHold;

  Command0<void>? _getAttendantsCommand;
  Command0<void> get getAttendantsCommand {
    _getAttendantsCommand ??= Command0<void>(_getAttendants)..execute();
    return _getAttendantsCommand!;
  }

  Command0<void>? _getBarTablesCommand;
  Command0<void> get getBarTablesCommand {
    _getBarTablesCommand ??= Command0<void>(_getBarTables)..execute();
    return _getBarTablesCommand!;
  }

  Command0<void>? _getCustomersCommand;
  Command0<void> get getCustomersCommand {
    _getCustomersCommand ??= Command0<void>(_getCustomers)..execute();
    return _getCustomersCommand!;
  }

  Command0<void>? _getProductCategoriesCommand;
  Command0<void> get getProductCategoriesCommand {
    _getProductCategoriesCommand ??= Command0<void>(_getProductCategories)..execute();
    return _getProductCategoriesCommand!;
  }

  Command0<void>? _getProductsCommand;
  Command0<void> get getProductsCommand {
    _getProductsCommand ??= Command0<void>(_getProducts);
    return _getProductsCommand!;
  }

  Command0<void>? _getAllProductsCommand;
  Command0<void> get getAllProductsCommand {
    _getAllProductsCommand ??= Command0<void>(_getAllProducts);
    return _getAllProductsCommand!;
  }

  Command0<void>? _getWarehousesCommand;
  Command0<void> get getWarehousesCommand {
    _getWarehousesCommand ??= Command0<void>(_getWarehouses)..execute();
    return _getWarehousesCommand!;
  }

  Command0<void>? _getGroupedHoldsCommand;
  Command0<void> get getGroupedHoldsCommand {
    _getGroupedHoldsCommand ??= Command0<void>(_getGroupedHolds);
    return _getGroupedHoldsCommand!;
  }

  Command1<void, BuildContext>? _createSaleCommand;
  Command1<void, BuildContext> get createSaleCommand {
    _createSaleCommand ??= Command1<void, BuildContext>(_createSale);
    return _createSaleCommand!;
  }

  Command1<void, BuildContext>? _createHoldCommand;
  Command1<void, BuildContext> get createHoldCommand {
    _createHoldCommand ??= Command1<void, BuildContext>(_createHold);
    return _createHoldCommand!;
  }

  Command2<void, BuildContext, CreateCustomerDto>? _createCustomerCommand;
  Command2<void, BuildContext, CreateCustomerDto> get createCustomerCommand {
    _createCustomerCommand ??= Command2<void, BuildContext, CreateCustomerDto>(_createCustomer);
    return _createCustomerCommand!;
  }

  TabController? _tabController;
  TabController? get tabController => _tabController;

  final TextEditingController _discountController = TextEditingController();
  TextEditingController get discountController => _discountController;

  final TextEditingController _shippingController = TextEditingController();
  TextEditingController get shippingController => _shippingController;

  bool get canPay {
    return cartCount > 0 && isBranchSelected && isAttendantSelected;
  }

  bool get isGroupedHold {
    return _selectedGroupedHold != null;
  }

  bool get isSingleHold {
    return _selectedHold != null;
  }

  bool get isHold {
    return isGroupedHold || isSingleHold;
  }

  bool get isHoldSaleGuard {
    if (isHold) {
      showErrorSnackbar(
        AppError(message: SpotstockStrings.holdCannotBeEdited),
        title: SpotstockStrings.actionNotAllowed,
        subtitle: SpotstockStrings.holdCannotBeEdited,
      );
      return false;
    }
    return true;
  }

  @override
  void bind(BuildContext context, {CreateSaleDto? createSaleDto, TabController? tabController}) async {
    if (createSaleDto != null) {
      _createSaleDto = createSaleDto;
      _discountController.text = createSaleDto.discount?.toString() ?? SpotstockStrings.EMPTY;
      _shippingController.text = createSaleDto.shipping?.toString() ?? SpotstockStrings.EMPTY;
    }

    if (tabController != null) {
      _tabController = tabController;
    }

    _createSaleCommand ??= Command1<void, BuildContext>(_createSale)..addListener(() => notifyListeners());
    _getWarehousesCommand = Command0<void>(_getWarehouses)..execute();
    _getAttendantsCommand = Command0<void>(_getAttendants)..execute();
    _getBarTablesCommand = Command0<void>(_getBarTables)..execute();
    _getCustomersCommand = Command0<void>(_getCustomers)..execute();
    _getProductCategoriesCommand = Command0<void>(_getProductCategories)..execute();
    _getGroupedHoldsCommand = Command0<void>(_getGroupedHolds)..execute();
    _getAllProductsCommand = Command0<void>(_getAllProducts)..execute();
    _getProductsCommand ??= Command0<void>(_getProducts);
    _createHoldCommand ??= Command1<void, BuildContext>(_createHold)..addListener(() => notifyListeners());
    _createCustomerCommand ??= Command2<void, BuildContext, CreateCustomerDto>(_createCustomer)..addListener(() => notifyListeners());
    await checkAndUpdateNetworkStatus();
  }

  Future<Result<void>> _getAttendants() async {
    getAttendants().listen((result) {
      result.when(
        onSuccess: (attendants) {
          _attendants = attendants;
          notifyListeners();
        },
        onFailure: (error) {
          addError(error);
        },
      );
    });
    return Result.success(null);
  }

  Future<Result<void>> _getBarTables() async {
    getBarTables().listen((result) {
      result.when(
        onSuccess: (barTables) {
          _barTables = barTables;
          notifyListeners();
        },
        onFailure: (error) {
          addError(error);
        },
      );
    });
    return Result.success(null);
  }

  Future<Result<void>> _getCustomers() async {
    getCustomers().listen((result) {
      result.when(
        onSuccess: (customers) {
          _customers = customers;
          notifyListeners();
        },
        onFailure: (error) {
          addError(error);
        },
      );
    });
    return Result.success(null);
  }

  Future<Result<void>> _getProductCategories() async {
    getProductCategories().listen((result) {
      result.when(
        onSuccess: (productCategories) {
          _productCategories = productCategories;
          notifyListeners();
        },
        onFailure: (error) {
          addError(error);
        },
      );
    });
    return Result.success(null);
  }

  Future<Result<void>> _getProducts() async {
    final stream = getProducts(warehouseId: selectedBranch?.id);
    await for (final result in stream) {
      result.when(
        onSuccess: (products) {
          _products = products;
          notifyListeners();
        },
        onFailure: (error) => addError(error),
      );
    }
    return Result.success(null);
  }

  Future<Result<void>> _getAllProducts() async {
    final stream = getProducts();
    await for (final result in stream) {
      result.when(
        onSuccess: (allSpotstockProducts) {
          _allSpotstockProducts = allSpotstockProducts;
          notifyListeners();
        },
        onFailure: (error) {
          addError(error);
        },
      );
    }
    return Result.success(null);
  }

  Future<Result<void>> _getWarehouses() async {
    final stream = getWarehouses();
    await for (final result in stream) {
      result.when(
        onSuccess: (branches) {
          _branches = branches;
          if (selectedBranch == null && branches.isNotEmpty) {
            _createSaleDto = _createSaleDto.copyWith(
              warehouseId: branches.first.id,
              warehouseName: branches.first.name,
            );
          }
          notifyListeners();
          if (_products.isEmpty) {
            getProductsCommand.execute();
          }
        },
        onFailure: (error) {
          addError(error);
        },
      );
    }
    return Result.success(null);
  }

  Future<Result<void>> _getGroupedHolds() async {
    getGroupedHolds().listen((result) {
      result.when(
        onSuccess: (groupedHolds) {
          _groupedHolds = groupedHolds;
          notifyListeners();
        },
        onFailure: (error) {
          addError(error);
        },
      );
    });
    return Result.success(null);
  }

  void initPosView() {
    _resetSale();
  }

  CreateSaleDto _prepareCreateSaleDtoForSubmission() {
    final isUnpaid = _createSaleDto.paymentStatus == PaymentStatus.unpaid;
    if (isUnpaid) {
      _createSaleDto = _createSaleDto.copyWith(
        paymentType: PaymentType.cash,
        payments: [PaymentDto(paymentType: PaymentType.cash, amount: 0)],
      );
    }

    if (selectedCustomer == null) {
      _createSaleDto = _createSaleDto.copyWith(
        customerId: SpotstockSaleCreationConstant.walkInCustomerId,
      );
    } else {
      _createSaleDto = _createSaleDto.copyWith(
        customerId: selectedCustomer?.isSynced == true ? selectedCustomer?.id : null,
      );
    }

    final saleItems = List<SaleItemDto>.from(_createSaleDto.saleItems ?? []);
    for (var item in saleItems) {
      saleItems[saleItems.indexOf(item)] = item.copyWith(
        tableId: selectedBarTable?.id,
        productId: item.isCustom == true ? 0 : item.productId,
        productName: item.isCustom == true ? item.customName : item.productName,
      );
    }
    _createSaleDto = _createSaleDto.copyWith(
      saleItems: saleItems,
      date: DateTime.now(),
      status: SaleStatus.completed,
      taxRate: _createSaleDto.taxRate ?? SpotstockSaleCreationConstant.taxRate,
      discount: _createSaleDto.discount ?? SpotstockSaleCreationConstant.discount,
      discountAmount: _createSaleDto.discountAmount ?? SpotstockSaleCreationConstant.discountAmount,
      shipping: _createSaleDto.shipping ?? SpotstockSaleCreationConstant.shipping,
      partialPaymentAmount: _createSaleDto.partialPaymentAmount ?? SpotstockSaleCreationConstant.partialPaymentAmount,
      partialPaymentMethod: _createSaleDto.partialPaymentMethod ?? SpotstockSaleCreationConstant.partialPaymentMethod,
    );
    if (isHold) {
      _createSaleDto = _createSaleDto.copyWith(
        referenceCode:
            _selectedHold?.referenceCode ?? _selectedGroupedHold?.groupedHoldReferenceNo ?? _selectedGroupedHold?.firstOrNull?.referenceCode,
      );
    }
    return _createSaleDto;
  }

  Future<Result<void>> _createSale(BuildContext context) async {
    final createSaleDto = _prepareCreateSaleDtoForSubmission();

    final theme = Theme.of(context);

    final groupedHoldToDelete = _selectedGroupedHold;
    final singleHoldToDelete = _selectedHold;

    final result = await createSale(createSaleDto);

    if (result is Success) {
      final extraReceiptDetails = ExtraReceiptDetails(tableName: selectedBarTable?.name);

      if (groupedHoldToDelete != null) {
        final delResult = await deleteHolds(groupedHoldToDelete.holds);
        if (delResult is Failure) {
          showErrorSnackbar(
            delResult.error,
            title: SpotstockStrings.failedToDeleteData,
            subtitle: delResult.error.message,
          );
        } else {
          _getGroupedHoldsCommand?.execute();
        }
      }
      if (singleHoldToDelete != null) {
        final delResult = await deleteHold(singleHoldToDelete);
        if (delResult is Failure) {
          showErrorSnackbar(
            delResult.error,
            title: SpotstockStrings.failedToDeleteData,
            subtitle: delResult.error.message,
          );
        } else {
          _getGroupedHoldsCommand?.execute();
        }
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showSpotstockBottomSheet(
          context,
          header: const SpotstockSaleCreatedBottomSheetHeader(),
          body: SpotstockSaleCreatedBottomSheetBody(sale: result.data),
          actions: [
            const SizedBox(height: SpotstockSizes.s8),
            SpotstockPrimaryButton(
              child: Text(
                SpotstockStrings.print,
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
              onPressed: () async {
                await printPdfReceipt(result.data, extraReceiptDetails: extraReceiptDetails);
              },
            ),
            const SizedBox(height: SpotstockSizes.s10),
            SpotstockSecondaryButton(
              child: Text(SpotstockStrings.share),
              onPressed: () async {
                await sharePdfReceipt(result.data, extraReceiptDetails: extraReceiptDetails);
              },
            ),
          ],
        );
      });
      _resetSale();
      notifyListeners();
    }
    if (result is Failure) {
      showSpotstockInformationDialog(
        SpotstockNavigation.context ?? context,
        icon: Icon(Icons.error, color: theme.colorScheme.error, size: SpotstockSizes.s40),
        title: SpotstockStrings.anErrorOccurred,
        description: result.error.message,
        actions: [
          SpotstockPrimaryButton(
            child: Text(
              SpotstockStrings.ok,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            onPressed: () {
              SpotstockNavigation.goBack(context);
            },
          ),
        ],
      );
    }
    return result;
  }

  CreateHoldDto _prepareCreateHoldDtoForSubmission() {
    final createSaleDto = _prepareCreateSaleDtoForSubmission();
    final createHoldDto = createSaleDto.toCreateHoldDto().copyWith(
          tableName: selectedBarTable?.name,
          note: "${SpotstockStrings.holdCreatedViaPosAppAt} ${DateTime.now().toFormattedDateTime()}",
        );
    return createHoldDto;
  }

  Future<Result<void>> _createHold(BuildContext context) async {
    final createHoldDto = _prepareCreateHoldDtoForSubmission();
    final theme = Theme.of(context);

    final result = await createHold(createHoldDto);
    result.when(
      onSuccess: (hold) {
        _resetSale();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showSpotstockBottomSheet(
            context,
            header: const SpotstockHoldCreatedBottomSheetHeader(),
            body: SpotstockHoldCreatedBottomSheetBody(hold: hold),
            actions: [
              const SizedBox(height: SpotstockSizes.s8),
              SpotstockPrimaryButton(
                child: Text(
                  SpotstockStrings.ok,
                  style: TextStyle(color: theme.colorScheme.onPrimary),
                ),
                onPressed: () async {
                  SpotstockNavigation.goBack();
                },
              ),
            ],
          );
        });
        notifyListeners();
      },
      onFailure: (error) {
        showSpotstockInformationDialog(
          SpotstockNavigation.context ?? context,
          icon: Icon(Icons.error, color: theme.colorScheme.error, size: SpotstockSizes.s40),
          title: SpotstockStrings.anErrorOccurred,
          description: error.message,
          actions: [
            SpotstockPrimaryButton(
              child: Text(
                SpotstockStrings.ok,
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
              onPressed: () {
                SpotstockNavigation.goBack(context);
              },
            ),
          ],
        );
      },
    );
    return result;
  }

  Future<Result<void>> _createCustomer(
    BuildContext context,
    CreateCustomerDto createCustomerDto,
  ) async {
    final theme = Theme.of(context);
    final result = await createCustomer(createCustomerDto);
    result.when(onSuccess: (customer) async {
      showSpotstockSnackbar(
        type: SpotstockSnackbarType.success,
        title: SpotstockStrings.success,
        message: SpotstockStrings.customerCreatedSuccessfully,
      );
      await getCustomersCommand.execute();
    }, onFailure: (error) {
      showSpotstockInformationDialog(
        SpotstockNavigation.context ?? context,
        icon: Icon(Icons.error, color: theme.colorScheme.error, size: SpotstockSizes.s40),
        title: SpotstockStrings.anErrorOccurred,
        description: error.message,
        actions: [
          SpotstockPrimaryButton(
            child: Text(
              SpotstockStrings.ok,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            onPressed: () {
              SpotstockNavigation.goBack(context);
            },
          ),
        ],
      );
    });
    return result;
  }

  Future<bool?> onBackPressed(BuildContext context) async {
    final confirmed = await showSpotstockInformationDialog<bool?>(
      context,
      title: SpotstockStrings.areYouSure,
      icon: Icon(Icons.warning),
      banner: SpotstockDialogWarningBanner(
        message: SpotstockStrings.leavePOSWarningMessage,
      ),
      description: SpotstockStrings.leavePOSWarningHeading,
      actions: [
        SpotstockPrimaryButton(
          color: Theme.of(context).colorScheme.error,
          textColor: Theme.of(context).colorScheme.onError,
          child: Text(
            SpotstockStrings.leaveAnyway,
            style: TextStyle(color: Theme.of(context).colorScheme.onError),
          ),
          onPressed: () {
            SpotstockNavigation.goBack();
            SpotstockNavigation.goBack(true);
          },
        ),
        SizedBox(height: SpotstockSizes.s16),
        SpotstockPrimaryButton(
          child: Text(
            SpotstockStrings.closeRegister,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          onPressed: () {
            SpotstockNavigation.goBack();
            _onCloseRegisterPressed(context);
          },
        ),
        SizedBox(height: SpotstockSizes.s16),
        SpotstockSecondaryButton(
          child: Text(SpotstockStrings.noCancel),
          onPressed: () {
            SpotstockNavigation.goBack();
          },
        ),
      ],
    );
    return confirmed;
  }

  void _onCloseRegisterPressed(BuildContext context) async {
    final formViewModel = getIt<SpotstockCloseRegisterFormViewModel>()
      ..bind(
        context,
        onRegisterClosed: () {
          SpotstockNavigation.goBack(true);
          SpotstockNavigation.goTo(SpotstockMobileRoutes.registerSummary);
        },
      );
    await showSpotstockFormDialog(
      context,
      title: SpotstockStrings.closeRegister,
      form: SpotstockCloseRegisterForm(
        viewModel: formViewModel,
        onFormValidated: () {},
      ),
      actions: [
        ListenableBuilder(
            listenable: formViewModel.closeRegisterCommand,
            builder: (context, _) {
              return SpotstockPrimaryButton(
                enabled: !formViewModel.closeRegisterCommand.running,
                color: Theme.of(context).colorScheme.primary,
                textColor: Theme.of(context).colorScheme.onPrimary,
                child: formViewModel.closeRegisterCommand.running
                    ? SpotstockProgressIndicator()
                    : Text(
                        SpotstockStrings.closeRegister,
                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                      ),
                onPressed: () {
                  if (formViewModel.validateForm()) {
                    FocusScope.of(context).unfocus();
                    formViewModel.closeRegisterCommand.execute(context);
                  }
                },
              );
            }),
      ],
    );
  }

  void _verifyStaffPin(
    BuildContext context,
    Attendant attendant, {
    Function()? onPinCorrect,
    Function(AppError error)? onPinIncorrect,
  }) async {
    final viewModel = getIt<SpotstockStaffPinFormViewModel>()..bind(context, userId: attendant.id);
    await showSpotstockFormDialog(
      context,
      title: SpotstockStrings.verifyStaffPin,
      form: SpotstockStaffPinForm(
        viewModel: viewModel,
        staffName: "${attendant.firstName ?? SpotstockStrings.EMPTY} ${attendant.lastName ?? SpotstockStrings.EMPTY}",
        onPinCorrect: () {
          onPinCorrect?.call();
        },
        onPinIncorrect: (error) {
          onPinIncorrect?.call(error);
        },
      ),
    );
  }

  void onAttendantPressed(BuildContext context) {
    final viewModel = getIt<SpotstockSelectAttendantFormViewModel>()..bind(context, attendants, _createSaleDto.attendantId);
    showSpotstockFormDialog(
      context,
      title: SpotstockStrings.selectAttendant,
      form: SpotstockSelectAttendantForm(
        viewModel: viewModel,
        onAttendantSelected: (attendant) {
          if (attendant.id == _createSaleDto.attendantId) {
            SpotstockNavigation.goBack();
            return;
          }
          SpotstockNavigation.goBack();
          _verifyStaffPin(
            context,
            attendant,
            onPinCorrect: () {
              final createSaleDto = _createSaleDto.copyWith(
                attendantId: attendant.id,
                staffId: attendant.id,
                attendantName: "${attendant.firstName} ${attendant.lastName}",
                staffName: "${attendant.firstName} ${attendant.lastName}",
              );
              _createSaleDto = createSaleDto;
              notifyListeners();
            },
            onPinIncorrect: (error) {},
          );
        },
      ),
    );
  }

  void onBranchPressed(BuildContext context) {
    final viewModel = getIt<SpotstockSelectBranchFormViewModel>()..bind(context, branches, _createSaleDto.warehouseId);
    showSpotstockFormDialog(
      context,
      title: SpotstockStrings.selectBranch,
      form: SpotstockSelectBranchForm(
        viewModel: viewModel,
        onBranchSelected: (branch) {
          if (branch.id == _createSaleDto.warehouseId) {
            SpotstockNavigation.goBack();
            return;
          }
          _resetSale();
          SpotstockNavigation.goBack();
          final createSaleDto = _createSaleDto.copyWith(
            warehouseId: branch.id,
            warehouseName: branch.name,
          );
          _createSaleDto = createSaleDto;
          notifyListeners();
          getProductsCommand.execute();
        },
      ),
    );
  }

  void onBarTablePressed(BuildContext context) {
    final viewModel = getIt<SpotstockSelectBarTableFormViewModel>()..bind(context, barTables, selectedBarTable);
    showSpotstockFormDialog(
      context,
      title: SpotstockStrings.selectBarTable,
      form: SpotstockSelectBarTableForm(
        viewModel: viewModel,
        onBarTableSelected: (barTable) {
          SpotstockNavigation.goBack();
          _selectedBarTable = barTable;
          notifyListeners();
        },
      ),
    );
  }

  void onCustomerPressed(BuildContext context) {
    getCustomersCommand.execute();
    final viewModel = getIt<SpotstockSelectCustomerFormViewModel>()..bind(context, customers, _createSaleDto.customerId);
    showSpotstockFormDialog(
      context,
      title: SpotstockStrings.selectCustomer,
      fab: SpotstockFloatingActionButton(
        label: SpotstockStrings.addNewCustomer,
        icon: Icon(
          Icons.person_add,
          color: Theme.of(context).colorScheme.onPrimary,
          size: SpotstockSizes.s18,
        ),
        onPressed: () {
          onAddNewCustomerPressed(context);
        },
      ),
      form: SpotstockSelectCustomerForm(
        viewModel: viewModel,
        onCustomerSelected: (customer) {
          SpotstockNavigation.goBack();
          if (customer?.isSynced == false) {
            final createSaleDto = _createSaleDto.copyWith(
              customerId: customer?.id,
              customerName: customer?.name,
              offlineCustomerName: customer?.name,
            );
            _createSaleDto = createSaleDto;
            notifyListeners();
            return;
          }
          final createSaleDto = _createSaleDto.copyWith(
            customerId: customer?.id,
            customerName: customer?.name,
            offlineCustomerName: null,
          );
          _createSaleDto = createSaleDto;
          notifyListeners();
        },
      ),
    );
  }

  void onAddNewCustomerPressed(BuildContext context) async {
    SpotstockNavigation.goBack();
    final viewModel = getIt<SpotstockAddNewCustomerFormViewModel>()..bind(context);
    showSpotstockFormDialog(
      context,
      title: SpotstockStrings.addNewCustomer,
      form: SpotstockAddNewCustomerForm(
        viewModel: viewModel,
      ),
      actions: [
        SpotstockPrimaryButton(
          onPressed: () async {
            if (viewModel.validateForm()) {
              final createCustomerDto = viewModel.onCreateCustomerPressed(context);
              SpotstockNavigation.goBack();
              await createCustomerCommand.execute(context, createCustomerDto);
            }
          },
          child: Text(
            SpotstockStrings.createCustomer,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ],
    );
  }

  bool _isStockAvailable(int? productId, int quantity) {
    final inStock = _getProduct(productId)?.inStock;
    if (inStock == null) {
      return true;
    }
    if (quantity <= inStock) {
      return true;
    } else {
      showErrorSnackbar(
        title: SpotstockStrings.outOfStockExclamation,
        subtitle: "${SpotstockStrings.youHave} $inStock ${SpotstockStrings.inStock}",
        OutOfStockError(
          message: SpotstockStrings.outOfStockExclamation,
          title: SpotstockStrings.outOfStockExclamation,
          subtitle: "${SpotstockStrings.youHave} $inStock ${SpotstockStrings.inStock}",
          code: SpotstockStatusCode.outOfStock.toString(),
          originalError: null,
        ),
      );
      return false;
    }
  }

  void _updateGrandTotal() {
    final total = grandTotal;
    _createSaleDto = _createSaleDto.copyWith(grandTotal: total);
  }

  void onAddProduct(SellableProduct product, {int initialQuantity = 1}) {
    final saleItems = List<SaleItemDto>.from(_createSaleDto.saleItems ?? []);

    final existingIndex = saleItems.indexWhere((s) => s.productId == product.id);

    if (existingIndex != -1) {
      final existingItem = saleItems[existingIndex];
      final newQuantity = (existingItem.quantity ?? 0) + 1;
      if (!_isStockAvailable(product.id, newQuantity.toInt())) {
        return;
      }
      final updatedItem = existingItem.copyWith(
        quantity: newQuantity,
        subTotal: (product.productPrice ?? 0) * newQuantity,
      );

      saleItems[existingIndex] = updatedItem;
    } else {
      if (!_isStockAvailable(product.id, initialQuantity)) {
        return;
      }
      final saleItem = SaleItemDto(
        productCode: product.code,
        productId: product.id,
        productName: product.name,
        tableId: selectedBarTable?.id,
        productPrice: product.productPrice,
        netUnitPrice: product.productPrice,
        taxType: SpotstockSaleCreationConstant.taxType,
        taxValue: 0,
        taxAmount: 0,
        discountType: SpotstockSaleCreationConstant.discountType,
        discountValue: 0,
        discountAmount: 0,
        saleUnit: SpotstockSaleCreationConstant.saleUnit,
        quantity: initialQuantity.toDouble(),
        subTotal: (product.productPrice ?? 0) * initialQuantity,
        isCustom: product.isCustom,
        customCost: product.customCost,
        customDescription: product.customDescription,
        customName: product.customName,
        customPrice: product.customPrice,
      );
      saleItems.add(saleItem);
    }

    _createSaleDto = _createSaleDto.copyWith(saleItems: saleItems);
    _updateGrandTotal();
    notifyListeners();
  }

  void onDiscountChanged(String? value) {
    _createSaleDto = _createSaleDto.copyWith(
      discount: double.tryParse(value ?? '0'),
      discountAmount: double.tryParse(value ?? '0'),
    );
    _updateGrandTotal();
    notifyListeners();
  }

  void onShippingChanged(String? value) {
    _createSaleDto = _createSaleDto.copyWith(shipping: double.tryParse(value ?? '0'));
    _updateGrandTotal();
    notifyListeners();
  }

  void onRemoveSaleItem(int? productId) {
    final saleItems = List<SaleItemDto>.from(_createSaleDto.saleItems ?? []);
    saleItems.removeWhere((s) => s.productId == productId);
    _createSaleDto = _createSaleDto.copyWith(saleItems: saleItems);
    _updateGrandTotal();
    notifyListeners();
  }

  Product? _getProduct(int? productId) {
    if (productId == null) return null;

    final product = products
        .where(
          (p) => p.id == productId,
        )
        .firstOrNull;

    if (product != null) return product;

    return customProducts.firstWhere(
      (p) => p.id == productId,
    );
  }

  void onIncreaseSaleItemQuantity(int? productId) {
    final saleItems = List<SaleItemDto>.from(_createSaleDto.saleItems ?? []);
    final saleItem = saleItems.firstWhere((s) => s.productId == productId);
    final newQuantity = (saleItem.quantity ?? 0) + 1;
    if (!_isStockAvailable(productId, newQuantity.toInt())) {
      return;
    }
    final updatedItem = saleItem.copyWith(quantity: newQuantity, subTotal: (saleItem.productPrice ?? 0) * newQuantity);
    saleItems[saleItems.indexOf(saleItem)] = updatedItem;
    _createSaleDto = _createSaleDto.copyWith(saleItems: saleItems);
    _updateGrandTotal();
    notifyListeners();
  }

  void onDecreaseSaleItemQuantity(int? productId) {
    final saleItems = List<SaleItemDto>.from(_createSaleDto.saleItems ?? []);
    final saleItem = saleItems.firstWhere((s) => s.productId == productId);
    if (saleItem.quantity == 1) {
      return;
    }
    final newQuantity = (saleItem.quantity ?? 0) - 1;
    final updatedItem = saleItem.copyWith(quantity: newQuantity, subTotal: (saleItem.productPrice ?? 0) * newQuantity);
    saleItems[saleItems.indexOf(saleItem)] = updatedItem;
    _createSaleDto = _createSaleDto.copyWith(saleItems: saleItems);
    _updateGrandTotal();
    notifyListeners();
  }

  void onEditSaleItem(BuildContext context, SaleItemDto? saleItem) {
    final viewModel = getIt<SpotstockEditSaleItemFormViewModel>()
      ..bind(
        context,
        saleItem: saleItem,
        quantityInStock: _getProduct(saleItem?.productId)?.inStock,
        onSaleItemEdited: (editedSaleItem) {
          if (editedSaleItem == null) return;
          if (saleItem == null) return;
          final saleItems = List<SaleItemDto>.from(_createSaleDto.saleItems ?? []);
          saleItems[saleItems.indexOf(saleItem)] = editedSaleItem;
          _createSaleDto = _createSaleDto.copyWith(saleItems: saleItems);
          _updateGrandTotal();
          notifyListeners();
        },
        productName: saleItem?.isCustom == true ? saleItem?.customName : _getProduct(saleItem?.productId)?.name,
        cost: saleItem?.isCustom == true ? saleItem?.customCost : null,
        description: saleItem?.isCustom == true ? saleItem?.customDescription : null,
        isCustom: saleItem?.isCustom ?? false,
      );
    showSpotstockFormDialog(
      context,
      title: SpotstockStrings.editSaleItem,
      form: SpotstockEditSaleItemForm(
        viewModel: viewModel,
      ),
      actions: [
        SpotstockPrimaryButton(
          child: Text(
            SpotstockStrings.save,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          onPressed: () {
            viewModel.onSavePressed(context);
          },
        ),
      ],
    );
  }

  void _resetSale() {
    _discountController.clear();
    _shippingController.clear();
    _selectedBarTable = null;
    _createSaleDto = CreateSaleDto(
      taxAmount: SpotstockSaleCreationConstant.taxAmount,
      warehouseId: selectedBranch?.id,
      warehouseName: selectedBranch?.name,
    );
    _selectedGroupedHold = null;
    _selectedHold = null;
    _updateGrandTotal();
    notifyListeners();
  }

  Future<bool?> onResetPressed(BuildContext context) async {
    final confirmed = await showSpotstockInformationDialog(
      context,
      title: SpotstockStrings.areYouSure,
      icon: Icon(Icons.warning),
      description: SpotstockStrings.youllLoseAllProgressWhenYouReset,
      actions: [
        SpotstockPrimaryButton(
          child: Text(
            SpotstockStrings.yesReset,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          onPressed: () {
            _resetSale();
            SpotstockNavigation.goBack(true);
          },
        ),
        SizedBox(height: SpotstockSizes.s16),
        SpotstockSecondaryButton(
          child: Text(SpotstockStrings.noCancel),
          onPressed: () {
            SpotstockNavigation.goBack();
          },
        ),
      ],
    );
    return confirmed;
  }

  void onHoldPressed(BuildContext context) {
    _verifyStaffPin(context, selectedAttendant!, onPinCorrect: () {
      _openCreateHoldForm(context);
    }, onPinIncorrect: (error) {});
  }

  void _openCreateHoldForm(BuildContext context) {
    final viewModel = getIt<SpotstockCreateHoldFormViewModel>()
      ..bind(
        context,
        _barTables,
        _selectedBarTable,
      );
    showSpotstockFormDialog(
      context,
      title: SpotstockStrings.holdSale,
      form: SpotstockCreateHoldForm(
        viewModel: viewModel,
        onBarTableSelected: (barTable) {
          _selectedBarTable = barTable;
          notifyListeners();
        },
      ),
      actions: [
        AnimatedBuilder(
          animation: createHoldCommand,
          builder: (context, _) {
            return SpotstockPrimaryButton(
              enabled: !createHoldCommand.running,
              child: createHoldCommand.running
                  ? SpotstockProgressIndicator(
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  : Text(SpotstockStrings.hold, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
              onPressed: () async {
                SpotstockNavigation.goBack(true);
                await createHoldCommand.execute(context);
              },
            );
          },
        ),
      ],
    );
  }

  void _updatePaymentAmount(PaymentType paymentType, double? amount) {
    final payments = List<PaymentDto>.from(_createSaleDto.payments ?? []);
    final existingIndex = payments.indexWhere((p) => p.paymentType == paymentType);

    if (existingIndex != -1) {
      payments[existingIndex] = payments[existingIndex].copyWith(amount: amount ?? 0);
    } else {
      payments.add(PaymentDto(paymentType: paymentType, amount: amount ?? 0));
    }

    _createSaleDto = _createSaleDto.copyWith(payments: payments);
    notifyListeners();
  }

  void onPayPressed(BuildContext context) async {
    _verifyStaffPin(context, selectedAttendant!, onPinCorrect: () {
      _openPaymentForm(context);
    }, onPinIncorrect: (error) {});
  }

  void _openPaymentForm(BuildContext context) async {
    final viewModel = getIt<SpotstockPaymentFormViewModel>()
      ..bind(
        context,
        createSaleDto: _createSaleDto,
        onFormLoaded: (createSaleDto) {
          _createSaleDto = createSaleDto ?? _createSaleDto;
          notifyListeners();
        },
      );
    await showSpotstockFormDialog(
      context,
      title: SpotstockStrings.enterPaymentDetails,
      form: SpotstockPaymentForm(
        viewModel: viewModel,
        onNoteChanged: (note) {
          _createSaleDto = _createSaleDto.copyWith(note: note, notes: note);
          notifyListeners();
        },
        onPaymentStatusChanged: (paymentStatus) {
          _createSaleDto = _createSaleDto.copyWith(paymentStatus: paymentStatus);
          _updateGrandTotal();
          notifyListeners();
        },
        onPaymentTypeUpdated: (payments) {
          final paidAmount = payments.fold(0.0, (a, b) => a + (b.amount ?? 0));
          _createSaleDto = _createSaleDto.copyWith(
            paymentType: payments.first.paymentType,
            payments: payments,
            paidAmount: paidAmount,
            receivedAmount: paidAmount,
          );
          _updateGrandTotal();
          notifyListeners();
        },
        onCashAmountChanged: (value) {
          _updatePaymentAmount(PaymentType.cash, double.tryParse(value ?? '0'));
        },
        onPosAmountChanged: (value) {
          _updatePaymentAmount(PaymentType.pos, double.tryParse(value ?? '0'));
        },
        onTransferAmountChanged: (value) {
          _updatePaymentAmount(PaymentType.transfer, double.tryParse(value ?? '0'));
        },
        onFolioAmountChanged: (value) {
          _updatePaymentAmount(PaymentType.folio, double.tryParse(value ?? '0'));
        },
        onOtherAmountChanged: (value) {
          _updatePaymentAmount(PaymentType.other, double.tryParse(value ?? '0'));
        },
      ),
      actions: [
        AnimatedBuilder(
          animation: createSaleCommand,
          builder: (context, _) {
            return SpotstockPrimaryButton(
              enabled: !createSaleCommand.running,
              child: createSaleCommand.running
                  ? SpotstockProgressIndicator(
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  : Text(
                      SpotstockStrings.submit,
                      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                    ),
              onPressed: () async {
                SpotstockNavigation.goBack(true);
                await createSaleCommand.execute(context);
              },
            );
          },
        )
      ],
    );
  }

  void onHoldsPressed(BuildContext context) async {
    final viewModel = getIt<SpotstockHoldsFormViewModel>()..bind(context, _groupedHolds);
    await showSpotstockFormDialog(
      context,
      title: SpotstockStrings.holdsGroupedInBrackets,
      form: SpotstockHoldsForm(
        viewModel: viewModel,
        onGroupHoldSelected: (holdSelectionResult) async {
          bind(
            context,
            createSaleDto: holdSelectionResult?.createSaleDto,
          );
          _selectedBarTable = _barTables
              .where(
                (barTable) => (barTable.name == holdSelectionResult?.groupedHold?.tableName),
              )
              .firstOrNull;
          _selectedGroupedHold = holdSelectionResult?.groupedHold;
          _selectedHold = holdSelectionResult?.hold;
          notifyListeners();
          await _getProductsCommand?.execute();
          notifyListeners();
        },
      ),
      actions: [
        SpotstockSecondaryButton(
          child: Text(SpotstockStrings.viewAllHolds),
          onPressed: () async {
            final holdSelectionResult = await viewModel.onViewAllHoldsPressed(context);
            if (holdSelectionResult != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                bind(
                  context,
                  createSaleDto: holdSelectionResult.createSaleDto,
                );
                _selectedBarTable = _barTables
                    .where(
                      (barTable) => (barTable.id == int.tryParse(holdSelectionResult.hold?.tableId ?? SpotstockStrings.EMPTY)),
                    )
                    .firstOrNull;
                _selectedGroupedHold = holdSelectionResult.groupedHold;
                _selectedHold = holdSelectionResult.hold;
                notifyListeners();
                await _getProductsCommand?.execute();
                notifyListeners();
              });
            }
          },
        ),
      ],
    );
  }

  void onTapAddCustomProduct(BuildContext context) async {
    final viewModel = getIt<SpotstockAddCustomProductFormViewModel>()..bind(context);
    await showSpotstockFormDialog(
      context,
      title: SpotstockStrings.addCustomProduct,
      form: SpotstockAddCustomProductForm(
        viewModel: viewModel,
      ),
      actions: [
        SpotstockPrimaryButton(
          child: Text(
            SpotstockStrings.addToCart,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          onPressed: () async {
            if (viewModel.validateForm()) {
              FocusScope.of(context).unfocus();
              final addToCartResult = await viewModel.onAddToCartPressed();
              addToCartResult.when(
                onSuccess: (cartAdditionObject) {
                  if (cartAdditionObject.product is CustomSellableProduct) {
                    final CustomSellableProduct sellableProduct = cartAdditionObject.product as CustomSellableProduct;
                    _customProducts.add(sellableProduct.product);
                    notifyListeners();
                    onAddProduct(
                      sellableProduct,
                      initialQuantity: cartAdditionObject.quantity,
                    );
                    SpotstockNavigation.goBack();
                  }
                },
                onFailure: (error) {
                  addError(error);
                },
              );
            }
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _discountController.dispose();
    _shippingController.dispose();
    super.dispose();
  }
}
