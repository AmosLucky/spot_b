import 'package:objectbox/objectbox.dart';
import 'package:spotstock_inventory/data/models/sales_models.dart';


@Entity()
class PaidInvoice {
  @Id()
  int id = 0;
  
  String reference;
  String customerName;
  String? attendantName;
  double amount;
  String paidAt;
  String userId;
  String companyId;
  String originalInvoiceData; // Store the full transaction data as JSON
  
  PaidInvoice({
    required this.reference,
    required this.customerName,
    this.attendantName,
    required this.amount,
    required this.paidAt,
    required this.userId,
    required this.companyId,
    required this.originalInvoiceData,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reference': reference,
      'customerName': customerName,
      'attendantName': attendantName,
      'amount': amount,
      'paidAt': paidAt,
      'userId': userId,
      'companyId': companyId,
      'originalInvoiceData': originalInvoiceData,
    };
  }
}



@Entity()
class Orders {
  @Id()
  int id = 0;
  String customerName;
  String trxId;
  int productId;
  int quantity;
  double amount;
  String? paymentStatus;
  double? receivedAmount;
  double? partialAmount;
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
  String? attendantId; // New field for attendant tracking
  String? invoiceReference; // New field for unique invoice reference

  Orders({
    required this.customerName,
    required this.trxId,
    required this.productId,
    required this.quantity,
    required this.amount,
    this.paymentStatus,
    this.receivedAmount,
    this.partialAmount,
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
    this.attendantId, // New parameter
    this.invoiceReference, // New parameter
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'trxId': trxId,
      'productId': productId,
      'quantity': quantity,
      'amount': amount,
      'paymentStatus': paymentStatus,
      'receivedAmount': receivedAmount,
      'partialAmount': partialAmount,
      'createdAt': createdAt.toIso8601String(),
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
      'attendantId': attendantId,
      'invoiceReference': invoiceReference,
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
  @Id()
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
  String? attendantId; // New field for attendant tracking
  String? originalReference; // New field to track original reference

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
    this.attendantId, // New parameter
    this.originalReference, // New parameter
  });

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
      'attendantId': attendantId,
      'originalReference': originalReference,
    };
  }
}


@Entity()
class SelectAttendantModel {
  @Id()
  int id = 0;
  
  int apiId; // Store the original API ID
  String firstName;
  String lastName;
  String email;
  String phone;
  String department;
  bool hasPinSet;
  String? pin;

  SelectAttendantModel({
    required this.apiId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.department,
    required this.hasPinSet,
    this.pin,
  });

  String get fullName => '$firstName $lastName';

  factory SelectAttendantModel.fromJson(Map<String, dynamic> json) {
    return SelectAttendantModel(
      apiId: json['id'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      department: json['department'] ?? '',
      hasPinSet: json['pin_set'] ?? false,
      pin: json['pin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': apiId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'department': department,
      'pin_set': hasPinSet,
      'pin': pin,
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


@Entity()
class SaleEntity {
  @Id()
  int id = 0;
  int originalId;
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
  
  // **NEW: Added attendant fields**
  String? attendantName;
  String? attendantId;

  SaleEntity({
    this.id = 0,
    required this.originalId,
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
    
    // **NEW: Added attendant parameters**
    this.attendantName,
    this.attendantId,
  });

  // Convert from API model to ObjectBox entity
  factory SaleEntity.fromSale(Sale sale) {
    return SaleEntity(
      id: 0,
      originalId: sale.id,
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
      
      // **NEW: Map attendant fields if they exist in Sale model**
      // Note: You may need to add these fields to your Sale model too
      attendantName: null, // Update this if Sale model has attendantName
      attendantId: null,   // Update this if Sale model has attendantId
    );
  }

  // Convert to API model
  Sale toSale() {
    return Sale(
      id: originalId,
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
      saleItems: [], // Populated later in getLocalSales
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
      'originalId': originalId,
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
      
      // **NEW: Include attendant fields in map**
      'attendantName': attendantName,
      'attendantId': attendantId,
    };
  }
}


@Entity()
class SaleItemEntity {
  @Id()
  int id = 0;
  int originalId; // Store API's SaleItem.id

  // int saleEntityId; // Reference to parent sale
  // int originalSaleId; // Original sale ID from API
  int saleEntityId; // Reference to parent SaleEntity's ObjectBox ID
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
    required this.originalId,
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
      // id: saleItem.id,
      id: 0, // Let ObjectBox assign ID
      originalId: saleItem.id,
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
      // id: id,
      id: originalId, // Use API's ID for SaleItem
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



// @Entity()
// class Orders {
//   @Id() // Auto-incrementing ID
//   int id = 0;
//   String customerName;
//   String trxId;
//   int productId;
//   int quantity;
//   double amount;
//    String? paymentStatus;
//   DateTime createdAt;
//   String searchDate;
//   int billerId;
//   String paymentMethod;
//   String items;
//   String others;
//   String companyId;
//   String register;
//   int status;
//   String? tableId;
//   int sync;

//   Orders({
//     required this.customerName,
//     required this.trxId,
//     required this.productId,
//     required this.quantity,
//     required this.amount,
//     this.paymentStatus,
//     required this.createdAt,
//     required this.searchDate,
//     required this.billerId,
//     required this.paymentMethod,
//     required this.items,
//     required this.others,
//     required this.companyId,
//     required this.register,
//     this.status = 0,
//     this.tableId,
//     this.sync = 0,
//   });

//   // Method to convert the Orders object to a Map
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'customerName': customerName,
//       'trxId': trxId,
//       'productId': productId,
//       'quantity': quantity,
//       'amount': amount,
//       'paymentStatus': paymentStatus,
//       'createdAt': createdAt.toIso8601String(), // Convert DateTime to String
//       'searchDate': searchDate,
//       'billerId': billerId,
//       'paymentMethod': paymentMethod,
//       'items': items,
//       'others': others,
//       'companyId': companyId,
//       'register': register,
//       'status': status,
//       'tableId': tableId,
//       'sync': sync,
//     };
//   }
// }


// Sales Report screen


// @Entity()
// class SaleEntity {
//   @Id()
//   int id = 0;
//   int originalId;

//   String type;
//   DateTime date;
//   int isReturn;
//   int customerId;
//   String customerName;
//   int warehouseId;
//   String warehouseName;
//   double taxRate;
//   double taxAmount;
//   double discount;
//   double shipping;
//   double grandTotal;
//   double? receivedAmount;
//   double paidAmount;
//   double partialAmount;
//   double dueAmount;
//   int paymentType;
//   String? note;
//   int status;
//   int paymentStatus;
//   String referenceCode;
//   DateTime createdAt;
//   String barcodeUrl;
//   int isOffline;
//   String? offlineCustomerName;

//   SaleEntity({
//     this.id = 0,
//     required this.originalId,
//     required this.type,
//     required this.date,
//     required this.isReturn,
//     required this.customerId,
//     required this.customerName,
//     required this.warehouseId,
//     required this.warehouseName,
//     required this.taxRate,
//     required this.taxAmount,
//     required this.discount,
//     required this.shipping,
//     required this.grandTotal,
//     this.receivedAmount,
//     required this.paidAmount,
//     required this.partialAmount,
//     required this.dueAmount,
//     required this.paymentType,
//     this.note,
//     required this.status,
//     required this.paymentStatus,
//     required this.referenceCode,
//     required this.createdAt,
//     required this.barcodeUrl,
//     required this.isOffline,
//     this.offlineCustomerName,
//   });

//   // Convert from API model to ObjectBox entity
//   factory SaleEntity.fromSale(Sale sale) {
//     return SaleEntity(
//       // id: sale.id,
//       id: 0,
//       originalId: sale.id,
//       type: sale.type,
//       date: sale.date,
//       isReturn: sale.isReturn,
//       customerId: sale.customerId,
//       customerName: sale.customerName,
//       warehouseId: sale.warehouseId,
//       warehouseName: sale.warehouseName,
//       taxRate: sale.taxRate,
//       taxAmount: sale.taxAmount,
//       discount: sale.discount,
//       shipping: sale.shipping,
//       grandTotal: sale.grandTotal,
//       receivedAmount: sale.receivedAmount,
//       paidAmount: sale.paidAmount,
//       partialAmount: sale.partialAmount,
//       dueAmount: sale.dueAmount,
//       paymentType: sale.paymentType,
//       note: sale.note,
//       status: sale.status,
//       paymentStatus: sale.paymentStatus,
//       referenceCode: sale.referenceCode,
//       createdAt: sale.createdAt,
//       barcodeUrl: sale.barcodeUrl,
//       isOffline: sale.isOffline,
//       offlineCustomerName: sale.offlineCustomerName,
//     );
//   }

//   // Convert to API model
//   Sale toSale() {
//     return Sale(
//       // id: id,
//       id: originalId,
//       type: type,
//       date: date,
//       isReturn: isReturn,
//       customerId: customerId,
//       customerName: customerName,
//       warehouseId: warehouseId,
//       warehouseName: warehouseName,
//       taxRate: taxRate,
//       taxAmount: taxAmount,
//       discount: discount,
//       shipping: shipping,
//       grandTotal: grandTotal,
//       receivedAmount: receivedAmount,
//       paidAmount: paidAmount,
//       partialAmount: partialAmount,
//       dueAmount: dueAmount,
//       paymentType: paymentType,
//       note: note,
//       status: status,
//       paymentStatus: paymentStatus,
//       referenceCode: referenceCode,
//       // saleItems: [], // Will be populated separately
//       saleItems: [], // Populated later in getLocalSales
//       createdAt: createdAt,
//       barcodeUrl: barcodeUrl,
//       isOffline: isOffline,
//       offlineCustomerName: offlineCustomerName,
//     );
//   }

//   // Method to convert SaleEntity to a Map (following your pattern)
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'type': type,
//       'date': date.toIso8601String(),
//       'isReturn': isReturn,
//       'customerId': customerId,
//       'customerName': customerName,
//       'warehouseId': warehouseId,
//       'warehouseName': warehouseName,
//       'taxRate': taxRate,
//       'taxAmount': taxAmount,
//       'discount': discount,
//       'shipping': shipping,
//       'grandTotal': grandTotal,
//       'receivedAmount': receivedAmount,
//       'paidAmount': paidAmount,
//       'partialAmount': partialAmount,
//       'dueAmount': dueAmount,
//       'paymentType': paymentType,
//       'note': note,
//       'status': status,
//       'paymentStatus': paymentStatus,
//       'referenceCode': referenceCode,
//       'createdAt': createdAt.toIso8601String(),
//       'barcodeUrl': barcodeUrl,
//       'isOffline': isOffline,
//       'offlineCustomerName': offlineCustomerName,
//     };
//   }
// }
