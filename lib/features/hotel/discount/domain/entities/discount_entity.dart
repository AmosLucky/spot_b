class DiscountEntity {
  final int? id;
  final int bookingId;
  final double amount;
  final String? description;
  final int userId;
  final int registerId;
  final DateTime? dateCreated;
  final String status;

  DiscountEntity({
    this.id,
    required this.bookingId,
    required this.amount,
    this.description,
    required this.userId,
    required this.registerId,
    this.dateCreated,
    this.status = 'Pending',
  });

  DiscountEntity copyWith({
    int? id,
    String? status,
  }) {
    return DiscountEntity(
      id: id ?? this.id,
      bookingId: bookingId,
      amount: amount,
      description: description,
      userId: userId,
      registerId: registerId,
      dateCreated: dateCreated,
      status: status ?? this.status,
    );
  }
}
