import '../entities/facility_entity.dart';
import '../repositories/facilities_repository.dart';

class WatchFacilitiesUseCase {
  final FacilitiesRepository repository;

  WatchFacilitiesUseCase(this.repository);

  Stream<List<FacilityEntity>> call() {
    return repository.watchFacilities();
  }
}
