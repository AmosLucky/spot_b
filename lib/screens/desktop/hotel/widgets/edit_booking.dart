import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/data/repository/general_repo.dart';
import 'package:spotstock_inventory/data/repository/system_repo.dart';
import 'package:spotstock_inventory/widgets/custom_btn.dart';
import 'package:spotstock_inventory/widgets/dialogs.dart';
import 'package:spotstock_inventory/widgets/helper_utils.dart';

class EditBooking extends StatefulWidget {
  final Map<String, dynamic>? room;
  final List<dynamic> rooms;
  final Size mediaQuery;
  final Map registerInfo;
  final SystemProvider systemProvider;
  final UserDetails user;
  final VoidCallback onRefreshRooms;

  const EditBooking({
    super.key,
    required this.room,
    required this.mediaQuery,
    required this.registerInfo,
    required this.systemProvider,
    required this.user,
    required this.rooms,
    required this.onRefreshRooms,
  });

  @override
  State<EditBooking> createState() => _EditBookingState();
}

class _EditBookingState extends State<EditBooking> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  String? _bookingStatus =
      "Checked-in"; // Moved outside `build` to persist state
  int? status;
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

      print("Booking ==>> $booking");

      if (booking.containsKey('bookingOption')) {
        setState(() {
          lastBooking = booking;
          _bookingStatus = booking['bookingOption'];
          //_bookingStatus = widget.room!['attributes']['status'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var title = widget.room?.isNotEmpty == true
        ? "Edit Booking for ${widget.room?['attributes']?['name'] ?? 'Unknown Room'}"
        : "Edit Booking";

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
            child: widget.room!.isEmpty
                ? const Center(child: Text("No room selected yet!"))
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Current Status Container
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.info_outline, size: 16),
                              const SizedBox(width: 8),
                              Text(
                                "Current Status: ${_bookingStatus ?? 'Loading...'}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Booking Status Dropdown
                        DropdownButtonFormField<String>(
                          value: _bookingStatus,
                          items: const [
                            DropdownMenuItem(
                              value: "Checked-in",
                              child: Text("Checked-in"),
                            ),
                            DropdownMenuItem(
                              value: "Checked-out",
                              child: Text("Checked-out"),
                            ),
                            DropdownMenuItem(
                              value: "Reserved",
                              child: Text("Reserved"),
                            ),
                            DropdownMenuItem(
                              value: "Cancelled",
                              child: Text("Cancel"),
                            ),
                            DropdownMenuItem(
                              value: "Extend",
                              child: Text("Extend"),
                            ),
                            DropdownMenuItem(
                              value: "Dirty",
                              child: Text("Dirty"),
                            ),
                            DropdownMenuItem(
                              value: "Available",
                              child: Text("Clean/Available"),
                            ),
                            DropdownMenuItem(
                              value: "Under Maintenance",
                              child: Text("Under Maintenance"),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _bookingStatus = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Booking Status",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Duration TextField (Only show if "Extend" is selected)
                        if (_bookingStatus == "Extend") ...[
                          TextField(
                            controller: _durationController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Duration (Days)",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],

                        // Short Note
                        TextField(
                          controller: _noteController,
                          decoration: InputDecoration(
                            labelText: "Short Note (optional for cancellation)",
                            hintText: "Add a note about the booking...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: primaryColor,
                              ),
                            ),
                          ),
                          maxLines: 3,
                        ),
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
            onTap: _updateBooking,
          ),
        ],
      ),
    );
  }

  Future<void> _updateBooking() async {
    final note = _noteController.text;
    final duration = _durationController.text;

    status = _bookingStatus!.contains('Checked in') ? 2
        : _bookingStatus!.contains('Available') ? 1
        : _bookingStatus!.contains('Reserved') ? 3
        : _bookingStatus!.contains('Under Maintenance') ? 4 : 0;

    if (_bookingStatus == "Extend" && duration.isEmpty) {
      Dialogs.alertDialog(
          context, "Error", "Duration cannot be empty!", "OK", "", []);
      return;
    }

    // Fetch last booking
    var lastBooking = await widget.systemProvider
        .getLastBookingRoom(widget.room!['id'].toString());

    if (lastBooking.isNotEmpty) {
      if (_bookingStatus == "Extend") {
        // Extend booking duration
        DateTime lastCheckoutDate = DateTime.parse(lastBooking['checkout']);
        DateTime newCheckoutDate = lastCheckoutDate.add(Duration(days: int.parse(duration)));

        String formattedCheckoutDate = DateFormat('yyyy-MM-dd').format(newCheckoutDate);
        String formattedCheckoutTime = DateFormat('HH:mm').format(newCheckoutDate);

        await GeneralRepo().upsertBooking(
          trxID: lastBooking['trx'],
          updateData: {
            "booking_option": lastBooking['bookingOption'],
            "status": true,
            "note": note,
            "checkout_date": formattedCheckoutDate,
            "checkout_time": formattedCheckoutTime,
            "duration": duration,
          },
          user: widget.user,
        );
      } else {
        await GeneralRepo().upsertBooking(
          trxID: lastBooking['trx'],
          updateData: {
            "booking_option": _bookingStatus,
            "status": _bookingStatus == "Checked-out" ? false : true,
            "note": note,
          },
          user: widget.user,
        );

        print("Checked-in value ==>> ${['Checked-in']}");

        // update room values
        Map<List<String>, dynamic> updates = {
          ["attributes", "status"]: status,
          ["attributes", "color"]: getStatusColor(label: _bookingStatus),
          ["is_booked"]: ['Checked-in'].contains(_bookingStatus) ? 1 : 0,
          ["is_reserved"]: ['Reserved'].contains(_bookingStatus) ? 1 : 0,
          ['is_available']: ['Available'].contains(_bookingStatus) ? 1 : 0,
        };
        var result = await SystemRepo(online: false, refresh: false)
            .updateRoomData(widget.rooms, widget.room!['id'].toString(),
                widget.user, updates);

        print("========== updated result ===========");
        print(result);
      }
    }

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
}
