import 'package:flutter/material.dart';
import 'package:spotstock_inventory/core/shared/command.dart';

import '../../../../core/presentation/view_models/spotstock_form_view_model.dart';
import '../../../../core/shared/result.dart';
import '../../data/models/customer.dart';
import '../../domain/usecases/get_customers.dart';

class SpotstockSelectCustomerFormViewModel extends SpotstockFormViewModel {
  final GetCustomers getCustomers;
  SpotstockSelectCustomerFormViewModel(this.getCustomers);

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

  Command0<void>? _getCustomersCommand;
  Command0<void> get getCustomersCommand {
    _getCustomersCommand ??= Command0<void>(_getCustomers)..execute();
    return _getCustomersCommand!;
  }

  @override
  void bind(BuildContext context, [List<Customer> customers = const [], int? customerId]) async {
    _getCustomersCommand = Command0<void>(_getCustomers)..execute();
    _customers = customers;
    _filteredCustomers = customers;
    _customerId = customerId;
    _selectedCustomer = customers.where((customer) => customer.id == customerId).firstOrNull;
  }

  Future<Result<void>> _getCustomers() async {
    getCustomers().listen((result) {
      result.when(
        onSuccess: (customers) {
          _customers = customers;
          _filteredCustomers = customers;
          notifyListeners();
        },
        onFailure: (error) {
          addError(error);
        },
      );
    });
    return Result.success(null);
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
