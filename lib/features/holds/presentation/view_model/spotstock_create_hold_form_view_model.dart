import 'package:flutter/material.dart';

import '../../../../core/presentation/view_models/spotstock_form_view_model.dart';
import '../../../pos/data/models/bar_table.dart';

class SpotstockCreateHoldFormViewModel extends SpotstockFormViewModel {
  SpotstockCreateHoldFormViewModel();

  List<BarTable> _barTables = [];
  List<BarTable> get barTables => _barTables;

  BarTable? _selectedBarTable;
  BarTable? get selectedBarTable => _selectedBarTable;

  @override
  void bind(
    BuildContext context, [
    List<BarTable> barTables = const [],
    BarTable? selectedBarTable,
  ]) {
    _barTables = barTables;
    _selectedBarTable = selectedBarTable;
  }
}
