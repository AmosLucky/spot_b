import '../../domain/entities/premium_type_entity.dart';

class PremiumTypeState {
  final bool isLoading;
  final List<PremiumTypeEntity> all;
  final List<PremiumTypeEntity> filtered;

  final String selectedFilterStatus;
  final List<String> filterStatusList;

  final String selectedStatus;
  final List<String> selectedStatusList;

  const PremiumTypeState({
    this.isLoading = false,
    this.all = const [],
    this.filtered = const [],
    this.selectedFilterStatus = 'All',
    this.filterStatusList = const ['All', 'Active', 'Inactive'],
    this.selectedStatus = "Active",
    this.selectedStatusList = const ["Active","Inactive"]
  });

  PremiumTypeState copyWith({
    bool? isLoading,
    List<PremiumTypeEntity>? all,
    List<PremiumTypeEntity>? filtered,
    String? selectedFilterStatus,
      String? selectedStatus,
   List<String> ?selectedStatusList
  }) {
    return PremiumTypeState(
      isLoading: isLoading ?? this.isLoading,
      all: all ?? this.all,
      filtered: filtered ?? this.filtered,
      selectedFilterStatus:
          selectedFilterStatus ?? this.selectedFilterStatus,
      filterStatusList: filterStatusList,
      selectedStatus: selectedStatus?? this.selectedStatus,
      selectedStatusList: selectedStatusList??this.selectedStatusList
    );
  }
}
