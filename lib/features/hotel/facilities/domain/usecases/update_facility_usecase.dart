import '../entities/facility_entity.dart';
import '../repositories/facilities_repository.dart';

class UpdateFacilityUseCase {
  final FacilitiesRepository repository;

  UpdateFacilityUseCase(this.repository);

  Future<void> execute(FacilityEntity facility) {
    return repository.updateFacility(facility);
  }
}
