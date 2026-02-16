import '../../domain/entities/credit_request_entity.dart';

class CreditState {
  final bool isLoading;
  final String? error;

  // List of credit requests
  final List<CreditRequestEntity> credits;

  // -------- FORM STATE --------
  final double amount;
  final String? description;
  final DateTime? date;

  const CreditState({
    this.isLoading = false,
    this.error,
    this.credits = const [],
    this.amount = 0.0,
    this.description,
    this.date,
  });

  CreditState copyWith({
    bool? isLoading,
    String? error,
    List<CreditRequestEntity>? credits,
    double? amount,
    String? description,
    DateTime? date,
  }) {
    return CreditState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      credits: credits ?? this.credits,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }
}
