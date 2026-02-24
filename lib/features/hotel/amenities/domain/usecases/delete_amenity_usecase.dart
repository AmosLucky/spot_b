import '../repositories/amenity_repository.dart';

class DeleteAmenityUseCase {
  final AmenityRepository repository;
  DeleteAmenityUseCase(this.repository);
Future<void> execute(int id) async {
    await repository.deleteAmenity(id);
  }}