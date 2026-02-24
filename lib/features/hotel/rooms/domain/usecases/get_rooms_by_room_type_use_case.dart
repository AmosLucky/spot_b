import '../entities/room_entity.dart';
import '../repositories/room_repository.dart';

class GetRoomsByRoomTypeUseCase {
  final RoomRepository repository;

  GetRoomsByRoomTypeUseCase(this.repository);

  Future<List<RoomEntity>> call(int roomTypeId) {
    return repository.getRoomsByRoomType(roomTypeId);
  }
}
