import '../entities/amenity_entity.dart';

abstract class AmenityRepository {
  Future<List<AmenityEntity>> getAllAmenities();
  Stream<List<AmenityEntity>> watchAmenities();
  Future<void> addAmenity(AmenityEntity amenity);
  Future<void> updateAmenity(AmenityEntity amenity);
  Future<void> deleteAmenity(int id);
}
