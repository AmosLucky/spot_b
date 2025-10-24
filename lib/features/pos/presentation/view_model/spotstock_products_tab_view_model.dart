import 'package:flutter/material.dart';

import '../../../../core/constants/durations/spotstock_durations.dart';
import '../../../../core/presentation/view_models/spotstock_view_model.dart';
import '../../data/models/product.dart';

const int scrollToTopThreshold = 200;

class SpotstockProductsTabViewModel extends SpotstockViewModel {
  SpotstockProductsTabViewModel();

  List<Product> _products = [];
  List<Product> get products => _products;

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  late List<Product> _filteredProducts;
  List<Product> get filteredProducts => _filteredProducts;

  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  bool _showScrollToTopButton = false;
  bool get showScrollToTopButton => _showScrollToTopButton;

  @override
  void bind(BuildContext context, {List<Product> products = const [], int? branchId}) {
    final branchProducts = products.where((product) {
      return product.stock?.warehouseId == branchId;
    }).toList();
    _products = branchProducts;
    _filteredProducts = branchProducts;
    _initScrollListener();
    notifyListeners();
  }

  void _initScrollListener() {
    _scrollController.addListener(() {
      if (scrollController.offset > scrollToTopThreshold && !_showScrollToTopButton) {
        _showScrollToTopButton = true;
        notifyListeners();
      } else if (scrollController.offset <= scrollToTopThreshold && _showScrollToTopButton) {
        _showScrollToTopButton = false;
        notifyListeners();
      }
    });
  }

  void onSearch(String value) {
    _filteredProducts = _products.where((product) {
      return product.name?.toLowerCase().contains(value.toLowerCase()) ?? false;
    }).toList();
    notifyListeners();
  }

  void clearSearch() {
    _searchController.clear();
    _filteredProducts = _products;
    notifyListeners();
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: SpotstockDurations.scrollToTopAnimationDuration,
      curve: Curves.easeOut,
    );
  }
}
