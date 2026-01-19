// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_creation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SaleCreationResponseAttributesDaoImpl
    _$$SaleCreationResponseAttributesDaoImplFromJson(
            Map<String, dynamic> json) =>
        _$SaleCreationResponseAttributesDaoImpl(
          date: json['date'] == null
              ? null
              : DateTime.parse(json['date'] as String),
          isReturn: (json['is_return'] as num?)?.toInt(),
          customerId: (json['customer_id'] as num?)?.toInt(),
          companyId: (json['company_id'] as num?)?.toInt(),
          loggedUser: json['logged_user'] == null
              ? null
              : SaleCreationResponseLoggedUserDao.fromJson(
                  json['logged_user'] as Map<String, dynamic>),
          customerName: json['customer_name'] as String?,
          staffName: json['staff_name'] as String?,
          warehouseId: (json['warehouse_id'] as num?)?.toInt(),
          warehouseName: json['warehouse_name'] as String?,
          taxRate: (json['tax_rate'] as num?)?.toDouble(),
          taxAmount: (json['tax_amount'] as num?)?.toDouble(),
          discount: (json['discount'] as num?)?.toDouble(),
          discountAmount: (json['discount_amount'] as num?)?.toDouble(),
          shipping: (json['shipping'] as num?)?.toDouble(),
          grandTotal: (json['grand_total'] as num?)?.toDouble(),
          receivedAmount: (json['received_amount'] as num?)?.toDouble(),
          paidAmount: (json['paid_amount'] as num?)?.toDouble(),
          partialAmount: (json['partial_amount'] as num?)?.toDouble(),
          dueAmount: (json['due_amount'] as num?)?.toDouble(),
          paymentType:
              $enumDecodeNullable(_$PaymentTypeEnumMap, json['payment_type']),
          note: json['note'] as String?,
          status: $enumDecodeNullable(_$SaleStatusEnumMap, json['status']),
          paymentStatus: $enumDecodeNullable(
              _$PaymentStatusEnumMap, json['payment_status']),
          referenceCode: json['reference_code'] as String?,
          saleItems: (json['sale_items'] as List<dynamic>?)
              ?.map((e) => SaleCreationResponseSaleItemDao.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          payments: (json['payments'] as List<dynamic>?)
              ?.map((e) => SaleCreationResponsePaymentDao.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          paymentMethods: (json['payment_methods'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
          createdAt: json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
          barcodeUrl: json['barcode_url'] as String?,
          isOffline: json['is_offline'] == null
              ? false
              : const IntOrBoolToBoolConverter().fromJson(json['is_offline']),
          offlineCustomerName: json['offline_customer_name'] as String?,
          staffId: (json['staff_id'] as num?)?.toInt(),
          attendantName: json['attendant_name'] as String?,
          roomDetails: json['room_details'],
        );

Map<String, dynamic> _$$SaleCreationResponseAttributesDaoImplToJson(
        _$SaleCreationResponseAttributesDaoImpl instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'is_return': instance.isReturn,
      'customer_id': instance.customerId,
      'company_id': instance.companyId,
      'logged_user': instance.loggedUser,
      'customer_name': instance.customerName,
      'staff_name': instance.staffName,
      'warehouse_id': instance.warehouseId,
      'warehouse_name': instance.warehouseName,
      'tax_rate': instance.taxRate,
      'tax_amount': instance.taxAmount,
      'discount': instance.discount,
      'discount_amount': instance.discountAmount,
      'shipping': instance.shipping,
      'grand_total': instance.grandTotal,
      'received_amount': instance.receivedAmount,
      'paid_amount': instance.paidAmount,
      'partial_amount': instance.partialAmount,
      'due_amount': instance.dueAmount,
      'payment_type': _$PaymentTypeEnumMap[instance.paymentType],
      'note': instance.note,
      'status': _$SaleStatusEnumMap[instance.status],
      'payment_status': _$PaymentStatusEnumMap[instance.paymentStatus],
      'reference_code': instance.referenceCode,
      'sale_items': instance.saleItems,
      'payments': instance.payments,
      'payment_methods': instance.paymentMethods,
      'created_at': instance.createdAt?.toIso8601String(),
      'barcode_url': instance.barcodeUrl,
      'is_offline': _$JsonConverterToJson<dynamic, bool>(
          instance.isOffline, const IntOrBoolToBoolConverter().toJson),
      'offline_customer_name': instance.offlineCustomerName,
      'staff_id': instance.staffId,
      'attendant_name': instance.attendantName,
      'room_details': instance.roomDetails,
    };

const _$PaymentTypeEnumMap = {
  PaymentType.cash: 1,
  PaymentType.pos: 2,
  PaymentType.transfer: 3,
  PaymentType.folio: 4,
  PaymentType.other: 5,
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

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$SaleCreationResponseLoggedUserDaoImpl
    _$$SaleCreationResponseLoggedUserDaoImplFromJson(
            Map<String, dynamic> json) =>
        _$SaleCreationResponseLoggedUserDaoImpl(
          id: (json['id'] as num?)?.toInt(),
          firstName: json['first_name'] as String?,
          lastName: json['last_name'] as String?,
          dob: json['dob'] == null
              ? null
              : DateTime.parse(json['dob'] as String),
          salaryDate: json['salary_date'] == null
              ? null
              : DateTime.parse(json['salary_date'] as String),
          email: json['email'] as String?,
          phone: json['phone'] as String?,
          emailVerifiedAt: json['email_verified_at'] == null
              ? null
              : DateTime.parse(json['email_verified_at'] as String),
          defaultPassword: json['default_password'] as String?,
          createdAt: json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
          updatedAt: json['updated_at'] == null
              ? null
              : DateTime.parse(json['updated_at'] as String),
          status: (json['status'] as num?)?.toInt(),
          language: json['language'] as String?,
          companyId: (json['company_id'] as num?)?.toInt(),
          isAdmin: (json['is_admin'] as num?)?.toInt(),
          isSuper: (json['is_super'] as num?)?.toInt(),
          type: json['type'] as String?,
          salaryAmount: (json['salary_amount'] as num?)?.toDouble(),
          balance: (json['balance'] as num?)?.toDouble(),
          dateEmployed: json['date_employed'] == null
              ? null
              : DateTime.parse(json['date_employed'] as String),
          note: json['note'] as String?,
          isAttendant: (json['is_attendant'] as num?)?.toInt(),
          imageUrl: json['image_url'] as String?,
          media: json['media'] as List<dynamic>?,
        );

Map<String, dynamic> _$$SaleCreationResponseLoggedUserDaoImplToJson(
        _$SaleCreationResponseLoggedUserDaoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'dob': instance.dob?.toIso8601String(),
      'salary_date': instance.salaryDate?.toIso8601String(),
      'email': instance.email,
      'phone': instance.phone,
      'email_verified_at': instance.emailVerifiedAt?.toIso8601String(),
      'default_password': instance.defaultPassword,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'language': instance.language,
      'company_id': instance.companyId,
      'is_admin': instance.isAdmin,
      'is_super': instance.isSuper,
      'type': instance.type,
      'salary_amount': instance.salaryAmount,
      'balance': instance.balance,
      'date_employed': instance.dateEmployed?.toIso8601String(),
      'note': instance.note,
      'is_attendant': instance.isAttendant,
      'image_url': instance.imageUrl,
      'media': instance.media,
    };

_$SaleCreationResponseSaleItemDaoImpl
    _$$SaleCreationResponseSaleItemDaoImplFromJson(Map<String, dynamic> json) =>
        _$SaleCreationResponseSaleItemDaoImpl(
          productId: (json['product_id'] as num?)?.toInt(),
          productName: json['product_name'] as String?,
          companyId: (json['company_id'] as num?)?.toInt(),
          netUnitPrice: (json['net_unit_price'] as num?)?.toDouble(),
          productPrice: const StringOrNumToDoubleConverter()
              .fromJson(json['product_price']),
          taxType: (json['tax_type'] as num?)?.toInt(),
          taxValue: (json['tax_value'] as num?)?.toDouble(),
          taxAmount: (json['tax_amount'] as num?)?.toDouble(),
          discountType: (json['discount_type'] as num?)?.toInt(),
          discountValue: (json['discount_value'] as num?)?.toDouble(),
          discountAmount: (json['discount_amount'] as num?)?.toDouble(),
          saleUnit: json['sale_unit'] == null
              ? null
              : SaleCreationResponseSaleUnitDao.fromJson(
                  json['sale_unit'] as Map<String, dynamic>),
          quantity: (json['quantity'] as num?)?.toDouble(),
          subTotal: (json['sub_total'] as num?)?.toDouble(),
          isCustom: json['is_custom'] == null
              ? false
              : const IntOrBoolToBoolConverter().fromJson(json['is_custom']),
          customName: json['custom_name'] as String?,
          customDescription: json['custom_description'] as String?,
          customCost: const StringOrNumToDoubleConverter()
              .fromJson(json['custom_cost']),
          customPrice: const StringOrNumToDoubleConverter()
              .fromJson(json['custom_price']),
        );

Map<String, dynamic> _$$SaleCreationResponseSaleItemDaoImplToJson(
        _$SaleCreationResponseSaleItemDaoImpl instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'product_name': instance.productName,
      'company_id': instance.companyId,
      'net_unit_price': instance.netUnitPrice,
      'product_price':
          const StringOrNumToDoubleConverter().toJson(instance.productPrice),
      'tax_type': instance.taxType,
      'tax_value': instance.taxValue,
      'tax_amount': instance.taxAmount,
      'discount_type': instance.discountType,
      'discount_value': instance.discountValue,
      'discount_amount': instance.discountAmount,
      'sale_unit': instance.saleUnit,
      'quantity': instance.quantity,
      'sub_total': instance.subTotal,
      'is_custom': _$JsonConverterToJson<dynamic, bool>(
          instance.isCustom, const IntOrBoolToBoolConverter().toJson),
      'custom_name': instance.customName,
      'custom_description': instance.customDescription,
      'custom_cost':
          const StringOrNumToDoubleConverter().toJson(instance.customCost),
      'custom_price':
          const StringOrNumToDoubleConverter().toJson(instance.customPrice),
    };

_$SaleCreationResponseSaleUnitDaoImpl
    _$$SaleCreationResponseSaleUnitDaoImplFromJson(Map<String, dynamic> json) =>
        _$SaleCreationResponseSaleUnitDaoImpl(
          id: (json['id'] as num?)?.toInt(),
          name: json['name'] as String?,
          shortName: json['short_name'] as String?,
          baseUnit: (json['base_unit'] as num?)?.toInt(),
          createdAt: json['created_at'] == null
              ? null
              : DateTime.parse(json['created_at'] as String),
          updatedAt: json['updated_at'] == null
              ? null
              : DateTime.parse(json['updated_at'] as String),
          companyId: (json['company_id'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$SaleCreationResponseSaleUnitDaoImplToJson(
        _$SaleCreationResponseSaleUnitDaoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'short_name': instance.shortName,
      'base_unit': instance.baseUnit,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'company_id': instance.companyId,
    };

_$SaleCreationResponsePaymentDaoImpl
    _$$SaleCreationResponsePaymentDaoImplFromJson(Map<String, dynamic> json) =>
        _$SaleCreationResponsePaymentDaoImpl(
          saleId: (json['sale_id'] as num?)?.toInt(),
          companyId: (json['company_id'] as num?)?.toInt(),
          reference: json['reference'] as String?,
          paymentDate: json['payment_date'] == null
              ? null
              : DateTime.parse(json['payment_date'] as String),
          paymentType:
              $enumDecodeNullable(_$PaymentTypeEnumMap, json['payment_type']),
          paymentMethod: json['payment_method'] as String?,
          amount: (json['amount'] as num?)?.toDouble(),
          receivedAmount: (json['received_amount'] as num?)?.toDouble(),
        );

Map<String, dynamic> _$$SaleCreationResponsePaymentDaoImplToJson(
        _$SaleCreationResponsePaymentDaoImpl instance) =>
    <String, dynamic>{
      'sale_id': instance.saleId,
      'company_id': instance.companyId,
      'reference': instance.reference,
      'payment_date': instance.paymentDate?.toIso8601String(),
      'payment_type': _$PaymentTypeEnumMap[instance.paymentType],
      'payment_method': instance.paymentMethod,
      'amount': instance.amount,
      'received_amount': instance.receivedAmount,
    };
