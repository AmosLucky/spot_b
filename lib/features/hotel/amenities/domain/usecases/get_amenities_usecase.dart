import '../entities/amenity_entity.dart';
import '../repositories/amenity_repository.dart';

class GetAmenitiesUseCase {
  final AmenityRepository repository;
  GetAmenitiesUseCase(this.repository);

  Future<List<AmenityEntity>> execute() async {
    return await repository.getAllAmenities();
  }

  Stream<List<AmenityEntity>> watch() {
    return repository.watchAmenities();
  }
}
