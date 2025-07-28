class HoldRecord {
  final int id;
  final String referenceCode;
  final DateTime date;
  final int userId;
  final Attendant? attendant;
  final int customerId;
  final String customerName;
  final int staffId;
  final String? staffName;
  final int warehouseId;
  final String warehouseName;
  final double taxRate;
  final double taxAmount;
  final double discount;
  final double shipping;
  final double grandTotal;
  final double? receivedAmount;
  final double? paidAmount;
  final String? note;
  final String? status;
  final List<HoldItem> holdItems;
  final DateTime createdAt;

  HoldRecord({
    required this.id,
    required this.referenceCode,
    required this.date,
    required this.userId,
    this.attendant,
    required this.customerId,
    required this.customerName,
    required this.staffId,
    this.staffName,
    required this.warehouseId,
    required this.warehouseName,
    required this.taxRate,
    required this.taxAmount,
    required this.discount,
    required this.shipping,
    required this.grandTotal,
    this.receivedAmount,
    this.paidAmount,
    this.note,
    this.status,
    required this.holdItems,
    required this.createdAt,
  });

  factory HoldRecord.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] as Map<String, dynamic>;
    
    return HoldRecord(
      id: json['id'] as int,
      referenceCode: attributes['reference_code'] as String,
      date: DateTime.parse(attributes['date'] as String),
      userId: attributes['user_id'] as int,
      attendant: attributes['attendant'] != null 
          ? Attendant.fromJson(attributes['attendant'] as Map<String, dynamic>)
          : null,
      customerId: attributes['customer_id'] as int,
      customerName: attributes['customer_name'] as String,
      staffId: attributes['staff_id'] as int,
      staffName: attributes['staff_name'] as String?,
      warehouseId: attributes['warehouse_id'] as int,
      warehouseName: attributes['warehouse_name'] as String,
      taxRate: (attributes['tax_rate'] as num).toDouble(),
      taxAmount: (attributes['tax_amount'] as num).toDouble(),
      discount: (attributes['discount'] as num).toDouble(),
      shipping: (attributes['shipping'] as num).toDouble(),
      grandTotal: (attributes['grand_total'] as num).toDouble(),
      receivedAmount: attributes['received_amount'] != null 
          ? (attributes['received_amount'] as num).toDouble()
          : null,
      paidAmount: attributes['paid_amount'] != null 
          ? (attributes['paid_amount'] as num).toDouble()
          : null,
      note: attributes['note'] as String?,
      status: attributes['status'] as String?,
      holdItems: (attributes['hold_items'] as List<dynamic>)
          .map((item) => HoldItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(attributes['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': 'holds',
      'attributes': {
        'reference_code': referenceCode,
        'date': date.toIso8601String(),
        'user_id': userId,
        'attendant': attendant?.toJson(),
        'customer_id': customerId,
        'customer_name': customerName,
        'staff_id': staffId,
        'staff_name': staffName,
        'warehouse_id': warehouseId,
        'warehouse_name': warehouseName,
        'tax_rate': taxRate,
        'tax_amount': taxAmount,
        'discount': discount,
        'shipping': shipping,
        'grand_total': grandTotal,
        'received_amount': receivedAmount,
        'paid_amount': paidAmount,
        'note': note,
        'status': status,
        'hold_items': holdItems.map((item) => item.toJson()).toList(),
        'created_at': createdAt.toIso8601String(),
      },
    };
  }
}

class HoldItem {
  final int id;
  final int holdId;
  final int productId;
  final String productName;
  final double productPrice;
  final double netUnitPrice;
  final int taxType;
  final double taxValue;
  final double taxAmount;
  final int discountType;
  final double discountValue;
  final double discountAmount;
  final SaleUnit saleUnit;
  final int quantity;
  final double subTotal;
  final DateTime createdAt;
  final DateTime updatedAt;

  HoldItem({
    required this.id,
    required this.holdId,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.netUnitPrice,
    required this.taxType,
    required this.taxValue,
    required this.taxAmount,
    required this.discountType,
    required this.discountValue,
    required this.discountAmount,
    required this.saleUnit,
    required this.quantity,
    required this.subTotal,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HoldItem.fromJson(Map<String, dynamic> json) {
    return HoldItem(
      id: json['id'] as int,
      holdId: json['hold_id'] as int,
      productId: json['product_id'] as int,
      productName: json['product_name'] as String,
      productPrice: (json['product_price'] as num).toDouble(),
      netUnitPrice: (json['net_unit_price'] as num).toDouble(),
      taxType: json['tax_type'] as int,
      taxValue: (json['tax_value'] as num? ?? 0).toDouble(),
      taxAmount: (json['tax_amount'] as num).toDouble(),
      discountType: json['discount_type'] as int,
      discountValue: (json['discount_value'] as num).toDouble(),
      discountAmount: (json['discount_amount'] as num).toDouble(),
      saleUnit: SaleUnit.fromJson(json['sale_unit'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      subTotal: (json['sub_total'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hold_id': holdId,
      'product_id': productId,
      'product_name': productName,
      'product_price': productPrice,
      'net_unit_price': netUnitPrice,
      'tax_type': taxType,
      'tax_value': taxValue,
      'tax_amount': taxAmount,
      'discount_type': discountType,
      'discount_value': discountValue,
      'discount_amount': discountAmount,
      'sale_unit': saleUnit.toJson(),
      'quantity': quantity,
      'sub_total': subTotal,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Attendant {
  final int id;
  final String firstName;
  final String lastName;
  final String dob;
  final String salaryDate;
  final String email;
  final String phone;
  final String? emailVerifiedAt;
  final String? defaultPassword;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int status;
  final String language;
  final int companyId;
  final int isAdmin;
  final int isSuper;
  final String warehouseId;
  final String? branchId;
  final String type;
  final double salaryAmount;
  final double balance;
  final String dateEmployed;
  final String? note;
  final int isAttendant;
  final String imageUrl;
  final List<dynamic> media;

  Attendant({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.salaryDate,
    required this.email,
    required this.phone,
    this.emailVerifiedAt,
    this.defaultPassword,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.language,
    required this.companyId,
    required this.isAdmin,
    required this.isSuper,
    required this.warehouseId,
    this.branchId,
    required this.type,
    required this.salaryAmount,
    required this.balance,
    required this.dateEmployed,
    this.note,
    required this.isAttendant,
    required this.imageUrl,
    required this.media,
  });

  factory Attendant.fromJson(Map<String, dynamic> json) {
    return Attendant(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      dob: json['dob'] as String,
      salaryDate: json['salary_date'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      emailVerifiedAt: json['email_verified_at'] as String?,
      defaultPassword: json['default_password'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      status: json['status'] as int,
      language: json['language'] as String,
      companyId: json['company_id'] as int,
      isAdmin: json['is_admin'] as int,
      isSuper: json['is_super'] as int,
      warehouseId: json['warehouse_id'] as String,
      branchId: json['branch_id'] as String?,
      type: json['type'] as String,
      salaryAmount: (json['salary_amount'] as num).toDouble(),
      balance: (json['balance'] as num).toDouble(),
      dateEmployed: json['date_employed'] as String,
      note: json['note'] as String?,
      isAttendant: json['is_attendant'] as int,
      imageUrl: json['image_url'] as String,
      media: json['media'] as List<dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'dob': dob,
      'salary_date': salaryDate,
      'email': email,
      'phone': phone,
      'email_verified_at': emailVerifiedAt,
      'default_password': defaultPassword,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'status': status,
      'language': language,
      'company_id': companyId,
      'is_admin': isAdmin,
      'is_super': isSuper,
      'warehouse_id': warehouseId,
      'branch_id': branchId,
      'type': type,
      'salary_amount': salaryAmount,
      'balance': balance,
      'date_employed': dateEmployed,
      'note': note,
      'is_attendant': isAttendant,
      'image_url': imageUrl,
      'media': media,
    };
  }
}

class SaleUnit {
  final int id;
  final String name;
  final String shortName;
  final int baseUnit;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int companyId;

  SaleUnit({
    required this.id,
    required this.name,
    required this.shortName,
    required this.baseUnit,
    required this.createdAt,
    required this.updatedAt,
    required this.companyId,
  });

  factory SaleUnit.fromJson(Map<String, dynamic> json) {
    return SaleUnit(
      id: json['id'] as int,
      name: json['name'] as String,
      shortName: json['short_name'] as String,
      baseUnit: json['base_unit'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      companyId: json['company_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'short_name': shortName,
      'base_unit': baseUnit,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'company_id': companyId,
    };
  }
}