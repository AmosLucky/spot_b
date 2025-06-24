import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/booking_provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
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
  // Existing variables
  String? _bookingType = "Checked-in";
  String? _paymentType;
  int _duration = 0;
  double _totalAmount = 0.0;
  double subtotal = 0.0;
  bool _isFolioChecked = false;
  List<String> customers = [];
  double change = 0.0;
  List<String> tables = [];

  // Add payment form variables
  String _paymentStatus = 'Paid';
  bool _isCustomName = false;
  String? _selectedCustomer;
  String? _selectedTable;

  // Existing controllers
  final TextEditingController _folioNameController = TextEditingController();
  final TextEditingController _folioAddressController = TextEditingController();
  final TextEditingController _folioAmountController = TextEditingController();
  final TextEditingController _folioPhoneController = TextEditingController();
  final TextEditingController _folioReceivedAmountController =
      TextEditingController();

  // Add payment form controllers
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerPhoneController =
      TextEditingController();
  final TextEditingController _receivedAmountController =
      TextEditingController();
  final TextEditingController _partialAmountController =
      TextEditingController();
  final TextEditingController _tableNameController = TextEditingController();

  // Additional DateTime variables for folio dates
  DateTime? _folioArrivalDate;
  DateTime? _folioDepartureDate;

  @override
  void initState() {
    super.initState();
    _customerNameController.text = "Walk-in Customer";
    _customerPhoneController.text = "Enter phone number";
    _tableNameController.text = "Select a table";
    _loadCustomers();
    _loadTables();
  }

  // Add these methods from PaymentForm
  void _loadCustomers() async {
    try {
      var response = await widget.systemProvider.getCustomers();
      if (mounted) {
        setState(() {
          customers = response
              .map((customer) => customer['attributes']['name'] as String)
              .toList();
        });
      }
    } catch (e) {
      print('Error fetching customers: $e');
    }
  }

  void _loadTables() async {
    try {
      var response = await widget.systemProvider.getTables();
      if (mounted) {
        setState(() {
          tables = response
              .map((table) => table['attributes']['name'] as String)
              .toList();
        });
      }
    } catch (e) {
      print('Error fetching tables: $e');
    }
  }

  // Existing methods...
  void _selectFolioDate(BuildContext context, bool isArrival) async {
    DateTime currentDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
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

  void _calculateDuration() {
    if (widget.checkInDate != null && widget.checkOutDate != null) {
      setState(() {
        _duration = widget.checkOutDate!.difference(widget.checkInDate!).inDays;
        _duration = _duration > 0 ? _duration : 0;
        _calculateTotalAmount();
      });
    }
  }

  void _onRoomDataChanged() {
    _calculateTotalAmount();
    _calculateDuration();
  }

  void _calculateTotalAmount() {
    final roomPrice = widget.room?['room_type']?['fare'] ?? 0;
    setState(() {
      _totalAmount =
          (_duration * double.parse(roomPrice.toString())).toDouble();
      subtotal = _totalAmount; // Update subtotal for payment calculations
    });
  }

  @override
  Widget build(BuildContext context) {
    var title = widget.room?.isNotEmpty == true
        ? "Booking room ${widget.room?['room_number'] ?? 'Unknown Room'}"
        : "Booking Summary";

    _onRoomDataChanged();
    _calculateTotalAmount();
    _calculateDuration();

    return Container(
      width: widget.mediaQuery.width * 0.3,
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

                        // Payment Status
                        DropdownButtonFormField<String>(
                          value: _paymentStatus,
                          items: const [
                            DropdownMenuItem(
                              value: "Paid",
                              child: Text("Paid"),
                            ),
                            DropdownMenuItem(
                              value: "Unpaid",
                              child: Text("Unpaid"),
                            ),
                            DropdownMenuItem(
                              value: "Partial",
                              child: Text("Partial"),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _paymentStatus = value!;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: "Payment Status",
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Room Information Display
                        Text(
                          "Check-in Date: ${widget.checkInDate!.toIso8601String().replaceRange(10, 24, "")}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          "Check-out Date: ${widget.checkOutDate!.toIso8601String().replaceRange(10, 24, "")}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          "Nights: $_duration",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          "Room type: ${widget.room!['room_type']['name']}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          "Room number: ${widget.room!['room_number']}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          "Price per Room/Night: ${widget.room!['room_type']['fare']}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),

                        // Customer Information Section
                        Text(
                          "Customer Information",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),

                        // Customer Name Toggle
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Custom Customer Name: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Switch(
                              activeColor: Colors.grey,
                              inactiveThumbColor: Colors.grey,
                              inactiveTrackColor: Colors.grey[300],
                              value: _isCustomName,
                              onChanged: (value) {
                                setState(() {
                                  _isCustomName = value;
                                  if (!_isCustomName) {
                                    _customerNameController.text =
                                        _selectedCustomer ?? "Walk-in Customer";
                                  } else {
                                    _customerNameController.clear();
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Customer Name Field/Dropdown
                        _isCustomName
                            ? TextField(
                                controller: _customerNameController,
                                decoration: const InputDecoration(
                                  labelText: "Enter Customer Name",
                                ),
                              )
                            : DropdownButtonFormField<String>(
                                value: _selectedCustomer,
                                hint: Text(_customerNameController.text),
                                items: customers.map<DropdownMenuItem<String>>(
                                    (String customer) {
                                  return DropdownMenuItem<String>(
                                    value: customer,
                                    child: Text(customer),
                                  );
                                }).toList(),
                                onChanged: (String? newCustomer) {
                                  setState(() {
                                    _selectedCustomer = newCustomer;
                                    _customerNameController.text =
                                        newCustomer ?? "Walk-in Customer";
                                  });
                                },
                                decoration: const InputDecoration(
                                  labelText: "Select Customer",
                                ),
                              ),
                        const SizedBox(height: 10),

                        // Customer Phone (only show if custom name is enabled)
                        if (_isCustomName)
                          TextField(
                            controller: _customerPhoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: "Enter Customer Phone Number",
                            ),
                          ),
                        const SizedBox(height: 10),

                        // Amount to Pay (Read-only)
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText:
                                "Amount to Pay ${Money.format(_totalAmount)}",
                            hintText: Money.format(_totalAmount),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Received Amount (only if payment status is not Unpaid)
                        if (_paymentStatus != 'Unpaid')
                          TextField(
                            controller: _receivedAmountController,
                            decoration: const InputDecoration(
                                labelText: "Received Amount"),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              double receivedAmount =
                                  double.tryParse(value) ?? 0.0;
                              setState(() {
                                change = receivedAmount - _totalAmount;
                              });
                            },
                          ),
                        const SizedBox(height: 10),

                        // Partial Amount (only if payment status is Partial)
                        if (_paymentStatus == 'Partial')
                          TextField(
                            controller: _partialAmountController,
                            decoration: const InputDecoration(
                                labelText: "Partial Amount"),
                            keyboardType: TextInputType.number,
                          ),
                        const SizedBox(height: 10),

                        // Change Return (only show if there's change)
                        if (change != 0.0)
                          Text(
                            "Change Return: ${Money.format(change)}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        const SizedBox(height: 20),

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
                          // TextField(
                          //   controller: _folioPhoneController,
                          //   keyboardType: TextInputType.number,
                          //   decoration: const InputDecoration(
                          //     labelText: "Phone no.",
                          //   ),
                          // ),
                          // TextField(
                          //   readOnly: true,
                          //   decoration: InputDecoration(
                          //     labelText:
                          //         "Amount to Pay ${Money.format(subtotal)}",
                          //     hintText: Money.format(subtotal),
                          //   ),
                          // ),
                          // TextField(
                          //   controller: _folioReceivedAmountController,
                          //   keyboardType: TextInputType.number,
                          //   decoration: const InputDecoration(
                          //     labelText: "Received Amount",
                          //   ),
                          //   onChanged: (value) {
                          //     double receivedAmount =
                          //         double.tryParse(value) ?? 0.0;
                          //     setState(() {
                          //       change = receivedAmount - subtotal;
                          //     });
                          //   },
                          // ),
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
                            const SizedBox(width: 10),
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

          // Book Now Button (Updated to handle direct submission)
          CustomButton(
            label: "Book Now",
            icon: MdiIcons.cash,
            color: Colors.deepPurple,
            onTap: () {
              if (_totalAmount > 0 && _paymentType != null) {
                _handleDirectBooking();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Select a payment type to continue'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // New method to handle direct booking without dialog
  void _handleDirectBooking() async {
    // Create payment data from form fields
    double receivedAmount =
        double.tryParse(_receivedAmountController.text) ?? 0.0;
    Map<String, dynamic> paymentData = {
      'customerName': _customerNameController.text,
      'customerPhoneNumber': _customerPhoneController.text,
      'subtotal': _totalAmount,
      'receivedAmount': receivedAmount,
      'paymentType': _paymentType ?? '',
      'paymentStatus': _paymentStatus,
      'change': change,
      'partialAmount': _paymentStatus == 'Partial'
          ? double.tryParse(_partialAmountController.text) ?? 0.0
          : null,
      'table': '', // Not applicable for hotel booking
      'registerId': widget.registerInfo['id'],
    };

    try {
      // Create folio data
      Map folio = {
        "customerName": _folioNameController.text,
        "customerAddress": _folioAddressController.text,
        "amount": _folioAmountController.text,
        "arrival": _folioArrivalDate.toString(),
        "departure": _folioDepartureDate.toString(),
      };

      String? txnID = generateRandomString(12);

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

      final value = await Provider.of<CartProvider>(context, listen: false)
          .checkoutBooking(context, _totalAmount, paymentData, booking);

      if (value['status'] == true) {
        // Update room values
        paymentData['name'] = paymentData['customerName'];
        paymentData['phone'] = paymentData['customerPhoneNumber'];
        Map<List<String>, dynamic> updates = {
          ["attributes", "status"]:
              booking.bookingOption == 'Checked-in' ? 2 : 3,
          ["attributes", "color"]: getStatusColor(label: booking.bookingOption),
          ["is_booked"]: booking.bookingOption == 'Checked-in' ? 1 : 0,
          ["is_reserved"]: booking.bookingOption == 'Reserved' ? 1 : 0,
          ["bookings"]: {"trxID": booking.trx},
          ["customer"]: paymentData
        };

        await SystemRepo(online: false, refresh: false)
            .updateRoomData(widget.rooms, booking.roomId, widget.user, updates);

        // Add folio if checked
        if (_isFolioChecked && folio.keys.isNotEmpty) {
          await GeneralRepo().openFolio(
              module: "HOTEL",
              trackID: booking.trx,
              data: folio,
              amountPayable: booking.amountPayable);
        }

        // Get and show receipt
        var response = await getReceiptTxn(txnID);
        if (response.isNotEmpty && context.mounted) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => PrintScreenDialog(
                    user: widget.user,
                    transactionData: response,
                  )));
        }
      } else {
        // Show error dialog
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
  }

  // Keep existing methods...
  Future<Map<String, dynamic>> getReceiptTxn(String txnID) async {
    return await systemProvider.getHotelReceiptTxn(txnID);
  }

  Future<Map<String, dynamic>> getLastBookingRoom(String roomID) async {
    return await systemProvider.getLastBookingRoom(roomID);
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
    return null;
  }

  @override
  void dispose() {
    // Dispose existing controllers
    _folioNameController.dispose();
    _folioAddressController.dispose();
    _folioAmountController.dispose();
    _folioPhoneController.dispose();
    _folioReceivedAmountController.dispose();

    // Dispose new controllers
    _customerNameController.dispose();
    _customerPhoneController.dispose();
    _receivedAmountController.dispose();
    _partialAmountController.dispose();
    _tableNameController.dispose();

    super.dispose();
  }
}
