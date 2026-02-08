import '../entities/room_entity.dart';
import '../repositories/room_repository.dart';

class UpdateRoom {
  final RoomRepository repository;

  UpdateRoom(this.repository);

  Future<void> call(RoomEntity room) {
    return repository.updateRoom(room);
  }
}
