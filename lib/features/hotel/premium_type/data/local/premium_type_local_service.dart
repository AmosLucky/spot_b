import 'package:drift/drift.dart';

import '../../../../../core/database/database_client.dart';
import '../../domain/entities/premium_type_entity.dart';

class PremiumTypeLocalDataSource {
  final DatabaseClient db;

  PremiumTypeLocalDataSource(this.db);

  // ================== FETCH ALL ==================
  Future<List<PremiumTypeEntity>> getAllPremiumTypes() async {
    final rows = await db.select(db.premiumTypesTable).get();
    return rows.map<PremiumTypeEntity>(_toEntity).toList();
  }

  // ================== WATCH CHANGES ==================
  Stream<List<PremiumTypeEntity>> watchPremiumTypes() {
    return db.select(db.premiumTypesTable).watch().map(
          (rows) => rows.map<PremiumTypeEntity>(_toEntity).toList(),
        );
  }

  // ================== ADD ==================
  Future<void> addPremiumType(PremiumTypeEntity premiumType) async {
    await db.into(db.premiumTypesTable).insert(_toCompanion(premiumType));
  }

  // ================== UPDATE ==================
  Future<void> updatePremiumType(PremiumTypeEntity premiumType) async {
    await db.update(db.premiumTypesTable).replace(_toCompanion(premiumType));
  }

  // ================== DELETE ==================
  Future<void> deletePremiumType(int id) async {
    await (db.delete(db.premiumTypesTable)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  // ================== HELPERS ==================

  /// Converts Drift table row to domain entity
  PremiumTypeEntity _toEntity(PremiumTypesTableData row) {
    return PremiumTypeEntity(
      id: row.id,
      name: row.name,
      cost: row.cost,
      status: row.status,
    );
  }

  /// Converts domain entity to Drift insertable companion
  PremiumTypesTableCompanion _toCompanion(PremiumTypeEntity entity) {
    return PremiumTypesTableCompanion(
      id: entity.id != null ? Value(entity.id!) : const Value.absent(),
      name: Value(entity.name),
      cost: Value(entity.cost),
      status: Value(entity.status),
    );
  }
}
