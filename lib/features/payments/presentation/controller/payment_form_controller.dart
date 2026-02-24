import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/presentation/mesenger/app_messenger.dart';
import '../../domain/entities/payment_entity.dart';
import '../../domain/usecases/create_payment.dart';
import '../state/payment_form_state.dart';

class PaymentFormController extends StateNotifier<PaymentFormState> {
  final CreatePayment createPayment;

  PaymentFormController(this.createPayment) : super(PaymentFormState.initial());

  /// -------- FIELD UPDATES --------

  void setAmount(String value) {
    state = state.copyWith(amount: value, error: null);
  }

  void setTax(String value) {
    state = state.copyWith(tax: value, error: null);
  }

  void setDescription(String value) {
    state = state.copyWith(description: value);
  }

  void setPaymentMethod(String value) {
    state = state.copyWith(paymentMethod: value);
  }

  /// -------- VALIDATION --------

  String? validate() {
    if (state.amount.isEmpty) {
      return "Amount is required";
    }

    final amount = double.tryParse(state.amount);
    if (amount == null || amount <= 0) {
      return "Invalid amount";
    }

    final tax = double.tryParse(state.tax);
    if (tax == null) {
      return "Invalid tax value";
    }

    return null;
  }

  /// -------- SUBMIT --------

  Future<bool> submit({
    required int bookingId,
    required int userId,
    required int registerId,
  }) async {
    final errorMessage = validate();

    if (errorMessage != null) {
      state = state.copyWith(error: errorMessage);
      return false;
    }

    state = state.copyWith(isSubmitting: true);

    try {
      await createPayment(
        PaymentEntity(
          bookingId: bookingId,
          amount: double.parse(state.amount),
          tax: double.parse(state.tax),
          paymentMethod: state.paymentMethod,
          description: state.description,
          date: DateTime.now(),
          userId: userId,
          registerId: registerId,
        ),
      );

      AppMessenger.showSuccess("Payment Added Successfully");

      state = PaymentFormState.initial();
      return true;
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isSubmitting: false,
      );
      return false;
    }
  }
}
