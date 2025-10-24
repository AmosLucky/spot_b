import 'package:flutter/material.dart';

import '../../../../core/presentation/view_models/spotstock_form_view_model.dart';
import '../../data/models/warehouse.dart';

class SpotstockSelectBranchFormViewModel extends SpotstockFormViewModel {
  SpotstockSelectBranchFormViewModel();

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  List<Warehouse> _warehouses = [];
  List<Warehouse> get warehouses => _warehouses;

  List<Warehouse> _filteredWarehouses = [];
  List<Warehouse> get filteredWarehouses => _filteredWarehouses;

  Warehouse? _selectedWarehouse;
  Warehouse? get selectedWarehouse => _selectedWarehouse;

  late int? _warehouseId;
  int? get warehouseId => _warehouseId;

  @override
  void bind(
    BuildContext context, [
    List<Warehouse> warehouses = const [],
    int? warehouseId,
  ]) {
    _warehouses = warehouses;
    _filteredWarehouses = warehouses;
    _warehouseId = warehouseId;
    _selectedWarehouse = warehouses.where((warehouse) => warehouse.id == warehouseId).firstOrNull;
  }

  void onSearch(String value) {
    _filteredWarehouses = _warehouses.where((warehouse) {
      return warehouse.name?.toLowerCase().contains(value.toLowerCase()) ?? false;
    }).toList();
    notifyListeners();
  }

  void clearSearch() {
    _searchController.clear();
    _filteredWarehouses = _warehouses;
    notifyListeners();
  }
}
