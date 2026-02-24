import '../../domain/entities/booking_premium_service_entity.dart';

class BookingPremiumServiceState {
  final bool isLoading;
  final List<BookingPremiumServiceEntity> services;

  // Form fields
  final int? serviceId;
  final int quantity;
  final double unitPrice;
  final DateTime? startDate;
  final DateTime? endDate;

  BookingPremiumServiceState({
    this.isLoading = false,
    this.services = const [],
    this.serviceId,
    this.quantity = 1,
    this.unitPrice = 0,
    this.startDate,
    this.endDate,
  });

  BookingPremiumServiceState copyWith({
    bool? isLoading,
    List<BookingPremiumServiceEntity>? services,
    int? serviceId,
    int? quantity,
    double? unitPrice,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return BookingPremiumServiceState(
      isLoading: isLoading ?? this.isLoading,
      services: services ?? this.services,
      serviceId: serviceId ?? this.serviceId,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
