// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'hold.dart';

part 'create_hold_dto.freezed.dart';
part 'create_hold_dto.g.dart';

@freezed
class CreateHoldDto with _$CreateHoldDto {
  const factory CreateHoldDto({
    @JsonKey(name: 'customer_id') int? customerId,
    DateTime? date,
    double? discount,
    @JsonKey(name: 'discount_amount') double? discountAmount,
    @JsonKey(name: 'grand_total') double? grandTotal,
    @JsonKey(name: 'hold_items') List<HoldItemDto>? holdItems,
    String? note,
    @JsonKey(name: 'reference_code') String? referenceCode,
    double? shipping,
    @JsonKey(name: 'staff_id') int? staffId,
    @JsonKey(name: 'staff_name') String? staffName,
    double? subTotal,
    @JsonKey(name: 'tax_amount') double? taxAmount,
    @JsonKey(name: 'tax_rate') double? taxRate,
    @JsonKey(name: 'table_id') String? tableId,
    @JsonKey(name: 'warehouse_id') int? warehouseId,
    @JsonKey(includeFromJson: false, includeToJson: false) String? type,
    @JsonKey(includeFromJson: false, includeToJson: false) Map<String, dynamic>? links,
    @JsonKey(includeFromJson: false, includeToJson: false) int? userId,
    @JsonKey(includeFromJson: false, includeToJson: false) HoldAttendant? attendant,
    @JsonKey(includeFromJson: false, includeToJson: false) String? customerName,
    @JsonKey(includeFromJson: false, includeToJson: false) String? warehouseName,
    @JsonKey(includeFromJson: false, includeToJson: false) dynamic status,
    @JsonKey(includeFromJson: false, includeToJson: false) String? tableName,
    @JsonKey(includeFromJson: false, includeToJson: false) DateTime? createdAt,
    @JsonKey(includeFromJson: false, includeToJson: false) double? receivedAmount,
    @JsonKey(includeFromJson: false, includeToJson: false) double? paidAmount,
  }) = _CreateHoldDto;

  factory CreateHoldDto.fromJson(Map<String, dynamic> json) => _$CreateHoldDtoFromJson(json);
}

class StringOrNumToDoubleConverter implements JsonConverter<double?, dynamic> {
  const StringOrNumToDoubleConverter();

  @override
  double? fromJson(dynamic json) {
    if (json == null) return null;

    if (json is num) return json.toDouble();

    if (json is String) {
      if (json.trim().isEmpty) return null;
      return double.tryParse(json);
    }

    return null;
  }

  @override
  dynamic toJson(double? object) => object;
}

class IntBoolConverter implements JsonConverter<bool, dynamic> {
  const IntBoolConverter();

  @override
  bool fromJson(dynamic json) {
    if (json is bool) return json;
    if (json is num) return json == 1;
    if (json is String) return json == '1' || json.toLowerCase() == 'true';
    return false;
  }

  @override
  dynamic toJson(bool value) => value ? 1 : 0;
}

@freezed
class HoldItemDto with _$HoldItemDto {
  const factory HoldItemDto({
    String? code,
    @JsonKey(name: 'discount_amount') double? discountAmount,
    @JsonKey(name: 'discount_type') int? discountType,
    @JsonKey(name: 'discount_value') double? discountValue,
    @JsonKey(name: 'hold_item_id') String? holdItemId,
    int? id,
    String? name,
    @JsonKey(name: 'net_unit_cost') double? netUnitCost,
    @JsonKey(name: 'net_unit_price') double? netUnitPrice,
    @JsonKey(name: 'product_cost') double? productCost,
    @JsonKey(name: 'product_id') int? productId,
    @JsonKey(name: 'product_price') double? productPrice,
    @JsonKey(name: 'product_unit') String? productUnit,
    double? quantity,
    @JsonKey(name: 'sale_id') int? saleId,
    @JsonKey(name: 'sale_unit') dynamic saleUnit,
    @JsonKey(name: 'stock_alert') String? stockAlert,
    @JsonKey(name: 'sub_total') double? subTotal,
    @JsonKey(name: 'tax_amount') double? taxAmount,
    @JsonKey(name: 'tax_type') int? taxType,
    @JsonKey(name: 'tax_value') double? taxValue,
    @JsonKey(name: 'custom_cost') @StringOrNumToDoubleConverter() double? customCost,
    @JsonKey(name: 'custom_price') @StringOrNumToDoubleConverter() double? customPrice,
    @JsonKey(name: 'custom_name') String? customName,
    @JsonKey(name: 'custom_description') String? customDescription,
    @JsonKey(name: 'is_custom') @IntBoolConverter() @Default(false) bool isCustom,
  }) = _HoldItemDto;

  factory HoldItemDto.fromJson(Map<String, dynamic> json) => _$HoldItemDtoFromJson(json);
}
