import '../../domain/entities/credit_request_entity.dart';

class CreditState {
  final bool isLoading;
  final String? error;

  /// 🔥 ORIGINAL (for current view, pagination, etc.)
  final List<CreditRequestEntity> credits;

  /// 🔥 NEW (raw full data)
  final List<CreditRequestEntity> allCredits;

  final String searchQuery;
  final int rowsPerPage;

  final double amount;
  final String? description;
  final DateTime? date;

  const CreditState({
    this.isLoading = false,
    this.error,
    this.credits = const [],
    this.allCredits = const [], // ✅ added
    this.searchQuery = '',
    this.rowsPerPage = 10,
    this.amount = 0.0,
    this.description,
    this.date,
  });

  /// 🔥 Filter FROM allCredits
  List<CreditRequestEntity> get filteredCredits {
    if (searchQuery.isEmpty) return allCredits;

    final query = searchQuery.toLowerCase();

    return allCredits.where((c) {
      return c.bookingId.toString().contains(query) ||
          c.amount.toString().contains(query) ||
          (c.description ?? '').toLowerCase().contains(query) ||
          c.status.toLowerCase().contains(query);
    }).toList();
  }

  CreditState copyWith({
    bool? isLoading,
    String? error,
    List<CreditRequestEntity>? credits,
    List<CreditRequestEntity>? allCredits, // ✅ added
    String? searchQuery,
    int? rowsPerPage,
    double? amount,
    String? description,
    DateTime? date,
  }) {
    return CreditState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      credits: credits ?? this.credits,
      allCredits: allCredits ?? this.allCredits, // ✅ added
      searchQuery: searchQuery ?? this.searchQuery,
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }
}