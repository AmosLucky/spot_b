import '../repositories/room_repository.dart';

class DeleteRoom {
  final RoomRepository repository;

  DeleteRoom(this.repository);

  Future<void> call(int id) {
    return repository.deleteRoom(id);
  }
}
