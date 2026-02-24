import '../repositories/room_type_repository.dart';
import '../entities/room_type_entities.dart';


class GetRoomTypesUseCase {
  final RoomTypeRepository repository;

  GetRoomTypesUseCase(this.repository);

  Future<List<RoomTypeEntity>> call() {
    return repository.getRoomTypes();
  }
}
