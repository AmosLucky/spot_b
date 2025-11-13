// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hold.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HoldImpl _$$HoldImplFromJson(Map<String, dynamic> json) => _$HoldImpl(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      links: json['links'] as Map<String, dynamic>?,
      referenceCode: json['reference_code'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      userId: (json['user_id'] as num?)?.toInt(),
      attendant: json['attendant'] == null
          ? null
          : HoldAttendant.fromJson(json['attendant'] as Map<String, dynamic>),
      customerId: (json['customer_id'] as num?)?.toInt(),
      customerName: json['customer_name'] as String?,
      staffId: (json['staff_id'] as num?)?.toInt(),
      staffName: json['staff_name'] as String?,
      warehouseId: (json['warehouse_id'] as num?)?.toInt(),
      warehouseName: json['warehouse_name'] as String?,
      taxRate: (json['tax_rate'] as num?)?.toDouble(),
      taxAmount: (json['tax_amount'] as num?)?.toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      shipping: (json['shipping'] as num?)?.toDouble(),
      grandTotal: (json['grand_total'] as num?)?.toDouble(),
      receivedAmount: (json['received_amount'] as num?)?.toDouble(),
      paidAmount: (json['paid_amount'] as num?)?.toDouble(),
      note: json['note'] as String?,
      status: json['status'],
      tableId: json['table_id'] as String?,
      tableName: json['table_name'],
      holdItems: (json['hold_items'] as List<dynamic>?)
          ?.map((e) => HoldItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$HoldImplToJson(_$HoldImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'links': instance.links,
      'reference_code': instance.referenceCode,
      'date': instance.date?.toIso8601String(),
      'user_id': instance.userId,
      'attendant': instance.attendant,
      'customer_id': instance.customerId,
      'customer_name': instance.customerName,
      'staff_id': instance.staffId,
      'staff_name': instance.staffName,
      'warehouse_id': instance.warehouseId,
      'warehouse_name': instance.warehouseName,
      'tax_rate': instance.taxRate,
      'tax_amount': instance.taxAmount,
      'discount': instance.discount,
      'shipping': instance.shipping,
      'grand_total': instance.grandTotal,
      'received_amount': instance.receivedAmount,
      'paid_amount': instance.paidAmount,
      'note': instance.note,
      'status': instance.status,
      'table_id': instance.tableId,
      'table_name': instance.tableName,
      'hold_items': instance.holdItems,
      'created_at': instance.createdAt?.toIso8601String(),
    };

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
    );

Map<String, dynamic> _$$HoldItemImplToJson(_$HoldItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
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
