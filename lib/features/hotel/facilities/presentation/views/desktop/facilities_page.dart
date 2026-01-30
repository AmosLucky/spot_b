import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/constants/colors/spotstock_colors.dart';
import '../../../domain/entities/facility_entity.dart';
import '../../providers/facilities_provider.dart';

class FacilitiesPage extends ConsumerStatefulWidget {
  const FacilitiesPage({super.key});

  @override
  ConsumerState<FacilitiesPage> createState() => _FacilitiesPageState();
}

class _FacilitiesPageState extends ConsumerState<FacilitiesPage> {
  final searchController = TextEditingController();

  // ---------------- Add / Edit Dialog ----------------

  void showFacilityDialog({FacilityEntity? facility}) {
    final nameCtrl = TextEditingController(text: facility?.name ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(facility == null ? 'Add Facility' : 'Edit Facility'),
        content: Consumer(
          builder: (context, ref, _) {
            final state = ref.watch(facilitiesControllerProvider);

            return SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Facility name'),
                  ),
                  const SizedBox(height: 16),

                  /// ICON DROPDOWN
                  Row(
                    children: [
                      const Text('Icon:'),
                      const SizedBox(width: 12),
                      DropdownButton<IconData>(
                        key: ValueKey(state.selectedIcon.codePoint),
                        value: state.selectedIcon,
                        items: state.icons
                            .map(
                              (icon) => DropdownMenuItem(
                                value: icon,
                                child: Icon(icon),
                              ),
                            )
                            .toList(),
                        onChanged: (icon) => ref
                            .read(facilitiesControllerProvider.notifier)
                            .changeSelectedIcon(icon!),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// STATUS DROPDOWN
                  DropdownButtonFormField<String>(
                    value: state.selectedFormStatus,
                    decoration: const InputDecoration(labelText: 'Status'),
                    items: state.formStatusList
                        .map(
                          (s) => DropdownMenuItem(value: s, child: Text(s)),
                        )
                        .toList(),
                    onChanged: (value) => ref
                        .read(facilitiesControllerProvider.notifier)
                        .changeFormStatus(value!),
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
                  ref.read(facilitiesControllerProvider.notifier);

              if (facility == null) {
                await controller.addFacility(
                  nameCtrl.text,
                );
              } else {
                await controller.updateFacility(
                  id: facility.id!,
                  name: nameCtrl.text,
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

  void showDeleteDialog(FacilityEntity facility) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Facility'),
        content: const Text('Are you sure you want to delete this facility?'),
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
                  .read(facilitiesControllerProvider.notifier)
                  .deleteFacility(facility.id!);
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
    final state = ref.watch(facilitiesControllerProvider);
    final facilities = state.facilities;

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
                  'Facilities',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => showFacilityDialog(),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Facility'),
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
                                hintText: 'Search facilities...',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onChanged: (value) {
                                // optional: add search use case later
                                ref
                                    .read(facilitiesControllerProvider.notifier)
                                    .filterByName(value);
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          DropdownButton<String>(
                            value: state.selectedFilterStatus,
                            items: state.filterStatusList
                                .map(
                                  (status) => DropdownMenuItem(
                                    value: status,
                                    child: Text(status),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) => ref
                                .read(facilitiesControllerProvider.notifier)
                                .changeSearchStatus(value!),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// TABLE HEADER
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: SpotstockColors.grey300,
                            ),
                          ),
                        ),
                        child: Row(
                          children: const [
                            Expanded(flex: 3, child: Text('Facility')),
                            Expanded(flex: 1, child: Text('Icon')),
                            Expanded(flex: 1, child: Text('Status')),
                            Expanded(flex: 2, child: Text('Actions')),
                          ],
                        ),
                      ),

                      /// LIST
                      Expanded(
                        child: state.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                itemCount: facilities.length,
                                itemBuilder: (context, index) {
                                  final facility = facilities[index];

                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: SpotstockColors.grey200,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(facility.name),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Icon(facility.icon),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            facility.status,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: facility.status == 'Active'
                                                  ? SpotstockColors.green
                                                  : SpotstockColors.red,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: SpotstockColors.blue,
                                                ),
                                                onPressed: () =>
                                                    showFacilityDialog(
                                                  facility: facility,
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: SpotstockColors.red,
                                                ),
                                                onPressed: () =>
                                                    showDeleteDialog(
                                                  facility,
                                                ),
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
