import 'product.dart';
import 'stock.dart';

abstract class SellableProduct {
  int? get id;
  String? get name;
  int? get companyId;
  String? get code;
  DateTime? get expiryDate;
  int? get mainProductId;
  int? get productCategoryId;
  double? get productCost;
  double? get productPrice;
  bool? get isActive;
  Stock? get stock;
  DateTime? get createdAt;
  int? get inStock;
  String? get link;
  bool? get isCustom;
  double? get customCost;
  String? get customDescription;
  String? get customName;
  double? get customPrice;
}

class DefaultSellableProduct implements SellableProduct {
  final Product product;

  DefaultSellableProduct(this.product);

  @override
  String? get code => product.code;

  @override
  int? get companyId => product.companyId;

  @override
  DateTime? get createdAt => product.createdAt;

  @override
  double? get customCost => product.customCost;

  @override
  String? get customDescription => product.customDescription;

  @override
  String? get customName => product.customName;

  @override
  DateTime? get expiryDate => product.expiryDate;

  @override
  int? get id => product.id;

  @override
  int? get inStock => product.inStock;

  @override
  bool? get isActive => product.isActive;

  @override
  bool? get isCustom => false;

  @override
  String? get link => product.link;

  @override
  int? get mainProductId => product.mainProductId;

  @override
  String? get name => product.name;

  @override
  int? get productCategoryId => product.productCategoryId;

  @override
  double? get productCost => product.productCost;

  @override
  double? get productPrice => product.productPrice;

  @override
  Stock? get stock => product.stock;

  @override
  double? get customPrice => product.customPrice;
}

class CustomSellableProduct implements SellableProduct {
  final Product product;
  final int customProductId;

  CustomSellableProduct(this.product, this.customProductId);

  @override
  String? get code => product.code;

  @override
  int? get companyId => product.companyId;

  @override
  DateTime? get createdAt => product.createdAt;

  @override
  double? get customCost => product.customCost;

  @override
  String? get customDescription => product.customDescription;

  @override
  String? get customName => product.customName;

  @override
  DateTime? get expiryDate => product.expiryDate;

  /// CustomSellableProduct Product id is always 0
  /// Hence the need for [customProductId] as a temporary
  @override
  int? get id => customProductId;

  @override
  int? get inStock => product.inStock;

  @override
  bool? get isActive => product.isActive;

  @override
  bool? get isCustom => true;

  @override
  String? get link => product.link;

  @override
  int? get mainProductId => product.mainProductId;

  @override
  String? get name => product.name;

  @override
  int? get productCategoryId => product.productCategoryId;

  @override
  double? get productCost => product.productCost;

  @override
  double? get productPrice => product.productPrice;

  @override
  Stock? get stock => product.stock;

  @override
  double? get customPrice => product.customPrice;
}
