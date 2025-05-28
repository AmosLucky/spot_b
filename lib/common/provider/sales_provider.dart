
// providers/sales_provider.dart
import 'package:flutter/material.dart';
import 'package:spotstock_inventory/data/models/sales_models.dart';

class SalesProvider with ChangeNotifier {
  List<Sale> _sales = [];
  PaginationMeta? _meta;
  bool _isLoading = false;
  String? _error;

  // Filter properties
  String? _startDate;
  String? _endDate;
  String? _selectedWarehouse;
  String? _selectedCustomer;
  String? _selectedAttendant;
  String? _selectedType;
  String? _searchQuery;
  int _currentPage = 1;

  // Getters
  List<Sale> get sales => _sales;
  PaginationMeta? get meta => _meta;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get selectedWarehouse => _selectedWarehouse;
  String? get selectedCustomer => _selectedCustomer;
  String? get selectedAttendant => _selectedAttendant;
  String? get selectedType => _selectedType;
  String? get searchQuery => _searchQuery;
  int get currentPage => _currentPage;

  // Filter setters
  void setStartDate(String? date) {
    _startDate = date;
    notifyListeners();
  }

  void setEndDate(String? date) {
    _endDate = date;
    notifyListeners();
  }

  void setWarehouse(String? warehouse) {
    _selectedWarehouse = warehouse;
    notifyListeners();
  }

  void setCustomer(String? customer) {
    _selectedCustomer = customer;
    notifyListeners();
  }

  void setAttendant(String? attendant) {
    _selectedAttendant = attendant;
    notifyListeners();
  }

  void setType(String? type) {
    _selectedType = type;
    notifyListeners();
  }

  void setSearchQuery(String? query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  // Reset filters
  void resetFilters() {
    _startDate = null;
    _endDate = null;
    _selectedWarehouse = null;
    _selectedCustomer = null;
    _selectedAttendant = null;
    _selectedType = null;
    _searchQuery = null;
    _currentPage = 1;
    notifyListeners();
  }

  // Fetch sales data
  Future<void> fetchSales({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    // try {
    //   final response = await SalesService.fetchSales(
    //     page: _currentPage,
    //     startDate: _startDate,
    //     endDate: _endDate,
    //     warehouse: _selectedWarehouse,
    //     customer: _selectedCustomer,
    //     attendant: _selectedAttendant,
    //     search: _searchQuery,
    //     type: _selectedType,
    //   );

    //   _sales = response.data;
    //   _meta = response.meta;
    //   _error = null;
    // } catch (e) {
    //   _error = e.toString();
    //   _sales = [];
    //   _meta = null;
    // } finally {
    //   _isLoading = false;
    //   notifyListeners();
    // }
  }

  // Apply filters and fetch data
  Future<void> applyFilters() async {
    await fetchSales(refresh: true);
  }
}