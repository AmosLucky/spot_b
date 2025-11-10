import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/di/di.dart';
import '../../../../core/networking/spotstock_status_code.dart';
import '../../../../core/presentation/bottom_sheets/spotstock_bottom_sheet.dart';
import '../../../../core/presentation/buttons/spotstock_primary_button.dart';
import '../../../../core/presentation/buttons/spotstock_secondary_button.dart';
import '../../../../core/presentation/dialogs/spotstock_dialog.dart';
import '../../../../core/presentation/progress_indicators/spotstock_progress_indicator.dart';
import '../../../../core/presentation/snackbars/spotstock_snackbar.dart';
import '../../../../core/presentation/view_models/spotstock_view_model.dart';
import '../../../../core/routing/navigation.dart';
import '../../../../core/shared/command.dart';
import '../../../../core/shared/result.dart';
import '../../../coming_soon/domain/errors/errors.dart';
import '../../../network_info/domain/usecases/check_and_update_network_status.dart';
import '../../../receipt/data/models/extra_receipt_details.dart';
import '../../../receipt/domain/usecases/print_pdf_receipt.dart';
import '../../../receipt/domain/usecases/share_pdf_receipt.dart';
import '../../constants/spotstock_sale_creation_constant.dart';
import '../../data/enums/enums.dart';
import '../../data/models/attendant.dart';
import '../../data/models/bar_table.dart';
import '../../data/models/create_sale_dto.dart';
import '../../data/models/customer.dart';
import '../../data/models/product.dart';
import '../../data/models/product_category.dart';
import '../../data/models/warehouse.dart';
import '../../domain/errors/errors.dart';
import '../../domain/usecases/create_sale.dart';
import '../../domain/usecases/get_attendants.dart';
import '../../domain/usecases/get_bar_tables.dart';
import '../../domain/usecases/get_customers.dart';
import '../../domain/usecases/get_product_categories.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/get_warehouses.dart';
import '../widget/spotstock_edit_sale_item_form.dart';
import '../widget/spotstock_payment_form.dart';
import '../widget/spotstock_sale_created_bottom_sheet.dart';
import '../widget/spotstock_select_attendant_form.dart';
import '../widget/spotstock_select_bar_table_form.dart';
import '../widget/spotstock_select_branch_form.dart';
import '../widget/spotstock_select_customer_form.dart';
import 'spotstock_edit_sale_item_form_view_model.dart';
import 'spotstock_payment_form_view_model.dart';
import 'spotstock_select_attendant_form_view_model.dart';
import 'spotstock_select_bar_table_form_view_model.dart';
import 'spotstock_select_branch_form_view_model.dart';
import 'spotstock_select_customer_form_view_model.dart';

class PosViewModel extends SpotstockViewModel
    with SpotstockDialogMixin, SpotstockSnackbarMixin, SpotstockBottomSheetMixin {
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
    if (id == null) return null;
    return _customers.where((c) => c.id == id).firstOrNull;
  }

  bool get isCustomerSelected => _createSaleDto.customerId != null;

  List<ProductCategory> _productCategories = [];
  List<ProductCategory> get productCategories => _productCategories;

  List<Product> _products = [];
  List<Product> get products => _products;

  late Command0<void> _getAttendantsCommand;
  Command0<void> get getAttendantsCommand => _getAttendantsCommand;

  late Command0<void> _getBarTablesCommand;
  Command0<void> get getBarTablesCommand => _getBarTablesCommand;

  late Command0<void> _getCustomersCommand;
  Command0<void> get getCustomersCommand => _getCustomersCommand;

  late Command0<void> _getProductCategoriesCommand;
  Command0<void> get getProductCategoriesCommand => _getProductCategoriesCommand;

  late Command0<void> _getProductsCommand;
  Command0<void> get getProductsCommand => _getProductsCommand;

  late Command0<void> _getWarehousesCommand;
  Command0<void> get getWarehousesCommand => _getWarehousesCommand;

  late Command1<void, BuildContext> _createSaleCommand;
  Command1<void, BuildContext> get createSaleCommand => _createSaleCommand;

  TabController? _tabController;
  TabController? get tabController => _tabController;

  TextEditingController _discountController = TextEditingController();
  TextEditingController get discountController => _discountController;

  TextEditingController _shippingController = TextEditingController();
  TextEditingController get shippingController => _shippingController;

  bool get canPay {
    return cartCount > 0 && isBranchSelected && isAttendantSelected;
  }

  @override
  void bind(BuildContext context, {CreateSaleDto? createSaleDto, TickerProvider? vsync}) async {
    _createSaleDto = createSaleDto ?? _createSaleDto;
    _tabController ??=
        (vsync != null) ? TabController(length: SpotstockSizes.s2.toInt(), vsync: vsync) : null;
    _getWarehousesCommand = Command0<void>(_getWarehouses)..execute();
    _getAttendantsCommand = Command0<void>(_getAttendants)..execute();
    _getBarTablesCommand = Command0<void>(_getBarTables)..execute();
    _getCustomersCommand = Command0<void>(_getCustomers)..execute();
    _getProductCategoriesCommand = Command0<void>(_getProductCategories)..execute();
    _getProductsCommand = Command0<void>(_getProducts);
    _createSaleCommand = Command1<void, BuildContext>(_createSale);
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

  Future<Result<void>> _getWarehouses() async {
    getWarehouses().listen((result) {
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
          _getProductsCommand.execute();
        },
        onFailure: (error) {
          addError(error);
        },
      );
    });
    return Result.success(null);
  }

  CreateSaleDto _prepareCreateSaleDtoForSubmission() {
    final isUnpaid = _createSaleDto.paymentStatus == PaymentStatus.unpaid;
    if (isUnpaid) {
      _createSaleDto = _createSaleDto.copyWith(
        paymentType: PaymentType.cash,
        payments: [PaymentDto(paymentType: PaymentType.cash, amount: 0)],
      );
    }

    if (_createSaleDto.customerId == null) {
      _createSaleDto = _createSaleDto.copyWith(
        customerId: selectedCustomer?.id ?? SpotstockSaleCreationConstant.walkInCustomerId,
      );
    }

    final saleItems = List<SaleItemDto>.from(_createSaleDto.saleItems ?? []);
    for (var item in saleItems) {
      saleItems[saleItems.indexOf(item)] = item.copyWith(tableId: selectedBarTable?.id);
    }
    _createSaleDto = _createSaleDto.copyWith(
      saleItems: saleItems,
      date: DateTime.now(),
      status: SaleStatus.completed,
      taxRate: _createSaleDto.taxRate ?? SpotstockSaleCreationConstant.taxRate,
      discount: _createSaleDto.discount ?? SpotstockSaleCreationConstant.discount,
      discountAmount: _createSaleDto.discountAmount ?? SpotstockSaleCreationConstant.discountAmount,
      shipping: _createSaleDto.shipping ?? SpotstockSaleCreationConstant.shipping,
      partialPaymentAmount:
          _createSaleDto.partialPaymentAmount ?? SpotstockSaleCreationConstant.partialPaymentAmount,
      partialPaymentMethod:
          _createSaleDto.partialPaymentMethod ?? SpotstockSaleCreationConstant.partialPaymentMethod,
    );
    return _createSaleDto;
  }

  Future<Result<void>> _createSale(BuildContext context) async {
    final createSaleDto = _prepareCreateSaleDtoForSubmission();

    final theme = Theme.of(context);

    final result = await createSale(createSaleDto);
    result.when(
      onSuccess: (sale) {
        final extraReceiptDetails = ExtraReceiptDetails(tableName: selectedBarTable?.name);
        _resetSale();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showSpotstockBottomSheet(
            context,
            header: const SpotstockSaleCreatedBottomSheetHeader(),
            body: SpotstockSaleCreatedBottomSheetBody(sale: sale),
            actions: [
              const SizedBox(height: SpotstockSizes.s8),
              SpotstockPrimaryButton(
                child: Text(
                  SpotstockStrings.print,
                  style: TextStyle(color: theme.colorScheme.onPrimary),
                ),
                onPressed: () async {
                  await printPdfReceipt(sale, extraReceiptDetails: extraReceiptDetails);
                },
              ),
              const SizedBox(height: SpotstockSizes.s10),
              SpotstockSecondaryButton(
                child: Text(SpotstockStrings.share),
                onPressed: () async {
                  await sharePdfReceipt(sale, extraReceiptDetails: extraReceiptDetails);
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

  Future<bool?> onBackPressed(BuildContext context) async {
    final confirmed = await showSpotstockInformationDialog(
      context,
      title: SpotstockStrings.areYouSure,
      icon: Icon(Icons.warning),
      description: SpotstockStrings.youllLoseAllProgressWhenYouLeave,
      actions: [
        SpotstockPrimaryButton(
          child: Text(
            SpotstockStrings.yesLeave,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          onPressed: () {
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

  void onAttendantPressed(BuildContext context) {
    final viewModel = getIt<SpotstockSelectAttendantFormViewModel>()
      ..bind(context, attendants, _createSaleDto.attendantId);
    showSpotstockFormDialog(
      context,
      title: SpotstockStrings.selectAttendant,
      form: SpotstockSelectAttendantForm(
        viewModel: viewModel,
        onAttendantSelected: (attendant) {
          SpotstockNavigation.goBack();
          final createSaleDto = _createSaleDto.copyWith(
            attendantId: attendant.id,
            staffId: attendant.id,
            attendantName: "${attendant.firstName} ${attendant.lastName}",
            staffName: "${attendant.firstName} ${attendant.lastName}",
          );
          _createSaleDto = createSaleDto;
          notifyListeners();
        },
      ),
    );
  }

  void onBranchPressed(BuildContext context) {
    final viewModel = getIt<SpotstockSelectBranchFormViewModel>()
      ..bind(context, branches, _createSaleDto.warehouseId);
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
          _getProductsCommand.execute();
        },
      ),
    );
  }

  void onBarTablePressed(BuildContext context) {
    final viewModel = getIt<SpotstockSelectBarTableFormViewModel>()
      ..bind(context, barTables, selectedBarTable);
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
    final viewModel = getIt<SpotstockSelectCustomerFormViewModel>()
      ..bind(context, customers, _createSaleDto.customerId);
    showSpotstockFormDialog(
      context,
      title: SpotstockStrings.selectCustomer,
      form: SpotstockSelectCustomerForm(
        viewModel: viewModel,
        onCustomerSelected: (customer) {
          SpotstockNavigation.goBack();
          final createSaleDto = _createSaleDto.copyWith(
            customerId: customer?.id,
            customerName: customer?.name,
          );
          _createSaleDto = createSaleDto;
          notifyListeners();
        },
      ),
    );
  }

  bool _isStockAvailable(int? productId, int quantity) {
    final inStock = _getProduct(productId)?.inStock ?? 0;
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

  void onAddProduct(Product product) {
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
      if (!_isStockAvailable(product.id, 1)) {
        return;
      }
      final saleItem = SaleItemDto(
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
        quantity: 1,
        subTotal: product.productPrice,
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
    return products.firstWhere((p) => p.id == productId);
  }

  void onIncreaseSaleItemQuantity(int? productId) {
    final saleItems = List<SaleItemDto>.from(_createSaleDto.saleItems ?? []);
    final saleItem = saleItems.firstWhere((s) => s.productId == productId);
    final newQuantity = (saleItem.quantity ?? 0) + 1;
    if (!_isStockAvailable(productId, newQuantity.toInt())) {
      return;
    }
    final updatedItem = saleItem.copyWith(
        quantity: newQuantity, subTotal: (saleItem.productPrice ?? 0) * newQuantity);
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
    final updatedItem = saleItem.copyWith(
        quantity: newQuantity, subTotal: (saleItem.productPrice ?? 0) * newQuantity);
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
        productName: _getProduct(saleItem?.productId)?.name,
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
    showErrorSnackbar(
      ComingSoonError(
        message: "${SpotstockStrings.holds} ${SpotstockStrings.featureIsComingSoon}",
      ),
      title: "${SpotstockStrings.holds} ${SpotstockStrings.featureIsComingSoon}",
      subtitle: SpotstockStrings.featureIsComingSoonSubtitle,
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
          animation: _createSaleCommand,
          builder: (context, _) {
            return SpotstockPrimaryButton(
              enabled: !_createSaleCommand.running,
              child: _createSaleCommand.running
                  ? SpotstockProgressIndicator(
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  : Text(
                      SpotstockStrings.submit,
                      style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                    ),
              onPressed: () async {
                SpotstockNavigation.goBack(true);
                await _createSaleCommand.execute(context);
              },
            );
          },
        )
      ],
    );
  }

  void onHoldsPressed(BuildContext context) {
    showErrorSnackbar(
      ComingSoonError(
        message: "${SpotstockStrings.holds} ${SpotstockStrings.featureIsComingSoon}",
      ),
      title: "${SpotstockStrings.holds} ${SpotstockStrings.featureIsComingSoon}",
      subtitle: SpotstockStrings.featureIsComingSoonSubtitle,
    );
  }
}
