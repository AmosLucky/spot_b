import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/networking/spotstock_api_data_conversion_helper.dart';
import 'product_unit_name.dart';
import 'product_warehouse.dart';
import 'stock.dart';

part 'product.freezed.dart';

@freezed
class Product with _$Product {
  const factory Product({
    int? id,
    String? name,
    int? companyId,
    String? code,
    DateTime? expiryDate,
    int? mainProductId,
    int? productCategoryId,
    double? productCost,
    double? productPrice,
    bool? isActive,
    Stock? stock,
    DateTime? createdAt,
    int? inStock,
    String? link,
    double? customCost,
    String? customDescription,
    String? customName,
    double? customPrice,
    String? brandName,
    String? productCategoryName,
    String? stockAlert,
    ProductUnitName? productUnitName,
    List<ProductWarehouse>? warehouse,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    final links = json['links'];

    // log the runtime type for all the attributes being assigned to the product

    return Product(
      id: int.tryParse(json['id'].toString()),
      name: attributes['name'],
      companyId: attributes['company_id'],
      code: attributes['code'],
      expiryDate: attributes['expiry_date'] != null ? DateTime.tryParse(attributes['expiry_date']) : null,
      mainProductId: attributes['main_product_id'],
      productCategoryId: attributes['product_category_id'],
      productCost: SpotstockApiDataConversionHelper.toDouble(attributes['product_cost']),
      productPrice: SpotstockApiDataConversionHelper.toDouble(attributes['product_price']),
      isActive: attributes['is_active'],
      stock: Stock.fromJson(attributes['stock']),
      createdAt: attributes['created_at'] != null ? DateTime.tryParse(attributes['created_at']) : null,
      inStock: attributes['in_stock'],
      brandName: attributes['brand_name'],
      productCategoryName: attributes['product_category_name'],
      stockAlert: attributes['stock_alert'],
      productUnitName: attributes['product_unit_name'] is String
          ? ProductUnitName(name: attributes['product_unit_name'])
          : attributes['product_unit_name'] != null
              ? ProductUnitName.fromJson(attributes['product_unit_name'])
              : null,
      warehouse:
          attributes['warehouse'] != null ? List<ProductWarehouse>.from(attributes['warehouse'].map((x) => ProductWarehouse.fromJson(x))) : null,
      link: links['self'],
    );
  }
}
