import '../../data/repositories/room_type_repository.dart';
import '../entities/room_type_entities.dart';


class AddRoomTypeUseCase {
  final RoomTypeRepository repository;

  AddRoomTypeUseCase(this.repository);

  Future<void> call(RoomTypeEntity roomType) {
    return repository.addRoomType(roomType);
  }
}
