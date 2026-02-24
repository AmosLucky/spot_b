class PaymentEntity {
  final int? id;
  final int bookingId;
  final double amount;
  final double? tax;
  final String paymentMethod;
  final String? description;
  final DateTime? date;
  final int userId;
  final int registerId;

  const PaymentEntity({
    this.id,
    required this.bookingId,
    required this.amount,
    required this.tax,
    required this.paymentMethod,
     this.description = "",
    required this.date,
    required this.userId,
    required this.registerId,
  });

  double get total => amount + tax!;
}
