import 'package:drift/drift.dart';

import '../../../../core/database/database_client.dart';
import '../models/product_category.dart';

extension ProductCategoryMapper on ProductCategory {
  LocalProductCategoriesCompanion toDrift() {
    return LocalProductCategoriesCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      name: Value(name),
      companyId: Value(companyId),
      image: Value(image),
      productCount: Value(productCount),
      link: Value(link),
    );
  }

  static ProductCategory fromDrift(LocalProductCategory row) {
    return ProductCategory(
      id: row.id,
      name: row.name,
      companyId: row.companyId,
      image: row.image,
      productCount: row.productCount,
      link: row.link,
    );
  }
}
