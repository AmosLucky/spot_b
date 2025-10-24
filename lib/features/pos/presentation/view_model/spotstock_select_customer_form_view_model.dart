import 'package:flutter/material.dart';

import '../../../../core/presentation/view_models/spotstock_form_view_model.dart';
import '../../data/models/customer.dart';

class SpotstockSelectCustomerFormViewModel extends SpotstockFormViewModel {
  SpotstockSelectCustomerFormViewModel();

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  List<Customer> _customers = [];
  List<Customer> get customers => _customers;

  List<Customer> _filteredCustomers = [];
  List<Customer> get filteredCustomers => _filteredCustomers;

  Customer? _selectedCustomer;
  Customer? get selectedCustomer => _selectedCustomer;

  late int? _customerId;
  int? get customerId => _customerId;

  @override
  void bind(BuildContext context, [List<Customer> customers = const [], int? customerId]) {
    _customers = customers;
    _filteredCustomers = customers;
    _customerId = customerId;
    _selectedCustomer = customers.where((customer) => customer.id == customerId).firstOrNull;
  }

  void onSearch(String value) {
    _filteredCustomers = _customers.where((customer) {
      return customer.name?.toLowerCase().contains(value.toLowerCase()) ?? false;
    }).toList();
    notifyListeners();
  }

  void clearSearch() {
    _searchController.clear();
    _filteredCustomers = _customers;
    notifyListeners();
  }
}
