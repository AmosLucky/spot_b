import '../entities/amenity_entity.dart';
import '../repositories/amenity_repository.dart';

class UpdateAmenityUseCase {
  final AmenityRepository repository;
  UpdateAmenityUseCase(this.repository);
Future<void> execute(AmenityEntity amenity) async {
    await repository.updateAmenity(amenity);
  }}