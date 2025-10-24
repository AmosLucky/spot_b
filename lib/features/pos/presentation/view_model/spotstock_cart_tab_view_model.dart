import 'package:flutter/material.dart';

import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/view_models/spotstock_view_model.dart';
import '../../data/models/product.dart';

class SpotstockCartTabViewModel extends SpotstockViewModel {
  SpotstockCartTabViewModel();

  List<Product> _products = [];
  List<Product> get products => _products;

  @override
  void bind(BuildContext context, {List<Product> products = const []}) {
    _products = products;
    notifyListeners();
  }

  String getProductName(int? productId) {
    if (productId == null) return SpotstockStrings.na;
    return products.where((p) => p.id == productId).firstOrNull?.name ?? SpotstockStrings.na;
  }
}
