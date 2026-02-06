import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/room_type_entities.dart';
import '../../domain/usecases/Deleteroom_type_use_case.dart';
import '../../domain/usecases/add_room_type_use_case.dart';
import '../../domain/usecases/get_room_types_use_case.dart';
import '../../domain/usecases/update_room_type_usecase.dart';
import '../state/room_type_state.dart';


class RoomTypeController extends StateNotifier<RoomTypeState> {
  final GetRoomTypesUseCase getUseCase;
  final AddRoomTypeUseCase addUseCase;
  final UpdateRoomTypeUseCase updateUseCase;
  final DeleteRoomTypeUseCase deleteUseCase;

  RoomTypeController({
    required this.getUseCase,
    required this.addUseCase,
    required this.updateUseCase,
    required this.deleteUseCase,
  }) : super(RoomTypeState.initial()) {
    loadRoomTypes();
  }

  List<RoomTypeEntity> _allRoomTypes = [];

  // ---------------- Load ----------------

  Future<void> loadRoomTypes() async {
    state = state.copyWith(isLoading: true);
    final list = await getUseCase.call();
    _allRoomTypes = list;
    state = state.copyWith(roomTypes: list, isLoading: false);
  }

  // ---------------- CRUD ----------------

  Future<void> addRoomType(RoomTypeEntity entity) async {
    await addUseCase.call(entity);
    resetForm();
    loadRoomTypes();
  }

  Future<void> updateRoomType(RoomTypeEntity entity) async {
    await updateUseCase.call(entity);
    resetForm();
    loadRoomTypes();
  }

  Future<void> deleteRoomType(int id) async {
    await deleteUseCase.call(id);
    loadRoomTypes();
  }

  // ---------------- Form ----------------

  void toggleAmenity(int id) {
    final list = [...state.selectedAmenityIds];
    list.contains(id) ? list.remove(id) : list.add(id);
    state = state.copyWith(selectedAmenityIds: list);
  }

  void toggleFacility(int id) {
    final list = [...state.selectedFacilityIds];
    list.contains(id) ? list.remove(id) : list.add(id);
    state = state.copyWith(selectedFacilityIds: list);
  }

  void toggleBedType(int id) {
    final list = [...state.selectedBedTypeIds];
    list.contains(id) ? list.remove(id) : list.add(id);
    state = state.copyWith(selectedBedTypeIds: list);
  }

  void changeStatus(String status) {
    state = state.copyWith(status: status);
  }

  void resetForm() {
    state = state.copyWith(
      status: 'Active',
      selectedAmenityIds: [],
      selectedFacilityIds: [],
      selectedBedTypeIds: [],
    );
  }
}
