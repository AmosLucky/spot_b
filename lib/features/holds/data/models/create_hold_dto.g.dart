// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_hold_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateHoldDtoImpl _$$CreateHoldDtoImplFromJson(Map<String, dynamic> json) =>
    _$CreateHoldDtoImpl(
      customerId: (json['customer_id'] as num?)?.toInt(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      discount: (json['discount'] as num?)?.toDouble(),
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
      grandTotal: (json['grand_total'] as num?)?.toDouble(),
      holdItems: (json['hold_items'] as List<dynamic>?)
          ?.map((e) => HoldItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      note: json['note'] as String?,
      referenceCode: json['reference_code'] as String?,
      shipping: (json['shipping'] as num?)?.toDouble(),
      staffId: (json['staff_id'] as num?)?.toInt(),
      staffName: json['staff_name'] as String?,
      subTotal: (json['subTotal'] as num?)?.toDouble(),
      taxAmount: (json['tax_amount'] as num?)?.toDouble(),
      taxRate: (json['tax_rate'] as num?)?.toDouble(),
      tableId: json['table_id'] as String?,
      warehouseId: (json['warehouse_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CreateHoldDtoImplToJson(_$CreateHoldDtoImpl instance) =>
    <String, dynamic>{
      'customer_id': instance.customerId,
      'date': instance.date?.toIso8601String(),
      'discount': instance.discount,
      'discount_amount': instance.discountAmount,
      'grand_total': instance.grandTotal,
      'hold_items': instance.holdItems,
      'note': instance.note,
      'reference_code': instance.referenceCode,
      'shipping': instance.shipping,
      'staff_id': instance.staffId,
      'staff_name': instance.staffName,
      'subTotal': instance.subTotal,
      'tax_amount': instance.taxAmount,
      'tax_rate': instance.taxRate,
      'table_id': instance.tableId,
      'warehouse_id': instance.warehouseId,
    };

_$HoldItemDtoImpl _$$HoldItemDtoImplFromJson(Map<String, dynamic> json) =>
    _$HoldItemDtoImpl(
      code: json['code'] as String?,
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
      discountType: (json['discount_type'] as num?)?.toInt(),
      discountValue: (json['discount_value'] as num?)?.toDouble(),
      holdItemId: json['hold_item_id'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      netUnitCost: (json['net_unit_cost'] as num?)?.toDouble(),
      netUnitPrice: (json['net_unit_price'] as num?)?.toDouble(),
      productCost: (json['product_cost'] as num?)?.toDouble(),
      productId: (json['product_id'] as num?)?.toInt(),
      productPrice: (json['product_price'] as num?)?.toDouble(),
      productUnit: json['product_unit'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
      saleId: (json['sale_id'] as num?)?.toInt(),
      saleUnit: json['sale_unit'],
      stockAlert: json['stock_alert'] as String?,
      subTotal: (json['sub_total'] as num?)?.toDouble(),
      taxAmount: (json['tax_amount'] as num?)?.toDouble(),
      taxType: (json['tax_type'] as num?)?.toInt(),
      taxValue: (json['tax_value'] as num?)?.toDouble(),
      customCost:
          const StringOrNumToDoubleConverter().fromJson(json['custom_cost']),
      customPrice:
          const StringOrNumToDoubleConverter().fromJson(json['custom_price']),
      customName: json['custom_name'] as String?,
      customDescription: json['custom_description'] as String?,
      isCustom: json['is_custom'] == null
          ? false
          : const IntBoolConverter().fromJson(json['is_custom']),
    );

Map<String, dynamic> _$$HoldItemDtoImplToJson(_$HoldItemDtoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'discount_amount': instance.discountAmount,
      'discount_type': instance.discountType,
      'discount_value': instance.discountValue,
      'hold_item_id': instance.holdItemId,
      'id': instance.id,
      'name': instance.name,
      'net_unit_cost': instance.netUnitCost,
      'net_unit_price': instance.netUnitPrice,
      'product_cost': instance.productCost,
      'product_id': instance.productId,
      'product_price': instance.productPrice,
      'product_unit': instance.productUnit,
      'quantity': instance.quantity,
      'sale_id': instance.saleId,
      'sale_unit': instance.saleUnit,
      'stock_alert': instance.stockAlert,
      'sub_total': instance.subTotal,
      'tax_amount': instance.taxAmount,
      'tax_type': instance.taxType,
      'tax_value': instance.taxValue,
      'custom_cost':
          const StringOrNumToDoubleConverter().toJson(instance.customCost),
      'custom_price':
          const StringOrNumToDoubleConverter().toJson(instance.customPrice),
      'custom_name': instance.customName,
      'custom_description': instance.customDescription,
      'is_custom': const IntBoolConverter().toJson(instance.isCustom),
    };
