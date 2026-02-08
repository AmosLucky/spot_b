import '../entities/room_entity.dart';
import '../repositories/room_repository.dart';

class GetAllRooms {
  final RoomRepository repository;

  GetAllRooms(this.repository);

  Future<List<RoomEntity>> call() {
    return repository.getAllRooms();
  }
}
