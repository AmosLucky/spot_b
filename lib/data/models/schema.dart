import 'package:objectbox/objectbox.dart';
import 'package:spotstock_inventory/data/models/sales_models.dart';

@Entity()
class Orders {
  @Id() // Auto-incrementing ID
  int id = 0;
  String customerName;
  String trxId;
  int productId;
  int quantity;
  double amount;
  DateTime createdAt;
  String searchDate;
  int billerId;
  String paymentMethod;
  String items;
  String others;
  String companyId;
  String register;
  int status;
  String? tableId;
  int sync;

  Orders({
    required this.customerName,
    required this.trxId,
    required this.productId,
    required this.quantity,
    required this.amount,
    required this.createdAt,
    required this.searchDate,
    required this.billerId,
    required this.paymentMethod,
    required this.items,
    required this.others,
    required this.companyId,
    required this.register,
    this.status = 0,
    this.tableId,
    this.sync = 0,
  });

  // Method to convert the Orders object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'trxId': trxId,
      'productId': productId,
      'quantity': quantity,
      'amount': amount,
      'createdAt': createdAt.toIso8601String(), // Convert DateTime to String
      'searchDate': searchDate,
      'billerId': billerId,
      'paymentMethod': paymentMethod,
      'items': items,
      'others': others,
      'companyId': companyId,
      'register': register,
      'status': status,
      'tableId': tableId,
      'sync': sync,
    };
  }
}

@Entity()
class StoreX {
  @Id() // Auto-incrementing ID
  int id = 0;
  String name;
  String value;
  String billerId;
  String companyId;
  String lastUpdated;

  StoreX({
    required this.name,
    required this.value,
    required this.billerId,
    required this.companyId,
    required this.lastUpdated,
  });

  // Method to convert StoreX to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'billerId': billerId,
      'companyId': companyId,
      'lastUpdated': lastUpdated,
    };
  }
}

@Entity()
class TableList {
  @Id() // Auto-incrementing ID
  int id = 0;
  String name;
  String userId;
  String companyId;
  String lastUpdated;

  TableList({
    required this.name,
    required this.userId,
    required this.companyId,
    required this.lastUpdated,
  });

  // Method to convert TableList to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'userId': userId,
      'companyId': companyId,
      'lastUpdated': lastUpdated,
    };
  }
}

@Entity()
class Register {
  @Id() // Auto-incrementing ID
  int id = 0;
  String opening;
  String closing;
  String userId;
  String module;
  String companyId;
  String lastUpdated;

  Register({
    required this.opening,
    required this.closing,
    required this.userId,
    required this.module,
    required this.companyId,
    required this.lastUpdated,
  });

  // Method to convert Register to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'opening': opening,
      'closing': closing,
      'module': module,
      'userId': userId,
      'companyId': companyId,
      'lastUpdated': lastUpdated,
    };
  }
}

@Entity()
class Invoice {
  @Id() // Auto-incrementing ID
  int id = 0;
  String userId;
  double amount;
  String reference;
  String invoice;
  String? tableId;
  String status;
  String companyId;
  String lastUpdated;
  String customerName;
  String customerPhone;

  Invoice({
    required this.userId,
    required this.amount,
    required this.reference,
    required this.invoice,
    required this.status,
    required this.companyId,
    required this.lastUpdated,
    this.tableId,
    required this.customerName,
    required this.customerPhone,
  });

  // Method to convert Invoice to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'amount': amount,
      'reference': reference,
      'invoice': invoice,
      'tableId': tableId,
      'status': status,
      'companyId': companyId,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'lastUpdated': lastUpdated,
    };
  }
}

@Entity()
class Users {
  @Id() // Auto-incrementing ID
  int id = 0;
  String email;
  String firstName;
  String lastName;
  String password;
  String companyId;
  String lastUpdated;

  Users({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.companyId,
    required this.lastUpdated,
  });

  // Method to convert Users to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'companyId': companyId,
      'lastUpdated': lastUpdated,
    };
  }
}

@Entity()
class BookingX {
  @Id()
  int id; // bigint UNSIGNED NOT NULL
  String uid; // varchar(255) NOT NULL
  String perNight; // varchar(255) NOT NULL
  String checkin; // varchar(255) NOT NULL
  String checkout; // varchar(255) NOT NULL
  double amount; //// varchar(255) NOT NULL
  String roomName;
  String folio;
  double? amountPayable; // text
  int? discount; // int DEFAULT NULL
  double? totalDebt; // float DEFAULT NULL
  String roomId; // varchar(255) NOT NULL
  int? folioId; // int DEFAULT NULL
  String trx; // varchar(255) NOT NULL
  String? customerId; // text
  String bookingOption; // varchar(255) NOT NULL
  String? paymentType; // varchar(255) DEFAULT NULL
  String duration; // varchar(255) NOT NULL
  bool status; // tinyint(1) NOT NULL
  DateTime? createdAt;
  String others; // timestamp NULL DEFAULT NULL
  DateTime? updatedAt; // timestamp NULL DEFAULT NULL
  String userId; // varchar(200) NOT NULL
  String? cancelReason; // text
  String? checkoutTime; // varchar(200) DEFAULT NULL
  String? checkinTime; // varchar(200) DEFAULT NULL
  String? companyId; // text
  String? searchDate;

  // Default constructor
  BookingX(
      {required this.id,
      required this.uid,
      required this.perNight,
      required this.checkin,
      required this.checkout,
      required this.amount,
      required this.roomName,
      required this.folio,
      this.amountPayable,
      this.discount,
      this.totalDebt,
      required this.roomId,
      this.folioId,
      required this.trx,
      this.customerId,
      required this.bookingOption,
      this.paymentType,
      required this.duration,
      required this.others,
      required this.status,
      this.createdAt,
      this.updatedAt,
      required this.userId,
      this.cancelReason,
      this.checkoutTime,
      this.checkinTime,
      this.companyId,
      this.searchDate});

  // Method to convert the Orders object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'perNight': perNight,
      'checkin': checkin,
      'checkout': checkout,
      'amount': amount,
      'roomName': roomName,
      'folio': folio,
      'amountPayable': amountPayable,
      'discount': discount,
      'totalDebt': totalDebt,
      'roomId': roomId,
      'folioId': folioId,
      'trx': trx,
      'customerId': customerId,
      'bookingOption': bookingOption,
      'paymentType': paymentType,
      'duration': duration,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'userId': userId,
      'others': others,
      'cancelReason': cancelReason,
      'checkoutTime': checkoutTime,
      'checkinTime': checkinTime,
      'companyId': companyId,
      'searchDate': searchDate
    };
  }
}

@Entity()
class FolioX {
  @Id()
  int id;
  String uid;
  String customerName;
  String customerAddress;
  String customerPhone;
  String arrivalDate;
  String departureDate;
  double balance;
  double debit;
  double credit;
  String type;
  int? discount;
  String trackID;
  bool status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String userId;
  String? companyId;
  String? searchDate;

  // Constructor
  FolioX({
    required this.id,
    required this.uid,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
    required this.arrivalDate,
    required this.departureDate,
    required this.balance,
    required this.credit,
    required this.debit,
    required this.type,
    this.discount,
    required this.trackID,
    required this.status,
    this.createdAt,
    this.updatedAt,
    required this.userId,
    this.companyId,
    this.searchDate,
  });

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'customerName': customerName,
      'customerAddress': customerAddress,
      'customerPhone': customerPhone,
      'arrivalDate': arrivalDate,
      'departureDate': departureDate,
      'balance': balance,
      'debit': debit,
      'credit': credit,
      'type': type,
      'discount': discount,
      'trackID': trackID,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'userId': userId,
      'companyId': companyId,
      'searchDate': searchDate,
    };
  }
}

// @Entity()
// class MaintenanceRoom {
//   @Id()
//   int id = 0;
  
//   String? roomNumber;
//   String? status;
//   String? maintenanceNote;
//   String? maintenanceDate;
//   String? maintenanceExpectedEndDate;
  
//   @Property(type: PropertyType.date)
//   DateTime? createdAt;
  
//   @Property(type: PropertyType.date)
//   DateTime? updatedAt;

// //   MaintenanceRoom({
// //     this.id = 0,
// //     this.roomNumber,
// //     this.status,
// //     this.maintenanceNote,
// //     this.maintenanceDate,
// //     this.maintenanceExpectedEndDate,
// //     this.createdAt,
// //     this.updatedAt,
// //   });

// //   factory MaintenanceRoom.fromJson(Map<String, dynamic> json) {
// //     return MaintenanceRoom(
// //       id: json['id'] ?? 0,
// //       roomNumber: json['room_number'],
// //       status: json['status'],
// //       maintenanceNote: json['maintenance_note'],
// //       maintenanceDate: json['maintenance_date'],
// //       maintenanceExpectedEndDate: json['maintenance_expected_end_date'],
// //       createdAt: json['created_at'] != null 
// //           ? DateTime.parse(json['created_at']) 
// //           : null,
// //       updatedAt: json['updated_at'] != null
// //           ? DateTime.parse(json['updated_at'])
// //           : null,
// //     );
// //   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'id': id,
// //       'room_number': roomNumber,
// //       'status': status,
// //       'maintenance_note': maintenanceNote,
// //       'maintenance_date': maintenanceDate,
// //       'maintenance_expected_end_date': maintenanceExpectedEndDate,
// //       'created_at': createdAt?.toIso8601String(),
// //       'updated_at': updatedAt?.toIso8601String(),
// //     };
// //   }
// // }


@Entity()
class MaintenanceRoom {
  @Id()
  int id = 0;

  @Property()
  int companyId;

  @Property()
  int roomTypeId;

  @Property()
  String roomNumber;

  @Property()
  String status;

  @Property()
  String? maintenanceNote;

  @Property()
  DateTime? maintenanceDate;

  @Property()
  DateTime? maintenanceExpectedEndDate;

  @Property()
  DateTime createdAt;

  @Property()
  DateTime updatedAt;

  @Property()
  String roomTypeName;

  @Property()
  double roomTypeFare;

  @Property()
  int roomTypeTotalAdult;

  @Property()
  int roomTypeTotalChild;

  MaintenanceRoom({
    required this.companyId,
    required this.roomTypeId,
    required this.roomNumber,
    required this.status,
    this.maintenanceNote,
    this.maintenanceDate,
    this.maintenanceExpectedEndDate,
    required this.createdAt,
    required this.updatedAt,
    required this.roomTypeName,
    required this.roomTypeFare,
    required this.roomTypeTotalAdult,
    required this.roomTypeTotalChild, required id,
  });

  // Add fromJson factory constructor
  factory MaintenanceRoom.fromJson(Map<String, dynamic> json) {
    return MaintenanceRoom(
      id: json['id'] ?? 0,
      companyId: json['company_id'],
      roomTypeId: json['room_type_id'],
      roomNumber: json['room_number'],
      status: json['status'],
      maintenanceNote: json['maintenance_note'],
      maintenanceDate: json['maintenance_date'] != null 
          ? DateTime.parse(json['maintenance_date']) 
          : null,
      maintenanceExpectedEndDate: json['maintenance_expected_end_date'] != null
          ? DateTime.parse(json['maintenance_expected_end_date'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      roomTypeName: json['room_type']['name'] ?? '',
      roomTypeFare: double.parse(json['room_type']['fare'] ?? '0'),
      roomTypeTotalAdult: json['room_type']['total_adult'] ?? 0,
      roomTypeTotalChild: json['room_type']['total_child'] ?? 0,
    );
  }
}


// Sales Report screen


@Entity()
class SaleEntity {
  @Id()
  int id = 0;

  String type;
  DateTime date;
  int isReturn;
  int customerId;
  String customerName;
  int warehouseId;
  String warehouseName;
  double taxRate;
  double taxAmount;
  double discount;
  double shipping;
  double grandTotal;
  double? receivedAmount;
  double paidAmount;
  double partialAmount;
  double dueAmount;
  int paymentType;
  String? note;
  int status;
  int paymentStatus;
  String referenceCode;
  DateTime createdAt;
  String barcodeUrl;
  int isOffline;
  String? offlineCustomerName;

  SaleEntity({
    this.id = 0,
    required this.type,
    required this.date,
    required this.isReturn,
    required this.customerId,
    required this.customerName,
    required this.warehouseId,
    required this.warehouseName,
    required this.taxRate,
    required this.taxAmount,
    required this.discount,
    required this.shipping,
    required this.grandTotal,
    this.receivedAmount,
    required this.paidAmount,
    required this.partialAmount,
    required this.dueAmount,
    required this.paymentType,
    this.note,
    required this.status,
    required this.paymentStatus,
    required this.referenceCode,
    required this.createdAt,
    required this.barcodeUrl,
    required this.isOffline,
    this.offlineCustomerName,
  });

  // Convert from API model to ObjectBox entity
  factory SaleEntity.fromSale(Sale sale) {
    return SaleEntity(
      id: sale.id,
      type: sale.type,
      date: sale.date,
      isReturn: sale.isReturn,
      customerId: sale.customerId,
      customerName: sale.customerName,
      warehouseId: sale.warehouseId,
      warehouseName: sale.warehouseName,
      taxRate: sale.taxRate,
      taxAmount: sale.taxAmount,
      discount: sale.discount,
      shipping: sale.shipping,
      grandTotal: sale.grandTotal,
      receivedAmount: sale.receivedAmount,
      paidAmount: sale.paidAmount,
      partialAmount: sale.partialAmount,
      dueAmount: sale.dueAmount,
      paymentType: sale.paymentType,
      note: sale.note,
      status: sale.status,
      paymentStatus: sale.paymentStatus,
      referenceCode: sale.referenceCode,
      createdAt: sale.createdAt,
      barcodeUrl: sale.barcodeUrl,
      isOffline: sale.isOffline,
      offlineCustomerName: sale.offlineCustomerName,
    );
  }

  // Convert to API model
  Sale toSale() {
    return Sale(
      id: id,
      type: type,
      date: date,
      isReturn: isReturn,
      customerId: customerId,
      customerName: customerName,
      warehouseId: warehouseId,
      warehouseName: warehouseName,
      taxRate: taxRate,
      taxAmount: taxAmount,
      discount: discount,
      shipping: shipping,
      grandTotal: grandTotal,
      receivedAmount: receivedAmount,
      paidAmount: paidAmount,
      partialAmount: partialAmount,
      dueAmount: dueAmount,
      paymentType: paymentType,
      note: note,
      status: status,
      paymentStatus: paymentStatus,
      referenceCode: referenceCode,
      saleItems: [], // Will be populated separately
      createdAt: createdAt,
      barcodeUrl: barcodeUrl,
      isOffline: isOffline,
      offlineCustomerName: offlineCustomerName,
    );
  }

  // Method to convert SaleEntity to a Map (following your pattern)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'date': date.toIso8601String(),
      'isReturn': isReturn,
      'customerId': customerId,
      'customerName': customerName,
      'warehouseId': warehouseId,
      'warehouseName': warehouseName,
      'taxRate': taxRate,
      'taxAmount': taxAmount,
      'discount': discount,
      'shipping': shipping,
      'grandTotal': grandTotal,
      'receivedAmount': receivedAmount,
      'paidAmount': paidAmount,
      'partialAmount': partialAmount,
      'dueAmount': dueAmount,
      'paymentType': paymentType,
      'note': note,
      'status': status,
      'paymentStatus': paymentStatus,
      'referenceCode': referenceCode,
      'createdAt': createdAt.toIso8601String(),
      'barcodeUrl': barcodeUrl,
      'isOffline': isOffline,
      'offlineCustomerName': offlineCustomerName,
    };
  }
}

@Entity()
class SaleItemEntity {
  @Id()
  int id = 0;

  int saleEntityId; // Reference to parent sale
  int originalSaleId; // Original sale ID from API
  int productId;
  int? tableId;
  double productPrice;
  double netUnitPrice;
  int taxType;
  double? taxValue;
  double taxAmount;
  int discountType;
  double discountValue;
  double discountAmount;
  int quantity;
  double subTotal;
  DateTime createdAt;
  DateTime updatedAt;
  int? companyId;

  // Sale Unit properties (flattened - following your pattern)
  int saleUnitId;
  String saleUnitName;
  String saleUnitShortName;
  int saleUnitBaseUnit;
  DateTime saleUnitCreatedAt;
  DateTime saleUnitUpdatedAt;
  int saleUnitCompanyId;

  SaleItemEntity({
    this.id = 0,
    required this.saleEntityId,
    required this.originalSaleId,
    required this.productId,
    this.tableId,
    required this.productPrice,
    required this.netUnitPrice,
    required this.taxType,
    this.taxValue,
    required this.taxAmount,
    required this.discountType,
    required this.discountValue,
    required this.discountAmount,
    required this.quantity,
    required this.subTotal,
    required this.createdAt,
    required this.updatedAt,
    this.companyId,
    required this.saleUnitId,
    required this.saleUnitName,
    required this.saleUnitShortName,
    required this.saleUnitBaseUnit,
    required this.saleUnitCreatedAt,
    required this.saleUnitUpdatedAt,
    required this.saleUnitCompanyId,
  });

  factory SaleItemEntity.fromSaleItem(SaleItem saleItem, int saleEntityId) {
    return SaleItemEntity(
      id: saleItem.id,
      saleEntityId: saleEntityId,
      originalSaleId: saleItem.saleId,
      productId: saleItem.productId,
      tableId: saleItem.tableId,
      productPrice: saleItem.productPrice,
      netUnitPrice: saleItem.netUnitPrice,
      taxType: saleItem.taxType,
      taxValue: saleItem.taxValue,
      taxAmount: saleItem.taxAmount,
      discountType: saleItem.discountType,
      discountValue: saleItem.discountValue,
      discountAmount: saleItem.discountAmount,
      quantity: saleItem.quantity,
      subTotal: saleItem.subTotal,
      createdAt: saleItem.createdAt,
      updatedAt: saleItem.updatedAt,
      companyId: saleItem.companyId,
      saleUnitId: saleItem.saleUnit.id,
      saleUnitName: saleItem.saleUnit.name,
      saleUnitShortName: saleItem.saleUnit.shortName,
      saleUnitBaseUnit: saleItem.saleUnit.baseUnit,
      saleUnitCreatedAt: saleItem.saleUnit.createdAt,
      saleUnitUpdatedAt: saleItem.saleUnit.updatedAt,
      saleUnitCompanyId: saleItem.saleUnit.companyId,
    );
  }

  SaleItem toSaleItem() {
    return SaleItem(
      id: id,
      saleId: originalSaleId,
      productId: productId,
      tableId: tableId,
      productPrice: productPrice,
      netUnitPrice: netUnitPrice,
      taxType: taxType,
      taxValue: taxValue,
      taxAmount: taxAmount,
      discountType: discountType,
      discountValue: discountValue,
      discountAmount: discountAmount,
      saleUnit: SaleUnit(
        id: saleUnitId,
        name: saleUnitName,
        shortName: saleUnitShortName,
        baseUnit: saleUnitBaseUnit,
        createdAt: saleUnitCreatedAt,
        updatedAt: saleUnitUpdatedAt,
        companyId: saleUnitCompanyId,
      ),
      quantity: quantity,
      subTotal: subTotal,
      createdAt: createdAt,
      updatedAt: updatedAt,
      companyId: companyId,
    );
  }

  // Method to convert SaleItemEntity to a Map (following your pattern)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'saleEntityId': saleEntityId,
      'originalSaleId': originalSaleId,
      'productId': productId,
      'tableId': tableId,
      'productPrice': productPrice,
      'netUnitPrice': netUnitPrice,
      'taxType': taxType,
      'taxValue': taxValue,
      'taxAmount': taxAmount,
      'discountType': discountType,
      'discountValue': discountValue,
      'discountAmount': discountAmount,
      'quantity': quantity,
      'subTotal': subTotal,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'companyId': companyId,
      'saleUnitId': saleUnitId,
      'saleUnitName': saleUnitName,
      'saleUnitShortName': saleUnitShortName,
      'saleUnitBaseUnit': saleUnitBaseUnit,
      'saleUnitCreatedAt': saleUnitCreatedAt.toIso8601String(),
      'saleUnitUpdatedAt': saleUnitUpdatedAt.toIso8601String(),
      'saleUnitCompanyId': saleUnitCompanyId,
    };
  }
}
