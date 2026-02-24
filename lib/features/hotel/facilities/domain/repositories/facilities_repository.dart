import '../entities/facility_entity.dart';

abstract class FacilitiesRepository {
  Future<List<FacilityEntity>> getAllFacilities();

  Stream<List<FacilityEntity>> watchFacilities();

  Future<void> addFacility(FacilityEntity facility);

  Future<void> updateFacility(FacilityEntity facility);

  Future<void> deleteFacility(int id);
}
