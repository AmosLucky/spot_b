import 'package:flutter/material.dart';
// import 'package:spotstock_inventory/screens/desktop/services/enhanced_select_attendant_service.dart';
// import 'package:spotstock_inventory/services/offline_pin_service.dart';
import '../model/select_attendant_model.dart';
import '../services/offline_pin_service.dart';
import '../services/select_attendant_service.dart';
// import '../services/select_attendant_service.dart';

class SelectAttendantProvider with ChangeNotifier {
  List<SelectAttendantModel> _attendants = [];
  List<SelectAttendantModel> _filteredAttendants = [];
  bool _isLoading = false;
  String? _errorMessage;
  SelectAttendantModel? _selectedAttendant;
  
  final SelectAttendantService _attendantService = SelectAttendantService();
  final OfflinePinService _offlinePinService = OfflinePinService();

  List<SelectAttendantModel> get attendants => _filteredAttendants;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  SelectAttendantModel? get selectedAttendant => _selectedAttendant;

  Future<void> loadAttendants() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _attendants = await _attendantService.getAttendants();
      _filteredAttendants = _attendants;
      
      // Sync offline data in background
      _attendantService.syncOfflineData();
    } catch (e) {
      _errorMessage = e.toString();
      _attendants = [];
      _filteredAttendants = [];
      print('Error loading attendants: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchAttendants(String query) {
    if (query.isEmpty) {
      _filteredAttendants = _attendants;
    } else {
      _filteredAttendants = _attendants.where((attendant) =>
          attendant.fullName.toLowerCase().contains(query.toLowerCase()) ||
          attendant.department.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }

  void selectAttendant(SelectAttendantModel? attendant) {
    _selectedAttendant = attendant;
    notifyListeners();
  }

  Future<Map<String, dynamic>> verifyPin(int attendantId, String pin) async {
    try {
      final response = await _attendantService.verifyPin(attendantId, pin);
      return response;
    } catch (e) {
      return {
        'success': false,
        'message': 'Error verifying PIN: $e'
      };
    }
  }

  Future<bool> createPin(int attendantId, String pin) async {
    try {
      return await _attendantService.createPin(attendantId, pin);
    } catch (e) {
      print('Error creating PIN: $e');
      return false;
    }
  }

  /// Check if attendant has offline PIN
  Future<bool> hasOfflinePin(int attendantId) async {
    return await _offlinePinService.hasOfflinePin(attendantId);
  }

  /// Get offline PIN status for display
  Future<String> getPinStatus(int attendantId) async {
    final hasOffline = await _offlinePinService.hasOfflinePin(attendantId);
    if (hasOffline) {
      return 'PIN available offline';
    }
    return 'PIN requires internet';
  }

  @override
  void dispose() {
    super.dispose();
  }
}




// import 'package:flutter/material.dart';
// import 'package:spotstock_inventory/screens/desktop/services/select_attendant_service.dart';
// import '../model/select_attendant_model.dart';

// class SelectAttendantProvider with ChangeNotifier {
//   List<SelectAttendantModel> _attendants = [];
//   List<SelectAttendantModel> _filteredAttendants = [];
//   bool _isLoading = false;
//   String? _errorMessage;
//   SelectAttendantModel? _selectedAttendant;
//   final SelectAttendantService _attendantService = SelectAttendantService();

//   List<SelectAttendantModel> get attendants => _filteredAttendants;
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   SelectAttendantModel? get selectedAttendant => _selectedAttendant;

//   Future<void> loadAttendants() async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     try {
//       _attendants = await _attendantService.getAttendants();
//       _filteredAttendants = _attendants;
//     } catch (e) {
//       _errorMessage = e.toString();
//       _attendants = [];
//       _filteredAttendants = [];
//       print('Error loading attendants: $e');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   void searchAttendants(String query) {
//     if (query.isEmpty) {
//       _filteredAttendants = _attendants;
//     } else {
//       _filteredAttendants = _attendants.where((attendant) =>
//           attendant.fullName.toLowerCase().contains(query.toLowerCase()) ||
//           attendant.department.toLowerCase().contains(query.toLowerCase())
//       ).toList();
//     }
//     notifyListeners();
//   }

//   void selectAttendant(SelectAttendantModel? attendant) {
//     _selectedAttendant = attendant;
//     notifyListeners();
//   }

//   Future<Map<String, dynamic>> verifyPin(int attendantId, String pin) async {
//     try {
//       final response = await _attendantService.verifyPin(attendantId, pin);
//       return response;
//     } catch (e) {
//       return {
//         'success': false,
//         'message': 'Error verifying PIN: $e'
//       };
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }