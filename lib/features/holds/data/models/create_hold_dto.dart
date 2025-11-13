// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_hold_dto.freezed.dart';
part 'create_hold_dto.g.dart';

@freezed
class CreateHoldDto with _$CreateHoldDto {
  const factory CreateHoldDto({
    @JsonKey(name: 'reference_code') String? referenceCode,
    DateTime? date,
    @JsonKey(name: 'customer_id') int? customerId,
    @JsonKey(name: 'warehouse_id') int? warehouseId,
    @JsonKey(name: 'staff_id') int? staffId,
    @JsonKey(name: 'staff_name') String? staffName,
    @JsonKey(name: 'tax_rate') double? taxRate,
    @JsonKey(name: 'tax_amount') double? taxAmount,
    double? discount,
    @JsonKey(name: 'discount_amount') double? discountAmount,
    double? shipping,
    @JsonKey(name: 'grand_total') double? grandTotal,
    double? subTotal,
    @JsonKey(name: 'hold_items') List<HoldItemDto>? holdItems,
    String? note,
    @JsonKey(name: 'table_id') String? tableId,
  }) = _CreateHoldDto;

  factory CreateHoldDto.fromJson(Map<String, dynamic> json) => _$CreateHoldDtoFromJson(json);
}

@freezed
class HoldItemDto with _$HoldItemDto {
  const factory HoldItemDto({
    String? name,
    String? code,
    @JsonKey(name: 'stock_alert') String? stockAlert,
    @JsonKey(name: 'product_id') int? productId,
    @JsonKey(name: 'product_cost') double? productCost,
    @JsonKey(name: 'net_unit_cost') double? netUnitCost,
    @JsonKey(name: 'product_price') double? productPrice,
    @JsonKey(name: 'net_unit_price') double? netUnitPrice,
    double? quantity,
    @JsonKey(name: 'sub_total') double? subTotal,
    @JsonKey(name: 'tax_type') int? taxType,
    @JsonKey(name: 'tax_value') double? taxValue,
    @JsonKey(name: 'tax_amount') double? taxAmount,
    @JsonKey(name: 'discount_type') int? discountType,
    @JsonKey(name: 'discount_value') double? discountValue,
    @JsonKey(name: 'discount_amount') double? discountAmount,
    @JsonKey(name: 'product_unit') String? productUnit,
    @JsonKey(name: 'sale_unit') dynamic saleUnit,
    int? id,
    @JsonKey(name: 'sale_id') int? saleId,
    @JsonKey(name: 'hold_item_id') String? holdItemId,
  }) = _HoldItemDto;

  factory HoldItemDto.fromJson(Map<String, dynamic> json) => _$HoldItemDtoFromJson(json);
}
