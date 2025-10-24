import 'package:drift/drift.dart';

import '../../../../core/database/database_client.dart';
import '../models/product.dart';
import '../models/stock.dart';

extension ProductMapper on Product {
  LocalProductsCompanion toDrift() {
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
      warehouseId: Value(stock?.warehouseId),
    );
  }

  static Product fromDrift(LocalProduct row) {
    return Product(
      id: row.id,
      name: row.name,
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
      stock: row.stockId != null || row.warehouseId != null
          ? Stock(id: row.stockId, warehouseId: row.warehouseId)
          : null,
    );
  }
}
