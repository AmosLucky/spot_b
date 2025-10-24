import 'package:flutter/material.dart';

import '../../../../core/presentation/extensions/num_extensions.dart';
import '../../../../core/presentation/view_models/spotstock_form_view_model.dart';
import '../../../../core/shared/command.dart';
import '../../data/enums/enums.dart';
import '../../data/models/create_sale_dto.dart';

class SpotstockPaymentFormViewModel extends SpotstockFormViewModel {
  SpotstockPaymentFormViewModel();

  final TextEditingController _payingAmountController = TextEditingController();
  TextEditingController get payingAmountController => _payingAmountController;

  final TextEditingController _changeController = TextEditingController();
  TextEditingController get changeController => _changeController;

  final TextEditingController _noteController = TextEditingController();
  TextEditingController get noteController => _noteController;

  final TextEditingController _cashAmountController = TextEditingController();
  TextEditingController get cashAmountController => _cashAmountController;

  final TextEditingController _posAmountController = TextEditingController();
  TextEditingController get posAmountController => _posAmountController;

  final TextEditingController _transferAmountController = TextEditingController();
  TextEditingController get transferAmountController => _transferAmountController;

  final TextEditingController _folioAmountController = TextEditingController();
  TextEditingController get folioAmountController => _folioAmountController;

  final TextEditingController _otherAmountController = TextEditingController();
  TextEditingController get otherAmountController => _otherAmountController;

  PaymentStatus get selectedPaymentStatus => _createSaleDto?.paymentStatus ?? PaymentStatus.paid;

  Set<PaymentType> _selectedPaymentTypes = {PaymentType.cash};
  Set<PaymentType> get selectedPaymentTypes => _selectedPaymentTypes;

  late CreateSaleDto? _createSaleDto;
  CreateSaleDto? get createSaleDto => _createSaleDto;

  late Command? _createSaleCommand;
  Command? get createSaleCommand => _createSaleCommand;

  double? _customerChange;
  double? get customerChange => _customerChange;

  int get totalProductCount {
    final items = _createSaleDto?.saleItems ?? [];
    return items.fold(0.0, (double a, b) => a + (b.quantity ?? 0)).toInt();
  }

  double get totalAmount {
    final payments = _createSaleDto?.payments ?? [];
    return payments.fold(0.0, (a, b) => a + (b.amount ?? 0));
  }

  double get vat {
    return _createSaleDto?.taxAmount ?? 0.0;
  }

  double get discount {
    return _createSaleDto?.discountAmount ?? 0.0;
  }

  double get shipping {
    return _createSaleDto?.shipping ?? 0.0;
  }

  String? get staffName {
    return _createSaleDto?.staffName;
  }

  double get grandTotal {
    return _createSaleDto?.grandTotal ?? 0.0;
  }

  bool get isUnpaid {
    return _createSaleDto?.paymentStatus == PaymentStatus.unpaid;
  }

  @override
  void bind(
    BuildContext context, {
    CreateSaleDto? createSaleDto,
    Function(CreateSaleDto?)? onFormLoaded,
  }) {
    _onFormLoaded(createSaleDto, onFormLoaded);
    _payingAmountController.text = _createSaleDto?.grandTotal?.toMoney() ?? '';
    _selectedPaymentTypes =
        _createSaleDto?.payments?.map((p) => p.paymentType).whereType<PaymentType>().toSet() ??
            {PaymentType.cash};
    _cashAmountController.text = _createSaleDto?.payments
            ?.where((p) => p.paymentType == PaymentType.cash)
            .firstOrNull
            ?.amount
            ?.toInt()
            .toString() ??
        '';
    _posAmountController.text = _createSaleDto?.payments
            ?.where((p) => p.paymentType == PaymentType.pos)
            .firstOrNull
            ?.amount
            ?.toInt()
            .toString() ??
        '';
    _transferAmountController.text = _createSaleDto?.payments
            ?.where((p) => p.paymentType == PaymentType.transfer)
            .firstOrNull
            ?.amount
            ?.toInt()
            .toString() ??
        '';
    _folioAmountController.text = _createSaleDto?.payments
            ?.where((p) => p.paymentType == PaymentType.folio)
            .firstOrNull
            ?.amount
            ?.toInt()
            .toString() ??
        '';
    _otherAmountController.text = _createSaleDto?.payments
            ?.where((p) => p.paymentType == PaymentType.other)
            .firstOrNull
            ?.amount
            ?.toInt()
            .toString() ??
        '';

    _noteController.text = _createSaleDto?.note ?? _createSaleDto?.notes ?? '';

    for (final controller in [
      _cashAmountController,
      _posAmountController,
      _transferAmountController,
      _folioAmountController,
      _otherAmountController,
    ]) {
      controller.removeListener(_updateCustomerChange);
      controller.addListener(_updateCustomerChange);
    }
    _updateCustomerChange();
  }

  void _onFormLoaded(CreateSaleDto? createSaleDto, Function(CreateSaleDto?)? onFormLoaded) {
    if ((createSaleDto?.payments?.isNotEmpty ?? false)) {
      _createSaleDto = createSaleDto?.copyWith(
        paymentType: createSaleDto.payments?.firstOrNull?.paymentType,
      );
    } else {
      _createSaleDto = createSaleDto?.copyWith(
        paidAmount: createSaleDto.grandTotal,
        receivedAmount: createSaleDto.grandTotal,
        paymentType: PaymentType.cash,
        payments: [
          PaymentDto(paymentType: PaymentType.cash, amount: createSaleDto.grandTotal),
        ],
        note: createSaleDto.note ?? createSaleDto.notes ?? '',
        notes: createSaleDto.note ?? createSaleDto.notes ?? '',
      );
    }

    if (_createSaleDto?.paymentStatus == null) {
      _createSaleDto = _createSaleDto?.copyWith(
        paymentStatus: PaymentStatus.paid,
      );
    }

    if (_createSaleDto?.payments?.length == 1) {
      final firstPayment = _createSaleDto?.payments?.firstOrNull;
      if (firstPayment != null) {
        _createSaleDto = _createSaleDto?.copyWith(
          payments: [firstPayment.copyWith(amount: _createSaleDto?.grandTotal)],
        );
      }
    }

    onFormLoaded?.call(_createSaleDto);
    notifyListeners();
  }

  void _updateCustomerChange() {
    final totalPayments = _selectedPaymentTypes
        .map((type) => _getPaymentAmount(type) ?? 0)
        .fold(0.0, (a, b) => a + b);

    final grandTotal = _createSaleDto?.grandTotal ?? 0;

    _customerChange = (totalPayments > grandTotal) ? totalPayments - grandTotal : 0;

    _changeController.text = _customerChange?.toStringAsFixed(2) ?? '';
    notifyListeners();
  }

  void onPaymentStatusChanged(PaymentStatus paymentStatus) {
    _createSaleDto = _createSaleDto?.copyWith(paymentStatus: paymentStatus);
    notifyListeners();
  }

  double? _getPaymentAmount(PaymentType paymentType) {
    switch (paymentType) {
      case PaymentType.cash:
        return double.tryParse(_cashAmountController.text);
      case PaymentType.pos:
        return double.tryParse(_posAmountController.text);
      case PaymentType.transfer:
        return double.tryParse(_transferAmountController.text);
      case PaymentType.folio:
        return double.tryParse(_folioAmountController.text);
      case PaymentType.other:
        return double.tryParse(_otherAmountController.text);
    }
  }

  List<PaymentDto> onPaymentTypeUpdated(Set<PaymentType> newPaymentTypes) {
    _selectedPaymentTypes = newPaymentTypes;
    List<PaymentDto> payments = [];
    for (var paymentType in newPaymentTypes) {
      payments.add(PaymentDto(paymentType: paymentType, amount: _getPaymentAmount(paymentType)));
    }
    final paidAmount = payments.fold(0.0, (a, b) => a + (b.amount ?? 0));
    _createSaleDto = _createSaleDto?.copyWith(
      paymentType: payments.first.paymentType,
      payments: payments,
      paidAmount: paidAmount,
      receivedAmount: paidAmount,
    );
    _updateCustomerChange();
    notifyListeners();
    return payments;
  }

  bool isPaymentTypeSelected(PaymentType paymentType) {
    return _selectedPaymentTypes.contains(paymentType);
  }
}
