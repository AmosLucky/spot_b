import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/database/database_client.dart';
import '../../data/datasources/local/amenity_local_data_source.dart';
import '../../data/repositories/amenity_repository_impl.dart';
import '../../domain/usecases/get_amenities_usecase.dart';
import '../../domain/usecases/add_amenity_usecase.dart';
import '../../domain/usecases/update_amenity_usecase.dart';
import '../../domain/usecases/delete_amenity_usecase.dart';
import '../controllers/amenities_controller.dart';
import '../../domain/entities/amenities_state.dart';

final appDatabaseProvider = Provider<DatabaseClient>((ref) => DatabaseClient());

final amenityLocalDataSourceProvider = Provider<AmenityLocalDataSource>((ref) {
  final db = ref.read(appDatabaseProvider);
  return AmenityLocalDataSource(db);
});

final amenityRepositoryProvider = Provider<AmenityRepositoryImpl>((ref) {
  final ds = ref.read(amenityLocalDataSourceProvider);
  return AmenityRepositoryImpl(ds);
});

final getAmenitiesUseCaseProvider = Provider<GetAmenitiesUseCase>((ref) {
  final repo = ref.read(amenityRepositoryProvider);
  return GetAmenitiesUseCase(repo);
});

final addAmenityUseCaseProvider = Provider<AddAmenityUseCase>((ref) {
  final repo = ref.read(amenityRepositoryProvider);
  return AddAmenityUseCase(repo);
});

final updateAmenityUseCaseProvider = Provider<UpdateAmenityUseCase>((ref) {
  final repo = ref.read(amenityRepositoryProvider);
  return UpdateAmenityUseCase(repo);
});

final deleteAmenityUseCaseProvider = Provider<DeleteAmenityUseCase>((ref) {
  final repo = ref.read(amenityRepositoryProvider);
  return DeleteAmenityUseCase(repo);
});

final amenitiesControllerProvider = StateNotifierProvider<AmenitiesController, AmenitiesState>((ref) {
  return AmenitiesController(
    getUseCase: ref.read(getAmenitiesUseCaseProvider),
    addUseCase: ref.read(addAmenityUseCaseProvider),
    updateUseCase: ref.read(updateAmenityUseCaseProvider),
    deleteUseCase: ref.read(deleteAmenityUseCaseProvider),
  );
});
