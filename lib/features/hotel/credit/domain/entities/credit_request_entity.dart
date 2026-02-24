class CreditRequestEntity {
  final int? id;
  final int bookingId;
  final double amount;
  final String? description;

  /// pending | approved | rejected
  final String status;

  final DateTime? dateCreated;
  final int userId;
  final int registerId;

  CreditRequestEntity({
    this.id,
    required this.bookingId,
    required this.amount,
    this.description,
    this.status = "pending", // default value
    this.dateCreated,
    required this.userId,
    required this.registerId,
  });

  CreditRequestEntity copyWith({
    int? id,
    String? status,
  }) {
    return CreditRequestEntity(
      id: id ?? this.id,
      bookingId: bookingId,
      amount: amount,
      description: description,
      status: status ?? this.status,
      dateCreated: dateCreated,
      userId: userId,
      registerId: registerId,
    );
  }
}
