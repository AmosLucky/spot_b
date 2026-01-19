// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hold.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HoldAttendantImpl _$$HoldAttendantImplFromJson(Map<String, dynamic> json) =>
    _$HoldAttendantImpl(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
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
      warehouseId: json['warehouse_id'] as String?,
      branchId: (json['branch_id'] as num?)?.toInt(),
      type: json['type'] as String?,
      salaryAmount: (json['salary_amount'] as num?)?.toDouble(),
      balance: (json['balance'] as num?)?.toDouble(),
      dateEmployed: json['date_employed'] == null
          ? null
          : DateTime.parse(json['date_employed'] as String),
      note: json['note'] as String?,
      isAttendant: (json['is_attendant'] as num?)?.toInt(),
      tableId: json['table_id'] as String?,
      imageUrl: json['image_url'] as String?,
      media: json['media'] as List<dynamic>?,
    );

Map<String, dynamic> _$$HoldAttendantImplToJson(_$HoldAttendantImpl instance) =>
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
      'warehouse_id': instance.warehouseId,
      'branch_id': instance.branchId,
      'type': instance.type,
      'salary_amount': instance.salaryAmount,
      'balance': instance.balance,
      'date_employed': instance.dateEmployed?.toIso8601String(),
      'note': instance.note,
      'is_attendant': instance.isAttendant,
      'table_id': instance.tableId,
      'image_url': instance.imageUrl,
      'media': instance.media,
    };

_$HoldItemImpl _$$HoldItemImplFromJson(Map<String, dynamic> json) =>
    _$HoldItemImpl(
      id: (json['id'] as num?)?.toInt(),
      code: json['code'] as String?,
      holdId: (json['hold_id'] as num?)?.toInt(),
      productId: (json['product_id'] as num?)?.toInt(),
      productName: json['product_name'] as String?,
      productPrice: (json['product_price'] as num?)?.toDouble(),
      netUnitPrice: (json['net_unit_price'] as num?)?.toDouble(),
      taxType: (json['tax_type'] as num?)?.toInt(),
      taxValue: (json['tax_value'] as num?)?.toDouble(),
      taxAmount: (json['tax_amount'] as num?)?.toDouble(),
      discountType: (json['discount_type'] as num?)?.toInt(),
      discountValue: (json['discount_value'] as num?)?.toDouble(),
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
      saleUnit: json['sale_unit'] == null
          ? null
          : HoldUnit.fromJson(json['sale_unit'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toDouble(),
      subTotal: (json['sub_total'] as num?)?.toDouble(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      customCost:
          const StringOrNumToDoubleConverter().fromJson(json['custom_cost']),
      customPrice:
          const StringOrNumToDoubleConverter().fromJson(json['custom_price']),
      customName: json['custom_name'] as String?,
      customDescription: json['custom_description'] as String?,
      isCustom: json['is_custom'] == null
          ? false
          : const IntBoolConverter().fromJson(json['is_custom']),
    );

Map<String, dynamic> _$$HoldItemImplToJson(_$HoldItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'hold_id': instance.holdId,
      'product_id': instance.productId,
      'product_name': instance.productName,
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
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'custom_cost':
          const StringOrNumToDoubleConverter().toJson(instance.customCost),
      'custom_price':
          const StringOrNumToDoubleConverter().toJson(instance.customPrice),
      'custom_name': instance.customName,
      'custom_description': instance.customDescription,
      'is_custom': const IntBoolConverter().toJson(instance.isCustom),
    };

_$HoldUnitImpl _$$HoldUnitImplFromJson(Map<String, dynamic> json) =>
    _$HoldUnitImpl(
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

Map<String, dynamic> _$$HoldUnitImplToJson(_$HoldUnitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'short_name': instance.shortName,
      'base_unit': instance.baseUnit,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'company_id': instance.companyId,
    };
