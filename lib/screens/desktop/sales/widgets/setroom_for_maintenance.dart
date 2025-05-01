import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
import 'package:spotstock_inventory/common/provider/maintenance_provider.dart';
import 'package:spotstock_inventory/common/provider/markroomfor_maintenance_provider.dart';

class SetRoomForMaintenance extends StatelessWidget {
  const SetRoomForMaintenance({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MarkRoomForMaintenanceProvider>(context);
    final rooms = {
      for (var type in provider.roomTypes)
        type: ['$type Room 101', '$type Room 102'] // Example room names
    };
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cleaning_services_rounded,
                  size: 20,
                  color: ColorsRes.cardpurple,
                ),
                Gap(10),
                const Text(
                  " Set  Room for Maintenance",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorsRes.cardpurple),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                  ),
                ),
              ],
            ),
            Divider(
              color: const Color.fromARGB(
                115,
                96,
                96,
                96,
              ),
              height: 1,
              thickness: 0.3,
            ),
            Gap(40),
            // Error message
            if (provider.error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text('Something Went Wrong, Login again',
                    style: const TextStyle(color: Colors.red)),
              ),
            // Select Room Type
            const Text("Select Room Type"),
            const SizedBox(height: 8),
            Container(
              padding: EdgeInsets.only(
                left: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: ColorsRes.btndarkshadow,
                ),
              ),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                value: provider.selectedRoomType,
                decoration: const InputDecoration(
                  hintText: 'Choose a room type',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
                items: provider.roomTypes
                    .map((type) =>
                        DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    provider.selectedRoomType = value;
                    provider.selectedRoom = null;
                    provider.notifyListeners();
                  }
                },
              ),
            ),
            const SizedBox(height: 20),

            // Select Room
            const Text("Select Room"),
            const SizedBox(height: 8),
            Container(
              padding: EdgeInsets.only(
                left: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: ColorsRes.btndarkshadow,
                ),
              ),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                value: provider.selectedRoom,
                decoration: InputDecoration(
                  hintText: provider.selectedRoomType == null
                      ? 'Please select a room type first'
                      : 'Select a room',
                  border: const OutlineInputBorder(),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                ),
                items: provider.selectedRoomType != null
                    ? rooms[provider.selectedRoomType]!
                        .map((room) =>
                            DropdownMenuItem(value: room, child: Text(room)))
                        .toList()
                    : null,
                onChanged: (value) {
                  if (value != null) {
                    provider.selectedRoom = value;
                    provider.notifyListeners();
                  }
                },
              ),
            ),
            const SizedBox(height: 20),

            // Cleaning Instructions/Note
            const Text("Cleaning Instructions/Note"),
            const SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: ColorsRes.btndarkshadow)),
              child: TextFormField(
                onChanged: (value) => provider.cleaningNote = value,
                decoration: const InputDecoration(
                  hintText: "Enter any specific cleaning instructions or notes",
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 20),

            // Expected Cleaning Completion Date
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
                  provider.notifyListeners();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: ColorsRes.btndarkshadow)),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    hintText: "Select expected completion date",
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    provider.expectedCleaningDate != null
                        ? "${provider.expectedCleaningDate!.toLocal()}"
                            .split(' ')[0]
                        : 'Select expected completion date',
                  ),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: ColorsRes.btndarkshadow,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Text('Cancel')),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: ColorsRes.cardpurple,
                      borderRadius: BorderRadius.circular(5)),
                  child: provider.isLoading
                      ? const CircularProgressIndicator()
                      : GestureDetector(
                          onTap: () async {
                            if (provider.selectedRoom == null) {
                              provider.error = 'Please select a room';
                              provider.notifyListeners();
                              return;
                            }

                            try {
                              await provider.setRoomForMaintain();
                              if (provider.error == null) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Set for maintenace successfully')),
                                );
                              }
                            } catch (e) {
                              // Error will be displayed via provider's error state
                            }
                          },
                          child: provider.isLoading
                              ? const CircularProgressIndicator()
                              : const Row(
                                  children: [
                                    Icon(Icons.build),
                                    Text("Set for Maintenance"),
                                  ],
                                ),
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
