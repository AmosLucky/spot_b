import 'package:flutter/material.dart';
import '../model/product_model.dart';
import '../services/products_service.dart';
// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:spotstock_inventory/data/models/product.dart';
// import 'package:spotstock_inventory/data/services/products_service.dart';

class ProductsProvider with ChangeNotifier {
  final ProductsService _service = ProductsService();
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;
  int _currentPage = 1;
  int _totalPages = 1;
  String? _searchQuery;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;

  void setSearchQuery(String? query) {
    _searchQuery = query;
    fetchProducts();
  }

  void setCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  Future<void> fetchProducts({bool refresh = false}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _service.fetchProducts(
        page: _currentPage,
        searchQuery: _searchQuery,
        refresh: refresh,
      );
      _products = result['products'];
      _totalPages = result['totalPages'];
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createProduct(Map<String, dynamic> payload, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _service.createProduct(payload, context);
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}





// import 'package:flutter/material.dart';

// import '../model/product_model.dart';
// import '../services/products_service.dart';
// // import 'package:spotstock_inventory/common/provider/system_provider.dart';
// // import 'package:spotstock_inventory/data/models/product.dart';
// // import 'package:spotstock_inventory/data/services/products_service.dart';

// class ProductsProvider with ChangeNotifier {
//   final ProductsService _service = ProductsService();
//   List<Product> _products = [];
//   bool _isLoading = false;
//   String? _error;
//   int _currentPage = 1;
//   int _totalPages = 1;
//   String? _searchQuery;

//   List<Product> get products => _products;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   int get currentPage => _currentPage;
//   int get totalPages => _totalPages;

//   void setSearchQuery(String? query) {
//     _searchQuery = query;
//     fetchProducts();
//   }

//   void setCurrentPage(int page) {
//     _currentPage = page;
//     notifyListeners();
//   }

//   Future<void> fetchProducts({bool refresh = false}) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       final result = await _service.fetchProducts(
//         page: _currentPage,
//         searchQuery: _searchQuery,
//         refresh: refresh,
//       );
//       _products = result['products'];
//       _totalPages = result['totalPages'];
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> createProduct(Map<String, dynamic> payload) async {
//     _isLoading = true;
//     notifyListeners();
//     try {
//       await _service.createProduct(payload);
//     } catch (e) {
//       _error = e.toString();
//       rethrow;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }