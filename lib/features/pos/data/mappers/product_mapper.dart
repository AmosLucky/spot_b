import 'package:drift/drift.dart';

import '../../../../core/database/database_client.dart';
import '../models/product.dart';
import '../models/stock.dart';

extension ProductMapper on Product {
  LocalProductsCompanion toDrift({int? warehouseId}) {
    return LocalProductsCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      name: Value(name),
      code: Value(code),
      expiryDate: Value(expiryDate),
      mainProductId: Value(mainProductId),
      productCategoryId: Value(productCategoryId),
      productCost: Value(productCost),
      productPrice: Value(productPrice),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      inStock: Value(inStock),
      link: Value(link),
      stockId: Value(stock?.id),
      warehouseId: Value(stock?.warehouseId ?? warehouseId),
      brandName: Value(brandName),
      productCategoryName: Value(productCategoryName),
      stockAlert: Value(stockAlert),
      productUnitName: Value(productUnitName),
      warehouse: Value(warehouse),
    );
  }

  static Product fromDrift(LocalProduct row) {
    return Product(
      id: row.id,
      name: row.name,
      companyId: row.companyId,
      code: row.code,
      expiryDate: row.expiryDate,
      mainProductId: row.mainProductId,
      productCategoryId: row.productCategoryId,
      productCost: row.productCost,
      productPrice: row.productPrice,
      isActive: row.isActive,
      createdAt: row.createdAt,
      inStock: row.inStock,
      link: row.link,
      stock: Stock(id: row.stockId, warehouseId: row.warehouseId),
      brandName: row.brandName,
      productCategoryName: row.productCategoryName,
      stockAlert: row.stockAlert,
      productUnitName: row.productUnitName,
      warehouse: row.warehouse,
    );
  }
}
