// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_sale_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateSaleDtoImpl _$$CreateSaleDtoImplFromJson(Map<String, dynamic> json) =>
    _$CreateSaleDtoImpl(
      referenceCode: json['reference_code'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      customerId: (json['customer_id'] as num?)?.toInt(),
      warehouseId: (json['warehouse_id'] as num?)?.toInt(),
      taxRate: (json['tax_rate'] as num?)?.toDouble(),
      taxAmount: (json['tax_amount'] as num?)?.toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
      shipping: (json['shipping'] as num?)?.toDouble(),
      grandTotal: (json['grand_total'] as num?)?.toDouble(),
      status: $enumDecodeNullable(_$SaleStatusEnumMap, json['status']),
      paymentStatus:
          $enumDecodeNullable(_$PaymentStatusEnumMap, json['payment_status']),
      paymentType:
          $enumDecodeNullable(_$PaymentTypeEnumMap, json['payment_type']),
      receivedAmount: (json['received_amount'] as num?)?.toDouble(),
      paidAmount: (json['paid_amount'] as num?)?.toDouble(),
      payments: (json['payments'] as List<dynamic>?)
          ?.map((e) => PaymentDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: json['notes'] as String?,
      saleItems: (json['sale_items'] as List<dynamic>?)
          ?.map((e) => SaleItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      note: json['note'] as String?,
      partialPaymentAmount:
          (json['partial_payment_amount'] as num?)?.toDouble(),
      partialPaymentMethod: json['partial_payment_method'] as String?,
      staffId: (json['staff_id'] as num?)?.toInt(),
      staffName: json['staff_name'] as String?,
      attendantId: (json['attendant_id'] as num?)?.toInt(),
      attendantName: json['attendant_name'] as String?,
      roomDetails: json['room_details'],
      isOffline: json['is_offline'] == null
          ? false
          : const IntOrBoolToBoolConverter().fromJson(json['is_offline']),
      offlineCustomerName: json['offline_customer_name'] as String?,
    );

Map<String, dynamic> _$$CreateSaleDtoImplToJson(_$CreateSaleDtoImpl instance) =>
    <String, dynamic>{
      'reference_code': instance.referenceCode,
      'date': instance.date?.toIso8601String(),
      'customer_id': instance.customerId,
      'warehouse_id': instance.warehouseId,
      'tax_rate': instance.taxRate,
      'tax_amount': instance.taxAmount,
      'discount': instance.discount,
      'discount_amount': instance.discountAmount,
      'shipping': instance.shipping,
      'grand_total': instance.grandTotal,
      'status': _$SaleStatusEnumMap[instance.status],
      'payment_status': _$PaymentStatusEnumMap[instance.paymentStatus],
      'payment_type': _$PaymentTypeEnumMap[instance.paymentType],
      'received_amount': instance.receivedAmount,
      'paid_amount': instance.paidAmount,
      'payments': instance.payments,
      'notes': instance.notes,
      'sale_items': instance.saleItems,
      'note': instance.note,
      'partial_payment_amount': instance.partialPaymentAmount,
      'partial_payment_method': instance.partialPaymentMethod,
      'staff_id': instance.staffId,
      'staff_name': instance.staffName,
      'attendant_id': instance.attendantId,
      'attendant_name': instance.attendantName,
      'room_details': instance.roomDetails,
      'is_offline': _$JsonConverterToJson<dynamic, bool>(
          instance.isOffline, const IntOrBoolToBoolConverter().toJson),
      'offline_customer_name': instance.offlineCustomerName,
    };

const _$SaleStatusEnumMap = {
  SaleStatus.completed: 1,
  SaleStatus.held: 2,
  SaleStatus.cancelled: 3,
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.paid: 1,
  PaymentStatus.unpaid: 2,
  PaymentStatus.partial: 3,
};

const _$PaymentTypeEnumMap = {
  PaymentType.cash: 1,
  PaymentType.pos: 2,
  PaymentType.transfer: 3,
  PaymentType.folio: 4,
  PaymentType.other: 5,
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$PaymentDtoImpl _$$PaymentDtoImplFromJson(Map<String, dynamic> json) =>
    _$PaymentDtoImpl(
      paymentType:
          $enumDecodeNullable(_$PaymentTypeEnumMap, json['payment_type']),
      amount: (json['amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$PaymentDtoImplToJson(_$PaymentDtoImpl instance) =>
    <String, dynamic>{
      'payment_type': _$PaymentTypeEnumMap[instance.paymentType],
      'amount': instance.amount,
    };

_$SaleItemDtoImpl _$$SaleItemDtoImplFromJson(Map<String, dynamic> json) =>
    _$SaleItemDtoImpl(
      productId: (json['product_id'] as num?)?.toInt(),
      tableId: (json['table_id'] as num?)?.toInt(),
      productPrice: (json['product_price'] as num?)?.toDouble(),
      netUnitPrice: (json['net_unit_price'] as num?)?.toDouble(),
      taxType: (json['tax_type'] as num?)?.toInt(),
      taxValue: (json['tax_value'] as num?)?.toDouble(),
      taxAmount: (json['tax_amount'] as num?)?.toDouble(),
      discountType: (json['discount_type'] as num?)?.toInt(),
      discountValue: (json['discount_value'] as num?)?.toDouble(),
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
      saleUnit: json['sale_unit'],
      quantity: (json['quantity'] as num?)?.toDouble(),
      subTotal: (json['sub_total'] as num?)?.toDouble(),
      isCustom: _toBool(json['is_custom']),
      customCost: (json['custom_cost'] as num?)?.toDouble(),
      customDescription: json['custom_description'] as String?,
      customName: json['custom_name'] as String?,
      customPrice: (json['custom_price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$SaleItemDtoImplToJson(_$SaleItemDtoImpl instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'table_id': instance.tableId,
      'product_price': instance.productPrice,
      'net_unit_price': instance.netUnitPrice,
      'tax_type': instance.taxType,
      'tax_value': instance.taxValue,
      'tax_amount': instance.taxAmount,
      'discount_type': instance.discountType,
      'discount_value': instance.discountValue,
      'discount_amount': instance.discountAmount,
      'sale_unit': instance.saleUnit,
      'quantity': instance.quantity,
      'sub_total': instance.subTotal,
      'is_custom': _fromBool(instance.isCustom),
      'custom_cost': instance.customCost,
      'custom_description': instance.customDescription,
      'custom_name': instance.customName,
      'custom_price': instance.customPrice,
    };
