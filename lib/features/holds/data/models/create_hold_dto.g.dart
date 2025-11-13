// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_hold_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateHoldDtoImpl _$$CreateHoldDtoImplFromJson(Map<String, dynamic> json) =>
    _$CreateHoldDtoImpl(
      referenceCode: json['reference_code'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      customerId: (json['customer_id'] as num?)?.toInt(),
      warehouseId: (json['warehouse_id'] as num?)?.toInt(),
      staffId: (json['staff_id'] as num?)?.toInt(),
      staffName: json['staff_name'] as String?,
      taxRate: (json['tax_rate'] as num?)?.toDouble(),
      taxAmount: (json['tax_amount'] as num?)?.toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
      shipping: (json['shipping'] as num?)?.toDouble(),
      grandTotal: (json['grand_total'] as num?)?.toDouble(),
      subTotal: (json['subTotal'] as num?)?.toDouble(),
      holdItems: (json['hold_items'] as List<dynamic>?)
          ?.map((e) => HoldItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      note: json['note'] as String?,
      tableId: json['table_id'] as String?,
    );

Map<String, dynamic> _$$CreateHoldDtoImplToJson(_$CreateHoldDtoImpl instance) =>
    <String, dynamic>{
      'reference_code': instance.referenceCode,
      'date': instance.date?.toIso8601String(),
      'customer_id': instance.customerId,
      'warehouse_id': instance.warehouseId,
      'staff_id': instance.staffId,
      'staff_name': instance.staffName,
      'tax_rate': instance.taxRate,
      'tax_amount': instance.taxAmount,
      'discount': instance.discount,
      'discount_amount': instance.discountAmount,
      'shipping': instance.shipping,
      'grand_total': instance.grandTotal,
      'subTotal': instance.subTotal,
      'hold_items': instance.holdItems,
      'note': instance.note,
      'table_id': instance.tableId,
    };

_$HoldItemDtoImpl _$$HoldItemDtoImplFromJson(Map<String, dynamic> json) =>
    _$HoldItemDtoImpl(
      name: json['name'] as String?,
      code: json['code'] as String?,
      stockAlert: json['stock_alert'] as String?,
      productId: (json['product_id'] as num?)?.toInt(),
      productCost: (json['product_cost'] as num?)?.toDouble(),
      netUnitCost: (json['net_unit_cost'] as num?)?.toDouble(),
      productPrice: (json['product_price'] as num?)?.toDouble(),
      netUnitPrice: (json['net_unit_price'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toDouble(),
      subTotal: (json['sub_total'] as num?)?.toDouble(),
      taxType: (json['tax_type'] as num?)?.toInt(),
      taxValue: (json['tax_value'] as num?)?.toDouble(),
      taxAmount: (json['tax_amount'] as num?)?.toDouble(),
      discountType: (json['discount_type'] as num?)?.toInt(),
      discountValue: (json['discount_value'] as num?)?.toDouble(),
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
      productUnit: json['product_unit'] as String?,
      saleUnit: json['sale_unit'],
      id: (json['id'] as num?)?.toInt(),
      saleId: (json['sale_id'] as num?)?.toInt(),
      holdItemId: json['hold_item_id'] as String?,
    );

Map<String, dynamic> _$$HoldItemDtoImplToJson(_$HoldItemDtoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'stock_alert': instance.stockAlert,
      'product_id': instance.productId,
      'product_cost': instance.productCost,
      'net_unit_cost': instance.netUnitCost,
      'product_price': instance.productPrice,
      'net_unit_price': instance.netUnitPrice,
      'quantity': instance.quantity,
      'sub_total': instance.subTotal,
      'tax_type': instance.taxType,
      'tax_value': instance.taxValue,
      'tax_amount': instance.taxAmount,
      'discount_type': instance.discountType,
      'discount_value': instance.discountValue,
      'discount_amount': instance.discountAmount,
      'product_unit': instance.productUnit,
      'sale_unit': instance.saleUnit,
      'id': instance.id,
      'sale_id': instance.saleId,
      'hold_item_id': instance.holdItemId,
    };
