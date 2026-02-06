import 'package:drift/drift.dart';
import '../../../../../../core/database/database_client.dart';
import '../../../../../../core/error_handling/app_error.dart';
import '../../../domain/entities/room_type_entities.dart';

class RoomTypeLocalService {
  final DatabaseClient db;

  RoomTypeLocalService(this.db);

  /// ---------------- GET ALL ----------------
  Future<List<RoomTypeEntity>> getRoomTypes() async {
    try {
      final rows = await db.select(db.roomTypesTable).get();
      return rows.map(_toEntity).toList();
    } catch (e) {
      throw AppError(message: 'Failed to load room types', originalError: e);
    }
  }

  /// ---------------- ADD ----------------
  Future<void> addRoomType(RoomTypeEntity entity) async {
    try {
      await db.into(db.roomTypesTable).insert(_toCompanion(entity));
    } catch (e) {
      throw AppError(message: 'Failed to add room type', originalError: e);
    }
  }

  /// ---------------- UPDATE ----------------
  Future<void> updateRoomType(RoomTypeEntity entity) async {
    try {
      await db.update(db.roomTypesTable).replace(
            RoomTypesTableData(
              id: entity.id!,
              name: entity.name,
              totalAdults: entity.totalAdults,
              totalChildren: entity.totalChildren,
              totalBeds: entity.totalBeds,
              fare: entity.fare,
              keywords: entity.keywords,
              description: entity.description,
              cancellationFee: entity.cancellationFee,
              cancellationPolicy: entity.cancellationPolicy,
              amenities: entity.amenityIds.join(','), // CSV string
              facilities: entity.facilityIds.join(','), // CSV string
              bedTypes: entity.bedTypeIds.join(','), // CSV string
              isActive: entity.isActive, 
              createdAt: DateTime.now(),
             
            ),
          );
    } catch (e) {
      throw AppError(message: 'Failed to update room type', originalError: e);
    }
  }

  /// ---------------- DELETE ----------------
  Future<void> deleteRoomType(int id) async {
    try {
      await (db.delete(db.roomTypesTable)..where((t) => t.id.equals(id))).go();
    } catch (e) {
      throw AppError(message: 'Failed to delete room type', originalError: e);
    }
  }

  /// ---------------- MAPPERS ----------------
  RoomTypeEntity _toEntity(RoomTypesTableData row) {
    return RoomTypeEntity(
      id: row.id,
      name: row.name,
      totalAdults: row.totalAdults,
      totalChildren: row.totalChildren,
      totalBeds: row.totalBeds,
      fare: row.fare,
      keywords: row.keywords,
      description: row.description,
      cancellationFee: row.cancellationFee,
      cancellationPolicy: row.cancellationPolicy,
      amenityIds: _csvToIntList(row.amenities),
      facilityIds: _csvToIntList(row.facilities),
      bedTypeIds: _csvToIntList(row.bedTypes),
      isActive: row.isActive,
     
    );
  }

RoomTypesTableCompanion _toCompanion(RoomTypeEntity e) {
  return RoomTypesTableCompanion.insert(
    name: (e.name), // wrap in Value
    totalAdults: Value(e.totalAdults), // wrap int
    totalChildren: Value(e.totalChildren), // wrap int
    totalBeds: Value(e.totalBeds), // wrap int
    fare: Value(e.fare), // wrap double
    keywords: Value(e.keywords ?? ''), // nullable String wrapped
    description: (e.description), // wrap String
    cancellationFee: Value(e.cancellationFee), // wrap double
    cancellationPolicy: (e.cancellationPolicy), // wrap String
    amenities: Value(e.amenityIds.join(',')), // wrap String
    facilities: Value(e.facilityIds.join(',')), // wrap String
    bedTypes: Value(e.bedTypeIds.join(',')), // wrap String
    isActive: Value(e.isActive), // wrap bool
    createdAt: Value(DateTime.now()), // wrap DateTime
  );
}


  List<int> _csvToIntList(String? value) {
    if (value == null || value.isEmpty) return [];
    return value.split(',').map((s) => int.tryParse(s) ?? 0).toList();
  }
}
