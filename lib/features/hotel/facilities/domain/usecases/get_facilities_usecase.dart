import '../entities/facility_entity.dart';
import '../repositories/facilities_repository.dart';

class GetFacilitiesUseCase {
  final FacilitiesRepository repository;

  GetFacilitiesUseCase(this.repository);

  /// one-time fetch (used by controller loadFacilities)
  Future<List<FacilityEntity>> execute() {
    return repository.getAllFacilities();
  }

  /// stream (optional, if you need reactive updates later)
  Stream<List<FacilityEntity>> watch() {
    return repository.watchFacilities();
  }
}
