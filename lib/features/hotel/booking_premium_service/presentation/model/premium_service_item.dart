class PremiumServiceItem {
  final int? serviceId;
  final String? serviceName;
  final double unitPrice;
  final int quantity;

  PremiumServiceItem({
    this.serviceId,
    this.serviceName,
    this.unitPrice = 0,
    this.quantity = 1,
  });

  double get total => unitPrice * quantity;

  PremiumServiceItem copyWith({
    int? serviceId,
    String? serviceName,
    double? unitPrice,
    int? quantity,
  }) {
    return PremiumServiceItem(
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
    );
  }
}
