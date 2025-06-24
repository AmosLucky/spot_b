import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/custom_selector_sheet.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/data/repository/general_repo.dart';
import 'package:spotstock_inventory/widgets/custom_btn.dart';
import 'package:spotstock_inventory/widgets/dialogs.dart';

import '../../../../common/secondary_custom_dropdown.dart';

class TransferBooking extends StatefulWidget {
  final Map<String, dynamic>? room;
  final Size mediaQuery;
  final Map registerInfo;
  final List rooms;
  final SystemProvider systemProvider;
  final UserDetails user;
  final VoidCallback onRefreshRooms;

  const TransferBooking({
    super.key,
    required this.room,
    required this.rooms,
    required this.mediaQuery,
    required this.registerInfo,
    required this.systemProvider,
    required this.user,
    required this.onRefreshRooms,
  });

  @override
  State<TransferBooking> createState() => _EditBookingState();
}

class _EditBookingState extends State<TransferBooking> {
  final TextEditingController _noteController = TextEditingController();
  String? _transferTo = 'Select...';
  Map<String, dynamic>? selectedRoom;

  Map<String, dynamic>? lastBooking; // To store last booking details

  @override
  void initState() {
    super.initState();
    _fetchLastBookingStatus();
  }

  Future<void> _fetchLastBookingStatus() async {
    if (widget.room != null) {
      var booking = await widget.systemProvider
          .getLastBookingRoom(widget.room!['id'].toString());
      print("---------others---------------");
      print(booking['others']);
      if (booking.containsKey('roomId')) {
        setState(() {
          lastBooking = booking;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var title = widget.room?.isNotEmpty == true
        ? "Transfer ${widget.room?['attributes']?['name'] ?? 'Unknown Room'} Room"
        : "Edit Booking"; // Default status

    var others = lastBooking?['others'] != null
        ? jsonDecode(lastBooking!['others'])
        : {};

    return Container(
      width: widget.mediaQuery.width * 0.3, // Adjust width based on screen size
      constraints: BoxConstraints(
        maxHeight: widget.mediaQuery.height * 0.96,
      ),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: widget.room!.isEmpty && lastBooking!.isEmpty
                ? const Center(child: Text("No room or booking selected yet!"))
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Current Status Container
                        const SizedBox(height: 15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Room Name"),
                            Text(lastBooking?['roomName']?.toString() ?? "N/A")
                          ],
                        ),

                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Customer Name"),
                            Text(others!['customerName'] ?? '')
                          ],
                        ),

                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Category"),
                            Text(widget.room?['attributes']?['category']
                                    ?['name'] ??
                                "")
                          ],
                        ),

                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Price"),
                            Text(
                              widget.room?['attributes']?['price']
                                      ?.toString() ??
                                  'N/A',
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 4.h,
                        ),

                        // Booking Status Dropdown
                        SecondaryCustomDropDown(
                            color: Colors.grey.withOpacity(0.3),
                            hintText: _transferTo,
                            titleText: "Transfer To",
                            onTap: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  barrierColor: Colors.black.withOpacity(0.5),
                                  isDismissible: true,
                                  context: context,
                                  builder: (context) {
                                    return CustomSelectorBottomSheet(
                                      height: 90.h,
                                      onSelect: (value, index) {
                                        setState(() {
                                          _transferTo = value;
                                          selectedRoom = widget.rooms[index];
                                        });
                                        print("valueeee ===>> $_transferTo");
                                      },
                                      items: widget.rooms,
                                    );
                                  });
                            }),
                        // DropdownButtonFormField<String>(
                        //   value: _bookingStatus,
                        //     items: .map((currency) => DropdownMenuItem(
                        //       child: Text(currency),
                        //       value: currency,
                        //     ),
                        //     ),
                        //   onChanged: (value) {
                        //     setState(() {
                        //       _bookingStatus = value;
                        //     });
                        //   },
                        //   decoration: InputDecoration(
                        //     labelText: "Transfer To",
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     enabledBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide: const BorderSide(
                        //         color: Colors
                        //             .grey, // Border color when not focused
                        //       ),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide: BorderSide(
                        //         color:
                        //         primaryColor, // Border color when focused
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
          ),
          const SizedBox(height: 10),

          // Save Changes Button
          CustomButton(
            label: "Save Changes",
            icon: MdiIcons.contentSave,
            color: primaryColor,
            onTap: () async {
              // Save changes logic
              final updatedStatus = _transferTo;
              final note = _noteController.text;

              // Perform save operation here
              print("Updated Status: $updatedStatus");
              print("Note: $note");
              print(widget.room);

              print("============== selected Room =============");
              print(selectedRoom);

              // update booking
              if (selectedRoom!.isNotEmpty && lastBooking!['trx'] != null) {
                await GeneralRepo().upsertBooking(
                  trxID: lastBooking!['trx'],
                  updateData: {
                    "room_id": selectedRoom!['id'],
                    "room_name": selectedRoom!['attributes']['name'],
                    "per_night": selectedRoom!['attributes']['amountPerNight'],
                    "amount": selectedRoom!['attributes']['amountPerNight'],
                  },
                  user: widget.user,
                );

                // Show confirmation message
                Dialogs.alertDialog(
                  context,
                  "Booking Updated",
                  "Your booking has been successfully updated.",
                  "OK",
                  "",
                  [],
                );

                // Refresh room data
                widget.onRefreshRooms();
              }
            },
          ),
        ],
      ),
    );
  }
}
