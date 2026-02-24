import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/database/database_client.dart';
import '../../data/datasources/booking_premium_service_local_data_source.dart';
import '../../data/repositories/booking_premium_service_repository_impl.dart';
import '../../domain/usecases/add_booking_premium_service.dart';
import '../../domain/usecases/delete_booking_premium_service.dart';
import '../../domain/usecases/get_booking_premium_services.dart';
import '../controller/booking_premium_service_controller.dart';
import '../controller/booking_premium_service_form_controller.dart';
import '../state/booking_premium_service_form_state.dart';
import '../state/booking_premium_service_state.dart';


final databaseClient = Provider<DatabaseClient>((ref) {
  return DatabaseClient(); // ✅ new instance of the Drift DB
});


final bookingPremiumServiceLocalDataSourceProvider =
    Provider((ref) {
  final db = ref.watch(databaseClient);
  return BookingPremiumServiceLocalDataSource(db);
});

final bookingPremiumServiceRepositoryProvider =
    Provider((ref) {
  final local =
      ref.watch(bookingPremiumServiceLocalDataSourceProvider);
  return BookingPremiumServiceRepositoryImpl(local);
});

final bookingPremiumServiceControllerProvider =
    StateNotifierProvider<
        BookingPremiumServiceController,
        BookingPremiumServiceState>((ref) {
  final repo =
      ref.watch(bookingPremiumServiceRepositoryProvider);

  return BookingPremiumServiceController(
    addUseCase: AddBookingPremiumService(repo),
    getUseCase: GetBookingPremiumServices(repo),
    deleteUseCase: DeleteBookingPremiumService(repo),
  );
});


final bookingPremiumServiceFormProvider =
    StateNotifierProvider<
        BookingPremiumServiceFormController,
        BookingPremiumServiceFormState>(
  (ref) => BookingPremiumServiceFormController(),
);

