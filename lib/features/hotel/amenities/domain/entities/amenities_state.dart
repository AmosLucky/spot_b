import 'package:flutter/foundation.dart'; 
import 'package:flutter/material.dart';
import 'amenity_entity.dart';

@immutable
class AmenitiesState {
  final List<AmenityEntity> amenities;
  final bool isLoading;

  final List<String> amenityStatus;
  final List<IconData> amenityIcons;

  final String selectedAmenityStatus;
  final IconData selectedAmenityIcon;

  final String searchSelectedAmenityStatus; // ← new field

  const AmenitiesState({
    required this.amenities,
    required this.isLoading,
    required this.amenityStatus,
    required this.amenityIcons,
    required this.selectedAmenityStatus,
    required this.selectedAmenityIcon,
    required this.searchSelectedAmenityStatus, // ← required in constructor
  });

  factory AmenitiesState.initial() => AmenitiesState(
        amenities: const [],
        isLoading: false,
        amenityStatus: const ['All', 'Active', 'Inactive'],
        amenityIcons: const [
          Icons.star,
          Icons.bed,
          Icons.tv,
          Icons.wifi,
          Icons.ac_unit,
          Icons.check_circle,
          Icons.cancel,
        ],
        selectedAmenityStatus: 'Active',
        selectedAmenityIcon: Icons.star,
        searchSelectedAmenityStatus: 'All', // ← default value
      );

  AmenitiesState copyWith({
    List<AmenityEntity>? amenities,
    bool? isLoading,
    List<String>? amenityStatus,
    List<IconData>? amenityIcons,
    String? selectedAmenityStatus,
    IconData? selectedAmenityIcon,
    String? searchSelectedAmenityStatus, // ← add copyWith support
  }) {
    return AmenitiesState(
      amenities: amenities ?? this.amenities,
      isLoading: isLoading ?? this.isLoading,
      amenityStatus: amenityStatus ?? this.amenityStatus,
      amenityIcons: amenityIcons ?? this.amenityIcons,
      selectedAmenityStatus:
          selectedAmenityStatus ?? this.selectedAmenityStatus,
      selectedAmenityIcon:
          selectedAmenityIcon ?? this.selectedAmenityIcon,
      searchSelectedAmenityStatus:
          searchSelectedAmenityStatus ?? this.searchSelectedAmenityStatus,
    );
  }
}
