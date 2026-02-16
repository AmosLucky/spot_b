import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotstock_inventory/core/presentation/mesenger/app_messenger.dart';
import '../../domain/entities/credit_request_entity.dart';
import '../../domain/usecases/create_credit_request.dart';
import '../../domain/usecases/delete_credit_request.dart';
import '../../domain/usecases/get_credit_by_booking.dart';
import '../../domain/usecases/update_credit_request.dart';
import '../state/credit_state.dart';

class CreditController extends StateNotifier<CreditState> {
  final CreateCreditRequest createCredit;
  final GetCreditByBooking getCreditByBooking;
  final UpdateCreditRequest updateCredit;
  final DeleteCreditRequest deleteCredit;

  CreditController({
    required this.createCredit,
    required this.getCreditByBooking,
    required this.updateCredit,
    required this.deleteCredit,
  }) : super(const CreditState());

  // ===============================
  // FORM FIELD CONTROLLERS
  // ===============================

  void setAmount(String value) {
    final parsed = double.tryParse(value) ?? 0.0;
    state = state.copyWith(amount: parsed);
  }

  void setDescription(String? value) {
    state = state.copyWith(description: value);
  }

  void setDate(DateTime date) {
    state = state.copyWith(date: date);
  }

  void resetForm() {
    state = state.copyWith(
      amount: 0.0,
      description: null,
      date: null,
    );
  }

  // ===============================
  // LOAD BY BOOKING
  // ===============================

  Future<void> loadCredits(int bookingId) async {
    state = state.copyWith(isLoading: true);

    try {
      final credits = await getCreditByBooking(bookingId);

      state = state.copyWith(
        isLoading: false,
        credits: credits,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // ===============================
  // CREATE CREDIT REQUEST
  // ===============================

  Future<void> create({
    required int bookingId,
    required int userId,
    required int registerId,
  }) async {
    if (state.amount <= 0) return;

    state = state.copyWith(isLoading: true);

    try {
      final credit = CreditRequestEntity(
        bookingId: bookingId,
        amount: state.amount,
        description: state.description,
        userId: userId,
        registerId: registerId,
        dateCreated: state.date ?? DateTime.now(),
        // status defaults to false
      );

      await createCredit(credit);

      await loadCredits(bookingId);
      AppMessenger.showSuccess("credit request sent successfully");

      resetForm();
    } catch (e) {
       AppMessenger.showError("Failed to credit request");
      state = state.copyWith(error: e.toString());
    }

    state = state.copyWith(isLoading: false);
  }

  // ===============================
  // APPROVE / UPDATE
  // ===============================

  Future<void> approveCredit(CreditRequestEntity credit) async {
    final updated = credit.copyWith(status: "aproved");

    await updateCredit(updated);
    await loadCredits(credit.bookingId);
  }

  // ===============================
  // DELETE
  // ===============================

  Future<void> deleteCreditItem(int id, int bookingId) async {
    await deleteCredit(id);
    await loadCredits(bookingId);
  }
}
