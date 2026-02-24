import 'package:drift/drift.dart';

import '../../../../../core/database/database_client.dart';
import '../../../../../core/error_handling/app_error.dart';
import '../../domain/entities/room_entity.dart';

class RoomLocalDataSource {
  final DatabaseClient db;

  RoomLocalDataSource(this.db);

  // ================== FETCH ALL ==================
  Future<List<RoomEntity>> getAllRooms() async {
    final rows = await db.select(db.roomsTable).get();
    return rows.map<RoomEntity>(_toEntity).toList();
  }

  // ================== WATCH ==================
  Stream<List<RoomEntity>> watchRooms() {
    return db.select(db.roomsTable).watch().map(
          (rows) => rows.map<RoomEntity>(_toEntity).toList(),
        );
  }

  // ================== ADD ==================
  Future<void> addRoom(RoomEntity room) async {
    print(room.bookingStatus);
    print(room.status);
    print(room.roomNumber);
    print(room.roomTypeId);
    await db.into(db.roomsTable).insert(_toCompanion(room));
  }

  // ================== UPDATE ==================
  Future<void> updateRoom(RoomEntity room) async {
    await db.update(db.roomsTable).replace(_toCompanion(room));
  }

  // ================== DELETE ==================
  Future<void> deleteRoom(int id) async {
    await (db.delete(db.roomsTable)..where((tbl) => tbl.id.equals(id))).go();
  }


  Future<List<RoomEntity>> getRoomsByRoomType(int roomTypeId) async {
  try {
    final rows = await (db.select(db.roomsTable)
          ..where((t) =>
              t.roomTypeId.equals(roomTypeId) &
              t.bookingStatus.equals('available')))
        .get();

    return rows.map(_toEntity).toList();
  } catch (e) {
    throw AppError(
      message: 'Failed to load available rooms',
      originalError: e,
    );
  }
}


  // ================== HELPERS ==================

  RoomEntity _toEntity(RoomsTableData row) {
    return RoomEntity(
      id: row.id,
      roomNumber: row.roomNumber,
      roomTypeId: row.roomTypeId,
      status: row.status,
    );
  }

  RoomsTableCompanion _toCompanion(RoomEntity entity) {
    return RoomsTableCompanion(
      id: entity.id != null ? Value(entity.id!) : const Value.absent(),
      roomNumber: Value(entity.roomNumber),
      roomTypeId: Value(entity.roomTypeId),
      status: Value(entity.status),
    );
  }
}
