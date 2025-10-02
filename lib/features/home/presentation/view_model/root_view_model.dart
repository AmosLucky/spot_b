import 'package:flutter/material.dart';

import '../../../../core/presentation/view_models/spotstock_view_model.dart';

class RootViewModel extends SpotstockViewModel {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  @override
  void bind(BuildContext context) {}

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
