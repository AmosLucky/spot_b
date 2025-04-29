import 'package:flutter/material.dart';

class MaintenanceProvider with ChangeNotifier {
  int roomsUnderMaintenance = 0;
  int dirtyRooms = 0;
  int overdueMaintenance = 0;
  int totalRooms = 0;

  double get maintenanceRate {
    if (totalRooms == 0) return 0.0;
    return (roomsUnderMaintenance / totalRooms) * 100;
  }

  void markRoomAsDirty() {
    dirtyRooms++;
    notifyListeners();
  }

  void setRoomForMaintenance() {
    roomsUnderMaintenance++;
    totalRooms++;
    notifyListeners();
  }

  void resetFilters() {
    // Implement filter reset logic here if needed
    notifyListeners();
  }
}


class MarkRoomDirtyProvider extends ChangeNotifier {
  String? selectedRoomType;
  String? selectedRoom;
  String cleaningNote = '';
  DateTime? expectedCleaningDate;

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