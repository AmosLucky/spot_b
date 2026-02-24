class PaymentFormState {
  final String amount;
  final String tax;
  final String description;
  final String paymentMethod;

  final bool isSubmitting;
  final String? error;

  const PaymentFormState({
    required this.amount,
    required this.tax,
    required this.description,
    required this.paymentMethod,
    required this.isSubmitting,
    required this.error,
  });

  factory PaymentFormState.initial() {
    return const PaymentFormState(
      amount: '',
      tax: '0',
      description: '',
      paymentMethod: 'Cash',
      isSubmitting: false,
      error: null,
    );
  }

  PaymentFormState copyWith({
    String? amount,
    String? tax,
    String? description,
    String? paymentMethod,
    bool? isSubmitting,
    String? error,
  }) {
    return PaymentFormState(
      amount: amount ?? this.amount,
      tax: tax ?? this.tax,
      description: description ?? this.description,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error,
    );
  }
}
