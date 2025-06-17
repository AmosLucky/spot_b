import 'dart:ui';

import 'package:flutter/material.dart';


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
  List<SaleItem> saleItems;
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
    try {
      final attributes = json['attributes'] as Map<String, dynamic>;
      return Sale(
        id: json['id'] as int,
        type: json['type'] as String,
        date: DateTime.parse(attributes['date'] as String),
        isReturn: attributes['is_return'] as int,
        customerId: attributes['customer_id'] as int,
        customerName: attributes['customer_name'] as String? ?? '',
        warehouseId: attributes['warehouse_id'] as int,
        warehouseName: attributes['warehouse_name'] as String? ?? '',
        taxRate: _parseDouble(attributes['tax_rate']),
        taxAmount: _parseDouble(attributes['tax_amount']),
        discount: _parseDouble(attributes['discount']),
        shipping: _parseDouble(attributes['shipping']),
        grandTotal: _parseDouble(attributes['grand_total']),
        receivedAmount: attributes['received_amount'] != null 
            ? _parseDouble(attributes['received_amount']) 
            : null,
        paidAmount: _parseDouble(attributes['paid_amount']),
        partialAmount: _parseDouble(attributes['partial_amount']),
        dueAmount: _parseDouble(attributes['due_amount']),
        paymentType: attributes['payment_type'] as int,
        note: attributes['note'] as String?,
        status: attributes['status'] as int,
        paymentStatus: attributes['payment_status'] as int,
        referenceCode: attributes['reference_code'] as String? ?? '',
        saleItems: (attributes['sale_items'] as List<dynamic>? ?? [])
            .map((item) => SaleItem.fromJson(item as Map<String, dynamic>))
            .toList(),
        createdAt: DateTime.parse(attributes['created_at'] as String),
        barcodeUrl: attributes['barcode_url'] as String? ?? '',
        isOffline: attributes['is_offline'] as int,
        offlineCustomerName: attributes['offline_customer_name'] as String?,
      );
    } catch (e) {
      print('Error parsing Sale from JSON: $e');
      print('JSON data: $json');
      rethrow;
    }
  }

  // Helper method to safely parse doubles
  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }

  String get paymentStatusText {
    switch (paymentStatus) {
      case 1:
        return 'Paid';
      case 2:
        return 'Unpaid';
      case 3:
        return 'Partially Paid';
      default:
        return 'Unknown';
    }
  }

  Color get paymentStatusColor {
    switch (paymentStatus) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.red;
      case 3:
        return Colors.orange;
      default:
        return Colors.grey;
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
    try {
      return SaleItem(
        id: json['id'] as int,
        saleId: json['sale_id'] as int,
        productId: json['product_id'] as int,
        tableId: json['table_id'] as int?,
        productPrice: _parseDouble(json['product_price']),
        netUnitPrice: _parseDouble(json['net_unit_price']),
        taxType: json['tax_type'] as int,
        taxValue: json['tax_value'] != null ? _parseDouble(json['tax_value']) : null,
        taxAmount: _parseDouble(json['tax_amount']),
        discountType: json['discount_type'] as int,
        discountValue: _parseDouble(json['discount_value']),
        discountAmount: _parseDouble(json['discount_amount']),
        saleUnit: SaleUnit.fromJson(json['sale_unit'] as Map<String, dynamic>),
        quantity: json['quantity'] as int,
        subTotal: _parseDouble(json['sub_total']),
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
        companyId: json['company_id'] as int?,
      );
    } catch (e) {
      print('Error parsing SaleItem from JSON: $e');
      print('JSON data: $json');
      rethrow;
    }
  }

  // Helper method to safely parse doubles
  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
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
    try {
      return SaleUnit(
        id: json['id'] as int,
        name: json['name'] as String? ?? '',
        shortName: json['short_name'] as String? ?? '',
        baseUnit: json['base_unit'] as int,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
        companyId: json['company_id'] as int,
      );
    } catch (e) {
      print('Error parsing SaleUnit from JSON: $e');
      print('JSON data: $json');
      rethrow;
    }
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
    try {
      return SalesResponse(
        data: (json['data'] as List<dynamic>? ?? [])
            .map((sale) => Sale.fromJson(sale as Map<String, dynamic>))
            .toList(),
        meta: PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>? ?? {}),
      );
    } catch (e) {
      print('Error parsing SalesResponse from JSON: $e');
      print('JSON keys: ${json.keys}');
      print('Data type: ${json['data']?.runtimeType}');
      print('Meta type: ${json['meta']?.runtimeType}');
      rethrow;
    }
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
    try {
      return PaginationMeta(
        currentPage: json['current_page'] as int? ?? 1,
        from: json['from'] as int? ?? 1,
        lastPage: json['last_page'] as int? ?? 1,
        perPage: json['per_page'] as int? ?? 10,
        to: json['to'] as int? ?? 1,
        total: json['total'] as int? ?? 0,
      );
    } catch (e) {
      print('Error parsing PaginationMeta from JSON: $e');
      print('JSON data: $json');
      // Return default values if parsing fails
      return PaginationMeta(
        currentPage: 1,
        from: 1,
        lastPage: 1,
        perPage: 10,
        to: 1,
        total: 0,
      );
    }
  }
}