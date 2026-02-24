import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotstock_inventory/core/database/database_client.dart';
import '../../data/datasources/local/bed_type_local_service.dart' show BedTypeLocalService;
import '../../data/repositories/bed_type_repository_impl.dart';

import '../../domain/usecases/add_bed_type.dart';
import '../../domain/usecases/get_bed_types.dart';
import '../../domain/usecases/update_bed_type.dart';
import '../../domain/usecases/delete_bed_type.dart';
import '../../presentation/controllers/bed_types_controller.dart';

// Drift DB provider
final bedTypeDriftServiceProvider = Provider<DatabaseClient>((ref) {
  return DatabaseClient(); // ✅ new instance of the Drift DB
});

// Local service provider
final bedTypeLocalServiceProvider = Provider<BedTypeLocalService>((ref) {
  final driftService = ref.watch(bedTypeDriftServiceProvider);
  return BedTypeLocalService(driftService);
});

// Repository
final bedTypeRepositoryProvider = Provider<BedTypeRepositoryImpl>((ref) {
  final localService = ref.watch(bedTypeLocalServiceProvider);
  return BedTypeRepositoryImpl(localService);
});

// Use Cases
final addBedTypeUseCaseProvider = Provider<AddBedType>((ref) {
  return AddBedType(ref.watch(bedTypeRepositoryProvider));
});

final getBedTypesUseCaseProvider = Provider<GetBedTypes>((ref) {
  return GetBedTypes(ref.watch(bedTypeRepositoryProvider));
});

final updateBedTypeUseCaseProvider = Provider<UpdateBedType>((ref) {
  return UpdateBedType(ref.watch(bedTypeRepositoryProvider));
});

final deleteBedTypeUseCaseProvider = Provider<DeleteBedType>((ref) {
  return DeleteBedType(ref.watch(bedTypeRepositoryProvider));
});

// Controller
final bedTypesControllerProvider =
    StateNotifierProvider<BedTypesController, dynamic>((ref) {
  return BedTypesController(
    getUseCase: ref.watch(getBedTypesUseCaseProvider),
    addUseCase: ref.watch(addBedTypeUseCaseProvider),
    updateUseCase: ref.watch(updateBedTypeUseCaseProvider),
    deleteUseCase: ref.watch(deleteBedTypeUseCaseProvider),
  );
});
