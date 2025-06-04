import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/data/repository/system_repo.dart';

class MarkDirtyRoomProvider with ChangeNotifier {
  int roomsUnderMaintenance = 0;
  int dirtyRooms = 0;
  int overdueMaintenance = 0;
  int totalRooms = 0;

  String? selectedRoomType;
  String? selectedRoom;
  String? cleaningNote;
  DateTime? expectedCleaningDate;

  List<String> roomTypes = [];
  List<MaintenanceRoom> allRooms = []; // Added to store all rooms
  List<MaintenanceRoom> dirtyRoomsList = [];
  bool isLoading = false;
  String? error;

    bool _isDialogVisible = false;

  bool get isDialogVisible => _isDialogVisible;

  double get maintenanceRate {
    if (totalRooms == 0) return 0.0;
    return (roomsUnderMaintenance / totalRooms) * 100;
  }

  final SystemRepo _systemRepo;

  MarkDirtyRoomProvider(this._systemRepo);

  Future<void> fetchMaintenanceRooms({bool refresh = false}) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response =
          await _systemRepo.fetchMaintenanceRoomTypesAPI(refresh: refresh);

      // Parse room data
      final roomsData = (response.data['rooms']['data'] as List)
          .map((json) => MaintenanceRoom.fromJson(json))
          .toList();

      // Store all rooms
      allRooms = roomsData;

      // Get all possible room types from both dedicated array and actual rooms
      final roomTypesFromResponse = (response.data['room_types'] as List)
          .map((type) => type['name'] as String)
          .toList();

      final roomsTypesFromData = roomsData
          .map((room) => room.roomTypeName)
          .whereType<String>()
          .toSet()
          .toList();

      roomTypes =
          [...roomTypesFromResponse, ...roomsTypesFromData].toSet().toList();

      // Update counts based on status
      dirtyRoomsList =
          roomsData.where((room) => room.status == 'dirty').toList();
      roomsUnderMaintenance =
          roomsData.where((room) => room.status == 'maintenance').length;
      dirtyRooms = dirtyRoomsList.length;
      totalRooms = response.data['stats']['total_rooms'] ?? roomsData.length;

      // Check for overdue maintenance
      final now = DateTime.now();
      overdueMaintenance = roomsData.where((room) {
        return room.maintenanceExpectedEndDate != null &&
            room.maintenanceExpectedEndDate!.isBefore(now);
      }).length;
    } on DioException catch (e) {
      error = 'Failed to load rooms: ${e.message}';
    } catch (e) {
      error = 'Unexpected error: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

// In MarkDirtyRoomProvider's markRoomAsDirty method:
  Future<void> markRoomAsDirty() async {
    if (selectedRoom == null) {
      error = 'Please select a room';
      notifyListeners();
      return;
    }

    // Extract room ID from the selected room number
    final selectedRoomData = allRooms.firstWhere(
      (room) => room.roomNumber == selectedRoom,
      orElse: () => throw Exception('Selected room not found'),
    );

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      await _systemRepo.markRoomAsDirty(
        roomId: selectedRoomData.id,
        maintenanceNote: cleaningNote ?? '',
        expectedEndDate: expectedCleaningDate,
      );

      // Update local state
      dirtyRooms++;
      dirtyRoomsList.add(selectedRoomData);

      // Reset form
      selectedRoomType = null;
      selectedRoom = null;
      cleaningNote = null;
      expectedCleaningDate = null;

      // Refresh data
      await fetchMaintenanceRooms(refresh: true);
    } on Exception catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Future<void> makeRoomAvailable(int roomId) async {
  //   try {
  //     await _systemRepo.makeRoomAvailable(roomId);
  //     await fetchMaintenanceRooms(refresh: true);
  //   } catch (e) {
  //     error = 'Failed to make room available: $e';
  //     notifyListeners();
  //   }
  // }

  void setRoomForMaintenance() {
    roomsUnderMaintenance++;
    totalRooms++;
    notifyListeners();
  }
  void showDialogBox() {
    _isDialogVisible = true;
    notifyListeners();
  }

    void hideDialogBox() {
    _isDialogVisible = false;
    notifyListeners();
  }

    void makeRoomAvailable() {
    // TODO: Add your API call or room availability logic
    _isDialogVisible = false;
    notifyListeners();
  }
  void resetFilters() {
    // Implement filter reset logic here if needed
    selectedRoomType = null;
    selectedRoom = null;
    cleaningNote = null;
    expectedCleaningDate = null;
    error = null;
    notifyListeners();
  }
}
