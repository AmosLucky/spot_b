
// models/sale_models.dart
class Sale {
  final int id;
  final String type;
  final DateTime date;
  final int isReturn;
  final int customerId;
  final String customerName;
  final int warehouseId;
  final String warehouseName;
  final double taxRate;
  final double taxAmount;
  final double discount;
  final double shipping;
  final double grandTotal;
  final double? receivedAmount;
  final double paidAmount;
  final double partialAmount;
  final double dueAmount;
  final int paymentType;
  final String? note;
  final int status;
  final int paymentStatus;
  final String referenceCode;
  final List<SaleItem> saleItems;
  final DateTime createdAt;
  final String barcodeUrl;
  final int isOffline;
  final String? offlineCustomerName;

  Sale({
    required this.id,
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
    required this.saleItems,
    required this.createdAt,
    required this.barcodeUrl,
    required this.isOffline,
    this.offlineCustomerName,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    return Sale(
      id: json['id'],
      type: json['type'],
      date: DateTime.parse(attributes['date']),
      isReturn: attributes['is_return'],
      customerId: attributes['customer_id'],
      customerName: attributes['customer_name'],
      warehouseId: attributes['warehouse_id'],
      warehouseName: attributes['warehouse_name'],
      taxRate: (attributes['tax_rate'] ?? 0).toDouble(),
      taxAmount: (attributes['tax_amount'] ?? 0).toDouble(),
      discount: (attributes['discount'] ?? 0).toDouble(),
      shipping: (attributes['shipping'] ?? 0).toDouble(),
      grandTotal: (attributes['grand_total'] ?? 0).toDouble(),
      receivedAmount: attributes['received_amount']?.toDouble(),
      paidAmount: (attributes['paid_amount'] ?? 0).toDouble(),
      partialAmount: double.parse(attributes['partial_amount'] ?? '0'),
      dueAmount: (attributes['due_amount'] ?? 0).toDouble(),
      paymentType: attributes['payment_type'],
      note: attributes['note'],
      status: attributes['status'],
      paymentStatus: attributes['payment_status'],
      referenceCode: attributes['reference_code'],
      saleItems: (attributes['sale_items'] as List)
          .map((item) => SaleItem.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(attributes['created_at']),
      barcodeUrl: attributes['barcode_url'],
      isOffline: attributes['is_offline'],
      offlineCustomerName: attributes['offline_customer_name'],
    );
  }

  String get paymentStatusText {
    switch (paymentStatus) {
      case 1:
        return 'Paid';
      case 0:
        return 'Unpaid';
      default:
        return 'Partial';
    }
  }

  String get statusText {
    switch (status) {
      case 1:
        return 'Completed';
      case 0:
        return 'Pending';
      default:
        return 'Cancelled';
    }
  }
}

class SaleItem {
  final int id;
  final int saleId;
  final int productId;
  final int? tableId;
  final double productPrice;
  final double netUnitPrice;
  final int taxType;
  final double? taxValue;
  final double taxAmount;
  final int discountType;
  final double discountValue;
  final double discountAmount;
  final SaleUnit saleUnit;
  final int quantity;
  final double subTotal;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? companyId;

  SaleItem({
    required this.id,
    required this.saleId,
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
    required this.saleUnit,
    required this.quantity,
    required this.subTotal,
    required this.createdAt,
    required this.updatedAt,
    this.companyId,
  });

  factory SaleItem.fromJson(Map<String, dynamic> json) {
    return SaleItem(
      id: json['id'],
      saleId: json['sale_id'],
      productId: json['product_id'],
      tableId: json['table_id'],
      productPrice: (json['product_price'] ?? 0).toDouble(),
      netUnitPrice: (json['net_unit_price'] ?? 0).toDouble(),
      taxType: json['tax_type'],
      taxValue: json['tax_value']?.toDouble(),
      taxAmount: (json['tax_amount'] ?? 0).toDouble(),
      discountType: json['discount_type'],
      discountValue: (json['discount_value'] ?? 0).toDouble(),
      discountAmount: (json['discount_amount'] ?? 0).toDouble(),
      saleUnit: SaleUnit.fromJson(json['sale_unit']),
      quantity: json['quantity'],
      subTotal: (json['sub_total'] ?? 0).toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      companyId: json['company_id'],
    );
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
      id: json['id'],
      name: json['name'],
      shortName: json['short_name'],
      baseUnit: json['base_unit'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      companyId: json['company_id'],
    );
  }
}

class SalesResponse {
  final List<Sale> data;
  final PaginationMeta meta;

  SalesResponse({
    required this.data,
    required this.meta,
  });

  factory SalesResponse.fromJson(Map<String, dynamic> json) {
    return SalesResponse(
      data: (json['data'] as List).map((sale) => Sale.fromJson(sale)).toList(),
      meta: PaginationMeta.fromJson(json['meta']),
    );
  }
}

class PaginationMeta {
  final int currentPage;
  final int from;
  final int lastPage;
  final int perPage;
  final int to;
  final int total;

  PaginationMeta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }
}
