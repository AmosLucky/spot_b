import 'package:flutter/material.dart';
import 'package:spotstock_inventory/core/constants/sizes/spotstock_sizes.dart';
import 'package:spotstock_inventory/core/shared/result.dart';
import 'package:spotstock_inventory/features/pos/data/models/product.dart';
import 'package:spotstock_inventory/features/pos/data/models/sellable_product.dart';
import 'package:spotstock_inventory/features/pos/domain/usecases/get_custom_product_code.dart';

import '../../../../core/presentation/view_models/spotstock_form_view_model.dart';
import '../../data/models/add_custom_product_to_cart_object.dart';
import '../../domain/usecases/get_custom_product_id.dart';

class SpotstockAddCustomProductFormViewModel extends SpotstockFormViewModel {
  final GetCustomProductId getCustomProductId;
  final GetCustomProductCode getCustomProductCode;

  SpotstockAddCustomProductFormViewModel(this.getCustomProductId, this.getCustomProductCode);

  final TextEditingController _productNameController = TextEditingController();
  TextEditingController get productNameController => _productNameController;

  final TextEditingController _productDescriptionController = TextEditingController();
  TextEditingController get productDescriptionController => _productDescriptionController;

  final TextEditingController _productCostController = TextEditingController();
  TextEditingController get productCostController => _productCostController;

  final TextEditingController _productSellingPriceController = TextEditingController();
  TextEditingController get productSellingPriceController => _productSellingPriceController;

  final TextEditingController _productQuantityController = TextEditingController();
  TextEditingController get productQuantityController => _productQuantityController;

  @override
  void bind(BuildContext context) {}

  Product _createProduct() {
    return Product(
      name: _productNameController.text,
      companyId: null,
      code: null,
      expiryDate: null,
      mainProductId: null,
      productCategoryId: null,
      productCost: double.tryParse(_productCostController.text),
      productPrice: double.tryParse(_productSellingPriceController.text),
      isActive: null,
      stock: null,
      createdAt: DateTime.now(),
      inStock: null,
      link: null,
      customCost: double.tryParse(_productCostController.text),
      customDescription: _productDescriptionController.text,
      customName: _productNameController.text,
      customPrice: double.tryParse(_productSellingPriceController.text),
    );
  }

  Future<Result<AddCustomProductToCartObject>> onAddToCartPressed() async {
    final quantity = int.tryParse(_productQuantityController.text);

    final idResult = await getCustomProductId();
    if (idResult is Failure) {
      return Result.failure(idResult.error);
    }

    final codeResult = await getCustomProductCode();
    if (codeResult is Failure) {
      return Result.failure(codeResult.error);
    }

    final product = _createProduct().copyWith(
      id: idResult.data,
      code: codeResult.data,
    );

    final sellableProduct = CustomSellableProduct(
      product,
      idResult.data,
    );

    return Result.success(
      AddCustomProductToCartObject(
        sellableProduct,
        quantity ?? SpotstockSizes.s1.toInt(),
      ),
    );
  }
}
