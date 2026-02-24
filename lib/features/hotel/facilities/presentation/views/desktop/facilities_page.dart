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

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ---------------- Add / Edit Dialog ----------------
  void showFacilityDialog({FacilityEntity? facility}) {
    if (facility != null) {
      ref.read(facilitiesControllerProvider.notifier).initForm(facility);
    }

    final nameCtrl = TextEditingController(text: facility?.name ?? '');

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          facility == null ? 'Add Facility' : 'Edit Facility',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Consumer(
          builder: (_, ref, __) {
            final state = ref.watch(facilitiesControllerProvider);

            return SizedBox(
              width: 420,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameCtrl,
                    decoration: InputDecoration(
                      labelText: 'Facility name',
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// ICON PICKER
                  DropdownButtonFormField<IconData>(
                    value: state.selectedIcon,
                    decoration: InputDecoration(
                      labelText: 'Icon',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: state.icons
                        .map(
                          (icon) => DropdownMenuItem(
                            value: icon,
                            child: Row(
                              children: [
                                Icon(icon),
                                const SizedBox(width: 12),
                                Text(icon.codePoint.toString()),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (icon) => ref
                        .read(facilitiesControllerProvider.notifier)
                        .changeSelectedIcon(icon!),
                  ),

                  const SizedBox(height: 16),

                  /// STATUS
                  DropdownButtonFormField<String>(
                    value: state.selectedFormStatus,
                    decoration: InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
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
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final controller =
                  ref.read(facilitiesControllerProvider.notifier);

              if (facility == null) {
                await controller.addFacility(nameCtrl.text);
              } else {
                await controller.updateFacility(
                  id: facility.id!,
                  name: nameCtrl.text,
                );
              }

              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: SpotstockColors.c473069,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Save'),
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
      backgroundColor: Colors.grey.shade50,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Facilities',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Manage hotel facilities and amenities',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () => showFacilityDialog(),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Facility'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: SpotstockColors.c473069,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// MAIN CARD
            Expanded(
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
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
                                filled: true,
                                fillColor: Colors.grey.shade50,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: (value) => ref
                                  .read(facilitiesControllerProvider.notifier)
                                  .filterByName(value),
                            ),
                          ),
                          const SizedBox(width: 16),
                          DropdownButton<String>(
                            value: state.selectedFilterStatus,
                            underline: const SizedBox(),
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

                      const SizedBox(height: 24),

                      /// LIST
                      Expanded(
                        child: state.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : facilities.isEmpty
                                ? _buildEmptyState()
                                : ListView.builder(
                                    itemCount: facilities.length,
                                    itemBuilder: (_, index) =>
                                        _buildFacilityRow(
                                      facilities[index],
                                      index,
                                    ),
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

  Widget _buildFacilityRow(FacilityEntity facility, int index) {
    final isActive = facility.status == 'Active';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: index.isEven ? Colors.white : Colors.grey.shade50,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: SpotstockColors.c473069.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(facility.icon),
                ),
                const SizedBox(width: 12),
                Text(
                  facility.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _statusBadge(isActive),
          ),
          SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () => showFacilityDialog(facility: facility),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline,
                      color: SpotstockColors.red),
                  onPressed: () => showDeleteDialog(
                      facility, MediaQuery.of(context).size.width * 0.6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showDeleteDialog(FacilityEntity facility, double width) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Icon
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: SpotstockColors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    color: SpotstockColors.red,
                    size: 48,
                  ),
                ),

                const SizedBox(height: 20),

                /// Title
                const Text(
                  'Delete Facility',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                /// Message
                Text(
                  'Are you sure you want to delete "${facility.name}"?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 24),

                /// Actions
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _statusBadge(bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive
            ? SpotstockColors.green.withOpacity(0.1)
            : SpotstockColors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: TextStyle(
          color: isActive ? SpotstockColors.green : SpotstockColors.red,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.home_work_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No facilities found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
