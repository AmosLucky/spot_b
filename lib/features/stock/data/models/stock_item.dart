// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_item.freezed.dart';
part 'stock_item.g.dart';

@freezed
class StockItem with _$StockItem {
  const factory StockItem({
    int? id,
    @JsonKey(name: 'product_id') int? productId,
    @JsonKey(name: 'main_product_id') int? mainProductId,
    @JsonKey(name: 'product_name') String? productName,
    @JsonKey(name: 'product_code') String? productCode,
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'brand_name') String? brandName,
    int? quantity,
    @JsonKey(name: 'stock_alert') String? stockAlert,
    @JsonKey(name: 'value_by_cost') double? valueByCost,
    @JsonKey(name: 'value_by_price') double? valueByPrice,
    @JsonKey(name: 'product_cost') double? productCost,
    @JsonKey(name: 'product_price') double? productPrice,
    @JsonKey(name: 'product_unit') String? productUnit,
    @JsonKey(name: 'warehouse_id') int? warehouseId,
    @JsonKey(name: 'warehouse_name') String? warehouseName,
    @JsonKey(name: 'company_id') int? companyId,
  }) = _StockItem;

  factory StockItem.fromJson(Map<String, dynamic> json) => _$StockItemFromJson(json);
}
