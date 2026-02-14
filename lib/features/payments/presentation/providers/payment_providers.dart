import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/database/database_client.dart';

import '../../data/local/payment_local_data_source.dart';
import '../../data/repositories/payment_repository_impl.dart';

import '../../domain/repositories/payment_repository.dart';
import '../../domain/usecases/create_payment.dart';
import '../../domain/usecases/delete_payment.dart';
import '../../domain/usecases/get_payments_by_booking.dart';
import '../../domain/usecases/update_payment.dart';
import '../../domain/usecases/get_single_payment_by_booking.dart';

import '../controller/payment_controller.dart';
import '../state/payment_state.dart';


/// ------------------------------------------------
/// DATABASE
/// ------------------------------------------------
final paymentDatabaseProvider = Provider<DatabaseClient>((ref) {
  return DatabaseClient();
});


/// ------------------------------------------------
/// LOCAL DATASOURCE
/// ------------------------------------------------
final paymentLocalDataSourceProvider = Provider<PaymentLocalDataSource>((ref) {
  final db = ref.read(paymentDatabaseProvider);
  return PaymentLocalDataSource(db);
});


/// ------------------------------------------------
/// REMOTE DATASOURCE (API)
/// ------------------------------------------------



/// ------------------------------------------------
/// REPOSITORY
/// ------------------------------------------------
final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  final local = ref.read(paymentLocalDataSourceProvider);
  //final remote = ref.read(paymentRemoteDataSourceProvider);

  return PaymentRepositoryImpl(local);
});


/// ------------------------------------------------
/// USECASES
/// ------------------------------------------------

final getPaymentsByBookingProvider = Provider<GetPaymentsByBooking>((ref) {
  return GetPaymentsByBooking(ref.read(paymentRepositoryProvider));
});

final getSinglePaymentByBookingProvider =
    Provider<GetSinglePaymentByBooking>((ref) {
  return GetSinglePaymentByBooking(ref.read(paymentRepositoryProvider));
});

final createPaymentProvider = Provider<CreatePayment>((ref) {
  return CreatePayment(ref.read(paymentRepositoryProvider));
});

final updatePaymentProvider = Provider<UpdatePayment>((ref) {
  return UpdatePayment(ref.read(paymentRepositoryProvider));
});

final deletePaymentProvider = Provider<DeletePayment>((ref) {
  return DeletePayment(ref.read(paymentRepositoryProvider));
});


/// ------------------------------------------------
/// CONTROLLER
/// ------------------------------------------------
final paymentControllerProvider =
    StateNotifierProvider<PaymentController, PaymentState>((ref) {
  return PaymentController(
    ref.read(getPaymentsByBookingProvider),
    ref.read(createPaymentProvider),
    ref.read(updatePaymentProvider),
    ref.read(deletePaymentProvider),
  );
});
