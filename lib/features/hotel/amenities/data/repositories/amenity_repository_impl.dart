import '../../domain/entities/amenity_entity.dart';
import '../../domain/repositories/amenity_repository.dart';
import '../datasources/local/amenity_local_data_source.dart';

class AmenityRepositoryImpl implements AmenityRepository {
  final AmenityLocalDataSource localDataSource;

  AmenityRepositoryImpl(this.localDataSource);

  @override
  Future<List<AmenityEntity>> getAllAmenities() => localDataSource.getAllAmenities();

  @override
  Stream<List<AmenityEntity>> watchAmenities() => localDataSource.watchAmenities();

  @override
  Future<void> addAmenity(AmenityEntity amenity) => localDataSource.addAmenity(amenity);

  @override
  Future<void> updateAmenity(AmenityEntity amenity) => localDataSource.updateAmenity(amenity);

  @override
  Future<void> deleteAmenity(int id) => localDataSource.deleteAmenity(id);
}
