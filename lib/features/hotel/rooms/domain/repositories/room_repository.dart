import '../entities/room_entity.dart';

abstract class RoomRepository {
  Future<List<RoomEntity>> getAllRooms();
  Stream<List<RoomEntity>> watchRooms();

  Future<void> addRoom(RoomEntity room);
  Future<void> updateRoom(RoomEntity room);
  Future<void> deleteRoom(int id);

   Future<void> updateRoomStatus(int roomId, String status);

  Future<void> updateBookingStatus(int roomId, String bookingStatus);
  Future<List<RoomEntity>> getRoomsByRoomType(int roomTypeId);
}
