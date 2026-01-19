import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../features/pos/data/models/product_unit_name.dart';
import '../../../features/pos/data/models/product_warehouse.dart';

class ProductUnitNameConverter extends TypeConverter<ProductUnitName, String> {
  const ProductUnitNameConverter();

  @override
  ProductUnitName fromSql(String fromDb) {
    if (fromDb.isEmpty) return const ProductUnitName();
    return ProductUnitName.fromJson(jsonDecode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(ProductUnitName value) => jsonEncode(value.toJson());
}

class ProductWarehouseListConverter extends TypeConverter<List<ProductWarehouse>, String> {
  const ProductWarehouseListConverter();

  @override
  List<ProductWarehouse> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];
    final List<dynamic> decoded = jsonDecode(fromDb) as List<dynamic>;
    return decoded.map((e) => ProductWarehouse.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  String toSql(List<ProductWarehouse> value) {
    return jsonEncode(value.map((e) => e.toJson()).toList());
  }
}

class LocalProducts extends Table {
  IntColumn get id => integer().nullable()();
  TextColumn get name => text().nullable()();
  IntColumn get companyId => integer().nullable()();
  TextColumn get code => text().nullable()();
  DateTimeColumn get expiryDate => dateTime().nullable()();
  IntColumn get mainProductId => integer().nullable()();
  IntColumn get productCategoryId => integer().nullable()();
  RealColumn get productCost => real().nullable()();
  RealColumn get productPrice => real().nullable()();
  BoolColumn get isActive => boolean().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  IntColumn get inStock => integer().nullable()();
  TextColumn get link => text().nullable()();
  IntColumn get stockId => integer().nullable()();
  IntColumn get warehouseId => integer().nullable()();
  TextColumn get brandName => text().nullable()();
  TextColumn get productCategoryName => text().nullable()();
  TextColumn get stockAlert => text().nullable()();
  TextColumn get productUnitName => text().map(NullAwareTypeConverter.wrap(const ProductUnitNameConverter())).nullable()();
  TextColumn get warehouse => text().map(NullAwareTypeConverter.wrap(const ProductWarehouseListConverter())).nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
