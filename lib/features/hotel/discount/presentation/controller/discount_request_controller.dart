import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecase/get_all_discount_requests.dart';
import '../state/discount_request_state.dart';

class DiscountRequestController extends StateNotifier<DiscountRequestState> {
  final GetAllDiscountRequests getAllDiscountRequests;

  DiscountRequestController(this.getAllDiscountRequests)
      : super(const DiscountRequestState());

  // ===============================
  // LOAD ALL DISCOUNT REQUESTS
  // ===============================
  Future<void> loadAllDiscountRequests() async {
    state = state.copyWith(isLoading: true);

    try {
      final result = await getAllDiscountRequests();

      state = state.copyWith(
        isLoading: false,
        allDiscounts: result,
        filteredDiscounts: result,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // ===============================
  // SEARCH
  // ===============================
  void search(String query) {
    final filtered = state.allDiscounts.where((discount) {
      final q = query.toLowerCase();

      return discount.bookingId.toString().contains(q) ||
          (discount.description ?? '').toLowerCase().contains(q) ||
          discount.amount.toString().contains(q);
    }).toList();

    state = state.copyWith(
      searchQuery: query,
      filteredDiscounts: filtered,
    );
  }

  // ===============================
  // ROWS PER PAGE
  // ===============================
  void setRowsPerPage(int value) {
    state = state.copyWith(rowsPerPage: value);
  }
}