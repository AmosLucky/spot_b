import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/textfields/spotstock_date_picker_field.dart';
import '../../../../core/presentation/textfields/spotstock_dropdown_textfield.dart';
import '../data_classes/register_filter_result.dart';
import '../view_model/spotstock_filter_register_form_view_model.dart';

class SpotstockFilterRegisterForm extends StatelessWidget {
  final SpotstockFilterRegisterFormViewModel viewModel;
  const SpotstockFilterRegisterForm({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpotstockDropdownTextField<ResgisterStatus>(
          hintText: SpotstockStrings.status,
          items: [
            DropdownMenuItem(
              value: ResgisterStatus.open,
              child: Text(SpotstockStrings.open),
            ),
            DropdownMenuItem(
              value: ResgisterStatus.closed,
              child: Text(SpotstockStrings.closed),
            ),
          ],
          value: viewModel.status,
          onChanged: (value) {
            viewModel.status = value;
          },
        ),
        SizedBox(height: SpotstockSizes.s8),
        SpotstockDatePickerField(
          hintText: SpotstockStrings.startDate,
          initialDate: viewModel.startDate,
          onDateSelected: (date) {
            viewModel.startDate = date;
          },
        ),
        SizedBox(height: SpotstockSizes.s8),
        SpotstockDatePickerField(
          hintText: SpotstockStrings.endDate,
          initialDate: viewModel.endDate,
          onDateSelected: (date) {
            viewModel.endDate = date;
          },
        ),
      ],
    );
  }
}
