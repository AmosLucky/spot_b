import 'package:drift/drift.dart';
import '../../../../../../core/database/database_client.dart';
import '../../../../../../core/error_handling/app_error.dart';
import '../../../domain/entities/bed_type.dart';

class BedTypeLocalService {
  final DatabaseClient db;

  BedTypeLocalService(this.db);

  /// Fetch all bed types
  Future<List<BedType>> getBedTypes() async {
    try {
      final rows = await db.select(db.bedTypesTable).get();
      return rows
          .map(
            (row) => BedType(
              id: row.id,
              name: row.name,
            ),
          )
          .toList();
    } catch (e) {
      throw AppError(
        message: 'Failed to load bed types',
        originalError: e,
      );
    }
  }

  /// Insert new bed type
  Future<void> addBedType(String name) async {
    try {
      await db.into(db.bedTypesTable).insert(
            BedTypesTableCompanion.insert(
              name: name,
            ),
          );
    } catch (e) {
      throw AppError(
        message: 'Failed to add bed type',
        originalError: e,
      );
    }
  }

  /// Update bed type
  Future<void> updateBedType(int id, String name) async {
    try {
      await db.update(db.bedTypesTable).replace(
            BedTypesTableData(
              id: id,
              name: name,
              isActive: true,
              createdAt: DateTime.now(),
            ),
          );
    } catch (e) {
      throw AppError(
        message: 'Failed to update bed type',
        originalError: e,
      );
    }
  }

  /// Delete bed type
  Future<void> deleteBedType(int id) async {
    try {
      await (db.delete(db.bedTypesTable)..where((tbl) => tbl.id.equals(id)))
          .go();
    } catch (e) {
      throw AppError(
        message: 'Failed to delete bed type',
        originalError: e,
      );
    }
  }
}
