



import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/database/database_client.dart';
import '../../data/datasources/credit_local_data_source.dart';
import '../../data/repositories/credit_repository_impl.dart';
import '../../domain/repositories/credit_repository.dart';
import '../../domain/usecases/create_credit_request.dart';
import '../../domain/usecases/delete_credit_request.dart';
import '../../domain/usecases/get_all_credits.dart';
import '../../domain/usecases/get_credit_by_booking.dart';
import '../../domain/usecases/update_credit_request.dart';
import '../controller/credit_controller.dart';
import '../controller/select_id_controller.dart';
import '../state/credit_state.dart';

final appDatabaseProvider =
    Provider<DatabaseClient>((ref) => DatabaseClient());

final creditRepositoryProvider =
    Provider<CreditRepository>((ref) {
  final db = ref.read(appDatabaseProvider);
  return CreditRepositoryImpl(
    CreditLocalDataSource(db),
  );
});

final createCreditProvider = Provider(
  (ref) => CreateCreditRequest(
    ref.read(creditRepositoryProvider),
  ),
);

final getCreditByBookingProvider = Provider(
  (ref) => GetCreditByBooking(
    ref.read(creditRepositoryProvider),
  ),
);

final updateCreditProvider = Provider(
  (ref) => UpdateCreditRequest(
    ref.read(creditRepositoryProvider),
  ),
);

final deleteCreditProvider = Provider(
  (ref) => DeleteCreditRequest(
    ref.read(creditRepositoryProvider),
  ),
);



// final getAllCreditsProvider = Provider<GetAllCredits>((ref) {
//   final repo = ref.read(creditRepositoryProvider);
//   return GetAllCredits(repo);
// });


final getAllCreditsProvider = Provider(
  (ref) => GetAllCredits(
    ref.read(creditRepositoryProvider),
  ),
);

final creditControllerProvider =
    StateNotifierProvider<CreditController, CreditState>(
  (ref) => CreditController(
    createCredit: ref.read(createCreditProvider),
    getCreditByBooking:
        ref.read(getCreditByBookingProvider),
    updateCredit: ref.read(updateCreditProvider),
    deleteCredit: ref.read(deleteCreditProvider),
    getAllCredits: ref.read(getAllCreditsProvider)
  ),
);


final selectedCreditIdsProvider =
    StateNotifierProvider<SelectedCreditIdsNotifier, Set<int>>((ref) {
  return SelectedCreditIdsNotifier();
});


