import 'package:flutter/material.dart';

import '../../../../core/presentation/view_models/spotstock_form_view_model.dart';
import '../../data/models/create_customer_dto.dart';

class SpotstockAddNewCustomerFormViewModel extends SpotstockFormViewModel {
  final TextEditingController _customerNameController = TextEditingController();
  TextEditingController get customerNameController => _customerNameController;

  final TextEditingController _customerEmailController = TextEditingController();
  TextEditingController get customerEmailController => _customerEmailController;

  final TextEditingController _customerPhoneController = TextEditingController();
  TextEditingController get customerPhoneController => _customerPhoneController;

  final TextEditingController _customerCountryController = TextEditingController();
  TextEditingController get customerCountryController => _customerCountryController;

  final TextEditingController _customerCityController = TextEditingController();
  TextEditingController get customerCityController => _customerCityController;

  final TextEditingController _customerAddressController = TextEditingController();
  TextEditingController get customerAddressController => _customerAddressController;

  bool get enableEmailValidator {
    final enable = _customerEmailController.text.isNotEmpty;
    notifyListeners();
    return enable;
  }

  @override
  void bind(BuildContext context) {}

  CreateCustomerDto onCreateCustomerPressed(BuildContext context) {
    return CreateCustomerDto(
      address: customerAddressController.text,
      city: customerCityController.text,
      email: customerEmailController.text,
      country: customerCountryController.text,
      name: customerNameController.text,
      phone: customerPhoneController.text,
    );
  }
}
