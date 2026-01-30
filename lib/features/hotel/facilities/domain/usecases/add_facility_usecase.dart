import '../entities/facility_entity.dart';
import '../repositories/facilities_repository.dart';

class AddFacilityUseCase {
  final FacilitiesRepository repository;

  AddFacilityUseCase(this.repository);

  Future<void> execute(FacilityEntity facility) {
    return repository.addFacility(facility);
  }
}
