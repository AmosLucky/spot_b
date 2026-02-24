import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/amenity_entity.dart';
import '../../domain/entities/amenities_state.dart';
import '../../domain/usecases/add_amenity_usecase.dart';
import '../../domain/usecases/get_amenities_usecase.dart';
import '../../domain/usecases/update_amenity_usecase.dart';
import '../../domain/usecases/delete_amenity_usecase.dart';

class AmenitiesController extends StateNotifier<AmenitiesState> {
  final GetAmenitiesUseCase getUseCase;
  final AddAmenityUseCase addUseCase;
  final UpdateAmenityUseCase updateUseCase;
  final DeleteAmenityUseCase deleteUseCase;

  AmenitiesController({
    required this.getUseCase,
    required this.addUseCase,
    required this.updateUseCase,
    required this.deleteUseCase,
  }) : super(AmenitiesState.initial()) {
    loadAmenities();
  }
  List<AmenityEntity> _allAmenities = [];
  // store current search query
  String _searchQuery = '';

  void loadAmenities() async {
    state = state.copyWith(isLoading: true);
    final list = await getUseCase.execute();
    _allAmenities = list;
    state = state.copyWith(amenities: list, isLoading: false);
    _applyFilters(); // apply search + status
  }

  Stream<List<AmenityEntity>> watchAmenities() {
    return getUseCase.watch();
  }

  Future<void> addAmenity(AmenityEntity amenity) async {
    await addUseCase.execute(amenity);
    loadAmenities();
  }

  Future<void> updateAmenity(AmenityEntity amenity) async {
    await updateUseCase.execute(amenity);
    loadAmenities();
  }

  Future<void> deleteAmenity(int id) async {
    await deleteUseCase.execute(id);
    loadAmenities();
  }

  void changeAmenityStatus(String status) {
    // final index = state.amenityStatus.indexOf(status);

    // if (index == -1) return;

    state = state.copyWith(
      selectedAmenityStatus: status,
      //selectedAmenityIcon: state.amenityIcons[index],
    );
  }

  //  void changeSearchAmenityStatus(String status) {
  //   // final index = state.amenityStatus.indexOf(status);

  //   // if (index == -1) return;

  //   state = state.copyWith(
  //     searchSelectedAmenityStatus: status,
  //     //selectedAmenityIcon: state.amenityIcons[index],
  //   );
  // }

  void changeAmenityIcon(IconData icon) {
    //print(icon);
    // final index = state.amenityIcons.indexOf(icon);

    //if (index == -1) return;

    state = state.copyWith(
        //selectedAmenityStatus: icon,
        selectedAmenityIcon: icon //state.amenityIcons[index],
        );
  }

  void changeSearchAmenityStatus(String status) {
    List<AmenityEntity> filteredAmenities;

    if (status == 'All') {
      filteredAmenities = _allAmenities; // always use full list
    } else {
      filteredAmenities =
          _allAmenities.where((a) => a.status == status).toList();
    }

    state = state.copyWith(
      searchSelectedAmenityStatus: status,
      amenities: filteredAmenities,
    );
  }


  //private: apply search + status filters
  void _applyFilters() {
    List<AmenityEntity> filtered = _allAmenities;

    // filter by status
    if (state.searchSelectedAmenityStatus != 'All') {
      filtered = filtered
          .where((a) => a.status == state.searchSelectedAmenityStatus)
          .toList();
    }

    // filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((a) =>
              a.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    state = state.copyWith(amenities: filtered);
  }



  // method to filter by search query
  void filterByTitle(String query) {
    _searchQuery = query;
    _applyFilters();
  }

}
