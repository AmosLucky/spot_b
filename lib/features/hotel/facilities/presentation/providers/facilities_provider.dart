import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/database/database_client.dart';
import '../../data/datasources/local/facilities_local_data_source.dart';
import '../../data/repositories/facilities_repository_impl.dart';
import '../../domain/repositories/facilities_repository.dart';
import '../../domain/usecases/add_facility_usecase.dart';
import '../../domain/usecases/delete_facility_usecase.dart';
import '../../domain/usecases/update_facility_usecase.dart';
import '../../domain/usecases/watch_facilities_usecase.dart';
import '../controllers/facilities_controller.dart';
import '../states/facilities_state.dart';

final appDatabaseProvider = Provider<DatabaseClient>((ref) => DatabaseClient());

// Repository
final facilitiesRepositoryProvider = Provider<FacilitiesRepository>((ref) {
  final db = ref.read(appDatabaseProvider);
  final localDataSource = FacilitiesLocalDataSource(db);
  return FacilitiesRepositoryImpl(localDataSource);
});

// Use cases
final watchFacilitiesUseCaseProvider = Provider((ref) => WatchFacilitiesUseCase(
      ref.read(facilitiesRepositoryProvider),
    ));

final addFacilityUseCaseProvider = Provider((ref) => AddFacilityUseCase(
      ref.read(facilitiesRepositoryProvider),
    ));

final updateFacilityUseCaseProvider = Provider((ref) => UpdateFacilityUseCase(
      ref.read(facilitiesRepositoryProvider),
    ));

final deleteFacilityUseCaseProvider = Provider((ref) => DeleteFacilityUseCase(
      ref.read(facilitiesRepositoryProvider),
    ));

// Controller
final facilitiesControllerProvider =
    StateNotifierProvider<FacilitiesController, FacilitiesState>((ref) {
  return FacilitiesController(
    watchFacilitiesUseCase: ref.read(watchFacilitiesUseCaseProvider),
    addFacilityUseCase: ref.read(addFacilityUseCaseProvider),
    updateFacilityUseCase: ref.read(updateFacilityUseCaseProvider),
    deleteFacilityUseCase: ref.read(deleteFacilityUseCaseProvider),
  );
});
