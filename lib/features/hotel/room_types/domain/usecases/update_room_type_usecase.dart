import '../../data/repositories/room_type_repository.dart';
import '../entities/room_type_entities.dart';


class UpdateRoomTypeUseCase {
  final RoomTypeRepository repository;

  UpdateRoomTypeUseCase(this.repository);

  /// Update a room type
  /// Pass the full RoomTypeEntity with updated fields
  Future<void> call(RoomTypeEntity entity) async {
    await repository.updateRoomType(entity);
  }
}
