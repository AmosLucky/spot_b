import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/payment_entity.dart';
import '../../domain/usecases/create_payment.dart';
import '../../domain/usecases/delete_payment.dart';
import '../../domain/usecases/get_payments_by_booking.dart';
import '../../domain/usecases/update_payment.dart';
import '../state/payment_state.dart';

class PaymentController extends StateNotifier<PaymentState> {

  final GetPaymentsByBooking getPayments;
  final CreatePayment createPaymentUC;
  final UpdatePayment updatePaymentUC;
  final DeletePayment deletePaymentUC;

  PaymentController(
    this.getPayments,
    this.createPaymentUC,
    this.updatePaymentUC,
    this.deletePaymentUC,
  ) : super(PaymentState.initial());

  int? _bookingId;

  Future<void> loadPayments(int bookingId) async {
    _bookingId = bookingId;
    state = state.copyWith(isLoading: true);

    final data = await getPayments(bookingId);

    state = state.copyWith(
      payments: data,
      totalPaid: data.fold(0, (sum, e) => sum! + e.total),
      isLoading: false,
    );
  }

  Future<void> addPayment(PaymentEntity payment) async {
    await createPaymentUC(payment);
    await loadPayments(_bookingId!);
  }

  Future<void> deletePayment(int id) async {
    await deletePaymentUC(id);
    await loadPayments(_bookingId!);
  }

  Future<void> updatePayment(PaymentEntity payment) async {
    await updatePaymentUC(payment);
    await loadPayments(_bookingId!);
  }
}
