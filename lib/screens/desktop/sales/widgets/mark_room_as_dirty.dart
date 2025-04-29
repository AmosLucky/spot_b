import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
import 'package:spotstock_inventory/common/provider/maintenance_provider.dart';

class MarkRoomDirtyDialog extends StatelessWidget {
  const MarkRoomDirtyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MarkRoomDirtyProvider>(context);

    // Dummy data for dropdowns
    final roomTypes = ['Deluxe', 'Suite', 'Standard'];
    final rooms = {
      'Deluxe': ['Deluxe Room 101', 'Deluxe Room 102'],
      'Suite': ['Suite Room 201', 'Suite Room 202'],
      'Standard': ['Standard Room 301', 'Standard Room 302'],
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
                  " Mark Room as Dirty",
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
                value: provider.selectedRoomType,
                decoration: const InputDecoration(
                  hintText: 'Choose a room type',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
                items: roomTypes
                    .map((type) =>
                        DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) provider.setRoomType(value);
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
                value: provider.selectedRoom,
                decoration: const InputDecoration(
                  hintText: 'Please select a room type first',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                ),
                items: (provider.selectedRoomType != null)
                    ? rooms[provider.selectedRoomType!]!
                        .map((room) =>
                            DropdownMenuItem(value: room, child: Text(room)))
                        .toList()
                    : [],
                onChanged: (value) {
                  if (value != null) provider.setRoom(value);
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
                initialValue: provider.cleaningNote,
                decoration: const InputDecoration(
                  hintText: "Enter any specific cleaning instructions or notes",
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                maxLines: 3,
                onChanged: (value) {
                  provider.setCleaningNote(value);
                },
              ),
            ),
            const SizedBox(height: 20),

            // Expected Cleaning Completion Date
            const Text("Expected Cleaning Completion Date"),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) {
                  provider.setExpectedCleaningDate(picked);
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
              "Optional. If specified, the room will be flagged if not cleaned by this date.",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
                      color: ColorsRes.cardyellow,
                      borderRadius: BorderRadius.circular(5)),
                  child: GestureDetector(
                      onTap: () {
                        // Save the form
                        print("Room Type: ${provider.selectedRoomType}");
                        print("Room: ${provider.selectedRoom}");
                        print("Notes: ${provider.cleaningNote}");
                        print(
                            "Completion Date: ${provider.expectedCleaningDate}");
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.build),
                          const Text("Mark as Dirty"),
                        ],
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
