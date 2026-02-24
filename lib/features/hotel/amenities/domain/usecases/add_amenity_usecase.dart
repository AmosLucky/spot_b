import '../entities/amenity_entity.dart';
import '../repositories/amenity_repository.dart';

class AddAmenityUseCase {
  final AmenityRepository repository;
  AddAmenityUseCase(this.repository);

  Future<void> execute(AmenityEntity amenity) async {
    await repository.addAmenity(amenity);
  }
}
