class WarehouseProductModel {
  final int id;
  final String name;
  final String code;
  final String? expiryDate;
  final String productCategoryName;
  final String brandName;
  final double productCost;
  final double productPrice;
  final String productUnitName;
  final int inStock;
  final String createdAt;
  final String? barcodeUrl;
  final List<Warehouse> warehouses;
  final Company company;

  WarehouseProductModel({
    required this.id,
    required this.name,
    required this.code,
    this.expiryDate,
    required this.productCategoryName,
    required this.brandName,
    required this.productCost,
    required this.productPrice,
    required this.productUnitName,
    required this.inStock,
    required this.createdAt,
    this.barcodeUrl,
    required this.warehouses,
    required this.company,
  });

  factory WarehouseProductModel.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    return WarehouseProductModel(
      id: json['id'],
      name: attributes['name'] ?? '',
      code: attributes['code'] ?? '',
      expiryDate: attributes['expiry_date'],
      productCategoryName: attributes['product_category_name'] ?? '',
      brandName: attributes['brand_name'] ?? '',
      productCost: (attributes['product_cost'] ?? 0).toDouble(),
      productPrice: (attributes['product_price'] ?? 0).toDouble(),
      productUnitName: attributes['product_unit_name']?['name'] ?? '',
      inStock: attributes['in_stock'] ?? 0,
      createdAt: attributes['created_at'] ?? '',
      barcodeUrl: attributes['barcode_url'],
      warehouses: (attributes['warehouse'] as List?)
          ?.map((w) => Warehouse.fromJson(w))
          .toList() ?? [],
      company: Company.fromJson(attributes['company'] ?? {}),
    );
  }
}

class Warehouse {
  final int totalQuantity;
  final String name;

  Warehouse({
    required this.totalQuantity,
    required this.name,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      totalQuantity: json['total_quantity'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class Company {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String address;

  Company({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
    );
  }
}

class ProductAnalytics {
  final int inStock;
  final int outOfStock;
  final double totalStockValue;

  ProductAnalytics({
    required this.inStock,
    required this.outOfStock,
    required this.totalStockValue,
  });

  factory ProductAnalytics.fromJson(Map<String, dynamic> json) {
    return ProductAnalytics(
      inStock: json['in_stock'] ?? 0,
      outOfStock: json['out_of_stock'] ?? 0,
      totalStockValue: (json['total_stock_value'] ?? 0).toDouble(),
    );
  }
}
