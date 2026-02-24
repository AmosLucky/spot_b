import 'package:spotstock_inventory/features/pos/data/models/sellable_product.dart';

class AddCustomProductToCartObject {
  final SellableProduct product;
  final int quantity;

  AddCustomProductToCartObject(this.product, this.quantity);
}
