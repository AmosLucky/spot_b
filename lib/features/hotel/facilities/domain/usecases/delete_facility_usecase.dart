import '../repositories/facilities_repository.dart';

class DeleteFacilityUseCase {
  final FacilitiesRepository repository;

  DeleteFacilityUseCase(this.repository);

  Future<void> execute(int id) {
    return repository.deleteFacility(id);
  }
}
