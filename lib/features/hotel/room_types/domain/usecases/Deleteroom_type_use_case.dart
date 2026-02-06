import '../../data/repositories/room_type_repository.dart';

class DeleteRoomTypeUseCase {
  final RoomTypeRepository repository;

  DeleteRoomTypeUseCase(this.repository);

  Future<void> call(int id) {
    return repository.deleteRoomType(id);
  }
}
