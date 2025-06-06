
// providers/sales_provider.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spotstock_inventory/data/models/sales_models.dart';
import 'package:spotstock_inventory/data/repository/system_repo.dart';
import 'dart:io';

class SalesProvider with ChangeNotifier {
  final SystemRepo _systemRepo;
  
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
  bool _isOffline = false;
bool get isOffline => _isOffline;

  SalesProvider(this._systemRepo);

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

Future<void> fetchSales({bool refresh = false}) async {
  if (refresh) {
    _currentPage = 1;
  }

  _isLoading = true;
  _error = null;
  notifyListeners();

  try {
    // Check internet connectivity first
    bool isConnected = await _checkInternetConnection();
    _isOffline = !isConnected;

    SalesResponse response;

    if (isConnected && refresh) {
      // Try to fetch from network if connected and refreshing
      try {
        response = await _systemRepo.fetchSales(
          refresh: true,
          page: _currentPage,
          startDate: _startDate,
          endDate: _endDate,
          warehouse: _selectedWarehouse,
          customer: _selectedCustomer,
          attendant: _selectedAttendant,
          search: _searchQuery,
          type: _selectedType,
        );
        print('✅ Successfully fetched from network: ${response.data.length} sales');
      } catch (networkError) {
        print('❌ Network fetch failed: $networkError');
        // Network failed, fall back to local data
        response = await _buildLocalSalesResponse();
        _isOffline = true;
      }
    } else {
      // Offline or not refreshing - get local data first
      print('📱 Fetching from local storage (offline: $_isOffline)');
      response = await _buildLocalSalesResponse();
      
      // If local data is empty and we're connected, try network
      if (response.data.isEmpty && isConnected) {
        try {
          response = await _systemRepo.fetchSales(
            refresh: false,
            page: _currentPage,
            startDate: _startDate,
            endDate: _endDate,
            warehouse: _selectedWarehouse,
            customer: _selectedCustomer,
            attendant: _selectedAttendant,
            search: _searchQuery,
            type: _selectedType,
          );
          print('✅ Successfully fetched from network (fallback): ${response.data.length} sales');
        } catch (e) {
          print('❌ Network fallback failed: $e');
          // Keep the empty local response
        }
      }
    }

    _sales = response.data;
    _meta = response.meta;
    _error = null;

    print('📊 Final sales count: ${_sales.length}');
    if (_sales.isEmpty) {
      print('⚠️ No sales data available');
    }

  } catch (e) {
    print('❌ Fatal error in fetchSales: $e');
    _error = e.toString();
    _sales = [];
    _meta = null;
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}


  // Apply filters and fetch data
  Future<void> applyFilters() async {
    await fetchSales(refresh: true);
  }

  // Clear local sales data
Future<void> clearLocalData() async {
  try {
    await _systemRepo.clearLocalSales();
    _sales = [];
    _meta = null;
    print('✅ Local sales data cleared');
    notifyListeners();
  } catch (e) {
    print('❌ Error clearing local data: $e');
    _error = e.toString();
    notifyListeners();
  }
}
  // Future<void> clearLocalData() async {
  //   try {
  //     await _systemRepo.clearLocalSales();
  //     _sales = [];
  //     _meta = null;
  //     notifyListeners();
  //   } catch (e) {
  //     _error = e.toString();
  //     notifyListeners();
  //   }
  // }

  // Get local sales count
  Future<int> getLocalSalesCount() async {
    return await _systemRepo.getLocalSalesCount();
  }
  // Check internet connection
Future<bool> _checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } catch (_) {
    return false;
  }
}

Future<SalesResponse> _buildLocalSalesResponse() async {
  try {
    final localSales = await _systemRepo.getLocalSales(
      page: _currentPage,
      startDate: _startDate,
      endDate: _endDate,
      warehouse: _selectedWarehouse,
      customer: _selectedCustomer,
      attendant: _selectedAttendant,
      search: _searchQuery,
      type: _selectedType,
    );

    print('📱 Local sales found: ${localSales.length}');

    if (localSales.isNotEmpty) {
      // Calculate pagination for local data
      final perPage = 10;
      final totalCount = await _systemRepo.getLocalSalesCount();
      final totalPages = (totalCount / perPage).ceil();

      return SalesResponse(
        data: localSales,
        meta: PaginationMeta(
          currentPage: _currentPage,
          from: ((_currentPage - 1) * perPage) + 1,
          lastPage: totalPages,
          perPage: perPage,
          to: ((_currentPage - 1) * perPage) + localSales.length,
          total: totalCount,
        ),
      );
    } else {
      return SalesResponse(
        data: [],
        meta: PaginationMeta(
          currentPage: 1,
          from: 0,
          lastPage: 1,
          perPage: 10,
          to: 0,
          total: 0,
        ),
      );
    }
  } catch (e) {
    print('❌ Error getting local sales: $e');
    return SalesResponse(
      data: [],
      meta: PaginationMeta(
        currentPage: 1,
        from: 0,
        lastPage: 1,
        perPage: 10,
        to: 0,
        total: 0,
      ),
    );
  }
}

}


  // Fetch sales data
  
  // Future<void> fetchSales({bool refresh = false}) async {
  //   if (refresh) {
  //     _currentPage = 1;
  //   }

  //   _isLoading = true;
  //   _error = null;
  //   notifyListeners();

  //   try {
  //     final response = await _systemRepo.fetchSales(
  //       refresh: refresh,
  //       page: _currentPage,
  //       startDate: _startDate,
  //       endDate: _endDate,
  //       warehouse: _selectedWarehouse,
  //       customer: _selectedCustomer,
  //       attendant: _selectedAttendant,
  //       search: _searchQuery,
  //       type: _selectedType,
  //     );

  //     _sales = response.data;
  //     _meta = response.meta;
  //     _error = null;
  //   } catch (e) {
  //     _error = e.toString();
  //     _sales = [];
  //     _meta = null;
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }