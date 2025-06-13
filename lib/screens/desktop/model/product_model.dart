class Product {
  int? id;
  String? name;
  String? productCode;
  String? code;
  int? type;
  int? productCategoryId;
  int? brandId;
  int? barcodeSymbol;
  int? productUnit;
  int? saleUnit;
  int? purchaseUnit;
  int? productType;
  int? quantityLimit;
  String? notes;
  int? purchaseSupplierId;
  int? purchaseWarehouseId;
  String? purchaseDate;
  int? purchaseStatus;
  List<Variation>? variationData;
  int? orderTax;
  int? taxType;
  String? imageUrl;
  String? expiryDate;
  String? brand;
  String? branch;
  double? price;
  int? inStock;
  String? createdOn;

  Product({
    this.id,
    this.name,
    this.productCode,
    this.code,
    this.type,
    this.productCategoryId,
    this.brandId,
    this.barcodeSymbol,
    this.productUnit,
    this.saleUnit,
    this.purchaseUnit,
    this.productType,
    this.quantityLimit,
    this.notes,
    this.purchaseSupplierId,
    this.purchaseWarehouseId,
    this.purchaseDate,
    this.purchaseStatus,
    this.variationData,
    this.orderTax,
    this.taxType,
    this.imageUrl,
    this.expiryDate,
    this.brand,
    this.branch,
    this.price,
    this.inStock,
    this.createdOn,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['attributes']['name'],
      productCode: json['attributes']['product_code'],
      code: json['attributes']['code'],
      type: int.tryParse(json['attributes']['type']?.toString() ?? '0'),
      productCategoryId: json['attributes']['product_category_id'],
      brandId: json['attributes']['brand_id'],
      barcodeSymbol: json['attributes']['barcode_symbol'],
      productUnit: int.tryParse(json['attributes']['product_unit']?.toString() ?? '0'),
      saleUnit: int.tryParse(json['attributes']['sale_unit']?.toString() ?? '0'),
      purchaseUnit: int.tryParse(json['attributes']['purchase_unit']?.toString() ?? '0'),
      productType: int.tryParse(json['attributes']['product_type']?.toString() ?? '0'),
      quantityLimit: json['attributes']['quantity_limit'],
      notes: json['attributes']['notes'],
      purchaseSupplierId: json['attributes']['purchase_supplier_id'],
      purchaseWarehouseId: json['attributes']['purchase_warehouse_id'],
      purchaseDate: json['attributes']['purchase_date'],
      purchaseStatus: json['attributes']['purchase_status'],
      variationData: (json['attributes']['variation_data'] as List?)
          ?.map((v) => Variation.fromJson(v))
          .toList(),
      orderTax: json['attributes']['order_tax'],
      taxType: json['attributes']['tax_type'],
      imageUrl: json['attributes']['image_url'],
      expiryDate: json['attributes']['expiry_date'],
      brand: json['attributes']['brand_name'],
      branch: json['attributes']['warehouse'][0]['name'],
      price: json['attributes']['product_price']?.toDouble(),
      inStock: json['attributes']['in_stock'],
      createdOn: json['attributes']['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'product_code': productCode,
      'type': type,
      'product_category_id': productCategoryId,
      'brand_id': brandId,
      'code': code,
      'barcode_symbol': barcodeSymbol,
      'product_unit': productUnit,
      'sale_unit': saleUnit,
      'purchase_unit': purchaseUnit,
      'product_type': productType,
      'quantity_limit': quantityLimit,
      'notes': notes,
      'purchase_supplier_id': purchaseSupplierId,
      'purchase_warehouse_id': purchaseWarehouseId,
      'purchase_date': purchaseDate,
      'purchase_status': purchaseStatus,
      'variation_data': variationData?.map((v) => v.toJson()).toList(),
      'order_tax': orderTax,
      'tax_type': taxType,
      'image_url': imageUrl,
    };
  }
}

class Variation {
  String? variationType;
  double? productCost;
  double? productPrice;
  int? stockAlert;
  int? orderTax;
  int? taxType;
  int? addStock;
  String? code;
  int? barcodeSymbol;

  Variation({
    this.variationType,
    this.productCost,
    this.productPrice,
    this.stockAlert,
    this.orderTax,
    this.taxType,
    this.addStock,
    this.code,
    this.barcodeSymbol,
  });

  factory Variation.fromJson(Map<String, dynamic> json) {
    return Variation(
      variationType: json['variation_type'],
      productCost: json['product_cost']?.toDouble(),
      productPrice: json['product_price']?.toDouble(),
      stockAlert: json['stock_alert'],
      orderTax: json['order_tax'],
      taxType: json['tax_type'],
      addStock: json['add_stock'],
      code: json['code'],
      barcodeSymbol: json['barcode_symbol'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'variation_type': variationType,
      'product_cost': productCost,
      'product_price': productPrice,
      'stock_alert': stockAlert,
      'order_tax': orderTax,
      'tax_type': taxType,
      'add_stock': addStock,
      'code': code,
      'barcode_symbol': barcodeSymbol,
    };
  }
}




// class Product {
//   int? id;
//   String? name;
//   String? productCode;
//   String? code;
//   int? type;
//   int? productCategoryId;
//   int? brandId;
//   int? barcodeSymbol;
//   int? productUnit;
//   int? saleUnit;
//   int? purchaseUnit;
//   int? productType;
//   int? quantityLimit;
//   String? notes;
//   int? purchaseSupplierId;
//   int? purchaseWarehouseId;
//   String? purchaseDate;
//   int? purchaseStatus;
//   List<Variation>? variationData;
//   int? orderTax;
//   int? taxType;
//   String? imageUrl;
//   String? expiryDate;
//   String? brand;
//   String? branch;
//   double? price;
//   int? inStock;
//   String? createdOn;

//   Product({
//     this.id,
//     this.name,
//     this.productCode,
//     this.code,
//     this.type,
//     this.productCategoryId,
//     this.brandId,
//     this.barcodeSymbol,
//     this.productUnit,
//     this.saleUnit,
//     this.purchaseUnit,
//     this.productType,
//     this.quantityLimit,
//     this.notes,
//     this.purchaseSupplierId,
//     this.purchaseWarehouseId,
//     this.purchaseDate,
//     this.purchaseStatus,
//     this.variationData,
//     this.orderTax,
//     this.taxType,
//     this.imageUrl,
//     this.expiryDate,
//     this.brand,
//     this.branch,
//     this.price,
//     this.inStock,
//     this.createdOn,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       name: json['name'],
//       productCode: json['product_code'],
//       code: json['code'],
//       type: json['type'],
//       productCategoryId: json['product_category_id'],
//       brandId: json['brand_id'],
//       barcodeSymbol: json['barcode_symbol'],
//       productUnit: json['product_unit'],
//       saleUnit: json['sale_unit'],
//       purchaseUnit: json['purchase_unit'],
//       productType: json['product_type'],
//       quantityLimit: json['quantity_limit'],
//       notes: json['notes'],
//       purchaseSupplierId: json['purchase_supplier_id'],
//       purchaseWarehouseId: json['purchase_warehouse_id'],
//       purchaseDate: json['purchase_date'],
//       purchaseStatus: json['purchase_status'],
//       variationData: (json['variation_data'] as List?)
//           ?.map((v) => Variation.fromJson(v))
//           .toList(),
//       orderTax: json['order_tax'],
//       taxType: json['tax_type'],
//       imageUrl: json['image_url'],
//       expiryDate: json['expiry_date'],
//       brand: json['brand'],
//       branch: json['branch'],
//       price: json['price']?.toDouble(),
//       inStock: json['in_stock'],
//       createdOn: json['created_on'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'product_code': productCode,
//       'type': type,
//       'product_category_id': productCategoryId,
//       'brand_id': brandId,
//       'code': code,
//       'barcode_symbol': barcodeSymbol,
//       'product_unit': productUnit,
//       'sale_unit': saleUnit,
//       'purchase_unit': purchaseUnit,
//       'product_type': productType,
//       'quantity_limit': quantityLimit,
//       'notes': notes,
//       'purchase_supplier_id': purchaseSupplierId,
//       'purchase_warehouse_id': purchaseWarehouseId,
//       'purchase_date': purchaseDate,
//       'purchase_status': purchaseStatus,
//       'variation_data': variationData?.map((v) => v.toJson()).toList(),
//       'order_tax': orderTax,
//       'tax_type': taxType,
//       'image_url': imageUrl,
//     };
//   }
// }

// class Variation {
//   String? variationType;
//   double? productCost;
//   double? productPrice;
//   int? stockAlert;
//   int? orderTax;
//   int? taxType;
//   int? addStock;
//   String? code;
//   int? barcodeSymbol;

//   Variation({
//     this.variationType,
//     this.productCost,
//     this.productPrice,
//     this.stockAlert,
//     this.orderTax,
//     this.taxType,
//     this.addStock,
//     this.code,
//     this.barcodeSymbol,
//   });

//   factory Variation.fromJson(Map<String, dynamic> json) {
//     return Variation(
//       variationType: json['variation_type'],
//       productCost: json['product_cost']?.toDouble(),
//       productPrice: json['product_price']?.toDouble(),
//       stockAlert: json['stock_alert'],
//       orderTax: json['order_tax'],
//       taxType: json['tax_type'],
//       addStock: json['add_stock'],
//       code: json['code'],
//       barcodeSymbol: json['barcode_symbol'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'variation_type': variationType,
//       'product_cost': productCost,
//       'product_price': productPrice,
//       'stock_alert': stockAlert,
//       'order_tax': orderTax,
//       'tax_type': taxType,
//       'add_stock': addStock,
//       'code': code,
//       'barcode_symbol': barcodeSymbol,
//     };
//   }
// }