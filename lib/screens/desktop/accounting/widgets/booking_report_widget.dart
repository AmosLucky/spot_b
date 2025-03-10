import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/data/repository/general_repo.dart';
import 'package:spotstock_inventory/screens/desktop/pos/print_desktop.dart';

class BookingReportWidget extends StatefulWidget {
  final Future<List<BookingX>> Function() fetchBookingReport;
  final UserDetails user;
  final SystemProvider systemProvider;
  final Function()? onRefreshRooms;

  const BookingReportWidget({
    super.key,
    required this.fetchBookingReport,
    this.onRefreshRooms,
    required this.user,
    required this.systemProvider,
  });

  @override
  _BookingReportWidgetState createState() => _BookingReportWidgetState();
}

class _BookingReportWidgetState extends State<BookingReportWidget> {
  String? _selectedStatus;
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  void _showEditStatusDialog(BookingX booking) {
    _selectedStatus = booking.bookingOption;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Update Booking Status"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedStatus,
                    items: const [
                      DropdownMenuItem(
                          value: "Checked-in", child: Text("Checked-in")),
                      DropdownMenuItem(
                          value: "Checked-out", child: Text("Checked-out")),
                      DropdownMenuItem(
                          value: "Reserved", child: Text("Reserved")),
                      DropdownMenuItem(
                          value: "Cancelled", child: Text("Cancelled")),
                      DropdownMenuItem(value: "Extend", child: Text("Extend")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedStatus = value;
                      });
                    },
                  ),
                  if (_selectedStatus == "Extend")
                    TextField(
                      controller: _durationController,
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(labelText: "Duration (Days)"),
                    ),
                  TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(
                        labelText: "Short Note (Optional)"),
                    maxLines: 3,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _updateBooking(booking);
                    Navigator.pop(context);
                  },
                  child: const Text("Save Changes",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _updateBooking(BookingX booking) async {
    final note = _noteController.text;
    final duration = _durationController.text;

    if (_selectedStatus == "Extend" && duration.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Duration cannot be empty!")),
      );
      return;
    }

    await GeneralRepo().upsertBooking(
      trxID: booking.trx,
      updateData: {
        "booking_option": _selectedStatus,
        "status": _selectedStatus == "Checked-out" ? false : true,
        "note": note,
        if (_selectedStatus == "Extend") "duration": duration,
      },
      user: widget.user,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookingX>>(
      future: widget.fetchBookingReport(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching booking report'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No bookings found'));
        }

        final bookings = snapshot.data!;
        return ListView.builder(
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            final booking = bookings[index];
            //print(booking.duration);
            return GestureDetector(
              onTap: () => _showEditStatusDialog(booking),
              child: Card(
                child: ListTile(
                  title: Text("Room: ${booking.roomName}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Status: ${booking.bookingOption}"),
                      Text("Amount: ${Money.format(booking.amount)}"),
                      Text(
                        "Check-in: ${DateTime.tryParse(booking.checkin) != null ? DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(booking.checkin)) : 'N/A'}",
                      ),
                      Text(
                        "Check-out: ${DateTime.tryParse(booking.checkout) != null ? DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(booking.checkout)) : 'N/A'}",
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showEditStatusDialog(booking),
                      ),
                      IconButton(
                        icon: const Icon(Icons.print, color: Colors.green),
                        onPressed: () => _printBooking(booking),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Retrieve the receipt transaction details using the provided transaction ID.
  Future<Map<String, dynamic>> getReceiptTxn(String txnID) async {
    return await widget.systemProvider.getHotelReceiptTxn(txnID);
  }

  void _printBooking(BookingX booking) async {
    var response = await getReceiptTxn(booking.trx);
    print("Response ===>>> $response");

    if (response.isNotEmpty && context.mounted) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => PrintScreenDialog(
          user: widget.user,
          transactionData: response,
        ),
      ));
    }
  }
}
