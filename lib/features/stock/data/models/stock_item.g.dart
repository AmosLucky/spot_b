// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StockItemImpl _$$StockItemImplFromJson(Map<String, dynamic> json) =>
    _$StockItemImpl(
      id: (json['id'] as num?)?.toInt(),
      productId: (json['product_id'] as num?)?.toInt(),
      mainProductId: (json['main_product_id'] as num?)?.toInt(),
      productName: json['product_name'] as String?,
      productCode: json['product_code'] as String?,
      categoryId: (json['category_id'] as num?)?.toInt(),
      categoryName: json['category_name'] as String?,
      brandName: json['brand_name'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      stockAlert: json['stock_alert'] as String?,
      valueByCost: (json['value_by_cost'] as num?)?.toDouble(),
      valueByPrice: (json['value_by_price'] as num?)?.toDouble(),
      productCost: (json['product_cost'] as num?)?.toDouble(),
      productPrice: (json['product_price'] as num?)?.toDouble(),
      productUnit: json['product_unit'] as String?,
      warehouseId: (json['warehouse_id'] as num?)?.toInt(),
      warehouseName: json['warehouse_name'] as String?,
      companyId: (json['company_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$StockItemImplToJson(_$StockItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'main_product_id': instance.mainProductId,
      'product_name': instance.productName,
      'product_code': instance.productCode,
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'brand_name': instance.brandName,
      'quantity': instance.quantity,
      'stock_alert': instance.stockAlert,
      'value_by_cost': instance.valueByCost,
      'value_by_price': instance.valueByPrice,
      'product_cost': instance.productCost,
      'product_price': instance.productPrice,
      'product_unit': instance.productUnit,
      'warehouse_id': instance.warehouseId,
      'warehouse_name': instance.warehouseName,
      'company_id': instance.companyId,
    };
