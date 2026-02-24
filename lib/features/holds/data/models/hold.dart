// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'create_hold_dto.dart';

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
    @JsonKey(includeFromJson: false, includeToJson: false) bool? isSynced,
  }) = _Hold;

  factory Hold.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] as Map<String, dynamic>? ?? {};
    final links = json['links'] as Map<String, dynamic>?;

    return Hold(
      id: int.tryParse(json['id']?.toString() ?? ''),
      type: json['type'] as String?,
      links: links,

      referenceCode: attributes['reference_code'] as String?,
      date: attributes['date'] != null ? DateTime.tryParse(attributes['date']) : null,
      userId: attributes['user_id'] as int?,
      attendant: attributes['attendant'] != null ? HoldAttendant.fromJson(attributes['attendant']) : null,
      customerId: attributes['customer_id'] as int?,
      customerName: attributes['customer_name'] as String?,
      staffId: attributes['staff_id'] as int?,
      staffName: attributes['staff_name'] as String?,
      warehouseId: attributes['warehouse_id'] as int?,
      warehouseName: attributes['warehouse_name'] as String?,
      taxRate: (attributes['tax_rate'] as num?)?.toDouble(),
      taxAmount: (attributes['tax_amount'] as num?)?.toDouble(),
      discount: (attributes['discount'] as num?)?.toDouble(),
      shipping: (attributes['shipping'] as num?)?.toDouble(),
      grandTotal: (attributes['grand_total'] as num?)?.toDouble(),
      receivedAmount: (attributes['received_amount'] as num?)?.toDouble(),
      paidAmount: (attributes['paid_amount'] as num?)?.toDouble(),
      note: attributes['note'] as String?,
      status: attributes['status'],
      tableId: attributes['table_id']?.toString(),
      tableName: attributes['table_name'],
      holdItems: attributes['hold_items'] != null ? (attributes['hold_items'] as List).map((e) => HoldItem.fromJson(e)).toList() : null,
      createdAt: attributes['created_at'] != null ? DateTime.tryParse(attributes['created_at']) : null,

      // Not included in JSON
      // isSynced: false,
    );
  }
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
    String? code,
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
    @JsonKey(name: 'custom_cost') @StringOrNumToDoubleConverter() double? customCost,
    @JsonKey(name: 'custom_price') @StringOrNumToDoubleConverter() double? customPrice,
    @JsonKey(name: 'custom_name') String? customName,
    @JsonKey(name: 'custom_description') String? customDescription,
    @JsonKey(name: 'is_custom') @IntBoolConverter() @Default(false) bool isCustom,
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
