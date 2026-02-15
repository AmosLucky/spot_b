import '../../domain/entities/discount_entity.dart';

class DiscountState {
  final bool isLoading;
  final String? error;

  final List<DiscountEntity> discounts;

  // Form fields
  final double amount;
  final String? description;
  final DateTime? date;

  const DiscountState({
    this.isLoading = false,
    this.error,
    this.discounts = const [],
    this.amount = 0.0,
    this.description,
    this.date,
  });

  DiscountState copyWith({
    bool? isLoading,
    String? error,
    List<DiscountEntity>? discounts,
    double? amount,
    String? description,
    DateTime? date,
  }) {
    return DiscountState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      discounts: discounts ?? this.discounts,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }
}
