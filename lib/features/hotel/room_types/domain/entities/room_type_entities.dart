class RoomTypeEntity {
  final int? id;
  final String name;
  final int totalAdults;
  final int totalChildren;
  final int totalBeds;
  final double fare;
  final String? keywords;
  final String description;
  final double cancellationFee;
  final String cancellationPolicy;
  final List<int> amenityIds;
  final List<int> facilityIds;
  final List<int> bedTypeIds;
  final bool isActive;

  RoomTypeEntity({
    this.id,
    required this.name,
    required this.totalAdults,
    required this.totalChildren,
    required this.totalBeds,
    required this.fare,
    this.keywords,
    required this.description,
    required this.cancellationFee,
    required this.cancellationPolicy,
    required this.amenityIds,
    required this.facilityIds,
    required this.bedTypeIds,
    required this.isActive,
  });
}
