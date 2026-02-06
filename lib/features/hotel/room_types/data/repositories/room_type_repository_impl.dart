

import '../../domain/entities/room_type_entities.dart';
import '../datasources/local/room_types_local_service.dart';
import 'room_type_repository.dart';

class RoomTypeRepositoryImpl implements RoomTypeRepository {
  final RoomTypeLocalService localService;

  RoomTypeRepositoryImpl(this.localService);

  @override
  Future<List<RoomTypeEntity>> getRoomTypes() {
    return localService.getRoomTypes();
  }

  @override
  Future<void> addRoomType(RoomTypeEntity roomType) {
    return localService.addRoomType(roomType);
  }

  @override
  Future<void> updateRoomType(RoomTypeEntity roomType) {
    return localService.updateRoomType(roomType);
  }

  @override
  Future<void> deleteRoomType(int id) {
    return localService.deleteRoomType(id);
  }
}
