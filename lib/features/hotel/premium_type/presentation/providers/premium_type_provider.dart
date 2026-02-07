import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../../../core/database/database_client.dart';
import '../../data/local/premium_type_local_service.dart';
import '../../data/repositories/premium_type_repository_impl.dart';
import '../controllers/premium_type_controller.dart';
import '../state/premium_type_state.dart';

final appDatabaseProvider = Provider<DatabaseClient>((ref) => DatabaseClient());


final premiumTypeControllerProvider =
    StateNotifierProvider<PremiumTypeController, PremiumTypeState>((ref) {
  final db = ref.read(appDatabaseProvider);

  final local =
      PremiumTypeLocalDataSource(db);

  final repo =
      PremiumTypeRepositoryImpl(local);

  return PremiumTypeController(repo);
});
