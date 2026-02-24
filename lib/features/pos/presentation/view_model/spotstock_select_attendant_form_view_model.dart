import 'package:flutter/material.dart';

import '../../../../core/presentation/view_models/spotstock_form_view_model.dart';
import '../../data/models/attendant.dart';

class SpotstockSelectAttendantFormViewModel extends SpotstockFormViewModel {
  SpotstockSelectAttendantFormViewModel();

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  late List<Attendant> _attendants;
  List<Attendant> get attendants => _attendants;

  late List<Attendant> _filteredAttendants;
  List<Attendant> get filteredAttendants => _filteredAttendants;

  late Attendant? _selectedAttendant;
  Attendant? get selectedAttendant => _selectedAttendant;

  late int? _attendantId;
  int? get attendantId => _attendantId;

  @override
  void bind(
    BuildContext context, [
    List<Attendant> attendants = const [],
    int? attendantId,
  ]) {
    _attendants = attendants;
    _filteredAttendants = attendants;
    _attendantId = attendantId;
    _selectedAttendant = attendants.where((attendant) => attendant.id == attendantId).firstOrNull;
  }

  void onSearch(String value) {
    _filteredAttendants = _attendants.where((attendant) {
      final first = attendant.firstName?.toLowerCase() ?? '';
      final last = attendant.lastName?.toLowerCase() ?? '';
      return first.contains(value.toLowerCase()) || last.contains(value.toLowerCase());
    }).toList()
      ..sort((a, b) => a.firstName!.compareTo(b.firstName!));
    notifyListeners();
  }

  void clearSearch() {
    _searchController.clear();
    _filteredAttendants = _attendants;
    notifyListeners();
  }
}
