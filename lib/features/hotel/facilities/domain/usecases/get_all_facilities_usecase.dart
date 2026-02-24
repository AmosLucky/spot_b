import '../entities/facility_entity.dart';
import '../repositories/facilities_repository.dart';

class GetAllFacilitiesUseCase {
  final FacilitiesRepository repository;

  GetAllFacilitiesUseCase(this.repository);

  Future<List<FacilityEntity>> call() {
    return repository.getAllFacilities();
  }
}
