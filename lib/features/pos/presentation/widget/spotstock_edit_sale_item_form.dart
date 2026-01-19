import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/textfields/spotstock_textfield.dart';
import '../view_model/spotstock_edit_sale_item_form_view_model.dart';

class SpotstockEditSaleItemForm extends StatelessWidget {
  final SpotstockEditSaleItemFormViewModel viewModel;
  const SpotstockEditSaleItemForm({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: viewModel.formKey,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(SpotstockStrings.name),
              const SizedBox(height: SpotstockSizes.s5),
              SpotstockTextField(
                enabled: viewModel.isCustom,
                controller: viewModel.productNameController,
                hintText: SpotstockStrings.productName,
              ),
              const SizedBox(height: SpotstockSizes.s10),
              Text(SpotstockStrings.quantity),
              const SizedBox(height: SpotstockSizes.s5),
              SpotstockTextField(
                controller: viewModel.quantityController,
                keyboardType: TextInputType.number,
                hintText: SpotstockStrings.quantity,
                validator: (value) => viewModel.validateQuantity(value),
              ),
              const SizedBox(height: SpotstockSizes.s10),
              Text(SpotstockStrings.price),
              const SizedBox(height: SpotstockSizes.s5),
              SpotstockTextField(
                controller: viewModel.priceController,
                keyboardType: TextInputType.number,
                hintText: SpotstockStrings.price,
                validator: (value) => viewModel.validatePrice(value),
              ),
              if (viewModel.isCustom)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: SpotstockSizes.s10),
                    Text(SpotstockStrings.cost),
                    const SizedBox(height: SpotstockSizes.s5),
                    SpotstockTextField(
                      controller: viewModel.productCostController,
                      keyboardType: TextInputType.number,
                      hintText: SpotstockStrings.cost,
                    ),
                    const SizedBox(height: SpotstockSizes.s10),
                    Text(SpotstockStrings.description),
                    const SizedBox(height: SpotstockSizes.s5),
                    SpotstockTextField(
                      controller: viewModel.productDescriptionController,
                      hintText: SpotstockStrings.description,
                    ),
                  ],
                ),
            ],
          ),
          if (viewModel.isCustom)
            Positioned(
              right: SpotstockSizes.s0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SpotstockSizes.s5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SpotstockSizes.s1000),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  SpotstockStrings.custom,
                  style: TextStyle(
                    fontSize: SpotstockSizes.s11,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
