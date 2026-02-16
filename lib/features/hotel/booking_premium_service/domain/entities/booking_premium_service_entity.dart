class BookingPremiumServiceEntity {
  final int? id;
  final int bookingId;
  final int serviceId;
  final int quantity;
  final double unitPriceAtTime;
  final DateTime startDate;
  final DateTime endDate;
  final int numberOfDays;
  final double totalPrice;
  final DateTime? dateCreated;

  BookingPremiumServiceEntity({
    this.id,
    required this.bookingId,
    required this.serviceId,
    required this.quantity,
    required this.unitPriceAtTime,
    required this.startDate,
    required this.endDate,
    required this.numberOfDays,
    required this.totalPrice,
    this.dateCreated,
  });
}
