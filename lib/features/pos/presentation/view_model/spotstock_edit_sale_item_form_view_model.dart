import 'package:flutter/material.dart';

import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/view_models/spotstock_form_view_model.dart';
import '../../../../core/routing/navigation.dart';
import '../../data/models/create_sale_dto.dart';

class SpotstockEditSaleItemFormViewModel extends SpotstockFormViewModel {
  SpotstockEditSaleItemFormViewModel();

  final TextEditingController _quantityController = TextEditingController();
  TextEditingController get quantityController => _quantityController;

  final TextEditingController _priceController = TextEditingController();
  TextEditingController get priceController => _priceController;

  final TextEditingController _productNameController = TextEditingController();
  TextEditingController get productNameController => _productNameController;

  int? _quantityInStock;
  int? get quantityInStock => _quantityInStock;

  late Function(SaleItemDto?)? _onSaleItemEdited;
  Function(SaleItemDto?)? get onSaleItemEdited => _onSaleItemEdited;

  late SaleItemDto? _saleItem;
  SaleItemDto? get saleItem => _saleItem;

  late String? _productName;
  String? get productName => _productName;

  @override
  void bind(
    BuildContext context, {
    SaleItemDto? saleItem,
    int? quantityInStock,
    Function(SaleItemDto?)? onSaleItemEdited,
    String? productName,
  }) {
    _quantityController.text = saleItem?.quantity?.toInt().toString() ?? '';
    _priceController.text = saleItem?.productPrice?.toInt().toString() ?? '';
    _quantityInStock = quantityInStock;
    _onSaleItemEdited = onSaleItemEdited;
    _saleItem = saleItem;
    _productName = productName;
    _productNameController.text = productName ?? '';
  }

  String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return SpotstockStrings.quantityIsRequired;
    }
    if (int.tryParse(value) == null) {
      return SpotstockStrings.invalidQuantity;
    }
    if (int.tryParse(value)! < 1) {
      return SpotstockStrings.invalidQuantity;
    }
    if (quantityInStock != null && quantityInStock! < int.tryParse(value)!) {
      return "${SpotstockStrings.youHave} $quantityInStock ${SpotstockStrings.inStock}";
    }
    return null;
  }

  String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return SpotstockStrings.priceIsRequired;
    }
    if (double.tryParse(value) == null) {
      return SpotstockStrings.invalidPrice;
    }
    return null;
  }

  void onSavePressed(BuildContext context) {
    if (validateForm()) {
      final quantity = double.tryParse(_quantityController.text);
      final price = double.tryParse(_priceController.text);
      if (quantity == null || price == null) {
        return;
      }
      final saleItem = _saleItem?.copyWith(
        quantity: quantity,
        productPrice: price,
        subTotal: price * quantity,
      );
      _onSaleItemEdited?.call(saleItem);
      SpotstockNavigation.goBack();
    }
  }
}
