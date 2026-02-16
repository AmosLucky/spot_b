import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/room_entity.dart';
import '../../domain/repositories/room_repository.dart';
import '../state/room_state.dart';

class RoomController extends StateNotifier<RoomState> {
  final RoomRepository repository;

  RoomController(this.repository) : super(const RoomState()) {
    _init();
  }

  void _init() {
    state = state.copyWith(isLoading: true);

    repository.watchRooms().listen((rooms) {
      state = state.copyWith(
        isLoading: false,
        all: rooms,
        filtered: _applySearch(rooms, state.searchQuery),
      );
    });
  }

  void getRooms() async{
   state = state.copyWith(isLoading: true);
    final list = await repository.getAllRooms();
   
    state = state.copyWith(all: list, isLoading: false);
  }

  // ---------------- CRUD ----------------

  Future<void> addRooms({
    required List<String> roomNumbers,
    required int roomTypeId,
    required String status,
  }) async {
    for (final number in roomNumbers) {
      await repository.addRoom(
        RoomEntity(
            roomNumber: number,
            roomTypeId: roomTypeId,
            status: status,
            bookingStatus: "available"),
      );
    }
  }

  Future<void> deleteRoom(int id) {
    return repository.deleteRoom(id);
  }

  // ---------------- SEARCH ----------------

  void search(String query) {
    state = state.copyWith(
      searchQuery: query,
      filtered: _applySearch(state.all, query),
    );
  }

  List<RoomEntity> _applySearch(List<RoomEntity> list, String query) {
    if (query.isEmpty) return list;

    return list
        .where(
          (r) => r.roomNumber.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  Future<void> updateRoom(RoomEntity room) {
    return repository.updateRoomStatus(room.id!, room.status);
  }

  void setSelectedFilter(selectedFilter) {
    state = state.copyWith(selectedFilter: selectedFilter);
  }
}
