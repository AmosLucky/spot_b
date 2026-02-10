import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/facility_entity.dart';
import '../../domain/usecases/add_facility_usecase.dart';
import '../../domain/usecases/get_facilities_usecase.dart';
import '../../domain/usecases/update_facility_usecase.dart';
import '../../domain/usecases/delete_facility_usecase.dart';
import '../states/facilities_state.dart';

class FacilitiesController extends StateNotifier<FacilitiesState> {
  final GetFacilitiesUseCase getUseCase;
  final AddFacilityUseCase addUseCase;
  final UpdateFacilityUseCase updateUseCase;
  final DeleteFacilityUseCase deleteUseCase;

  FacilitiesController({
    required this.getUseCase,
    required this.addUseCase,
    required this.updateUseCase,
    required this.deleteUseCase,
  }) : super(FacilitiesState.initial()) {
    loadFacilities();
  }

  /// holds original list
  List<FacilityEntity> _allFacilities = [];

  /// search query
  String _searchQuery = '';

  // ---------------- Load ----------------

  Future<void> loadFacilities() async {
    state = state.copyWith(isLoading: true);

    final list = await getUseCase.execute();
    _allFacilities = list;

    state = state.copyWith(
      facilities: list,
      isLoading: false,
    );

    _applyFilters();
  }

  // ---------------- CRUD ----------------

  Future<void> addFacility(String name) async {
    final facility = FacilityEntity(
      name: name,
      status: state.selectedFormStatus,
      icon: state.selectedIcon,
    );

    await addUseCase.execute(facility);
    resetForm();
    loadFacilities();
  }

  Future<void> updateFacility({
    required int id,
    required String name,
  }) async {
    final facility = FacilityEntity(
      id: id,
      name: name,
      status: state.selectedFormStatus,
      icon: state.selectedIcon,
    );

    await updateUseCase.execute(facility);
    resetForm();
    loadFacilities();
  }

  Future<void> deleteFacility(int id) async {
    await deleteUseCase.execute(id);
    loadFacilities();
  }

  // ---------------- Filters ----------------

  void changeSearchStatus(String status) {
    // state = state.copyWith(searchSelectedStatus: status);
    List<FacilityEntity> filteredFacilities;

    if (status == 'All') {
      filteredFacilities = _allFacilities; // always use full list
    } else {
      filteredFacilities =
          _allFacilities.where((a) => a.status == status).toList();
    }

    state = state.copyWith(
      selectedFilterStatus: status,
      facilities: filteredFacilities,
    );
    _applyFilters();
  }


  void filterByName(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void _applyFilters() {
    List<FacilityEntity> filtered = _allFacilities;

    // status filter
    if (state.selectedFilterStatus != 'All') {
      filtered = filtered
          .where((f) => f.status == state.selectedFilterStatus)
          .toList();
    }

    // search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
              (f) => f.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    state = state.copyWith(facilities: filtered);
  }

  // ---------------- Form ----------------

  void changeFormStatus(String status) {
    state = state.copyWith(selectedFormStatus: status);
  }

  void changeSelectedIcon(IconData icon) {
    state = state.copyWith(selectedIcon: icon);
  }

  void initForm(FacilityEntity facility) {
  state = state.copyWith(
    selectedFormStatus: facility.status,
    selectedIcon: facility.icon,
  );
}


  void resetForm() {
    state = state.copyWith(
      selectedFormStatus: 'Active',
      selectedIcon: state.icons.first,
    );
  }
}





// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../domain/entities/facility_entity.dart';
// import '../../domain/usecases/add_facility_usecase.dart';
// import '../../domain/usecases/delete_facility_usecase.dart';
// import '../../domain/usecases/update_facility_usecase.dart';
// import '../../domain/usecases/watch_facilities_usecase.dart';
// import '../states/facilities_state.dart';

// class FacilitiesController extends StateNotifier<FacilitiesState> {
//   final WatchFacilitiesUseCase watchFacilitiesUseCase;
//   final AddFacilityUseCase addFacilityUseCase;
//   final UpdateFacilityUseCase updateFacilityUseCase;
//   final DeleteFacilityUseCase deleteFacilityUseCase;

//   StreamSubscription<List<FacilityEntity>>? _subscription;

//   FacilitiesController({
//     required this.watchFacilitiesUseCase,
//     required this.addFacilityUseCase,
//     required this.updateFacilityUseCase,
//     required this.deleteFacilityUseCase,
//   }) : super(FacilitiesState.initial()) {
//     _watchFacilities();
//   }

//   List<FacilityEntity> _allFacilities = [];

//   void _watchFacilities() {
//     state = state.copyWith(isLoading: true);

//     _subscription = watchFacilitiesUseCase().listen((facilities) {
//       final filtered = _applyStatusFilter(
//         facilities,
//         state.selectedFilterStatus,
//       );

//       state = state.copyWith(
//         facilities: filtered,
//         isLoading: false,
//       );
//     });
//   }

//   // ---------------- Filters ----------------

//   void changeFilterStatus(String status) {
//     state = state.copyWith(selectedFilterStatus: status);
//   }

//   List<FacilityEntity> _applyStatusFilter(
//     List<FacilityEntity> facilities,
//     String status,
//   ) {
//     if (status == 'All') return facilities;
//     return facilities.where((f) => f.status == status).toList();
//   }

//   // ---------------- Form ----------------

//   void changeFormStatus(String status) {
//     state = state.copyWith(selectedFormStatus: status);
//   }

//   void changeSelectedIcon(IconData icon) {
//     state = state.copyWith(selectedIcon: icon);
//   }

//   void resetForm() {
//     state = state.copyWith(
//       selectedFormStatus: 'Active',
//       selectedIcon: state.icons.first,
//     );
//   }

//   // ---------------- CRUD ----------------

//   Future<void> addFacility({
//     required String name,
//   }) async {
//     final facility = FacilityEntity(
//       name: name,
//       status: state.selectedFormStatus,
//       icon: state.selectedIcon,
//     );

//     await addFacilityUseCase(facility);
//     resetForm();
//   }


//   void changeSearchAmenityStatus(String status) {
//     List<FacilityEntity> filteredFacilities;

//     if (status == 'All') {
//       filteredFacilities = _allFacilities; // always use full list
//     } else {
//       filteredFacilities =
//           _allFacilities.where((a) => a.status == status).toList();
//     }

//     state = state.copyWith(
//       searchSelectedAmenityStatus: status,
//       facilities: filteredFacilities,
//     );
//   }

//   Future<void> updateFacility({
//     required int id,
//     required String name,
//   }) async {
//     final facility = FacilityEntity(
//       id: id,
//       name: name,
//       status: state.selectedFormStatus,
//       icon: state.selectedIcon,
//     );

//     await updateFacilityUseCase(facility);
//     resetForm();
//   }

//   Future<void> deleteFacility(int id) async {
//     await deleteFacilityUseCase(id);
//   }

//   @override
//   void dispose() {
//     _subscription?.cancel();
//     super.dispose();
//   }
// }
