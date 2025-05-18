import 'package:flutter/foundation.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';

class AttendantModel {
  final String id;
  final String name;
  final String department;
  final bool hasPinSet;
  final String? pin;

  AttendantModel({
    required this.id,
    required this.name,
    required this.department,
    required this.hasPinSet,
    this.pin,
  });

  factory AttendantModel.fromJson(Map<String, dynamic> json) {
    return AttendantModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      department: json['department'] ?? '',
      hasPinSet: json['pin_set'] == true || json['pin'] != null,
      pin: json['pin'],
    );
  }
}

class AttendantProvider extends ChangeNotifier {
  List<AttendantModel> _attendants = [];
  List<AttendantModel> _filteredAttendants = [];
  AttendantModel? _selectedAttendant;
  bool _isLoading = false;
  String _searchQuery = '';

  List<AttendantModel> get attendants => _filteredAttendants;
  AttendantModel? get selectedAttendant => _selectedAttendant;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  // Method to load attendants from your system provider
  Future<void> loadAttendants(SystemProvider systemProvider) async {
    try {
      _isLoading = true;
      notifyListeners();

      var response = await systemProvider.getAttendants();
      _attendants = response
          .map<AttendantModel>((attendant) =>
                  AttendantModel.fromJson(attendant) // Remove the cast here
              )
          .toList();

      _filteredAttendants = List.from(_attendants);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error loading attendants: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  // Search attendants
  void searchAttendants(String query) {
    _searchQuery = query;

    if (query.isEmpty) {
      _filteredAttendants = List.from(_attendants);
    } else {
      _filteredAttendants = _attendants
          .where((attendant) =>
              attendant.name.toLowerCase().contains(query.toLowerCase()) ||
              attendant.department.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    notifyListeners();
  }

  // Select an attendant
  void selectAttendant(AttendantModel attendant) {
    _selectedAttendant = attendant;
    notifyListeners();
  }

  // Clear selected attendant
  void clearSelectedAttendant() {
    _selectedAttendant = null;
    notifyListeners();
  }

  // Verify attendant PIN
  Future<bool> verifyAttendantPin(String enteredPin) async {
    if (_selectedAttendant == null) return false;

    try {
      // In a real app, you'd verify this against your backend
      // For now, we'll just check if the PIN matches the stored PIN
      return _selectedAttendant!.pin == enteredPin ||
          enteredPin == "1234"; // Default PIN for demo
    } catch (e) {
      print('Error verifying PIN: $e');
      return false;
    }
  }

  // Reset search
  void resetSearch() {
    _searchQuery = '';
    _filteredAttendants = List.from(_attendants);
    notifyListeners();
  }
}
