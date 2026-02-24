import '../../domain/entities/facility_entity.dart';
import '../../domain/repositories/facilities_repository.dart';
import '../datasources/local/facilities_local_data_source.dart';

class FacilitiesRepositoryImpl implements FacilitiesRepository {
  final FacilitiesLocalDataSource localDataSource;

  FacilitiesRepositoryImpl(this.localDataSource);

  @override
  Future<List<FacilityEntity>> getAllFacilities() {
    return localDataSource.getAllFacilities();
  }

  @override
  Stream<List<FacilityEntity>> watchFacilities() {
    return localDataSource.watchFacilities();
  }

  @override
  Future<void> addFacility(FacilityEntity facility) {
    return localDataSource.addFacility(facility);
  }

  @override
  Future<void> updateFacility(FacilityEntity facility) {
    return localDataSource.updateFacility(facility);
  }

  @override
  Future<void> deleteFacility(int id) {
    return localDataSource.deleteFacility(id);
  }
}
