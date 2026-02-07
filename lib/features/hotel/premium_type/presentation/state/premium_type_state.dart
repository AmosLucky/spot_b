import '../../domain/entities/premium_type_entity.dart';

class PremiumTypeState {
  final bool isLoading;
  final List<PremiumTypeEntity> all;
  final List<PremiumTypeEntity> filtered;

  final String selectedFilterStatus;
  final List<String> filterStatusList;

  const PremiumTypeState({
    this.isLoading = false,
    this.all = const [],
    this.filtered = const [],
    this.selectedFilterStatus = 'All',
    this.filterStatusList = const ['All', 'Active', 'Inactive'],
  });

  PremiumTypeState copyWith({
    bool? isLoading,
    List<PremiumTypeEntity>? all,
    List<PremiumTypeEntity>? filtered,
    String? selectedFilterStatus,
  }) {
    return PremiumTypeState(
      isLoading: isLoading ?? this.isLoading,
      all: all ?? this.all,
      filtered: filtered ?? this.filtered,
      selectedFilterStatus:
          selectedFilterStatus ?? this.selectedFilterStatus,
      filterStatusList: filterStatusList,
    );
  }
}
