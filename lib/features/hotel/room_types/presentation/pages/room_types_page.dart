import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/constants/colors/spotstock_colors.dart';
import '../../../amenities/presentation/providers/amenities_provider.dart';
import '../../../bed_type/presentation/providers/bed_types_provider.dart';
import '../../../facilities/presentation/providers/facilities_provider.dart';
import '../../domain/entities/room_type_entities.dart';
import '../providers/room_type_provider.dart';
import 'widgets/room_type_helpers.dart';

class RoomTypesPage extends ConsumerStatefulWidget {
  const RoomTypesPage({super.key});

  @override
  ConsumerState<RoomTypesPage> createState() => _RoomTypesPageState();
}

class _RoomTypesPageState extends ConsumerState<RoomTypesPage> {
  final searchController = TextEditingController();
  // ---------------- ADD / EDIT DIALOG ----------------
  void showRoomTypeDialog({RoomTypeEntity? roomType}) {
    final nameCtrl = TextEditingController(text: roomType?.name ?? '');
    final adultsCtrl =
        TextEditingController(text: roomType?.totalAdults.toString() ?? '1');
    final childrenCtrl =
        TextEditingController(text: roomType?.totalChildren.toString() ?? '0');
    final bedsCtrl =
        TextEditingController(text: roomType?.totalBeds.toString() ?? '0');
    final fareCtrl =
        TextEditingController(text: roomType?.fare.toString() ?? '0');
    final keywordsCtrl = TextEditingController(text: roomType?.keywords ?? '');
    final descriptionCtrl =
        TextEditingController(text: roomType?.description ?? '');
    final cancelFeeCtrl = TextEditingController(
        text: roomType?.cancellationFee.toString() ?? '0');
    final cancelPolicyCtrl =
        TextEditingController(text: roomType?.cancellationPolicy ?? '');

    bool isActive = roomType?.isActive ?? true;

    final amenities = ref.read(amenitiesControllerProvider).amenities;
    final facilities = ref.read(facilitiesControllerProvider).facilities;
    final bedTypes = ref.read(bedTypesControllerProvider).bedTypes;

    List<int> selectedAmenityIds = roomType?.amenityIds.toList() ?? [];
    List<int> selectedFacilityIds = roomType?.facilityIds.toList() ?? [];
    List<int> selectedBedTypeIds = roomType?.bedTypeIds.toList() ?? [];

    void updateBeds() {
      final adults = int.tryParse(adultsCtrl.text) ?? 0;
      final children = int.tryParse(childrenCtrl.text) ?? 0;
      bedsCtrl.text = (adults + children).toString();
    }

    String? validateForm() {
      if (nameCtrl.text.trim().isEmpty) {
        return 'Name is required';
      }

      final adults = int.tryParse(adultsCtrl.text) ?? 0;
      if (adults < 1) {
        return 'Total adults must be at least 1';
      }

      final fare = double.tryParse(fareCtrl.text) ?? 0;
      if (fare <= 0) {
        return 'Fare must be greater than 0';
      }

      if (descriptionCtrl.text.trim().isEmpty) {
        return 'Description is required';
      }

      if (cancelPolicyCtrl.text.trim().isEmpty) {
        return 'Cancellation policy is required';
      }

      if (selectedBedTypeIds.isEmpty) {
        return 'Select at least one bed type';
      }

      return null;
    }

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(roomType == null ? 'Add Room Type' : 'Edit Room Type'),
          content: SizedBox(
            width: 480,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  input(nameCtrl, 'Name *'),
                  number(
                    adultsCtrl,
                    'Total Adults *',
                    onChanged: (_) => setDialogState(updateBeds),
                  ),
                  number(
                    childrenCtrl,
                    'Total Children',
                    onChanged: (_) => setDialogState(updateBeds),
                  ),
                  number(bedsCtrl, 'Total Beds', enabled: false),
                  number(fareCtrl, 'Fare *'),
                  input(keywordsCtrl, 'Keywords (comma separated)'),
                  textarea(descriptionCtrl, 'Description *'),
                  number(cancelFeeCtrl, 'Cancellation Fee'),
                  textarea(cancelPolicyCtrl, 'Cancellation Policy *'),
                  const SizedBox(height: 12),
                  const Text('Amenities'),
                  chipGroup(
                    amenities,
                    selectedAmenityIds,
                    (id, val) => setDialogState(() {
                      val
                          ? selectedAmenityIds.add(id)
                          : selectedAmenityIds.remove(id);
                    }),
                  ),
                  const SizedBox(height: 12),
                  const Text('Facilities'),
                  chipGroup(
                    facilities,
                    selectedFacilityIds,
                    (id, val) => setDialogState(() {
                      val
                          ? selectedFacilityIds.add(id)
                          : selectedFacilityIds.remove(id);
                    }),
                  ),
                  const SizedBox(height: 12),
                  const Text('Bed Types *'),
                  chipGroup(
                    bedTypes,
                    selectedBedTypeIds,
                    (id, val) => setDialogState(() {
                      val
                          ? selectedBedTypeIds.add(id)
                          : selectedBedTypeIds.remove(id);
                    }),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<bool>(
                    value: isActive,
                    decoration: const InputDecoration(labelText: 'Status'),
                    items: const [
                      DropdownMenuItem(value: true, child: Text('Active')),
                      DropdownMenuItem(value: false, child: Text('Inactive')),
                    ],
                    onChanged: (v) => setDialogState(() => isActive = v!),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final error = validateForm();

                if (error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error),
                      backgroundColor: SpotstockColors.red,
                    ),
                  );
                  return;
                }

                final controller =
                    ref.read(roomTypeControllerProvider.notifier);

                final entity = RoomTypeEntity(
                  id: roomType?.id,
                  name: nameCtrl.text.trim(),
                  totalAdults: int.parse(adultsCtrl.text),
                  totalChildren: int.tryParse(childrenCtrl.text) ?? 0,
                  totalBeds: int.parse(bedsCtrl.text),
                  fare: double.parse(fareCtrl.text),
                  keywords: keywordsCtrl.text.trim(),
                  description: descriptionCtrl.text.trim(),
                  cancellationFee: double.tryParse(cancelFeeCtrl.text) ?? 0,
                  cancellationPolicy: cancelPolicyCtrl.text.trim(),
                  amenityIds: selectedAmenityIds,
                  facilityIds: selectedFacilityIds,
                  bedTypeIds: selectedBedTypeIds,
                  isActive: isActive,
                );

                roomType == null
                    ? await controller.addRoomType(entity)
                    : await controller.updateRoomType(entity);

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  // // ---------------- ADD / EDIT DIALOG ----------------
  // void showRoomTypeDialog({RoomTypeEntity? roomType}) {
  //   final nameCtrl = TextEditingController(text: roomType?.name ?? '');
  //   final adultsCtrl =
  //       TextEditingController(text: roomType?.totalAdults.toString() ?? '1');
  //   final childrenCtrl =
  //       TextEditingController(text: roomType?.totalChildren.toString() ?? '0');
  //   final bedsCtrl =
  //       TextEditingController(text: roomType?.totalBeds.toString() ?? '0');
  //   final fareCtrl =
  //       TextEditingController(text: roomType?.fare.toString() ?? '0');
  //   final keywordsCtrl = TextEditingController(text: roomType?.keywords ?? '');
  //   final descriptionCtrl =
  //       TextEditingController(text: roomType?.description ?? '');
  //   final cancelFeeCtrl = TextEditingController(
  //       text: roomType?.cancellationFee.toString() ?? '0');
  //   final cancelPolicyCtrl =
  //       TextEditingController(text: roomType?.cancellationPolicy ?? '');

  //   bool isActive = roomType?.isActive ?? true;

  //   final amenities = ref.read(amenitiesControllerProvider).amenities;
  //   final facilities = ref.read(facilitiesControllerProvider).facilities;
  //   final bedTypes = ref.read(bedTypesControllerProvider).bedTypes;

  //   List<int> selectedAmenityIds = roomType?.amenityIds.toList() ?? [];
  //   List<int> selectedFacilityIds = roomType?.facilityIds.toList() ?? [];
  //   List<int> selectedBedTypeIds = roomType?.bedTypeIds.toList() ?? [];

  //   void updateBeds() {
  //     final adults = int.tryParse(adultsCtrl.text) ?? 0;
  //     final children = int.tryParse(childrenCtrl.text) ?? 0;
  //     bedsCtrl.text = (adults + children).toString();
  //   }

  //   showDialog(
  //     context: context,
  //     builder: (_) => StatefulBuilder(
  //       builder: (context, setDialogState) => AlertDialog(
  //         title: Text(roomType == null ? 'Add Room Type' : 'Edit Room Type'),
  //         content: SizedBox(
  //           width: 480,
  //           child: SingleChildScrollView(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 input(nameCtrl, 'Name *'),
  //                 number(adultsCtrl, 'Total Adults *',
  //                     onChanged: (_) => setDialogState(updateBeds)),
  //                 number(childrenCtrl, 'Total Children',
  //                     onChanged: (_) => setDialogState(updateBeds)),
  //                 number(bedsCtrl, 'Total Beds', enabled: false),
  //                 number(fareCtrl, 'Fare per Night *'),
  //                 input(keywordsCtrl, 'Keywords (comma separated)'),
  //                 textarea(descriptionCtrl, 'Description *'),
  //                 number(cancelFeeCtrl, 'Cancellation Fee'),
  //                 textarea(cancelPolicyCtrl, 'Cancellation Policy *'),
  //                 const SizedBox(height: 12),
  //                 const Text('Amenities'),
  //                 chipGroup(
  //                   amenities,
  //                   selectedAmenityIds,
  //                   (id, val) => setDialogState(() {
  //                     val
  //                         ? selectedAmenityIds.add(id)
  //                         : selectedAmenityIds.remove(id);
  //                   }),
  //                 ),
  //                 const SizedBox(height: 12),
  //                 const Text('Facilities'),
  //                 chipGroup(
  //                   facilities,
  //                   selectedFacilityIds,
  //                   (id, val) => setDialogState(() {
  //                     val
  //                         ? selectedFacilityIds.add(id)
  //                         : selectedFacilityIds.remove(id);
  //                   }),
  //                 ),
  //                 const SizedBox(height: 12),
  //                 const Text('Bed Types *'),
  //                 chipGroup(
  //                   bedTypes,
  //                   selectedBedTypeIds,
  //                   (id, val) => setDialogState(() {
  //                     val
  //                         ? selectedBedTypeIds.add(id)
  //                         : selectedBedTypeIds.remove(id);
  //                   }),
  //                 ),
  //                 const SizedBox(height: 12),
  //                 DropdownButtonFormField<bool>(
  //                   value: isActive,
  //                   decoration: const InputDecoration(labelText: 'Status'),
  //                   items: const [
  //                     DropdownMenuItem(value: true, child: Text('Active')),
  //                     DropdownMenuItem(value: false, child: Text('Inactive')),
  //                   ],
  //                   onChanged: (v) => setDialogState(() => isActive = v!),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: const Text('Cancel')),
  //           ElevatedButton(
  //             onPressed: () async {
  //               final controller =
  //                   ref.read(roomTypeControllerProvider.notifier);

  //               final entity = RoomTypeEntity(
  //                 id: roomType?.id,
  //                 name: nameCtrl.text,
  //                 totalAdults: int.parse(adultsCtrl.text),
  //                 totalChildren: int.parse(childrenCtrl.text),
  //                 totalBeds: int.parse(bedsCtrl.text),
  //                 fare: double.parse(fareCtrl.text),
  //                 keywords: keywordsCtrl.text,
  //                 description: descriptionCtrl.text,
  //                 cancellationFee: double.parse(cancelFeeCtrl.text),
  //                 cancellationPolicy: cancelPolicyCtrl.text,
  //                 amenityIds: selectedAmenityIds,
  //                 facilityIds: selectedFacilityIds,
  //                 bedTypeIds: selectedBedTypeIds,
  //                 isActive: isActive,
  //               );

  //               roomType == null
  //                   ? await controller.addRoomType(entity)
  //                   : await controller.updateRoomType(entity);

  //               Navigator.pop(context);
  //             },
  //             child: const Text('Save'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // ---------------- DELETE ----------------
  void showDeleteDialog(RoomTypeEntity roomType) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Room Type'),
        content: const Text('Are you sure you want to delete this room type?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: SpotstockColors.red,
            ),
            onPressed: () {
              ref
                  .read(roomTypeControllerProvider.notifier)
                  .deleteRoomType(roomType.id!);
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
    final state = ref.watch(roomTypeControllerProvider);
    final roomTypes = state.roomTypes;

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
                  'Room Types',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () => showRoomTypeDialog(),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Room Type'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// SEARCH
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search room types...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => ref
                  .read(roomTypeControllerProvider.notifier)
                  .searchRoomType(v),
            ),

            const SizedBox(height: 20),

            /// TABLE HEADER
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: SpotstockColors.grey300),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Expanded(flex: 2, child: Text('Name')),
                      Expanded(flex: 3, child: Text('Description')),
                      Expanded(flex: 2, child: Text('Fare / Night')),
                      Expanded(flex: 1, child: Text('Status')),
                      Expanded(flex: 2, child: Text('Actions')),
                    ],
                  ),
                ),
              ),
            ),

            /// LIST
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: roomTypes.length,
                          itemBuilder: (context, index) {
                            final room = roomTypes[index];

                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: SpotstockColors.grey200,
                                  ),
                                ),
                              ),
                              child: Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    /// Name
                                    Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          room.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),

                                    /// Description
                                    Expanded(
                                      flex: 3,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          room.description,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),

                                    /// Fare
                                    Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '₦${room.fare.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),

                                    /// Status
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          room.isActive ? 'Active' : 'Inactive',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: room.isActive
                                                ? SpotstockColors.green
                                                : SpotstockColors.red,
                                          ),
                                        ),
                                      ),
                                    ),

                                    /// Actions
                                    Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.edit,
                                                color: SpotstockColors.blue,
                                              ),
                                              onPressed: () =>
                                                  showRoomTypeDialog(
                                                      roomType: room),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                color: SpotstockColors.red,
                                              ),
                                              onPressed: () =>
                                                  showDeleteDialog(room),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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
