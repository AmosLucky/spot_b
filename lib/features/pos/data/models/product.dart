import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/networking/spotstock_api_data_conversion_helper.dart';

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
    DateTime? createdAt,
    int? inStock,
    String? link,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    final links = json['links'];

    return Product(
      id: int.tryParse(json['id'].toString()),
      name: attributes['name'],
      companyId: attributes['company_id'],
      code: attributes['code'],
      expiryDate:
          attributes['expiry_date'] != null ? DateTime.tryParse(attributes['expiry_date']) : null,
      mainProductId: attributes['main_product_id'],
      productCategoryId: attributes['product_category_id'],
      productCost: SpotstockApiDataConversionHelper.toDouble(attributes['product_cost']),
      productPrice: SpotstockApiDataConversionHelper.toDouble(attributes['product_price']),
      isActive: attributes['is_active'],
      createdAt:
          attributes['created_at'] != null ? DateTime.tryParse(attributes['created_at']) : null,
      inStock: attributes['in_stock'],
      link: links['self'],
    );
  }
}
