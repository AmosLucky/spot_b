import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/dropdowns/spotstock_dropdown.dart';
import '../../../pos/data/models/bar_table.dart';
import '../view_model/spotstock_create_hold_form_view_model.dart';

class SpotstockCreateHoldForm extends StatelessWidget {
  final SpotstockCreateHoldFormViewModel viewModel;
  final Function(BarTable?) onBarTableSelected;
  const SpotstockCreateHoldForm({
    super.key,
    required this.viewModel,
    required this.onBarTableSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return Form(
          key: viewModel.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  SpotstockStrings.areYouSure,
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Text(
                  SpotstockStrings.youCanRetrieveTheHoldLaterInHoldsList,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: SpotstockSizes.s16),
              SpotstockDropdown(
                value: viewModel.selectedBarTable,
                hintText: SpotstockStrings.selectTable,
                items: [
                  DropdownMenuItem(
                    value: null,
                    child: Text(SpotstockStrings.selectTable),
                  ),
                  for (var barTable in viewModel.barTables)
                    DropdownMenuItem(
                      value: barTable,
                      child: Text(barTable.name ?? SpotstockStrings.na),
                    ),
                ],
                onChanged: (value) {
                  onBarTableSelected(value);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
