import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/buttons/spotstock_icon_button.dart';
import '../../../../core/presentation/textfields/spotstock_textfield.dart';
import '../../data/models/warehouse.dart';
import '../view_model/spotstock_select_branch_form_view_model.dart';

class SpotstockSelectBranchForm extends StatelessWidget {
  final SpotstockSelectBranchFormViewModel viewModel;
  final Function(Warehouse) onBranchSelected;
  const SpotstockSelectBranchForm({
    super.key,
    required this.viewModel,
    required this.onBranchSelected,
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
              SpotstockTextField(
                hintText: SpotstockStrings.searchBranches,
                controller: viewModel.searchController,
                onChanged: (value) => viewModel.onSearch(value ?? ''),
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
              ),
              const SizedBox(height: SpotstockSizes.s16),
              if (viewModel.filteredWarehouses.isEmpty)
                Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: SpotstockSizes.s34,
                    ),
                    SizedBox(height: SpotstockSizes.s8),
                    Text(SpotstockStrings.noBranchesFound),
                  ],
                ),
              if (viewModel.filteredWarehouses.isNotEmpty)
                ...viewModel.filteredWarehouses.map(
                  (branch) {
                    final isSelected = viewModel.selectedWarehouse?.id == branch.id;
                    return GestureDetector(
                      onTap: () => onBranchSelected(branch),
                      child: Container(
                        padding: EdgeInsets.all(SpotstockSizes.s8),
                        margin: EdgeInsets.only(bottom: SpotstockSizes.s8),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.outline),
                          borderRadius: BorderRadius.circular(SpotstockSizes.s8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  branch.name ?? '',
                                  style: TextStyle(
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                Text(
                                  "${branch.city ?? ''}, ${branch.country ?? ''}",
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: isSelected
                                            ? Theme.of(context).colorScheme.primary
                                            : Theme.of(context).colorScheme.onSurface,
                                      ),
                                ),
                              ],
                            ),
                            isSelected
                                ? Icon(
                                    Icons.check,
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.onSurface,
                                    size: SpotstockSizes.s18,
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
