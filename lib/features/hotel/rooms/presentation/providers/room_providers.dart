import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/database/database_client.dart';
import '../../data/datasources/room_local_data_source.dart';
import '../../data/repositories/room_repository_impl.dart';
import '../../domain/repositories/room_repository.dart';
import '../controller/room_controller.dart';
import '../state/room_state.dart';

final appDatabaseProvider =
    Provider<DatabaseClient>((ref) => DatabaseClient());

final roomRepositoryProvider = Provider<RoomRepository>((ref) {
  final db = ref.read(appDatabaseProvider);
  return RoomRepositoryImpl(RoomLocalDataSource(db));
});

final roomControllerProvider =
    StateNotifierProvider<RoomController, RoomState>((ref) {
  return RoomController(ref.read(roomRepositoryProvider));
});
