import '../../domain/entities/room_entity.dart';
import '../../domain/repositories/room_repository.dart';
import '../datasources/room_local_data_source.dart';

class RoomRepositoryImpl implements RoomRepository {
  final RoomLocalDataSource localDataSource;

  RoomRepositoryImpl(this.localDataSource);

  @override
  Future<List<RoomEntity>> getAllRooms() {
    return localDataSource.getAllRooms();
  }

  @override
  Stream<List<RoomEntity>> watchRooms() {
    return localDataSource.watchRooms();
  }

  @override
  Future<void> addRoom(RoomEntity room) {
    return localDataSource.addRoom(room);
  }

  @override
  Future<void> updateRoom(RoomEntity room) {
    return localDataSource.updateRoom(room);
  }

  @override
  Future<void> deleteRoom(int id) {
    return localDataSource.deleteRoom(id);
  }


  // ================== STATUS HELPERS (OPTIONAL BUT CLEAN) ==================

  @override
  Future<void> updateRoomStatus(int roomId, String status) async {
    final rooms = await localDataSource.getAllRooms();
    final room = rooms.firstWhere((r) => r.id == roomId);

    await localDataSource.updateRoom(
      room.copyWith(status: status),
    );
  }

  @override
  Future<void> updateBookingStatus(int roomId, String bookingStatus) async {
    final rooms = await localDataSource.getAllRooms();
    final room = rooms.firstWhere((r) => r.id == roomId);

    await localDataSource.updateRoom(
      room.copyWith(bookingStatus: bookingStatus),
    );
  }
  
}
