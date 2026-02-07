import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/constants/colors/spotstock_colors.dart';

import '../domain/entities/premium_type_entity.dart';
import '../presentation/providers/premium_type_provider.dart';

class PremiumTypesPage extends ConsumerStatefulWidget {
  const PremiumTypesPage({super.key});

  @override
  ConsumerState<PremiumTypesPage> createState() =>
      _PremiumTypesPageState();
}

class _PremiumTypesPageState
    extends ConsumerState<PremiumTypesPage> {
  final searchController = TextEditingController();

  // ---------------- Add / Edit Dialog ----------------

  void showPremiumTypeDialog({PremiumTypeEntity? premiumType}) {
    final nameCtrl =
        TextEditingController(text: premiumType?.name ?? '');
    final costCtrl = TextEditingController(
      text: premiumType?.cost.toString() ?? '',
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          premiumType == null
              ? 'Add Premium Type'
              : 'Edit Premium Type',
        ),
        content: Consumer(
          builder: (context, ref, _) {
            final state =
                ref.watch(premiumTypeControllerProvider);

            return SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// NAME
                  TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Premium type name',
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// COST
                  TextField(
                    controller: costCtrl,
                    keyboardType:
                        const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Cost',
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// STATUS
                  DropdownButtonFormField<String>(
                    value: state.selectedFilterStatus == 'All'
                        ? 'Active'
                        : state.selectedFilterStatus,
                    decoration:
                        const InputDecoration(labelText: 'Status'),
                    items: const [
                      DropdownMenuItem(
                        value: 'Active',
                        child: Text('Active'),
                      ),
                      DropdownMenuItem(
                        value: 'Inactive',
                        child: Text('Inactive'),
                      ),
                    ],
                    onChanged: (value) => ref
                        .read(
                            premiumTypeControllerProvider.notifier)
                        .changeSearchStatus(value!),
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final controller =
                  ref.read(premiumTypeControllerProvider.notifier);

              final cost =
                  double.tryParse(costCtrl.text) ?? 0;

              if (premiumType == null) {
                await controller.addPremiumType(
                  name: nameCtrl.text,
                  cost: cost,
                  status: 'Active',
                );
              } else {
                await controller.updatePremiumType(
                  id: premiumType.id!,
                  name: nameCtrl.text,
                  cost: cost,
                  status: premiumType.status,
                );
              }

              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // ---------------- Delete Dialog ----------------

  void showDeleteDialog(PremiumTypeEntity premiumType) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Premium Type'),
        content: const Text(
          'Are you sure you want to delete this premium type?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: SpotstockColors.red,
            ),
            onPressed: () {
              ref
                  .read(
                      premiumTypeControllerProvider.notifier)
                  .deletePremiumType(premiumType.id!);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(premiumTypeControllerProvider);
    final premiumTypes = state.filtered;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hotel Premium Types',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => showPremiumTypeDialog(),
                  icon: const Icon(Icons.add),
                  label:
                      const Text('Add Premium Service'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// CONTENT CARD
            Expanded(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      /// SEARCH + FILTER
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                hintText:
                                    'Search premium types...',
                                prefixIcon:
                                    const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(6),
                                ),
                              ),
                              onChanged: (value) => ref
                                  .read(
                                      premiumTypeControllerProvider
                                          .notifier)
                                  .filterByName(value),
                            ),
                          ),
                          const SizedBox(width: 16),
                          DropdownButton<String>(
                            value:
                                state.selectedFilterStatus,
                            items: state.filterStatusList
                                .map(
                                  (status) => DropdownMenuItem(
                                    value: status,
                                    child: Text(status),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) => ref
                                .read(
                                    premiumTypeControllerProvider
                                        .notifier)
                                .changeSearchStatus(value!),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// TABLE HEADER
                      Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: SpotstockColors.grey300,
                            ),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Expanded(flex: 3, child: Text('Name')),
                            Expanded(flex: 2, child: Text('Cost')),
                            Expanded(flex: 1, child: Text('Status')),
                            Expanded(flex: 2, child: Text('Actions')),
                          ],
                        ),
                      ),

                      /// LIST
                      Expanded(
                        child: state.isLoading
                            ? const Center(
                                child:
                                    CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                itemCount:
                                    premiumTypes.length,
                                itemBuilder:
                                    (context, index) {
                                  final item =
                                      premiumTypes[index];

                                  return Container(
                                    padding:
                                        const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color:
                                              SpotstockColors.grey200,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        /// NAME
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontWeight:
                                                  FontWeight.w500,
                                            ),
                                          ),
                                        ),

                                        /// COST
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            '₦${item.cost.toStringAsFixed(2)}',
                                          ),
                                        ),

                                        /// STATUS
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            item.status.toLowerCase(),
                                            style: TextStyle(
                                              fontWeight:
                                                  FontWeight.w600,
                                              color:
                                                  item.status ==
                                                          'Active'
                                                      ? SpotstockColors
                                                          .green
                                                      : SpotstockColors
                                                          .red,
                                            ),
                                          ),
                                        ),

                                        /// ACTIONS
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            mainAxisSize:
                                                MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color:
                                                      SpotstockColors.blue,
                                                ),
                                                onPressed: () =>
                                                    showPremiumTypeDialog(
                                                  premiumType:
                                                      item,
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color:
                                                      SpotstockColors.red,
                                                ),
                                                onPressed: () =>
                                                    showDeleteDialog(
                                                        item),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
