import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/input_validation/spotstock_input_validation.dart';
import '../../../../core/presentation/textfields/spotstock_textfield.dart';
import '../view_model/spotstock_add_new_customer_form_view_model.dart';

class SpotstockAddNewCustomerForm extends StatelessWidget with SpotstockInputValidationMixin {
  final SpotstockAddNewCustomerFormViewModel viewModel;
  const SpotstockAddNewCustomerForm({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) => Form(
        key: viewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(SpotstockStrings.name),
            const SizedBox(height: SpotstockSizes.s5),
            SpotstockTextField(
              hintText: SpotstockStrings.customerName,
              controller: viewModel.customerNameController,
              validator: (value) => value != null && value.isNotEmpty ? null : SpotstockStrings.customerNameRequired,
            ),
            const SizedBox(height: SpotstockSizes.s10),
            Text(SpotstockStrings.email),
            const SizedBox(height: SpotstockSizes.s5),
            SpotstockTextField(
              hintText: SpotstockStrings.customerEmail,
              controller: viewModel.customerEmailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return null;
                }
                return isValidEmail(value);
              },
            ),
            const SizedBox(height: SpotstockSizes.s10),
            Text(SpotstockStrings.phoneCapital),
            const SizedBox(height: SpotstockSizes.s5),
            SpotstockTextField(
              hintText: SpotstockStrings.customerPhone,
              controller: viewModel.customerPhoneController,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return SpotstockStrings.phoneNumberIsRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: SpotstockSizes.s10),
            Text(SpotstockStrings.country),
            const SizedBox(height: SpotstockSizes.s5),
            SpotstockTextField(
              hintText: SpotstockStrings.customerCountry,
              controller: viewModel.customerCountryController,
            ),
            const SizedBox(height: SpotstockSizes.s10),
            Text(SpotstockStrings.city),
            const SizedBox(height: SpotstockSizes.s5),
            SpotstockTextField(
              hintText: SpotstockStrings.customerCity,
              controller: viewModel.customerCityController,
            ),
            const SizedBox(height: SpotstockSizes.s10),
            Text(SpotstockStrings.address),
            const SizedBox(height: SpotstockSizes.s5),
            SpotstockTextField(
              hintText: SpotstockStrings.customerAddress,
              controller: viewModel.customerAddressController,
              keyboardType: TextInputType.streetAddress,
            ),
            const SizedBox(height: SpotstockSizes.s10),
          ],
        ),
      ),
    );
  }
}
