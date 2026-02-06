import 'package:flutter/material.dart';
import '../../domain/entities/bed_type.dart';

class BedTypesState {
  final bool isLoading;
  final List<BedType> bedTypes;
  final String searchQuery;
  final String selectedFilter;

  BedTypesState({
    required this.isLoading,
    required this.bedTypes,
    required this.searchQuery,
    required this.selectedFilter,
  });

  factory BedTypesState.initial() {
    return BedTypesState(
      isLoading: false,
      bedTypes: [],
      searchQuery: '',
      selectedFilter: 'All',
    );
  }

  BedTypesState copyWith({
    bool? isLoading,
    List<BedType>? bedTypes,
    String? searchQuery,
    String? selectedFilter,
  }) {
    return BedTypesState(
      isLoading: isLoading ?? this.isLoading,
      bedTypes: bedTypes ?? this.bedTypes,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }
}
