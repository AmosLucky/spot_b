import 'package:flutter/material.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';

import '../model/warehouse_product_model.dart';
// import '../models/product.dart';

class WarehouseProductsProvider with ChangeNotifier {
  final SystemProvider _systemProvider;
  
  List<WarehouseProductModel> _products = [];
  List<WarehouseProductModel> _filteredProducts = [];
  ProductAnalytics? _analytics;
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  String _selectedWarehouse = 'All Warehouses';
  String _selectedCategory = 'All Categories';
  String _selectedBrand = 'All Brands';
  String _stockFilter = 'All Products';
  int _currentPage = 1;
  int _totalPages = 1;

  WarehouseProductsProvider(this._systemProvider);

  // Getters
  List<WarehouseProductModel> get products => _filteredProducts;
  ProductAnalytics? get analytics => _analytics;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  String get selectedWarehouse => _selectedWarehouse;
  String get selectedCategory => _selectedCategory;
  String get selectedBrand => _selectedBrand;
  String get stockFilter => _stockFilter;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;

  // Get unique values for filters
  List<String> get warehouses {
    final warehouses = _products
        .expand((p) => p.warehouses.map((w) => w.name))
        .toSet()
        .toList();
    warehouses.insert(0, 'All Warehouses');
    return warehouses;
  }

  List<String> get categories {
    final categories = _products
        .map((p) => p.productCategoryName)
        .toSet()
        .toList();
    categories.insert(0, 'All Categories');
    return categories;
  }

  List<String> get brands {
    final brands = _products
        .map((p) => p.brandName)
        .toSet()
        .toList();
    brands.insert(0, 'All Brands');
    return brands;
  }

  Future<void> fetchProducts({int? warehouseId, bool refresh = false}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Get products from system provider
      final productsData = await _systemProvider.getProducts(warehouseId ?? _systemProvider.warehouseIds);
      
      _products = productsData.map<WarehouseProductModel>((json) => WarehouseProductModel.fromJson(json)).toList();
      
      // Calculate analytics
      _calculateAnalytics();
      
      // Apply filters
      _applyFilters();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void _calculateAnalytics() {
    if (_products.isEmpty) {
      _analytics = ProductAnalytics(inStock: 0, outOfStock: 0, totalStockValue: 0);
      return;
    }

    int inStock = _products.where((p) => p.inStock > 0).length;
    int outOfStock = _products.where((p) => p.inStock == 0).length;
    double totalValue = _products.fold(0, (sum, p) => sum + (p.productPrice * p.inStock));

    _analytics = ProductAnalytics(
      inStock: inStock,
      outOfStock: outOfStock,
      totalStockValue: totalValue,
    );
  }

  void _applyFilters() {
    _filteredProducts = _products.where((product) {
      // Search filter
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        if (!product.name.toLowerCase().contains(query) &&
            !product.code.toLowerCase().contains(query) &&
            !product.brandName.toLowerCase().contains(query)) {
          return false;
        }
      }

      // Warehouse filter
      if (_selectedWarehouse != 'All Warehouses') {
        if (!product.warehouses.any((w) => w.name == _selectedWarehouse)) {
          return false;
        }
      }

      // Category filter
      if (_selectedCategory != 'All Categories') {
        if (product.productCategoryName != _selectedCategory) {
          return false;
        }
      }

      // Brand filter
      if (_selectedBrand != 'All Brands') {
        if (product.brandName != _selectedBrand) {
          return false;
        }
      }

      // Stock filter
      if (_stockFilter == 'In Stock' && product.inStock <= 0) {
        return false;
      }
      if (_stockFilter == 'Out of Stock' && product.inStock > 0) {
        return false;
      }

      return true;
    }).toList();

    // Calculate pagination
    _totalPages = (_filteredProducts.length / 10).ceil();
    if (_totalPages == 0) _totalPages = 1;
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _currentPage = 1;
    _applyFilters();
    notifyListeners();
  }

  void setWarehouseFilter(String warehouse) {
    _selectedWarehouse = warehouse;
    _currentPage = 1;
    _applyFilters();
    notifyListeners();
  }

  void setCategoryFilter(String category) {
    _selectedCategory = category;
    _currentPage = 1;
    _applyFilters();
    notifyListeners();
  }

  void setBrandFilter(String brand) {
    _selectedBrand = brand;
    _currentPage = 1;
    _applyFilters();
    notifyListeners();
  }

  void setStockFilter(String filter) {
    _stockFilter = filter;
    _currentPage = 1;
    _applyFilters();
    notifyListeners();
  }

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  List<WarehouseProductModel> get paginatedProducts {
    final startIndex = (_currentPage - 1) * 10;
    final endIndex = startIndex + 10;
    return _filteredProducts.sublist(
      startIndex,
      endIndex > _filteredProducts.length ? _filteredProducts.length : endIndex,
    );
  }
}