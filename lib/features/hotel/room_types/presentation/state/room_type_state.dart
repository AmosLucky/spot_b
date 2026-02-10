import '../../domain/entities/room_type_entities.dart';

class RoomTypeState {
  final List<RoomTypeEntity> roomTypes;
  final bool isLoading;

  // form fields
  final String status;

  // multi selections (IDs)
  final List<int> selectedAmenityIds;
  final List<int> selectedFacilityIds;
  final List<int> selectedBedTypeIds;

  // NEW: separate toggle field
  final bool isActive;

  RoomTypeState({
    required this.roomTypes,
    required this.isLoading,
    required this.status,
    required this.selectedAmenityIds,
    required this.selectedFacilityIds,
    required this.selectedBedTypeIds,
    this.isActive = true, // default true
  });

  factory RoomTypeState.initial() {
    return RoomTypeState(
      roomTypes: [],
      isLoading: false,
      status: 'Active',
      selectedAmenityIds: [],
      selectedFacilityIds: [],
      selectedBedTypeIds: [],
      isActive: true,
    );
  }

  RoomTypeState copyWith({
    List<RoomTypeEntity>? roomTypes,
    bool? isLoading,
    String? status,
    List<int>? selectedAmenityIds,
    List<int>? selectedFacilityIds,
    List<int>? selectedBedTypeIds,
    bool? isActive, // include in copyWith
  }) {
    return RoomTypeState(
      roomTypes: roomTypes ?? this.roomTypes,
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      selectedAmenityIds: selectedAmenityIds ?? this.selectedAmenityIds,
      selectedFacilityIds: selectedFacilityIds ?? this.selectedFacilityIds,
      selectedBedTypeIds: selectedBedTypeIds ?? this.selectedBedTypeIds,
      isActive: isActive ?? this.isActive,
    );
  }
}
