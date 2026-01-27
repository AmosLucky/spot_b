import 'package:flutter/material.dart';

class HotelHomeViewmodel extends ChangeNotifier {
  bool hotelMenuOpen = true;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  toggleHotelMenuOpen() {
    hotelMenuOpen = !hotelMenuOpen;
    notifyListeners();
  }

  void selectPage(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
