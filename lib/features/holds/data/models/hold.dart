// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hold.freezed.dart';
part 'hold.g.dart';

@freezed
class Hold with _$Hold {
  const factory Hold({
    int? id,
    String? type,
    Map<String, dynamic>? links,
    @JsonKey(name: 'reference_code') String? referenceCode,
    DateTime? date,
    @JsonKey(name: 'user_id') int? userId,
    HoldAttendant? attendant,
    @JsonKey(name: 'customer_id') int? customerId,
    @JsonKey(name: 'customer_name') String? customerName,
    @JsonKey(name: 'staff_id') int? staffId,
    @JsonKey(name: 'staff_name') String? staffName,
    @JsonKey(name: 'warehouse_id') int? warehouseId,
    @JsonKey(name: 'warehouse_name') String? warehouseName,
    @JsonKey(name: 'tax_rate') double? taxRate,
    @JsonKey(name: 'tax_amount') double? taxAmount,
    double? discount,
    double? shipping,
    @JsonKey(name: 'grand_total') double? grandTotal,
    @JsonKey(name: 'received_amount') double? receivedAmount,
    @JsonKey(name: 'paid_amount') double? paidAmount,
    String? note,
    dynamic status,
    @JsonKey(name: 'table_id') String? tableId,
    @JsonKey(name: 'table_name') dynamic tableName,
    @JsonKey(name: 'hold_items') List<HoldItem>? holdItems,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _Hold;

  factory Hold.fromJson(Map<String, dynamic> json) => _$HoldFromJson(json);
}

@freezed
class HoldAttendant with _$HoldAttendant {
  const factory HoldAttendant({
    int? id,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    DateTime? dob,
    @JsonKey(name: 'salary_date') DateTime? salaryDate,
    String? email,
    String? phone,
    @JsonKey(name: 'email_verified_at') DateTime? emailVerifiedAt,
    @JsonKey(name: 'default_password') String? defaultPassword,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    int? status,
    String? language,
    @JsonKey(name: 'company_id') int? companyId,
    @JsonKey(name: 'is_admin') int? isAdmin,
    @JsonKey(name: 'is_super') int? isSuper,
    @JsonKey(name: 'warehouse_id') String? warehouseId,
    @JsonKey(name: 'branch_id') int? branchId,
    String? type,
    @JsonKey(name: 'salary_amount') double? salaryAmount,
    double? balance,
    @JsonKey(name: 'date_employed') DateTime? dateEmployed,
    String? note,
    @JsonKey(name: 'is_attendant') int? isAttendant,
    @JsonKey(name: 'table_id') String? tableId,
    @JsonKey(name: 'image_url') String? imageUrl,
    List<dynamic>? media,
  }) = _HoldAttendant;

  factory HoldAttendant.fromJson(Map<String, dynamic> json) => _$HoldAttendantFromJson(json);
}

@freezed
class HoldItem with _$HoldItem {
  const factory HoldItem({
    int? id,
    @JsonKey(name: 'hold_id') int? holdId,
    @JsonKey(name: 'product_id') int? productId,
    @JsonKey(name: 'product_name') String? productName,
    @JsonKey(name: 'product_price') double? productPrice,
    @JsonKey(name: 'net_unit_price') double? netUnitPrice,
    @JsonKey(name: 'tax_type') int? taxType,
    @JsonKey(name: 'tax_value') double? taxValue,
    @JsonKey(name: 'tax_amount') double? taxAmount,
    @JsonKey(name: 'discount_type') int? discountType,
    @JsonKey(name: 'discount_value') double? discountValue,
    @JsonKey(name: 'discount_amount') double? discountAmount,
    @JsonKey(name: 'sale_unit') HoldUnit? saleUnit,
    double? quantity,
    @JsonKey(name: 'sub_total') double? subTotal,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _HoldItem;

  factory HoldItem.fromJson(Map<String, dynamic> json) => _$HoldItemFromJson(json);
}

@freezed
class HoldUnit with _$HoldUnit {
  const factory HoldUnit({
    int? id,
    String? name,
    @JsonKey(name: 'short_name') String? shortName,
    @JsonKey(name: 'base_unit') int? baseUnit,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'company_id') int? companyId,
  }) = _HoldUnit;

  factory HoldUnit.fromJson(Map<String, dynamic> json) => _$HoldUnitFromJson(json);
}
