import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/booking_provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/data/repository/general_repo.dart';
import 'package:spotstock_inventory/data/repository/system_repo.dart';
import 'package:spotstock_inventory/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../common/provider/cart_provider.dart';
import '../../../../widgets/custom_widgets.dart';
import '../../../../widgets/dialogs.dart';
import '../../../mobile/home/pages/transactions.dart';
import '../../pos/print_desktop.dart';
import '../../pos/widgets/payform.dart';

class RoomSummary extends StatefulWidget {
  final Map<String, dynamic>? room;
  final List<dynamic> rooms;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final Size mediaQuery;
  final Map registerInfo;
  final SystemProvider systemProvider;
  final UserDetails user;

  const RoomSummary({
    super.key,
    required this.checkInDate,
    required this.checkOutDate,
    required this.room,
    required this.mediaQuery,
    required this.registerInfo,
    required this.systemProvider,
    required this.user,
    required this.rooms,
  });

  @override
  State<RoomSummary> createState() => _RoomSummaryState();
}

class _RoomSummaryState extends State<RoomSummary> {
  // DateTime? _checkInDate;
  // DateTime? _checkOutDate;
  String? _bookingType = "Checked-in";
  String? _paymentType;
  int _duration = 0;
  double _totalAmount = 0.0;
  double subtotal = 0.0;
  bool _isFolioChecked = false;
  List<String> customers = [];

  final TextEditingController _folioNameController = TextEditingController();
  final TextEditingController _folioAddressController = TextEditingController();
  final TextEditingController _folioAmountController = TextEditingController();
  final TextEditingController _folioPhoneController = TextEditingController();
  final TextEditingController _folioReceivedAmountController =
      TextEditingController();

  // Additional DateTime variables for folio dates
  DateTime? _folioArrivalDate;
  DateTime? _folioDepartureDate;

// Method to select folio dates
  void _selectFolioDate(BuildContext context, bool isArrival) async {
    DateTime currentDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate, // Disable past dates
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        if (isArrival) {
          _folioArrivalDate = pickedDate;
          if (_folioDepartureDate != null &&
              _folioDepartureDate!.isBefore(_folioArrivalDate!)) {
            _folioDepartureDate = _folioArrivalDate;
          }
        } else {
          _folioDepartureDate = pickedDate;
        }
      });
    }
  }

  // Calculate duration in days
  void _calculateDuration() {
    if (widget.checkInDate != null && widget.checkOutDate != null) {
      setState(() {
        _duration = widget.checkOutDate!.difference(widget.checkInDate!).inDays;
        _duration = _duration > 0 ? _duration : 0; // Prevent negative duration
        _calculateTotalAmount();
      });
    }
  }

  void _onRoomDataChanged() {
    // Recalculate total amount based on updated room price
    _calculateTotalAmount();
    _calculateDuration();
  }

  // Calculate total amount based on duration and room price
  void _calculateTotalAmount() {
    final roomPrice = widget.room?['room_type']?['fare'] ?? 0;
    setState(() {
      _totalAmount =
          (_duration * double.parse(roomPrice.toString())).toDouble();
    });
  }

  void _resetInputs() {
    setState(() {
      // Reset date fields
      // _checkInDate = null;
      // _checkOutDate = null;
      _bookingType = "Checked-in"; // Reset to default value
      _paymentType = null; // Reset to null or default value
      _isFolioChecked = false;

      // Reset controllers
      _folioNameController.clear();
      _folioAddressController.clear();
      _folioAmountController.clear();

      // Reset calculations
      _duration = 0;
      _totalAmount = 0.0;
    });
  }

  // Select a date
  // void _selectDate(BuildContext context, bool isCheckIn) async {
  //   DateTime currentDate = DateTime.now();
  //   DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: currentDate,
  //     firstDate: currentDate, // Disable past dates
  //     lastDate: DateTime(2100),
  //   );
  //   if (pickedDate != null) {
  //     setState(() {
  //       if (isCheckIn) {
  //         _checkInDate = pickedDate;
  //         if (_checkOutDate != null && _checkOutDate!.isBefore(_checkInDate!)) {
  //           _checkOutDate = _checkInDate;
  //         }
  //       } else {
  //         _checkOutDate = pickedDate;
  //       }
  //       _calculateDuration();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var title = widget.room?.isNotEmpty == true
        ? "Booking room ${widget.room?['room_number'] ?? 'Unknown Room'}"
        : "Booking Summary";

    _onRoomDataChanged();
    _calculateTotalAmount();
    _calculateDuration();

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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: widget.room!.isEmpty
                ? const Center(child: Text("No room selected yet!"))
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Check-in and Check-out
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: GestureDetector(
                        //         onTap: () => _selectDate(context, true),
                        //         child: TextField(
                        //           controller: TextEditingController(
                        //             text: widget.checkInDate != null
                        //                 ? "${widget.checkInDate!.year}-${widget.checkInDate!.month.toString().padLeft(2, '0')}-${widget.checkInDate!.day.toString().padLeft(2, '0')}"
                        //                 : '',
                        //           ),
                        //           enabled: false,
                        //           decoration: const InputDecoration(
                        //             labelText: "Check-in Date",
                        //             suffixIcon: Icon(Icons.calendar_today),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     const SizedBox(width: 10),
                        //     Expanded(
                        //       child: GestureDetector(
                        //         onTap: () => _selectDate(context, false),
                        //         child: TextField(
                        //           controller: TextEditingController(
                        //             text: widget.checkOutDate != null
                        //                 ? "${widget.checkOutDate!.year}-${widget.checkOutDate!.month.toString().padLeft(2, '0')}-${widget.checkOutDate!.day.toString().padLeft(2, '0')}"
                        //                 : '',
                        //           ),
                        //           enabled: false,
                        //           decoration: const InputDecoration(
                        //             labelText: "Check-out Date",
                        //             suffixIcon: Icon(Icons.calendar_today),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(height: 10),

                        // Booking Type
                        DropdownButtonFormField<String>(
                          value: _bookingType,
                          items: const [
                            DropdownMenuItem(
                              value: "Checked-in",
                              child: Text("Checked-in"),
                            ),
                            DropdownMenuItem(
                              value: "Reserved",
                              child: Text("Reserved"),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _bookingType = value;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: "Booking Type",
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Payment Type
                        DropdownButtonFormField<String>(
                          value: _paymentType,
                          items: const [
                            DropdownMenuItem(
                              value: "Cash",
                              child: Text("Cash"),
                            ),
                            DropdownMenuItem(
                              value: "POS",
                              child: Text("POS"),
                            ),
                            DropdownMenuItem(
                              value: "Transfer",
                              child: Text("Transfer"),
                            ),
                            DropdownMenuItem(
                              value: "Compliment",
                              child: Text("Compliment"),
                            ),
                            DropdownMenuItem(
                              value: "Unpaid",
                              child: Text("Unpaid"),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _paymentType = value;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: "Payment Type",
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Check-in Date: ${widget.checkInDate!.toIso8601String().replaceRange(10, 24, "")}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),

                        SizedBox(
                          height: 1.h,
                        ),

                        Text(
                          "Check-out Date: ${widget.checkOutDate!.toIso8601String().replaceRange(10, 24, "")}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),

                        SizedBox(
                          height: 1.h,
                        ),

                        Text(
                          "Nights: ${_duration}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),

                        SizedBox(
                          height: 1.h,
                        ),

                        Text(
                          "Room type: ${widget.room!['room_type']['name']}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),

                        SizedBox(
                          height: 1.h,
                        ),

                        Text(
                          "Room number: ${widget.room!['room_number']}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),

                        SizedBox(
                          height: 1.h,
                        ),

                        Text(
                          "Price per Room/Night: ${widget.room!['room_type']['fare']}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 10),

                        // Folio Section
                        Row(
                          children: [
                            Checkbox(
                              value: _isFolioChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isFolioChecked = value ?? false;
                                });
                              },
                            ),
                            const Text("Add Folio"),
                          ],
                        ),
                        if (_isFolioChecked) ...[
                          const SizedBox(height: 10),
                          TextField(
                            controller: _folioNameController,
                            decoration: const InputDecoration(
                              labelText: "Folio Name",
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _folioAddressController,
                            decoration: const InputDecoration(
                              labelText: "Folio Address",
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _folioAmountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Folio Amount",
                            ),
                          ),
                          TextField(
                            controller: _folioPhoneController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Phone no.",
                            ),
                          ),
                          // TextField(
                          //   controller: _folioPhoneController,
                          //   keyboardType: TextInputType.number,
                          //   decoration: const InputDecoration(
                          //     labelText: "Phone no.",
                          //   ),
                          // ),
                          Text('Amount to Pay ${Money.format(subtotal)}'),
                          TextField(
                            controller: _folioReceivedAmountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Received Amount",
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _selectFolioDate(context, true),
                                child: TextField(
                                  controller: TextEditingController(
                                    text: _folioArrivalDate != null
                                        ? "${_folioArrivalDate!.year}-${_folioArrivalDate!.month.toString().padLeft(2, '0')}-${_folioArrivalDate!.day.toString().padLeft(2, '0')}"
                                        : '',
                                  ),
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    labelText: "Arrival Date",
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _selectFolioDate(context, false),
                                child: TextField(
                                  controller: TextEditingController(
                                    text: _folioDepartureDate != null
                                        ? "${_folioDepartureDate!.year}-${_folioDepartureDate!.month.toString().padLeft(2, '0')}-${_folioDepartureDate!.day.toString().padLeft(2, '0')}"
                                        : '',
                                  ),
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    labelText: "Departure Date",
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ],
                      ],
                    ),
                  ),
          ),
          const SizedBox(height: 10),

          // Duration and Total Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Duration: $_duration ${_duration > 1 ? 'days' : 'day'}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Total: ${Money.format(_totalAmount)}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Book Now Button
          CustomButton(
            label: "Book Now",
            icon: MdiIcons.cash,
            color: Colors.deepPurple,
            onTap: () {
              // Booking logic
              if (_totalAmount > 0) {
                if (_paymentType != null) {
                  _showPaymentDialog(context, _totalAmount);
                  print("Room ==>> ${widget.room?['attributes']?['name']}");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Select a payment type to continue'),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  // Retrieve the receipt transaction details using the provided transaction ID.
  Future<Map<String, dynamic>> getReceiptTxn(String txnID) async {
    return await systemProvider.getHotelReceiptTxn(txnID);
  }

  // Retrieve the booking transaction details using the provided transaction ID.
  Future<Map<String, dynamic>> getLastBookingRoom(String roomID) async {
    return await systemProvider.getLastBookingRoom(roomID);
  }

  // Method to show the payment dialog
  void _showPaymentDialog(BuildContext context, double subtotal) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PaymentForm(
          isInvoice: false,
          data: {},
          app: 'hotel',
          systemProvider: systemProvider,
          subtotal: subtotal,
          onSubmit: (paymentData) async {
            paymentData['registerId'] = widget.registerInfo['id'];

            Map folio = {
              "customerName": _folioNameController.text,
              "customerAddress": _folioAddressController.text,
              "amount": _folioAmountController.text,
              "arrival": _folioArrivalDate.toString(),
              "departure": _folioDepartureDate.toString(),
            };

            String? txnID = generateRandomString(12);
            print("============== id ==================");
            print(widget.registerInfo);

            print(widget.registerInfo['id']);

            BookingX booking = BookingX(
              id: 0,
              uid: widget.user.id.toString(),
              perNight: (widget.room?['room_type']?['fare'].toString())!,
              checkin: widget.checkInDate!.toIso8601String(),
              checkout: widget.checkOutDate!.toIso8601String(),
              amount: _totalAmount,
              roomId: (widget.room?['id'].toString())!,
              folio: json.encode(folio),
              trx: txnID,
              bookingOption: _bookingType!,
              duration: _duration.toString(),
              userId: widget.user.id.toString(),
              roomName: widget.room?['room_number'],
              others: jsonEncode(paymentData),
              amountPayable: _totalAmount,
              paymentType: _paymentType,
              folioId: widget.registerInfo['id'],
              createdAt: widget.checkInDate!..toIso8601String(),
              companyId: widget.user.company!.id.toString(),
              checkinTime: DateFormat('hh:mm:ss').format(DateTime.now()),
              searchDate: searchDate(DateTime.now()),
              status: true,
            );
            print("============ booking data =============");
            print(booking.toMap());
            print("============ process booking =============");
            try {
              final value =
                  await Provider.of<CartProvider>(context, listen: false)
                      .checkoutBooking(context, subtotal, paymentData, booking);

              print("Got here too");
              if (value['status'] == true) {
                // update room values
                paymentData['name'] = paymentData['customerName'];
                paymentData['phone'] = paymentData['customerPhone'];
                Map<List<String>, dynamic> updates = {
                  ["attributes", "status"]:
                      booking.bookingOption == 'Checked-in' ? 2 : 3,
                  ["attributes", "color"]:
                      getStatusColor(label: booking.bookingOption),
                  ["is_booked"]: booking.bookingOption == 'Checked-in' ? 1 : 0,
                  ["is_reserved"]: booking.bookingOption == 'Reserved' ? 1 : 0,
                  ["bookings"]: {"trxID": booking.trx},
                  ["customer"]: paymentData
                };
                await SystemRepo(online: false, refresh: false).updateRoomData(
                    widget.rooms, booking.roomId, widget.user, updates);

                // add folio
                if (_isFolioChecked && folio.keys.isNotEmpty) {
                  await GeneralRepo().openFolio(
                      module: "HOTEL",
                      trackID: booking.trx,
                      data: folio,
                      amountPayable: booking.amountPayable);
                }

                var response = await getReceiptTxn(txnID);
                print("Response ===>>> $response");
                if (response.isNotEmpty && context.mounted) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => PrintScreenDialog(
                            user: widget.user,
                            transactionData: response,
                          )));
                }
              } else {
                // Show error dialog or message
                Dialogs.alertDialog(
                  context,
                  "Payment Failed",
                  "Something went wrong during the transaction. Please try again.",
                  "OK",
                  "",
                  [],
                );
              }
            } catch (e) {
              // Handle exceptions and show an error message.
              debugPrint(e.toString());
              Dialogs.alertDialog(
                context,
                "Error",
                "An unexpected error occurred: ${e.toString()}",
                "OK",
                "",
                [],
              );
            }
          },
        );
      },
    );
  }

  final List<Map<String, dynamic>> statusOptions = [
    {'value': 1, 'label': 'Available', 'color': "#279B0A"},
    {'value': 2, 'label': 'Checked-in', 'color': "#E96D3A"},
    {'value': 3, 'label': 'Reserved', 'color': "#DAA520"},
    {'value': 4, 'label': 'Under Maintenance', 'color': "#F62947"},
  ];

  String? getStatusColor({int? value, String? label}) {
    if (value == null && label == null) return null;

    for (var status in statusOptions) {
      if ((value != null && status['value'] == value) ||
          (label != null && status['label'] == label)) {
        return status['color'];
      }
    }

    return null; // Return null if no match is found
  }
}
