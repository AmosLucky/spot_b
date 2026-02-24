import 'package:drift/drift.dart';
import 'package:spotstock_inventory/core/database/database_client.dart';

import '../../../domain/entities/amenity_entity.dart';
import 'package:flutter/material.dart';

class AmenityLocalDataSource {
  final DatabaseClient db;

  AmenityLocalDataSource(this.db);

  // ✅ Fetch all amenities from database
  Future<List<AmenityEntity>> getAllAmenities() async {
    final rows = await db
        .select(db.amenitiesTable)
        .get(); // Future<List<AmenitiesTableData>>
    return rows.map<AmenityEntity>(_toEntity).toList();
  }

  // ✅ Stream for watching changes
  Stream<List<AmenityEntity>> watchAmenities() {
    return db.select(db.amenitiesTable).watch().map(
          (rows) =>
              rows.map<AmenityEntity>(_toEntity).toList(), // ✅ specify generic
        );
  }

  // ✅ Insert new amenity
  Future<void> addAmenity(AmenityEntity amenity) async {
    print(amenity);

    await db.into(db.amenitiesTable).insert(_toTableCompanion(amenity));
  }

  // ✅ Update existing amenity
  Future<void> updateAmenity(AmenityEntity amenity) async {
    await db.update(db.amenitiesTable).replace(
          AmenitiesTableData(
            // ✅ not db.AmenitiesTableData
            id: amenity.id!,
            name: amenity.name,
            description: amenity.description,
            icon: _iconToString(amenity.icon),
            status: amenity.status,
          ),
        );
  }

  // ✅ Delete amenity by id
  Future<void> deleteAmenity(int id) async {
    await (db.delete(db.amenitiesTable)..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  // ================== Helpers ==================
  AmenityEntity _toEntity(AmenitiesTableData row) {
    return AmenityEntity(
      id: row.id,
      name: row.name,
      description: row.description,
      icon: _iconFromString(row.icon),
      status: row.status,
    );
  }

  AmenitiesTableCompanion _toTableCompanion(AmenityEntity entity) {
    return AmenitiesTableCompanion.insert(
      name: entity.name,
      description: entity.description,
      icon: _iconToString(entity.icon),
      status: Value(entity.status),
    );
  }

  IconData _iconFromString(String name) {
    switch (name) {
      case 'Icons.bed':
        return Icons.bed;
      case 'Icons.tv':
        return Icons.tv;
      case 'Icons.wifi':
        return Icons.wifi;
      case 'Icons.ac_unit':
        return Icons.ac_unit;
      default:
        return Icons.star;
    }
  }

  String _iconToString(IconData icon) {
    if (icon == Icons.bed) return 'Icons.bed';
    if (icon == Icons.tv) return 'Icons.tv';
    if (icon == Icons.wifi) return 'Icons.wifi';
    if (icon == Icons.ac_unit) return 'Icons.ac_unit';
    return 'Icons.star';
  }
}
