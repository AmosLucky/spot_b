import '../entities/room_entity.dart';
import '../repositories/room_repository.dart';

class WatchRooms {
  final RoomRepository repository;

  WatchRooms(this.repository);

    Future<List<RoomEntity>> call() {
    return repository.getAllRooms();
  }
}
