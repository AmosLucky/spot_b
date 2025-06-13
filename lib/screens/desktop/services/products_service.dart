import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:spotstock_inventory/data/repository/auth_repo.dart';
// import 'package:spotstock_inventory/data/models/product.dart';
// import 'package:spotstock_inventory/common/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';

class ProductsService {
  static const String baseUrl = 'https://app.spotstockinventory.com/api';
  final AuthRepo _authRepo = AuthRepo();

  Future<Map<String, dynamic>> fetchProducts({
    int page = 1,
    String? searchQuery,
    bool refresh = false,
  }) async {
    final token = await _getToken();
    final url = Uri.parse('$baseUrl/products?page=$page&search=$searchQuery');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'products': (data['data'] as List)
            .map((json) => Product.fromJson(json))
            .toList(),
        'totalPages': data['last_page'],
      };
    } else {
      throw Exception('Failed to load products: ${response.body}');
    }
  }

  Future<void> createProduct(Map<String, dynamic> payload, BuildContext context) async {
    final token = await _getToken();
    final url = Uri.parse('$baseUrl/products');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create product: ${response.body}');
    }
  }

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }
}