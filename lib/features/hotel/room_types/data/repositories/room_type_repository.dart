import '../../domain/entities/room_type_entities.dart';

abstract class RoomTypeRepository {
  Future<List<RoomTypeEntity>> getRoomTypes();
  Future<void> addRoomType(RoomTypeEntity roomType);
  Future<void> updateRoomType(RoomTypeEntity roomType);
  Future<void> deleteRoomType(int id);
}
