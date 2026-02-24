// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hold_creation_response.freezed.dart';
part 'hold_creation_response.g.dart';

@freezed
class HoldCreationResponseAttributesDao with _$HoldCreationResponseAttributesDao {
  const factory HoldCreationResponseAttributesDao({
    @JsonKey(name: 'reference_code') String? referenceCode,
    DateTime? date,
    @JsonKey(name: 'user_id') int? userId,
    HoldCreationResponseAttendantDao? attendant,
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
    String? status,
    @JsonKey(name: 'table_id') String? tableId,
    @JsonKey(name: 'table_name') String? tableName,
    @JsonKey(name: 'hold_items') List<HoldCreationResponseHoldItemDao>? holdItems,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _HoldCreationResponseAttributesDao;

  factory HoldCreationResponseAttributesDao.fromJson(Map<String, dynamic> json) => _$HoldCreationResponseAttributesDaoFromJson(json);
}

@freezed
class HoldCreationResponseAttendantDao with _$HoldCreationResponseAttendantDao {
  const factory HoldCreationResponseAttendantDao({
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
    @JsonKey(name: 'branch_id') dynamic branchId,
    String? type,
    @JsonKey(name: 'salary_amount') double? salaryAmount,
    double? balance,
    @JsonKey(name: 'date_employed') DateTime? dateEmployed,
    String? note,
    @JsonKey(name: 'is_attendant') int? isAttendant,
    @JsonKey(name: 'table_id') String? tableId,
    @JsonKey(name: 'image_url') String? imageUrl,
    List<dynamic>? media,
  }) = _HoldCreationResponseAttendantDao;

  factory HoldCreationResponseAttendantDao.fromJson(Map<String, dynamic> json) => _$HoldCreationResponseAttendantDaoFromJson(json);
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
class HoldCreationResponseHoldItemDao with _$HoldCreationResponseHoldItemDao {
  const factory HoldCreationResponseHoldItemDao({
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
    @JsonKey(name: 'sale_unit') HoldCreationResponseSaleUnitDao? saleUnit,
    double? quantity,
    @JsonKey(name: 'sub_total') double? subTotal,
    @JsonKey(name: 'is_custom') @IntBoolConverter() @Default(false) bool isCustom,
    @JsonKey(name: 'custom_name') String? customName,
    @JsonKey(name: 'custom_cost') @StringOrNumToDoubleConverter() double? customCost,
    @JsonKey(name: 'custom_price') @StringOrNumToDoubleConverter() double? customPrice,
    @JsonKey(name: 'custom_description') String? customDescription,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _HoldCreationResponseHoldItemDao;

  factory HoldCreationResponseHoldItemDao.fromJson(Map<String, dynamic> json) => _$HoldCreationResponseHoldItemDaoFromJson(json);
}

@freezed
class HoldCreationResponseSaleUnitDao with _$HoldCreationResponseSaleUnitDao {
  const factory HoldCreationResponseSaleUnitDao({
    int? id,
    String? name,
    @JsonKey(name: 'short_name') String? shortName,
    @JsonKey(name: 'base_unit') int? baseUnit,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'company_id') int? companyId,
  }) = _HoldCreationResponseSaleUnitDao;

  factory HoldCreationResponseSaleUnitDao.fromJson(Map<String, dynamic> json) => _$HoldCreationResponseSaleUnitDaoFromJson(json);
}
