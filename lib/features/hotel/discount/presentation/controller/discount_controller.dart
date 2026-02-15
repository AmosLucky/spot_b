import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotstock_inventory/core/presentation/mesenger/app_messenger.dart';
import '../../domain/entities/discount_entity.dart';
import '../../domain/usecase/create_discount.dart';
import '../../domain/usecase/delete_discount.dart';
import '../../domain/usecase/get_discounts_by_booking.dart';
import '../../domain/usecase/update_discount.dart';

import '../state/discount_state.dart';

class DiscountController extends StateNotifier<DiscountState> {
  final CreateDiscount createDiscount;
  final GetDiscountsByBooking getDiscountsByBooking;
  final UpdateDiscount updateDiscount;
  final DeleteDiscount deleteDiscount;

  DiscountController({
    required this.createDiscount,
    required this.getDiscountsByBooking,
    required this.updateDiscount,
    required this.deleteDiscount,
  }) : super(const DiscountState());

  // --------------------------
  // FORM FIELD CONTROLLERS
  // --------------------------

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

  // --------------------------
  // GET DISCOUNTS BY BOOKING
  // --------------------------

  Future<void> loadDiscounts(int bookingId) async {
    state = state.copyWith(isLoading: true);

    try {
      final result = await getDiscountsByBooking(bookingId);

      state = state.copyWith(
        isLoading: false,
        discounts: result,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // --------------------------
  // CREATE DISCOUNT
  // --------------------------

  Future<void> create({
    required int bookingId,
    required int userId,
    required int registerId,
  }) async {
    if (state.amount <= 0) return;

    state = state.copyWith(isLoading: true);

    try {
      final discount = DiscountEntity(
        bookingId: bookingId,
        amount: state.amount,
        description: state.description,
        userId: userId,
        registerId: registerId,
        dateCreated: state.date ?? DateTime.now(),
      );

      await createDiscount(discount);

      await loadDiscounts(bookingId);
      AppMessenger.showSuccess("Discount added successfully");

      resetForm();
    } catch (e) {
      print(e);
      state = state.copyWith(error: e.toString());
      AppMessenger.showError(e.toString());
    }

    state = state.copyWith(isLoading: false);
  }

  // --------------------------
  // UPDATE
  // --------------------------

  Future<void> updateDiscountItem(DiscountEntity discount) async {
    await updateDiscount(discount);
    await loadDiscounts(discount.bookingId);
  }

  // --------------------------
  // DELETE
  // --------------------------

  Future<void> deleteDiscountItem(int id, int bookingId) async {
    await deleteDiscount(id);
    await loadDiscounts(bookingId);
  }
}
