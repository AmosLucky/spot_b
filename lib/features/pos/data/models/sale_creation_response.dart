// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/enums.dart';

part 'sale_creation_response.freezed.dart';
part 'sale_creation_response.g.dart';

@freezed
class SaleCreationResponseAttributesDao with _$SaleCreationResponseAttributesDao {
  const factory SaleCreationResponseAttributesDao({
    DateTime? date,
    @JsonKey(name: 'is_return') int? isReturn,
    @JsonKey(name: 'customer_id') int? customerId,
    @JsonKey(name: 'company_id') int? companyId,
    @JsonKey(name: 'logged_user') SaleCreationResponseLoggedUserDao? loggedUser,
    @JsonKey(name: 'customer_name') String? customerName,
    @JsonKey(name: 'staff_name') String? staffName,
    @JsonKey(name: 'warehouse_id') int? warehouseId,
    @JsonKey(name: 'warehouse_name') String? warehouseName,
    @JsonKey(name: 'tax_rate') double? taxRate,
    @JsonKey(name: 'tax_amount') double? taxAmount,
    double? discount,
    @JsonKey(name: 'discount_amount') double? discountAmount,
    double? shipping,
    @JsonKey(name: 'grand_total') double? grandTotal,
    @JsonKey(name: 'received_amount') double? receivedAmount,
    @JsonKey(name: 'paid_amount') double? paidAmount,
    @JsonKey(name: 'partial_amount') double? partialAmount,
    @JsonKey(name: 'due_amount') double? dueAmount,
    @JsonKey(name: 'payment_type') PaymentType? paymentType,
    String? note,
    SaleStatus? status,
    @JsonKey(name: 'payment_status') PaymentStatus? paymentStatus,
    @JsonKey(name: 'reference_code') String? referenceCode,
    @JsonKey(name: 'sale_items') List<SaleCreationResponseSaleItemDao>? saleItems,
    List<SaleCreationResponsePaymentDao>? payments,
    @JsonKey(name: 'payment_methods') List<String>? paymentMethods,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'barcode_url') String? barcodeUrl,
    @JsonKey(name: 'is_offline') @IntOrBoolToBoolConverter() @Default(false) bool? isOffline,
    @JsonKey(name: 'offline_customer_name') String? offlineCustomerName,
    @JsonKey(name: 'staff_id') int? staffId,
    @JsonKey(name: 'attendant_name') String? attendantName,
    @JsonKey(name: 'room_details') dynamic roomDetails,
  }) = _SaleCreationResponseAttributesDao;

  factory SaleCreationResponseAttributesDao.fromJson(Map<String, dynamic> json) => _$SaleCreationResponseAttributesDaoFromJson(json);
}

@freezed
class SaleCreationResponseLoggedUserDao with _$SaleCreationResponseLoggedUserDao {
  const factory SaleCreationResponseLoggedUserDao({
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
    String? type,
    @JsonKey(name: 'salary_amount') double? salaryAmount,
    double? balance,
    @JsonKey(name: 'date_employed') DateTime? dateEmployed,
    String? note,
    @JsonKey(name: 'is_attendant') int? isAttendant,
    @JsonKey(name: 'image_url') String? imageUrl,
    List<dynamic>? media,
  }) = _SaleCreationResponseLoggedUserDao;

  factory SaleCreationResponseLoggedUserDao.fromJson(Map<String, dynamic> json) => _$SaleCreationResponseLoggedUserDaoFromJson(json);
}

class StringOrNumToDoubleConverter implements JsonConverter<double?, dynamic> {
  const StringOrNumToDoubleConverter();

  @override
  double? fromJson(dynamic json) {
    if (json == null) return null;

    if (json is num) {
      return json.toDouble();
    }

    if (json is String) {
      if (json.trim().isEmpty) return null;
      return double.tryParse(json);
    }

    return null;
  }

  @override
  dynamic toJson(double? object) => object;
}

class IntOrBoolToBoolConverter implements JsonConverter<bool, dynamic> {
  const IntOrBoolToBoolConverter();

  @override
  bool fromJson(dynamic json) {
    if (json == null) return false;

    if (json is bool) return json;

    if (json is num) return json == 1;

    if (json is String) {
      final value = json.toLowerCase();
      return value == '1' || value == 'true';
    }

    return false;
  }

  @override
  dynamic toJson(bool object) => object;
}

@freezed
class SaleCreationResponseSaleItemDao with _$SaleCreationResponseSaleItemDao {
  const factory SaleCreationResponseSaleItemDao({
    @JsonKey(name: 'product_id') int? productId,
    @JsonKey(name: 'product_name') String? productName,
    @JsonKey(name: 'company_id') int? companyId,
    @JsonKey(name: 'net_unit_price') double? netUnitPrice,
    @JsonKey(name: 'product_price') @StringOrNumToDoubleConverter() double? productPrice,
    @JsonKey(name: 'tax_type') int? taxType,
    @JsonKey(name: 'tax_value') double? taxValue,
    @JsonKey(name: 'tax_amount') double? taxAmount,
    @JsonKey(name: 'discount_type') int? discountType,
    @JsonKey(name: 'discount_value') double? discountValue,
    @JsonKey(name: 'discount_amount') double? discountAmount,
    @JsonKey(name: 'sale_unit') SaleCreationResponseSaleUnitDao? saleUnit,
    double? quantity,
    @JsonKey(name: 'sub_total') double? subTotal,
    @JsonKey(name: 'is_custom') @IntOrBoolToBoolConverter() @Default(false) bool? isCustom,
    @JsonKey(name: 'custom_name') String? customName,
    @JsonKey(name: 'custom_description') String? customDescription,
    @JsonKey(name: 'custom_cost') @StringOrNumToDoubleConverter() double? customCost,
    @JsonKey(name: 'custom_price') @StringOrNumToDoubleConverter() double? customPrice,
  }) = _SaleCreationResponseSaleItemDao;

  factory SaleCreationResponseSaleItemDao.fromJson(Map<String, dynamic> json) => _$SaleCreationResponseSaleItemDaoFromJson(json);
}

@freezed
class SaleCreationResponseSaleUnitDao with _$SaleCreationResponseSaleUnitDao {
  const factory SaleCreationResponseSaleUnitDao({
    int? id,
    String? name,
    @JsonKey(name: 'short_name') String? shortName,
    @JsonKey(name: 'base_unit') int? baseUnit,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'company_id') int? companyId,
  }) = _SaleCreationResponseSaleUnitDao;

  factory SaleCreationResponseSaleUnitDao.fromJson(Map<String, dynamic> json) => _$SaleCreationResponseSaleUnitDaoFromJson(json);
}

@freezed
class SaleCreationResponsePaymentDao with _$SaleCreationResponsePaymentDao {
  const factory SaleCreationResponsePaymentDao({
    @JsonKey(name: 'sale_id') int? saleId,
    @JsonKey(name: 'company_id') int? companyId,
    String? reference,
    @JsonKey(name: 'payment_date') DateTime? paymentDate,
    @JsonKey(name: 'payment_type') PaymentType? paymentType,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    double? amount,
    @JsonKey(name: 'received_amount') double? receivedAmount,
  }) = _SaleCreationResponsePaymentDao;

  factory SaleCreationResponsePaymentDao.fromJson(Map<String, dynamic> json) => _$SaleCreationResponsePaymentDaoFromJson(json);
}
