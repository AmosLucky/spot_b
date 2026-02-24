import 'package:flutter/material.dart';
import 'package:spotstock_inventory/features/pos/presentation/view_model/spotstock_add_custom_product_form_view_model.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/textfields/spotstock_textfield.dart';

class SpotstockAddCustomProductForm extends StatefulWidget {
  final SpotstockAddCustomProductFormViewModel viewModel;

  const SpotstockAddCustomProductForm({
    super.key,
    required this.viewModel,
  });

  @override
  State<SpotstockAddCustomProductForm> createState() => _SpotstockAddCustomProductFormState();
}

class _SpotstockAddCustomProductFormState extends State<SpotstockAddCustomProductForm> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) => Form(
        key: widget.viewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(SpotstockStrings.productName),
                Text(
                  SpotstockStrings.ASTERISKS,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ),
            const SizedBox(height: SpotstockSizes.s8),
            SpotstockTextField(
              hintText: SpotstockStrings.name,
              controller: widget.viewModel.productNameController,
              validator: (value) => value != null && value.isNotEmpty ? null : SpotstockStrings.productNameRequired,
            ),
            const SizedBox(height: SpotstockSizes.s10),
            Text(SpotstockStrings.description),
            const SizedBox(height: SpotstockSizes.s8),
            SpotstockTextField(
              hintText: SpotstockStrings.optionalInBracket,
              controller: widget.viewModel.productDescriptionController,
            ),
            const SizedBox(height: SpotstockSizes.s10),
            Row(
              children: [
                Text(SpotstockStrings.cost),
                Text(
                  SpotstockStrings.ASTERISKS,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ),
            const SizedBox(height: SpotstockSizes.s8),
            SpotstockTextField(
              hintText: SpotstockSizes.s0.toString(),
              keyboardType: TextInputType.number,
              controller: widget.viewModel.productCostController,
              validator: (value) => value != null && value.isNotEmpty ? null : SpotstockStrings.productCostRequired,
            ),
            const SizedBox(height: SpotstockSizes.s10),
            Row(
              children: [
                Text(SpotstockStrings.sellingPrice),
                Text(
                  SpotstockStrings.ASTERISKS,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ),
            const SizedBox(height: SpotstockSizes.s8),
            SpotstockTextField(
              hintText: SpotstockSizes.s0.toString(),
              keyboardType: TextInputType.number,
              controller: widget.viewModel.productSellingPriceController,
              validator: (value) => value != null && value.isNotEmpty ? null : SpotstockStrings.producSellingPriceRequired,
            ),
            const SizedBox(height: SpotstockSizes.s10),
            Row(
              children: [
                Text(SpotstockStrings.quantity),
                Text(
                  SpotstockStrings.ASTERISKS,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ),
            const SizedBox(height: SpotstockSizes.s8),
            SpotstockTextField(
              hintText: SpotstockSizes.s0.toInt().toString(),
              keyboardType: TextInputType.number,
              controller: widget.viewModel.productQuantityController,
              validator: (value) => value != null && value.isNotEmpty ? null : SpotstockStrings.productQuantityRequired,
            ),
            const SizedBox(height: SpotstockSizes.s10),
          ],
        ),
      ),
    );
  }
}
