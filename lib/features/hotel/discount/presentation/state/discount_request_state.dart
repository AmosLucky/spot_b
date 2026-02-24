import '../../domain/entities/discount_entity.dart';

class DiscountRequestState {
  final bool isLoading;
  final String? error;

  final List<DiscountEntity> allDiscounts;
  final List<DiscountEntity> filteredDiscounts;

  final String searchQuery;
  final int rowsPerPage;

  const DiscountRequestState({
    this.isLoading = false,
    this.error,
    this.allDiscounts = const [],
    this.filteredDiscounts = const [],
    this.searchQuery = '',
    this.rowsPerPage = 10,
  });

  DiscountRequestState copyWith({
    bool? isLoading,
    String? error,
    List<DiscountEntity>? allDiscounts,
    List<DiscountEntity>? filteredDiscounts,
    String? searchQuery,
    int? rowsPerPage,
  }) {
    return DiscountRequestState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      allDiscounts: allDiscounts ?? this.allDiscounts,
      filteredDiscounts: filteredDiscounts ?? this.filteredDiscounts,
      searchQuery: searchQuery ?? this.searchQuery,
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
    );
  }
}