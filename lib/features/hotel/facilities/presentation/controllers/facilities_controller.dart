import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/facility_entity.dart';
import '../../domain/usecases/add_facility_usecase.dart';
import '../../domain/usecases/delete_facility_usecase.dart';
import '../../domain/usecases/update_facility_usecase.dart';
import '../../domain/usecases/watch_facilities_usecase.dart';
import '../states/facilities_state.dart';

class FacilitiesController extends StateNotifier<FacilitiesState> {
  final WatchFacilitiesUseCase watchFacilitiesUseCase;
  final AddFacilityUseCase addFacilityUseCase;
  final UpdateFacilityUseCase updateFacilityUseCase;
  final DeleteFacilityUseCase deleteFacilityUseCase;

  StreamSubscription<List<FacilityEntity>>? _subscription;

  FacilitiesController({
    required this.watchFacilitiesUseCase,
    required this.addFacilityUseCase,
    required this.updateFacilityUseCase,
    required this.deleteFacilityUseCase,
  }) : super(FacilitiesState.initial()) {
    _watchFacilities();
  }

  void _watchFacilities() {
    state = state.copyWith(isLoading: true);

    _subscription = watchFacilitiesUseCase().listen((facilities) {
      final filtered = _applyStatusFilter(
        facilities,
        state.selectedFilterStatus,
      );

      state = state.copyWith(
        facilities: filtered,
        isLoading: false,
      );
    });
  }

  // ---------------- Filters ----------------

  void changeFilterStatus(String status) {
    state = state.copyWith(selectedFilterStatus: status);
  }

  List<FacilityEntity> _applyStatusFilter(
    List<FacilityEntity> facilities,
    String status,
  ) {
    if (status == 'All') return facilities;
    return facilities.where((f) => f.status == status).toList();
  }

  // ---------------- Form ----------------

  void changeFormStatus(String status) {
    state = state.copyWith(selectedFormStatus: status);
  }

  void changeSelectedIcon(IconData icon) {
    state = state.copyWith(selectedIcon: icon);
  }

  void resetForm() {
    state = state.copyWith(
      selectedFormStatus: 'Active',
      selectedIcon: state.icons.first,
    );
  }

  // ---------------- CRUD ----------------

  Future<void> addFacility({
    required String name,
  }) async {
    final facility = FacilityEntity(
      name: name,
      status: state.selectedFormStatus,
      icon: state.selectedIcon,
    );

    await addFacilityUseCase(facility);
    resetForm();
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

    await updateFacilityUseCase(facility);
    resetForm();
  }

  Future<void> deleteFacility(int id) async {
    await deleteFacilityUseCase(id);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
