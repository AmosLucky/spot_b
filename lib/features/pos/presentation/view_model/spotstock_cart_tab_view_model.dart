import 'package:flutter/material.dart';
import 'package:spotstock_inventory/features/pos/data/models/create_sale_dto.dart';

import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/view_models/spotstock_view_model.dart';
import '../../../../core/shared/command.dart';
import '../../../../core/shared/result.dart';
import '../../../holds/data/models/grouped_hold.dart';
import '../../../holds/data/models/hold.dart';
import '../../../holds/domain/usecases/get_hold.dart';
import '../../data/models/product.dart';

class SpotstockCartTabViewModel extends SpotstockViewModel {
  final GetHold getHold;
  SpotstockCartTabViewModel(this.getHold);

  List<Product> _products = [];
  List<Product> get products => _products;

  List<SaleItemDto>? _saleItems;
  List<SaleItemDto>? get saleItems => _saleItems;

  GroupedHold? _selectedGroupedHold;

  Hold? _selectedHold;

  List<Hold>? _extraListOfHoldsToFindProductNamesFrom;

  Command0<void>? _getHoldCommand;
  Command0<void>? get getHoldCommand {
    _getHoldCommand ??= Command0<void>(_getHold)..execute();
    return _getHoldCommand;
  }

  @override
  void bind(
    BuildContext context, {
    List<Product> products = const [],
    List<SaleItemDto>? saleItems,
    GroupedHold? selectedGroupedHold,
    Hold? selectedHold,
  }) {
    _products = products;
    _saleItems = saleItems;
    _selectedGroupedHold = selectedGroupedHold;
    _selectedHold = selectedHold;
    _getHoldCommand = Command0<void>(_getHold)..execute();
    notifyListeners();
  }

  Future<Result<void>> _getHold() async {
    if (_selectedGroupedHold != null) {
      List<Hold> holds = [];
      for (final hold in _selectedGroupedHold?.holds ?? <Hold>[]) {
        if (hold.id != null && hold.referenceCode != null) {
          await for (final getHoldResult in getHold(hold.id!, hold.referenceCode!)) {
            if (getHoldResult is Success) {
              holds.add(getHoldResult.data);
            }
            if (getHoldResult is Failure) {
              addError(getHoldResult.error);
            }
          }
        }
      }
      _extraListOfHoldsToFindProductNamesFrom = holds;
      notifyListeners();
    }
    if (_selectedHold != null && _selectedHold?.id != null && _selectedHold?.referenceCode != null) {
      getHold(_selectedHold!.id!, _selectedHold!.referenceCode!).listen((result) {
        result.when(
          onSuccess: (hold) {
            _selectedHold = hold;
            notifyListeners();
          },
          onFailure: (error) {
            addError(error);
          },
        );
      });
    }

    return Result.success(null);
  }

  String getProductName(int? productId) {
    var productName = products.where((p) => p.id == productId).firstOrNull?.name;

    if (productName != null && productName.isNotEmpty) {
      return productName;
    }

    productName = _selectedHold?.holdItems?.where((h) => h.productId == productId).firstOrNull?.productName;

    if (productName != null && productName.isNotEmpty) {
      return productName;
    }

    for (final hold in _selectedGroupedHold?.holds ?? <Hold>[]) {
      for (final item in hold.holdItems ?? []) {
        if (item.productId == productId && item.productName != null && item.productName!.isNotEmpty) {
          return item.productName!;
        }
      }
    }

    for (final hold in _extraListOfHoldsToFindProductNamesFrom ?? <Hold>[]) {
      for (final item in hold.holdItems ?? []) {
        if (item.productId == productId && item.productName != null && item.productName!.isNotEmpty) {
          return item.productName!;
        }
      }
    }

    return SpotstockStrings.na;
  }
}
