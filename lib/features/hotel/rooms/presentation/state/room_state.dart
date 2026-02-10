import '../../domain/entities/room_entity.dart';

import 'package:equatable/equatable.dart';


class RoomState extends Equatable {
  final bool isLoading;
  final List<RoomEntity> all;
  final List<RoomEntity> filtered;
  final String searchQuery;
  final String selectedFilter;

  /// Separate field for global active toggle
  final bool isActive;

  const RoomState({
    this.isLoading = false,
    this.all = const [],
    this.filtered = const [],
    this.searchQuery = '',
    this.selectedFilter = "All",
    this.isActive = true, // default true
  });

  RoomState copyWith({
    bool? isLoading,
    List<RoomEntity>? all,
    List<RoomEntity>? filtered,
    String? searchQuery,
    String? selectedFilter,
    bool? isActive,
  }) {
    return RoomState(
      isLoading: isLoading ?? this.isLoading,
      all: all ?? this.all,
      filtered: filtered ?? this.filtered,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, all, filtered, searchQuery, selectedFilter, isActive];
}
