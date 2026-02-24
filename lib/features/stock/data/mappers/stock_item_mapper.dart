import '../../../pos/data/models/product.dart';
import '../models/stock_item.dart';

extension StockItemMapper on StockItem {
  static StockItem fromProduct(Product product) {
    return StockItem(
      id: product.id,
      productId: product.id,
      mainProductId: product.mainProductId,
      productName: product.name,
      productCode: product.code,
      categoryId: product.productCategoryId,
      categoryName: product.productCategoryName,
      brandName: product.brandName,
      quantity: product.inStock,
      stockAlert: product.stockAlert,
      // NB: The following fields always return null from the API
      // -> valueByCost
      // -> valueByPrice
      productCost: product.productCost,
      productPrice: product.productPrice,
      productUnit: product.productUnitName?.name,
      warehouseId: product.stock?.warehouseId,
      warehouseName: product.warehouse?.first.name,
      companyId: product.companyId,
    );
  }
}
