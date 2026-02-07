class PremiumTypeEntity {
  final int? id;
  final String name;
  final double cost;
  final String status; // Active | Inactive

  const PremiumTypeEntity({
    this.id,
    required this.name,
    required this.cost,
    required this.status,
  });
}
