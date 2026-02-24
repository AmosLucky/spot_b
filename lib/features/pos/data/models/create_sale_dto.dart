// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/enums.dart';
import 'sale_creation_response.dart';

part 'create_sale_dto.freezed.dart';
part 'create_sale_dto.g.dart';

@freezed
class CreateSaleDto with _$CreateSaleDto {
  const factory CreateSaleDto({
    @JsonKey(name: 'reference_code') String? referenceCode,
    DateTime? date,
    @JsonKey(name: 'customer_id') int? customerId,
    @JsonKey(name: 'warehouse_id') int? warehouseId,
    @JsonKey(name: 'tax_rate') double? taxRate,
    @JsonKey(name: 'tax_amount') double? taxAmount,
    double? discount,
    @JsonKey(name: 'discount_amount') double? discountAmount,
    double? shipping,
    @JsonKey(name: 'grand_total') double? grandTotal,
    SaleStatus? status,
    @JsonKey(name: 'payment_status') PaymentStatus? paymentStatus,
    @JsonKey(name: 'payment_type') PaymentType? paymentType,
    @JsonKey(name: 'received_amount') double? receivedAmount,
    @JsonKey(name: 'paid_amount') double? paidAmount,
    @JsonKey(name: 'payments') List<PaymentDto>? payments,
    String? notes,
    @JsonKey(name: 'sale_items') List<SaleItemDto>? saleItems,
    String? note,
    @JsonKey(name: 'partial_payment_amount') double? partialPaymentAmount,
    @JsonKey(name: 'partial_payment_method') String? partialPaymentMethod,
    @JsonKey(name: 'staff_id') int? staffId,
    @JsonKey(name: 'staff_name') String? staffName,
    @JsonKey(name: 'attendant_id') int? attendantId,
    @JsonKey(name: 'attendant_name') String? attendantName,
    @JsonKey(name: 'room_details') dynamic roomDetails,
    @JsonKey(name: 'is_offline') @IntOrBoolToBoolConverter() @Default(false) bool? isOffline,
    @JsonKey(name: 'offline_customer_name') String? offlineCustomerName,
    @JsonKey(includeFromJson: false, includeToJson: false) String? warehouseName,
    @JsonKey(includeFromJson: false, includeToJson: false) String? customerName,
  }) = _CreateSaleDto;

  factory CreateSaleDto.fromJson(Map<String, dynamic> json) => _$CreateSaleDtoFromJson(json);
}

@freezed
class PaymentDto with _$PaymentDto {
  const factory PaymentDto({
    @JsonKey(name: 'payment_type') PaymentType? paymentType,
    @JsonKey(name: 'amount') double? amount,
  }) = _PaymentDto;

  factory PaymentDto.fromJson(Map<String, dynamic> json) => _$PaymentDtoFromJson(json);
}

@freezed
class SaleItemDto with _$SaleItemDto {
  const factory SaleItemDto({
    @JsonKey(name: 'product_id') required int? productId,
    @JsonKey(name: 'table_id') int? tableId,
    @JsonKey(name: 'product_price') double? productPrice,
    @JsonKey(name: 'net_unit_price') double? netUnitPrice,
    @JsonKey(name: 'tax_type') int? taxType,
    @JsonKey(name: 'tax_value') double? taxValue,
    @JsonKey(name: 'tax_amount') double? taxAmount,
    @JsonKey(name: 'discount_type') int? discountType,
    @JsonKey(name: 'discount_value') double? discountValue,
    @JsonKey(name: 'discount_amount') double? discountAmount,
    @JsonKey(name: 'sale_unit') dynamic saleUnit,
    @JsonKey(name: 'quantity') double? quantity,
    @JsonKey(name: 'sub_total') double? subTotal,
    @JsonKey(name: 'is_custom', fromJson: _toBool, toJson: _fromBool) bool? isCustom,
    @JsonKey(name: 'custom_cost') double? customCost,
    @JsonKey(name: 'custom_description') String? customDescription,
    @JsonKey(name: 'custom_name') String? customName,
    @JsonKey(name: 'custom_price') double? customPrice,
    @JsonKey(includeFromJson: false, includeToJson: false) String? productName,
    @JsonKey(includeFromJson: false, includeToJson: false) String? productCode,
  }) = _SaleItemDto;

  factory SaleItemDto.fromJson(Map<String, dynamic> json) => _$SaleItemDtoFromJson(json);
}

bool? _toBool(dynamic value) {
  if (value == null) return null;
  return value == 1 || value == "1" || value == true;
}

dynamic _fromBool(bool? value) {
  if (value == null) return null;
  return value ? 1 : 0;
}
