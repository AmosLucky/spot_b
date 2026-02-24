import 'package:flutter/material.dart';

import '../../../../core/presentation/view_models/spotstock_form_view_model.dart';
import '../../data/models/bar_table.dart';

class SpotstockSelectBarTableFormViewModel extends SpotstockFormViewModel {
  SpotstockSelectBarTableFormViewModel();

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  List<BarTable> _barTables = [];
  List<BarTable> get barTables => _barTables;

  List<BarTable> _filteredBarTables = [];
  List<BarTable> get filteredBarTables => _filteredBarTables;

  BarTable? _selectedBarTable;
  BarTable? get selectedBarTable => _selectedBarTable;

  @override
  void bind(BuildContext context,
      [List<BarTable> barTables = const [], BarTable? selectedBarTable]) {
    _barTables = barTables;
    _filteredBarTables = barTables;
    _selectedBarTable = selectedBarTable;
  }

  void onSearch(String value) {
    _filteredBarTables = _barTables.where((barTable) {
      return barTable.name?.toLowerCase().contains(value.toLowerCase()) ?? false;
    }).toList();
    notifyListeners();
  }

  void clearSearch() {
    _searchController.clear();
    _filteredBarTables = _barTables;
    notifyListeners();
  }
}
