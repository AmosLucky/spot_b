// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/enums.dart';

part 'sale.freezed.dart';
part 'sale.g.dart';

@freezed
class Sale with _$Sale {
  const factory Sale({
    int? id,
    String? type,
    Map<String, dynamic>? links,
    DateTime? date,
    @JsonKey(name: 'is_return') int? isReturn,
    @JsonKey(name: 'customer_id') int? customerId,
    @JsonKey(name: 'company_id') int? companyId,
    @JsonKey(name: 'logged_user') SaleLoggedUser? loggedUser,
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
    @JsonKey(name: 'sale_items') List<SaleItem>? saleItems,
    List<SalePayment>? payments,
    @JsonKey(name: 'payment_methods') List<String>? paymentMethods,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'barcode_url') String? barcodeUrl,
    @JsonKey(name: 'is_offline') required int isOffline,
    @JsonKey(name: 'offline_customer_name') String? offlineCustomerName,
    @JsonKey(name: 'staff_id') int? staffId,
    @JsonKey(name: 'attendant_name') String? attendantName,
    @JsonKey(name: 'room_details') dynamic roomDetails,
    @JsonKey(name: 'attendant_id') int? attendantId,
    @JsonKey(name: 'partial_payment_method') String? partialPaymentMethod,
  }) = _Sale;

  factory Sale.fromJson(Map<String, dynamic> json) => _$SaleFromJson(json);
}

@freezed
class SaleLoggedUser with _$SaleLoggedUser {
  const factory SaleLoggedUser({
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
    @JsonKey(name: 'warehouse_id') int? warehouseId,
    @JsonKey(name: 'branch_id') int? branchId,
    String? type,
    @JsonKey(name: 'salary_amount') double? salaryAmount,
    double? balance,
    @JsonKey(name: 'date_employed') DateTime? dateEmployed,
    String? note,
    @JsonKey(name: 'is_attendant') int? isAttendant,
    @JsonKey(name: 'image_url') String? imageUrl,
    List<dynamic>? media,
  }) = _SaleLoggedUser;

  factory SaleLoggedUser.fromJson(Map<String, dynamic> json) => _$SaleLoggedUserFromJson(json);
}

@freezed
class SaleItem with _$SaleItem {
  const factory SaleItem({
    @JsonKey(name: 'product_id') int? productId,
    @JsonKey(name: 'product_name') String? productName,
    @JsonKey(name: 'company_id') int? companyId,
    @JsonKey(name: 'net_unit_price') double? netUnitPrice,
    @JsonKey(name: 'product_price') double? productPrice,
    @JsonKey(name: 'tax_type') int? taxType,
    @JsonKey(name: 'tax_value') double? taxValue,
    @JsonKey(name: 'tax_amount') double? taxAmount,
    @JsonKey(name: 'discount_type') int? discountType,
    @JsonKey(name: 'discount_value') double? discountValue,
    @JsonKey(name: 'discount_amount') double? discountAmount,
    @JsonKey(name: 'sale_unit') SaleUnit? saleUnit,
    double? quantity,
    @JsonKey(name: 'sub_total') double? subTotal,
  }) = _SaleItem;

  factory SaleItem.fromJson(Map<String, dynamic> json) => _$SaleItemFromJson(json);
}

@freezed
class SaleUnit with _$SaleUnit {
  const factory SaleUnit({
    int? id,
    String? name,
    @JsonKey(name: 'short_name') String? shortName,
    @JsonKey(name: 'base_unit') int? baseUnit,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'company_id') int? companyId,
  }) = _SaleUnit;

  factory SaleUnit.fromJson(Map<String, dynamic> json) => _$SaleUnitFromJson(json);
}

@freezed
class SalePayment with _$SalePayment {
  const factory SalePayment({
    @JsonKey(name: 'sale_id') int? saleId,
    @JsonKey(name: 'company_id') int? companyId,
    String? reference,
    @JsonKey(name: 'payment_date') DateTime? paymentDate,
    @JsonKey(name: 'payment_type') PaymentType? paymentType,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    double? amount,
    @JsonKey(name: 'received_amount') double? receivedAmount,
  }) = _SalePayment;

  factory SalePayment.fromJson(Map<String, dynamic> json) => _$SalePaymentFromJson(json);
}
