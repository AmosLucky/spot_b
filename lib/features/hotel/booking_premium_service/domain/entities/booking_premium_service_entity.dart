class BookingPremiumServiceEntity {
  final int? id;
  final int bookingId;
  final int serviceId;

  /// Optional - for UI display
  final String? serviceName;

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
    this.serviceName,
    required this.quantity,
    required this.unitPriceAtTime,
    required this.startDate,
    required this.endDate,
    required this.numberOfDays,
    required this.totalPrice,
    this.dateCreated,
  });

  BookingPremiumServiceEntity copyWith({
    int? id,
    String? serviceName,
  }) {
    return BookingPremiumServiceEntity(
      id: id ?? this.id,
      bookingId: bookingId,
      serviceId: serviceId,
      serviceName: serviceName ?? this.serviceName,
      quantity: quantity,
      unitPriceAtTime: unitPriceAtTime,
      startDate: startDate,
      endDate: endDate,
      numberOfDays: numberOfDays,
      totalPrice: totalPrice,
      dateCreated: dateCreated,
    );
  }
}
