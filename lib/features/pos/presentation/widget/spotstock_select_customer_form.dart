import 'package:flutter/material.dart';

import '../../../../core/constants/sizes/spotstock_sizes.dart';
import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/presentation/buttons/spotstock_icon_button.dart';
import '../../../../core/presentation/textfields/spotstock_textfield.dart';
import '../../data/models/customer.dart';
import '../view_model/spotstock_select_customer_form_view_model.dart';

class SpotstockSelectCustomerForm extends StatelessWidget {
  final SpotstockSelectCustomerFormViewModel viewModel;
  final Function(Customer?) onCustomerSelected;

  const SpotstockSelectCustomerForm({
    super.key,
    required this.viewModel,
    required this.onCustomerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return Form(
          key: viewModel.formKey,
          child: Column(
            children: [
              SpotstockTextField(
                hintText: SpotstockStrings.searchCustomers,
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
              SizedBox(height: SpotstockSizes.s16),
              if (viewModel.filteredCustomers.isEmpty)
                Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: SpotstockSizes.s34,
                    ),
                    SizedBox(height: SpotstockSizes.s8),
                    Text(SpotstockStrings.noCustomersFound),
                  ],
                ),
              if (viewModel.filteredCustomers.isNotEmpty)
                ...viewModel.filteredCustomers.map(
                  (customer) {
                    final isSelected = viewModel.selectedCustomer?.id == customer.id;
                    return GestureDetector(
                      onTap: () {
                        if (isSelected) {
                          onCustomerSelected(null);
                        } else {
                          onCustomerSelected(customer);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(SpotstockSizes.s8),
                        margin: EdgeInsets.only(bottom: SpotstockSizes.s8),
                        decoration: BoxDecoration(
                          border: Border.all(color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outline),
                          borderRadius: BorderRadius.circular(SpotstockSizes.s8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  customer.name ?? SpotstockStrings.na,
                                  style: TextStyle(
                                    color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                Text(
                                  customer.phone ?? SpotstockStrings.dash,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
                                      ),
                                ),
                                if (customer.email?.isNotEmpty == true)
                                  Text(
                                    customer.email ?? SpotstockStrings.dash,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
                                        ),
                                  ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                isSelected
                                    ? Icon(
                                        Icons.check,
                                        color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
                                        size: SpotstockSizes.s18,
                                      )
                                    : SizedBox.shrink(),
                                if (customer.isSynced == false) ...[
                                  Icon(
                                    Icons.sync_problem,
                                    size: SpotstockSizes.s16,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ]
                              ],
                            ),
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
