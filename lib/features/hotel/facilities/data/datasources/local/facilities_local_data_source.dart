import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:spotstock_inventory/core/database/database_client.dart';

import '../../../domain/entities/facility_entity.dart';

class FacilitiesLocalDataSource {
  final DatabaseClient db;

  FacilitiesLocalDataSource(this.db);

  // ✅ Fetch all facilities
  Future<List<FacilityEntity>> getAllFacilities() async {
    final rows = await db.select(db.localFacilitiesTable).get();
    return rows.map<FacilityEntity>(_toEntity).toList();
  }

  // ✅ Watch facilities changes
  Stream<List<FacilityEntity>> watchFacilities() {
    return db.select(db.localFacilitiesTable).watch().map(
          (rows) => rows.map<FacilityEntity>(_toEntity).toList(),
        );
  }

  // ✅ Insert new facility
  Future<void> addFacility(FacilityEntity facility) async {
    await db.into(db.localFacilitiesTable).insert(
          _toTableCompanion(facility),
        );
  }

  // ✅ Update existing facility
  Future<void> updateFacility(FacilityEntity facility) async {
    await db.update(db.localFacilitiesTable).replace(
          LocalFacilitiesTableData(
            id: facility.id!,
            name: facility.name,
            iconCodePoint: facility.icon.codePoint,
            status: facility.status,
          ),
        );
  }

  // ✅ Delete facility
  Future<void> deleteFacility(int id) async {
    await (db.delete(db.localFacilitiesTable)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  // ================== Helpers ==================

  FacilityEntity _toEntity(LocalFacilitiesTableData row) {
    return FacilityEntity(
    id: row.id,
    name: row.name,
    icon: IconData(
      row.iconCodePoint,
      fontFamily: 'MaterialIcons',
    ),
    status: row.status,
  );
  }

  LocalFacilitiesTableCompanion _toTableCompanion(
    FacilityEntity entity,
  ) {
    return LocalFacilitiesTableCompanion.insert(
      name: entity.name,
      iconCodePoint: entity.icon.codePoint,
      status: (entity.status),
    );
  }

  // ---------- Icon Mapping ----------

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
      case 'Icons.star':
        return Icons.star;
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
