import '../../domain/entities/payment_entity.dart';

class PaymentState {
  final List<PaymentEntity> payments;
  final List<PaymentEntity> allPayments;

  final bool isLoading;
  final String? error;
  final double totalPaid;

  /// 🔥 ADD THESE
  final String searchQuery;
  final int rowsPerPage;

  const PaymentState({
    required this.payments,
    required this.allPayments,
    required this.isLoading,
    required this.error,
    required this.totalPaid,
    required this.searchQuery,
    required this.rowsPerPage,
  });

  factory PaymentState.initial() => const PaymentState(
        payments: [],
        allPayments: [],
        isLoading: false,
        error: null,
        totalPaid: 0,
        searchQuery: '',
        rowsPerPage: 10,
      );

  /// 🔥 FILTER FROM allPayments
  List<PaymentEntity> get filteredPayments {
    if (searchQuery.isEmpty) return allPayments;

    final query = searchQuery.toLowerCase();

    return allPayments.where((p) {
      return p.bookingId.toString().contains(query) ||
          "p.customerName".toLowerCase().contains(query) ||
          p.amount.toString().contains(query);
    }).toList();
  }

  PaymentState copyWith({
    List<PaymentEntity>? payments,
    List<PaymentEntity>? allPayments,
    bool? isLoading,
    String? error,
    double? totalPaid,
    String? searchQuery,
    int? rowsPerPage,
  }) {
    return PaymentState(
      payments: payments ?? this.payments,
      allPayments: allPayments ?? this.allPayments,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      totalPaid: totalPaid ?? this.totalPaid,
      searchQuery: searchQuery ?? this.searchQuery,
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
    );
  }
}