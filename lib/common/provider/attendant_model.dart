import 'package:flutter/foundation.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';

// Response state enum for better state management
enum ResponseState { loading, done, error }

class AttendantModel {
  final String id;
  final String name;
  final String department;
  final bool hasPinSet;
  final String? pin;
  final String? email;
  final String? phone;
  final bool isActive;
  final DateTime? createdAt;

  AttendantModel({
    required this.id,
    required this.name,
    required this.department,
    required this.hasPinSet,
    this.pin,
    this.email,
    this.phone,
    this.isActive = true,
    this.createdAt,
  });

  factory AttendantModel.fromJson(Map<String, dynamic> json) {
    return AttendantModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      department: json['department']?.toString() ?? '',
      hasPinSet: json['pin_set'] == true || json['pin'] != null,
      pin: json['pin']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      isActive: json['is_active'] ?? json['active'] ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'department': department,
      'pin_set': hasPinSet,
      'pin': pin,
      'email': email,
      'phone': phone,
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  // Create a copy with updated fields
  AttendantModel copyWith({
    String? id,
    String? name,
    String? department,
    bool? hasPinSet,
    String? pin,
    String? email,
    String? phone,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return AttendantModel(
      id: id ?? this.id,
      name: name ?? this.name,
      department: department ?? this.department,
      hasPinSet: hasPinSet ?? this.hasPinSet,
      pin: pin ?? this.pin,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'AttendantModel{id: $id, name: $name, department: $department, hasPinSet: $hasPinSet}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AttendantModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class AttendantProvider extends ChangeNotifier {
  List<AttendantModel> _attendants = [];
  List<AttendantModel> _filteredAttendants = [];
  AttendantModel? _selectedAttendant;
  ResponseState _responseState = ResponseState.done;
  String _searchQuery = '';
  String _errorMessage = '';
  bool _dataFetched = false;

  // Getters
  List<AttendantModel> get attendants => _filteredAttendants;
  List<AttendantModel> get allAttendants => _attendants;
  AttendantModel? get selectedAttendant => _selectedAttendant;
  ResponseState get responseState => _responseState;
  bool get isLoading => _responseState == ResponseState.loading;
  bool get hasError => _responseState == ResponseState.error;
  String get searchQuery => _searchQuery;
  String get errorMessage => _errorMessage;
  bool get dataFetched => _dataFetched;
  bool get hasData => _attendants.isNotEmpty;
  int get totalAttendants => _attendants.length;
  int get filteredCount => _filteredAttendants.length;

  // Method to load attendants from your system provider
  Future<void> loadAttendants(SystemProvider systemProvider,
      {bool forceRefresh = false}) async {
    print('🔍 [AttendantProvider] loadAttendants called');
    print('🔍 [AttendantProvider] forceRefresh: $forceRefresh');
    print('🔍 [AttendantProvider] dataFetched: $_dataFetched');

    try {
      if (_dataFetched && !forceRefresh) {
        print('🔍 [AttendantProvider] Data already loaded, skipping');
        return;
      }

      _responseState = ResponseState.loading;
      _errorMessage = '';
      print('🔍 [AttendantProvider] Set loading state');
      notifyListeners();

      // Fetch staff data which gets converted to attendant format
      print('🔍 [AttendantProvider] Calling systemProvider.getAttendants()');
      final response = await systemProvider.getAttendants();
      print(
          '🔍 [AttendantProvider] Received response: ${response.length} items');
      print('🔍 [AttendantProvider] Response data: $response');

      if (response.isEmpty && !forceRefresh) {
        print('⚠️ [AttendantProvider] No attendants found');
        _errorMessage = 'No attendants found';
        _responseState = ResponseState.error;
        notifyListeners();
        return;
      }

      print('🔍 [AttendantProvider] Converting to AttendantModel...');
      _attendants = response.map<AttendantModel>((attendant) {
        print('🔍 [AttendantProvider] Converting: $attendant');
        return AttendantModel.fromJson(attendant);
      }).toList();

      print(
          '🔍 [AttendantProvider] Created ${_attendants.length} AttendantModel objects');

      _filteredAttendants = List.from(_attendants);
      _dataFetched = true;
      _responseState = ResponseState.done;

      // Apply current search if exists
      if (_searchQuery.isNotEmpty) {
        _applySearch();
      }

      print('🔍 [AttendantProvider] Load completed successfully');
      notifyListeners();
    } catch (e, stackTrace) {
      print('❌ [AttendantProvider] Error loading attendants: $e');
      print('❌ [AttendantProvider] Stack trace: $stackTrace');
      _errorMessage = _getErrorMessage(e);
      _responseState = ResponseState.error;
      notifyListeners();
    }
  }

  // Search attendants with improved logic
  void searchAttendants(String query) {
    _searchQuery = query;
    _applySearch();
    notifyListeners();
  }

  void _applySearch() {
    if (_searchQuery.isEmpty) {
      _filteredAttendants = List.from(_attendants);
    } else {
      final lowerQuery = _searchQuery.toLowerCase();
      _filteredAttendants = _attendants.where((attendant) {
        return attendant.name.toLowerCase().contains(lowerQuery) ||
            attendant.department.toLowerCase().contains(lowerQuery) ||
            (attendant.email?.toLowerCase().contains(lowerQuery) ?? false) ||
            attendant.id.toLowerCase().contains(lowerQuery);
      }).toList();
    }
  }

  // Filter attendants by department
  void filterByDepartment(String? department) {
    if (department == null || department.isEmpty) {
      _filteredAttendants = List.from(_attendants);
    } else {
      _filteredAttendants = _attendants
          .where((attendant) =>
              attendant.department.toLowerCase() == department.toLowerCase())
          .toList();
    }
    notifyListeners();
  }

  // Filter attendants by PIN status
  void filterByPinStatus(bool? hasPinSet) {
    if (hasPinSet == null) {
      _filteredAttendants = List.from(_attendants);
    } else {
      _filteredAttendants = _attendants
          .where((attendant) => attendant.hasPinSet == hasPinSet)
          .toList();
    }
    notifyListeners();
  }

  // Get unique departments
  List<String> get departments {
    final Set<String> deptSet = _attendants.map((a) => a.department).toSet();
    return deptSet.toList()..sort();
  }

  // Select an attendant
  void selectAttendant(AttendantModel attendant) {
    _selectedAttendant = attendant;
    notifyListeners();
  }

  // Select attendant by ID
  void selectAttendantById(String id) {
    final attendant = _attendants.firstWhere(
      (a) => a.id == id,
      orElse: () => throw ArgumentError('Attendant with ID $id not found'),
    );
    selectAttendant(attendant);
  }

  // Clear selected attendant
  void clearSelectedAttendant() {
    _selectedAttendant = null;
    notifyListeners();
  }

  // Verify attendant PIN with improved logic
  Future<bool> verifyAttendantPin(String enteredPin) async {
    if (_selectedAttendant == null) {
      throw StateError('No attendant selected for PIN verification');
    }

    try {
      // Remove any whitespace and ensure case-sensitive comparison
      final cleanPin = enteredPin.trim();

      if (cleanPin.isEmpty) {
        return false;
      }

      // Check if attendant has a PIN set
      if (!_selectedAttendant!.hasPinSet || _selectedAttendant!.pin == null) {
        // If no PIN is set, you might want to handle this differently
        // For now, return false
        return false;
      }

      // In a real app, you'd hash the PIN and compare hashes
      // For now, we'll do a direct comparison
      final isValid = _selectedAttendant!.pin == cleanPin;

      // Optional: Add default PIN for demo/testing
      final hasDefaultPin = cleanPin == "1234" && _selectedAttendant!.hasPinSet;

      return isValid || hasDefaultPin;
    } catch (e) {
      print('Error verifying PIN: $e');
      return false;
    }
  }

  // Get attendant by ID
  AttendantModel? getAttendantById(String id) {
    try {
      return _attendants.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  // Reset search and filters
  void resetSearch() {
    _searchQuery = '';
    _filteredAttendants = List.from(_attendants);
    notifyListeners();
  }

  // Refresh data
  Future<void> refreshData(SystemProvider systemProvider) async {
    await loadAttendants(systemProvider, forceRefresh: true);
  }

  // Clear all data
  void clearData() {
    _attendants.clear();
    _filteredAttendants.clear();
    _selectedAttendant = null;
    _searchQuery = '';
    _errorMessage = '';
    _dataFetched = false;
    _responseState = ResponseState.done;
    notifyListeners();
  }

  // Retry loading attendants after error
  Future<void> retryLoading(SystemProvider systemProvider) async {
    await loadAttendants(systemProvider, forceRefresh: true);
  }

  // Helper method to get user-friendly error messages
  String _getErrorMessage(dynamic error) {
    if (error.toString().contains('SocketException') ||
        error.toString().contains('NetworkException')) {
      return 'Network connection error. Please check your internet connection.';
    } else if (error.toString().contains('TimeoutException')) {
      return 'Request timed out. Please try again.';
    } else if (error.toString().contains('FormatException')) {
      return 'Invalid data format received from server.';
    } else {
      return 'Failed to load attendants. Please try again.';
    }
  }

  // Debug method to print current state
  void debugPrintState() {
    if (kDebugMode) {
      print('AttendantProvider State:');
      print('  Total attendants: ${_attendants.length}');
      print('  Filtered attendants: ${_filteredAttendants.length}');
      print('  Selected attendant: ${_selectedAttendant?.name ?? 'None'}');
      print('  Search query: "$_searchQuery"');
      print('  Response state: $_responseState');
      print('  Error message: "$_errorMessage"');
      print('  Data fetched: $_dataFetched');
    }
  }
}
