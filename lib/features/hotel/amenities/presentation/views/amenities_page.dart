import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/colors/spotstock_colors.dart';
import '../../domain/entities/amenity_entity.dart';

import '../providers/amenities_provider.dart';

// ---------------- Provider ----------------

class AmenitiesPage extends ConsumerStatefulWidget {
  const AmenitiesPage({super.key});

  @override
  ConsumerState<AmenitiesPage> createState() => _AmenitiesScreenState();
}

class _AmenitiesScreenState extends ConsumerState<AmenitiesPage> {
  final searchController = TextEditingController();
  // String selectedStatus = 'All';

  // ---------------- Add/Edit Dialog ----------------
  void showAmenityDialog({AmenityEntity? amenity}) {
    final nameCtrl = TextEditingController(text: amenity?.name ?? '');
    final descCtrl = TextEditingController(text: amenity?.description ?? '');
    //IconData selectedIcon = amenity?.icon ?? Icons.star;
    //String status = amenity?.status ?? 'Active';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(amenity == null ? 'Add Amenity' : 'Edit Amenity'),
        content: Consumer(builder: (context, ref, _) {
          final state = ref.watch(amenitiesControllerProvider);
          return SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(labelText: 'Name')),
                const SizedBox(height: 10),
                TextField(
                    controller: descCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Description')),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Icon:'),
                    const SizedBox(width: 10),
                    DropdownButton<IconData>(
                      key: ValueKey(state.selectedAmenityIcon.codePoint),
                      value: state.selectedAmenityIcon,
                      items: state.amenityIcons
                          .map(
                            (icon) => DropdownMenuItem<IconData>(
                              value: icon,
                              child: Icon(icon),
                            ),
                          )
                          .toList(),
                      //  const [
                      //   DropdownMenuItem(
                      //       value: Icons.star, child: Icon(Icons.star)),
                      //   DropdownMenuItem(
                      //       value: Icons.bed, child: Icon(Icons.bed)),
                      //   DropdownMenuItem(value: Icons.tv, child: Icon(Icons.tv)),
                      //   DropdownMenuItem(
                      //       value: Icons.wifi, child: Icon(Icons.wifi)),
                      //   DropdownMenuItem(
                      //       value: Icons.ac_unit, child: Icon(Icons.ac_unit)),
                      // ],
                      onChanged: (v) => ref
                          .read(amenitiesControllerProvider.notifier)
                          .changeAmenityIcon(v!),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: ref
                      .read(amenitiesControllerProvider)
                      .selectedAmenityStatus,
                  items: ref
                      .read(amenitiesControllerProvider)
                      .amenityStatus
                      .skip(1) // remove "All"
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (v) => ref
                      .read(amenitiesControllerProvider.notifier)
                      .changeAmenityStatus(v!),
                  decoration: const InputDecoration(labelText: 'Status'),
                ),
              ],
            ),
          );
        }),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final entity = AmenityEntity(
                id: amenity?.id,
                name: nameCtrl.text,
                description: descCtrl.text,
                icon: ref.read(amenitiesControllerProvider).selectedAmenityIcon,
                status:
                    ref.read(amenitiesControllerProvider).selectedAmenityStatus,
              );

              final controller = ref.read(amenitiesControllerProvider.notifier);
              if (amenity == null) {
                controller.addAmenity(entity);
              } else {
                controller.updateAmenity(entity);
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
  void showDeleteDialog(AmenityEntity amenity) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Amenity'),
        content: const Text('Are you sure you want to delete this amenity?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: SpotstockColors.red),
            onPressed: () {
              ref
                  .read(amenitiesControllerProvider.notifier)
                  .deleteAmenity(amenity.id!);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(amenitiesControllerProvider);
    final amenities = state.amenities;

    return Scaffold(
      //  appBar: AppBar(title: const Text('Hotel Amenities')),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Row(
          children: [
            /// RIGHT CONTENT
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Hotel Amenities',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            showAmenityDialog();
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Add Amenity'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // List / Loading
                    state.isLoading
                        ? const Expanded(
                            child: Center(child: CircularProgressIndicator()))
                        :

                        /// CARD
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
                                              decoration: InputDecoration(
                                                hintText: 'Search amenities...',
                                                prefixIcon:
                                                    const Icon(Icons.search),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                              ),
                                              onChanged: (value) => ref
                                                  .read(
                                                      amenitiesControllerProvider
                                                          .notifier)
                                                  .filterByTitle(value)),
                                        ),
                                        const SizedBox(width: 16),
                                        DropdownButton<String>(
                                          key: ValueKey(state
                                              .searchSelectedAmenityStatus),
                                          value:
                                              state.searchSelectedAmenityStatus,
                                          items: state.amenityStatus
                                              .map(
                                                (status) => DropdownMenuItem(
                                                  value: status,
                                                  child: Text(status),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (value) {
                                            ref
                                                .read(
                                                    amenitiesControllerProvider
                                                        .notifier)
                                                .changeSearchAmenityStatus(
                                                    value!);
                                          },
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 20),

                                    /// TABLE HEADER
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: SpotstockColors.grey300,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: const [
                                          Expanded(
                                              flex: 2, child: Text('Amenity')),
                                          Expanded(
                                              flex: 3,
                                              child: Text('Description')),
                                          Expanded(
                                              flex: 1, child: Text('Icon')),
                                          Expanded(
                                              flex: 1, child: Text('Status')),
                                          Expanded(
                                              flex: 2, child: Text('Actions')),
                                        ],
                                      ),
                                    ),

                                    /// LIST
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: amenities.length,
                                        itemBuilder: (context, index) {
                                          final amenity = amenities[index];

                                          return Container(
                                            padding: const EdgeInsets.symmetric(
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
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(amenity.name),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child:
                                                      Text(amenity.description),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Icon(amenity.icon),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    amenity.status,
                                                    style: TextStyle(
                                                      color: amenity.status ==
                                                              'Active'
                                                          ? SpotstockColors
                                                              .green
                                                          : SpotstockColors.red,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                          color: SpotstockColors
                                                              .blue,
                                                        ),
                                                        onPressed: () {
                                                          showAmenityDialog(
                                                            amenity: amenity,
                                                          );
                                                        },
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.delete,
                                                          color: SpotstockColors
                                                              .red,
                                                        ),
                                                        onPressed: () {
                                                          showDeleteDialog(
                                                            amenity,
                                                          );
                                                        },
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
            ),
          ],
        ),
      ),
    );
  }
}
