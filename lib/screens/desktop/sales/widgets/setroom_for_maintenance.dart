import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
import 'package:spotstock_inventory/common/provider/maintenance_provider.dart';
import 'package:spotstock_inventory/common/provider/markroomfor_maintenance_provider.dart';

class SetRoomForMaintenance extends StatelessWidget {
  const SetRoomForMaintenance({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MarkRoomForMaintenanceProvider>(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Icon(
                  Icons.cleaning_services_rounded,
                  size: 20,
                  color: ColorsRes.cardpurple,
                ),
                const Gap(10),
                const Text(
                  "Set Room for Maintenance",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorsRes.cardpurple,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.cancel_outlined),
                ),
              ],
            ),
            const Divider(
              color: Color.fromARGB(115, 96, 96, 96),
              height: 1,
              thickness: 0.3,
            ),
            const Gap(40),

            // Error message
            if (provider.error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  provider.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            // Room Type Dropdown
            const Text("Select Room Type"),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: ColorsRes.btndarkshadow),
              ),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                value: provider.selectedRoomType,
                decoration: const InputDecoration(
                  hintText: 'Choose a room type',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
                items: provider.roomTypes
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    provider.setRoomType(value);
                  }
                },
              ),
            ),
            const SizedBox(height: 20),

            // Room Dropdown
            const Text("Select Room"),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: ColorsRes.btndarkshadow),
              ),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                value: provider.selectedRoom,
                decoration: InputDecoration(
                  hintText: provider.selectedRoomType == null
                      ? 'Please select a room type first'
                      : provider.allRooms
                              .where((room) =>
                                  room.roomTypeName ==
                                  provider.selectedRoomType)
                              .isEmpty
                          ? 'No rooms available'
                          : 'Select a room',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
                items: provider.selectedRoomType != null
                    ? provider.allRooms
                        .where((room) =>
                            room.roomTypeName == provider.selectedRoomType)
                        .map((room) => DropdownMenuItem(
                              value: room.roomNumber,
                              child: Text(
                                  '${room.roomTypeName} ${room.roomNumber}'),
                            ))
                        .toList()
                    : null,
                onChanged: (value) {
                  if (value != null) {
                    provider.setRoom(value);
                  }
                },
              ),
            ),
            const SizedBox(height: 20),

            // Maintenance Note
            const Text("Maintenance Instructions/Note"),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 1,
                  color: ColorsRes.btndarkshadow,
                ),
              ),
              child: TextFormField(
                onChanged: (value) => provider.cleaningNote = value,
                decoration: const InputDecoration(
                  hintText: "Enter maintenance instructions or notes",
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 20),

            // Expected Completion Date
            const Text("Expected Completion Date"),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) {
                  provider.expectedCleaningDate = picked;
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: ColorsRes.btndarkshadow),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.expectedCleaningDate != null
                          ? DateFormat('yyyy-MM-dd')
                              .format(provider.expectedCleaningDate!)
                          : 'Select expected completion date',
                    ),
                    const Icon(Icons.calendar_today, size: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Leave empty if you are unsure when maintenance will be completed.",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed:
                      provider.isLoading ? null : () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: ColorsRes.btndarkshadow,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsRes.cardpurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  onPressed: provider.isLoading
                      ? null
                      : () async {
                          if (provider.selectedRoom == null) {
                            provider.error = 'Please select a room';
                            provider.notifyListeners();
                            return;
                          }

                          try {
                            await provider.setRoomForMaintenance();
                            if (provider.error == null) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Room set for maintenance successfully'),
                                ),
                              );
                            }
                          } catch (e) {
                            // Error is handled by the provider
                          }
                        },
                  child: provider.isLoading
                      ? const CircularProgressIndicator()
                      : const Row(
                          children: [
                            Icon(Icons.build),
                            SizedBox(width: 8),
                            Text("Set for Maintenance"),
                          ],
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
