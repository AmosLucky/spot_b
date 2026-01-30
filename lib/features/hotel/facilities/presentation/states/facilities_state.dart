import 'package:flutter/material.dart';
import '../../domain/entities/facility_entity.dart';

@immutable
class FacilitiesState {
  // Data
  final List<FacilityEntity> facilities;
  final bool isLoading;

  // Filters (list screen)
  final List<String> filterStatusList;
  final String selectedFilterStatus;

  // Form (add / edit)
  final List<String> formStatusList;
  final String selectedFormStatus;

  // Icons
  final List<IconData> icons;
  final IconData selectedIcon;

  const FacilitiesState({
    required this.facilities,
    required this.isLoading,
    required this.filterStatusList,
    required this.selectedFilterStatus,
    required this.formStatusList,
    required this.selectedFormStatus,
    required this.icons,
    required this.selectedIcon,
  });

  factory FacilitiesState.initial() => FacilitiesState(
        facilities: const [],
        isLoading: false,

        // Filters
        filterStatusList: const ['All', 'Active', 'Inactive'],
        selectedFilterStatus: 'All',

        // Form
        formStatusList: const ['Active', 'Inactive'],
        selectedFormStatus: 'Active',

        // Icons
        icons: const [
          Icons.star,
          Icons.bed,
          Icons.tv,
          Icons.wifi,
          Icons.ac_unit,
        ],
        selectedIcon: Icons.star,
      );

  FacilitiesState copyWith({
    List<FacilityEntity>? facilities,
    bool? isLoading,
    String? selectedFilterStatus,
    String? selectedFormStatus,
    IconData? selectedIcon,
  }) {
    return FacilitiesState(
      facilities: facilities ?? this.facilities,
      isLoading: isLoading ?? this.isLoading,
      filterStatusList: filterStatusList,
      selectedFilterStatus:
          selectedFilterStatus ?? this.selectedFilterStatus,
      formStatusList: formStatusList,
      selectedFormStatus:
          selectedFormStatus ?? this.selectedFormStatus,
      icons: icons,
      selectedIcon: selectedIcon ?? this.selectedIcon,
    );
  }
}
