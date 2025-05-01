import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/data/repository/system_repo.dart';

class MarkRoomForMaintenanceProvider extends ChangeNotifier {
  int roomsUnderMaintenance = 0;
  int dirtyRooms = 0;
  int overdueMaintenance = 0;
  int totalRooms = 0;

  String? selectedRoomType;
  String? selectedRoom;
  String cleaningNote = '';
  DateTime? expectedCleaningDate;

  List<String> roomTypes = [];
  List<MaintenanceRoom> allRooms = []; // Added to store all rooms
  List<MaintenanceRoom> maintenanceRoomList = [];
  bool isLoading = false;
  String? error;

  final SystemRepo _systemRepo;

  MarkRoomForMaintenanceProvider(this._systemRepo);

  Future<void> fetchMaintenanceRooms({bool refresh = false}) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response =
          await _systemRepo.fetchMaintenanceRoomTypesAPI(refresh: refresh);
      final roomsData = (response.data['rooms']['data'] as List)
          .map((json) => MaintenanceRoom.fromJson(json))
          .toList();

      allRooms = roomsData;
      maintenanceRoomList =
          roomsData.where((room) => room.status == 'dirty').toList();

      // Update counts based on status
      // Update counts based on status
      roomsUnderMaintenance =
          roomsData.where((room) => room.status == 'maintenance').length;
      dirtyRooms = maintenanceRoomList.length;
      totalRooms = roomsData.length;

      // Extract unique room types
      roomTypes = roomsData
          .map((room) => room.roomTypeName)
          .whereType<String>()
          .toSet()
          .toList();

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

//  MarkDirtyRoomProvider's markRoomAsDirty method:
  Future<void> setRoomForMaintain() async {
    if (selectedRoom == null) {
      error = 'Please select a room';
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      // Safely extract room ID - handles both "Type Room 101" and "101" formats
      final roomIdString = selectedRoom!.split(' ').last;
      final roomId = int.tryParse(roomIdString);

      if (roomId == null) {
        throw Exception('Invalid room number format');
      }

 
      await _systemRepo.setRoomForMaintain(
        roomId: roomId,
        maintenanceNote: cleaningNote ?? '',
        expectedEndDate: expectedCleaningDate,
      );

      // Update local state
      dirtyRooms++;
      notifyListeners();

      await fetchMaintenanceRooms(refresh: true);
    } on DioException catch (e) {
      error =
          'Failed to mark room: ${e.response?.data['message'] ?? e.message}';
    } catch (e) {
      error = 'Error: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


   Future<void> makeRoomAvailable(int roomId) async {
    try {
      await _systemRepo.makeRoomAvailable(roomId);
      await fetchMaintenanceRooms(refresh: true);
    } catch (e) {
      error = 'Failed to make room available: $e';
      notifyListeners();
    }
  }

  void setRoomType(String value) {
    selectedRoomType = value;
    selectedRoom = null; // Reset room when type changes
    notifyListeners();
  }

  void setRoom(String value) {
    selectedRoom = value;
    notifyListeners();
  }

  void setCleaningNote(String value) {
    cleaningNote = value;
    notifyListeners();
  }

  void setExpectedCleaningDate(DateTime date) {
    expectedCleaningDate = date;
    notifyListeners();
  }

  void clearAll() {
    selectedRoomType = null;
    selectedRoom = null;
    cleaningNote = '';
    expectedCleaningDate = null;
    notifyListeners();
  }
}
