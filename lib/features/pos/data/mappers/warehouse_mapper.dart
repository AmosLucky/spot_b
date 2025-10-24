import 'package:drift/drift.dart';

import '../../../../core/database/database_client.dart';
import '../models/warehouse.dart';

extension WarehouseMapper on Warehouse {
  LocalWarehousesCompanion toDrift() {
    return LocalWarehousesCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      name: Value(name),
      phone: Value(phone),
      country: Value(country),
      city: Value(city),
      email: Value(email),
      zipCode: Value(zipCode),
      status: Value(status),
      companyId: Value(companyId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  static Warehouse fromDrift(LocalWarehouse row) {
    return Warehouse(
      id: row.id,
      name: row.name,
      phone: row.phone,
      country: row.country,
      city: row.city,
      email: row.email,
      zipCode: row.zipCode,
      status: row.status,
      companyId: row.companyId,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
