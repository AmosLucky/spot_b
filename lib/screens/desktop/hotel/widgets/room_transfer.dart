import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
import 'package:spotstock_inventory/screens/desktop/hotel/widgets/operations_provider.dart';

class RoomTransferScreen extends StatelessWidget {
  const RoomTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OperationsProvider(),
      child: Container(
        child: const RoomTransferBody(),
      ),
    );
  }
}

class RoomTransferBody extends StatelessWidget {
  const RoomTransferBody({super.key});
  Future<void> _selectDate(BuildContext context) async {
    final provider = Provider.of<OperationsProvider>(context, listen: false);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: provider.selectedDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      provider.setDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OperationsProvider>(context);
    // DateTime? selectedDate;
    final selectedDate = provider.selectedDate;
    const expansionKey = 'roomTransfer';
    final isExpanded = provider.expandedStates[expansionKey] ?? false;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            leading: Icon(Icons.compare_arrows_outlined),
            title: Text('Room Transfer'),
            trailing: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
            initiallyExpanded: isExpanded,
            onExpansionChanged: (_) => provider.toggleExpanded(expansionKey),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Transfer Date Section
                  Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        size: 10,
                      ),
                      Text(
                        'Select Transfer Date',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 8,
                      ),
                      Text(
                        'Select a date to view available rooms. Changing dates will reset your selections.',
                        style: TextStyle(
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => provider.hideDestination(),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // SizedBox(width: 10),
                              Text(
                                "Thu\nMay 01\n",
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.room_preferences_outlined,
                                    size: 8,
                                  ),
                                  Text(
                                    "1 Room",
                                    style: TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gap(10),
                      Container(
                        padding: EdgeInsets.all(5),
                        // height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorsRes.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Or Select using calender',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            Gap(5),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: ColorsRes.grey)),
                              child: GestureDetector(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                    decoration: InputDecoration(
                                      constraints:
                                          BoxConstraints(maxHeight: 15),
                                      hintText: 'Select Date',
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(
                                        Icons.calendar_today,
                                        size: 15,
                                      ),
                                    ),
                                    controller: TextEditingController(
                                      text: selectedDate != null
                                          ? "${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.year}"
                                          : '',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Select a date between may 01 and may 02',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Source Room Section
                  Row(
                    children: [
                      Icon(
                        Icons.room_preferences_outlined,
                        size: 10,
                      ),
                      Gap(5),
                      const Text("Source Room", style: TextStyle(fontSize: 10)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => provider.showDestination(),
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.indigo),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Room 302",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 7)),
                              Text(
                                "EXECUTIVE",
                                style: TextStyle(fontSize: 7),
                              ),
                              Text("₦64500.00",
                                  style: TextStyle(
                                      color: Colors.indigo, fontSize: 7)),
                            ],
                          ),
                          Gap(10),
                          // const Spacer(),
                          Column(
                            children: [
                              Icon(
                                Icons.check_box,
                                color: Colors.indigo,
                                size: 15,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text("Active",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 7)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Destination Room Section
                  if (provider.showDestinationRooms) ...[
                    const Text("Destination Room",
                        style: TextStyle(fontSize: 10)),
                    const SizedBox(height: 10),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      children: List.generate(10, (index) {
                        return RoomCard(index: index);
                      }),
                    ),
                  ],
                  // Gap(10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        height: 30,
                        width: 150,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: ColorsRes.cardpurple,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.compare_arrows_outlined,
                              size: 10,
                              color: Colors.white,
                            ),
                            const Text(
                              "Transfer Room",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ]),
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final int index;
  const RoomCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Room ${100 + index}",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Text("DELUXE"),
          const Text("₦53750.00 (₦10750.00)",
              style: TextStyle(color: Colors.green)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child:
                const Text("Available", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  Widget buildDateSelector(BuildContext context, String label,
      DateTime? selectedDate, Function(DateTime?) onDateSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        Container(
          height: 25,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: InkWell(
            onTap: () async {
              final pickedDate = await showDialog(
                context: context,
                builder: (context) => DatePickerDialog(
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                ),
              );
              if (pickedDate != null) {
                onDateSelected(pickedDate);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedDate != null
                        ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
                        : 'Select Date',
                    style: TextStyle(
                      color: selectedDate != null ? Colors.black : Colors.grey,
                    ),
                  ),
                  const Icon(Icons.calendar_today, size: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  //   void _buildDateSelector(BuildContext context, String label,
  //     DateTime? selectedDate, Function(DateTime?) onDateSelected) async {
  //   final pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate ?? DateTime.now(),
  //     firstDate: DateTime.now().subtract(const Duration(days: 365)),
  //     lastDate: DateTime.now().add(const Duration(days: 365)),
  //   );
  //   if (pickedDate != null) {
  //     onDateSelected(pickedDate);
  //   }
  // }
}
