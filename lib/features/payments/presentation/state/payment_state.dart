import '../../domain/entities/payment_entity.dart';

class PaymentState {
  final List<PaymentEntity> payments;
  final bool isLoading;
  final String? error;
  final double totalPaid;

  const PaymentState({
    required this.payments,
    required this.isLoading,
    required this.error,
    required this.totalPaid,
  });

  factory PaymentState.initial() => const PaymentState(
        payments: [],
        isLoading: false,
        error: null,
        totalPaid: 0,
      );

  PaymentState copyWith({
    List<PaymentEntity>? payments,
    bool? isLoading,
    String? error,
    double? totalPaid,
  }) {
    return PaymentState(
      payments: payments ?? this.payments,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      totalPaid: totalPaid ?? this.totalPaid,
    );
  }
}
