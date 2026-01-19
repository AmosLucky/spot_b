import 'package:flutter/material.dart';
import 'package:spotstock_inventory/features/holds/presentation/data_classes/hold_selection_result.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/buttons/spotstock_icon_button.dart';
import '../../../../core/presentation/progress_indicators/spotstock_progress_indicator.dart';
import '../../../../core/presentation/textfields/spotstock_textfield.dart';
import '../view_model/spotstock_holds_form_view_model.dart';
import 'spotstock_grouped_hold_widget.dart';

class SpotstockHoldsForm extends StatelessWidget {
  final SpotstockHoldsFormViewModel viewModel;
  final ValueChanged<HoldSelectionResult?> onGroupHoldSelected;

  const SpotstockHoldsForm({
    super.key,
    required this.viewModel,
    required this.onGroupHoldSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) => Form(
        key: viewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("${viewModel.groupedHolds.length} ${SpotstockStrings.groupsWithSInBrackets}"),
            const SizedBox(height: SpotstockSizes.s10),
            SpotstockTextField(
              hintText: SpotstockStrings.searchGroupedHolds,
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.onSurface,
                size: SpotstockSizes.s18,
              ),
              suffixIcon: SpotstockIconButton(
                onPressed: () => viewModel.clearSearch(),
                icon: Icon(
                  Icons.cancel,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: SpotstockSizes.s18,
                ),
                color: Theme.of(context).colorScheme.onSurface,
              ),
              controller: viewModel.searchController,
              onChanged: (value) => viewModel.onSearch(value ?? ''),
            ),
            SizedBox(height: SpotstockSizes.s16),
            if (viewModel.filteredGroupedHolds.isEmpty && !viewModel.getGroupedHoldsCommand.running)
              Column(
                children: [
                  Icon(
                    Icons.search_off,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: SpotstockSizes.s34,
                  ),
                  SizedBox(height: SpotstockSizes.s8),
                  Text(SpotstockStrings.noGroupedHoldsFound)
                ],
              ),
            if (viewModel.filteredGroupedHolds.isEmpty && viewModel.getGroupedHoldsCommand.running)
              Column(
                children: [
                  SpotstockProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(height: SpotstockSizes.s8),
                  Text(SpotstockStrings.gettingGroupedHolds),
                ],
              ),
            if (viewModel.filteredGroupedHolds.isNotEmpty)
              ...viewModel.filteredGroupedHolds.map(
                (groupedHold) => SpotstockGroupedHoldWidget(
                  groupedHold: groupedHold,
                  onTap: () async {
                    final createSaleDto = await viewModel.onGroupedHoldSelected(context, groupedHold);
                    if (createSaleDto != null) {
                      onGroupHoldSelected(HoldSelectionResult(createSaleDto: createSaleDto, groupedHold: groupedHold));
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
