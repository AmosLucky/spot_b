import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/database/database_client.dart';

// data

import '../../data/datasources/local/room_types_local_service.dart';
import '../../data/repositories/room_type_repository.dart';
import '../../data/repositories/room_type_repository_impl.dart';

// domain

import '../../domain/usecases/Deleteroom_type_use_case.dart';
import '../../domain/usecases/add_room_type_use_case.dart';

import '../../domain/usecases/get_room_types_use_case.dart';


// presentation
import '../../domain/usecases/update_room_type_usecase.dart';
import '../controllers/room_type_controller.dart';
import '../state/room_type_state.dart';


/// --------------------
/// Database
/// --------------------
final appDatabaseProvider =
    Provider<DatabaseClient>((ref) => DatabaseClient());

/// --------------------
/// Repository
/// --------------------
final roomTypeRepositoryProvider = Provider<RoomTypeRepository>((ref) {
  final db = ref.read(appDatabaseProvider);
  final localDataSource = RoomTypeLocalService(db);
  return RoomTypeRepositoryImpl(localDataSource);
});

/// --------------------
/// Use cases
/// --------------------
final getRoomTypesUseCaseProvider = Provider(
  (ref) => GetRoomTypesUseCase(
    ref.read(roomTypeRepositoryProvider),
  ),
);

final addRoomTypeUseCaseProvider = Provider(
  (ref) => AddRoomTypeUseCase(
    ref.read(roomTypeRepositoryProvider),
  ),
);

final updateRoomTypeUseCaseProvider = Provider(
  (ref) => UpdateRoomTypeUseCase(
    ref.read(roomTypeRepositoryProvider),
  ),
);

final deleteRoomTypeUseCaseProvider = Provider(
  (ref) => DeleteRoomTypeUseCase(
    ref.read(roomTypeRepositoryProvider),
  ),
);

/// --------------------
/// Controller
/// --------------------
final roomTypeControllerProvider =
    StateNotifierProvider<RoomTypeController, RoomTypeState>((ref) {
  return RoomTypeController(
    getUseCase: ref.read(getRoomTypesUseCaseProvider),
    addUseCase: ref.read(addRoomTypeUseCaseProvider),
    updateUseCase: ref.read(updateRoomTypeUseCaseProvider),
    deleteUseCase: ref.read(deleteRoomTypeUseCaseProvider),
  );
});
