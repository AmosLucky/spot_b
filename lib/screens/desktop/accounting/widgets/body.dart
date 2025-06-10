import 'dart:convert';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/widgets/register_tile.dart';
import 'package:spotstock_inventory/widgets/sidebar.dart';
import 'package:spotstock_inventory/widgets/sidebar_inventory.dart';
import 'package:spotstock_inventory/widgets/transaction_tile.dart';
import 'package:spotstock_inventory/screens/desktop/pos/print_desktop.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../widgets/dialogs.dart';
import '../../../mobile/home/pages/transactions.dart';
import '../../pos/list_printers.dart';
import '../../pos/printusb.dart';
import 'booking_report_widget.dart';
import 'header.dart';
import 'sales_report_widget.dart';

class Body extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final Size mediaQuery;
  final String? app;
  const Body({
    super.key,
    required this.user,
    required this.systemProvider,
    required this.mediaQuery,
    required this.app,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTimeRange? _selectedDateRangeFromHeader;
  String? _selectedRegisterId;
  List? reportData;
  List? hotelReportData;
  List? registerData;
  int? registerIndex;
  final bool _isLoading = false;
  final ValueNotifier<String> _activeItem = ValueNotifier<String>("Reports");

  @override
  void initState() {
    _fetchRegisters(app: widget.app);
    super.initState();
  }

  @override
  void dispose() {
    _activeItem.dispose();
    super.dispose();
  }

  void _handleDateRangeSelection(DateTimeRange selectedDateRange) {
    setState(() {
      _selectedDateRangeFromHeader = selectedDateRange;
    });
    _fetchRegisters(app: widget.app);
  }

  Future<List<Register>> _fetchRegisters({String? app}) async {
    print("---------- module register ----------");
    print(app);
    if (_selectedDateRangeFromHeader == null) {
      var regData = await widget.systemProvider.getAllRegisters(app: widget.app);
      setState(() {
        registerData = regData;
      });
      return widget.systemProvider.getAllRegisters(app: widget.app);
    }
    var regData = await widget.systemProvider.getAllRegisterByDate(
        _selectedDateRangeFromHeader!.start, _selectedDateRangeFromHeader!.end, widget.app!);
    setState(() {
      registerData = regData;
    });
    print("Register Data ==>> $registerData");
    return widget.systemProvider.getAllRegisterByDate(
        _selectedDateRangeFromHeader!.start, _selectedDateRangeFromHeader!.end, widget.app!);
  }

  Future<List<Orders>> _fetchSalesReport() async {
    if (_selectedRegisterId == null) {
      return [];
    }
    reportData = await widget.systemProvider.getTransactionsByRegister(_selectedRegisterId);
    return widget.systemProvider.getTransactionsByRegister(_selectedRegisterId);
  }

  Future<List<BookingX>> _fetchBookingReport() async {
    if (_selectedRegisterId == null) {
      return [];
    }
    hotelReportData = await widget.systemProvider.getBookingsByRegister(_selectedRegisterId);
    return widget.systemProvider.getBookingsByRegister(_selectedRegisterId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                  ),
                  child: SizedBox(
                    width: 250,
                    child: widget.app == "HOTEL"
                        ? SideBarHotel(
                            vertical: 20,
                            user: widget.user,
                            systemProvider: widget.systemProvider,
                          )
                        : SideBarInventory(
                            vertical: 20,
                            user: widget.user,
                            systemProvider: widget.systemProvider,
                            activeItem: _activeItem,
                          ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(
                        title: "${widget.app} Accounting",
                        user: widget.user,
                        systemProvider: widget.systemProvider,
                        onDateRangeSelected: _handleDateRangeSelection,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
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
                                    const Text(
                                      'Register',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    if (registerData != [] && registerData != null)
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 100),
                                          child: ListView.builder(
                                            reverse: false,
                                            shrinkWrap: true,
                                            itemCount: registerData?.length,
                                            itemBuilder: (context, index) {
                                              final register = registerData?[index];
                                              final openingAmt = double.tryParse(register.opening) ?? 0.0;
                                              final closingAmt = double.tryParse(register.closing) ?? 0.0;
                                              final createdAt =
                                                  DateTime.tryParse(register.lastUpdated) ?? DateTime.now();
                                              return register.module == widget.app
                                                  ? RegisterTile(
                                                      openingAmt: openingAmt,
                                                      closingAmt: closingAmt,
                                                      isClosed: register.closing != '',
                                                      createdAt: createdAt,
                                                      onView: () {
                                                        setState(() {
                                                          registerIndex = index;
                                                          _selectedRegisterId = register.id.toString();
                                                        });
                                                      },
                                                      onClose: () async {
                                                        double? closingAmount = await showDialog<double>(
                                                          context: context,
                                                          builder: (context) {
                                                            TextEditingController amountController = TextEditingController();
                                                            return AlertDialog(
                                                              title: Text("Enter Closing Amount"),
                                                              content: TextField(
                                                                controller: amountController,
                                                                keyboardType: TextInputType.number,
                                                                decoration: const InputDecoration(
                                                                  labelText: "Closing Amount",
                                                                  hintText: "Enter closing amount",
                                                                ),
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: const Text("Cancel"),
                                                                ),
                                                                TextButton(
                                                                  onPressed: () {
                                                                    double? amount = double.tryParse(amountController.text);
                                                                    if (amount != null) {
                                                                      Navigator.of(context).pop(amount);
                                                                    }
                                                                  },
                                                                  child: const Text("Confirm"),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );

                                                        if (closingAmount != null) {
                                                          widget.systemProvider.closeRegister(closingAmount, widget.app);
                                                          _fetchRegisters(app: widget.app);
                                                        }
                                                      },
                                                    )
                                                  : SizedBox();
                                            },
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 3,
                              child: Container(
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Sales Report',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            TextButton(
                                              onPressed: () async {
                                                widget.systemProvider.syncAllTransactions(widget.user);
                                              },
                                              child: const Text(
                                                'Sync All',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                if (reportData != null) {
                                                  downloadReport();
                                                } else if (hotelReportData != null) {
                                                  downloadHotelReport();
                                                } else {
                                                  print('No report data available');
                                                }
                                              },
                                              child: Text(
                                                'Download',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: widget.app == "INVENTORY"
                                          ? SalesReportWidget(
                                              fetchSalesReport: _fetchSalesReport,
                                              user: widget.user,
                                              systemProvider: widget.systemProvider,
                                            )
                                          : BookingReportWidget(
                                              user: widget.user,
                                              systemProvider: widget.systemProvider,
                                              fetchBookingReport: _fetchBookingReport,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
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

  Future<void> downloadReport() async {
    List<Item> itemss = [];
    for (var itemData in reportData!) {
      if (itemData.items != null) {
        for (var items in jsonDecode(itemData.items)) {
          if (items is Map<String, dynamic>) {
            var product = items['product'];
            print("productssss ==>> $product");
            String itemName = product['name'] as String;
            int quantity = items['quantity'] as int;
            double totalAmount;
            if (items['totalAmount'] is String) {
              totalAmount = double.tryParse(items['totalAmount']) ?? 0.0;
            } else if (items['totalAmount'] is int) {
              totalAmount = (items['totalAmount'] as int).toDouble();
            } else if (items['totalAmount'] is double) {
              totalAmount = items['totalAmount'];
            } else {
              totalAmount = 0.0;
            }
            Item item = Item(itemName, quantity, totalAmount);
            itemss.add(item);
            print("Items to Download ==>> $itemss");
          }
        }
      } else {
        print('Expected itemData to be a Map, but got: $itemData');
      }
    }
    double totalAmount = itemss.map((item) => item.price).reduce((a, b) => a + b);
    try {
      print("company data ==>> ${widget.user.company?.phone}");
      await printSampleDocument(
          totalAmount,
          itemss,
          [],
          '',
          '',
          widget.user.company!.email,
          widget.user.company!.phone,
          widget.user.firstName,
          '',
          '',
          '',
          '',
          '',
          '',
          0.00,
          500,
          000.00,
          '0.00',
          DateTime.parse(registerData![registerIndex!].lastUpdated),
          widget.user.company!.name,
          widget.user.company!.address,
          null);
      print('Document sent to printer successfully.');
    } catch (e) {
      print('Error printing document: $e');
    }
  }

  Future<void> downloadHotelReport() async {
    if (hotelReportData == null || hotelReportData!.isEmpty) {
      print('No hotel report data available');
      return;
    }
    List<Item> itemss = [];
    print("Printing hotel report");
    for (var itemData in hotelReportData!) {
      try {
        if (itemData == null) continue;
        final String? itemName = itemData.roomName;
        if (itemName == null) {
          print('Skipping item with null roomName');
          continue;
        }
        final int quantity = int.tryParse(itemData.duration ?? '0') ?? 0;
        double totalAmount = 0.0;
        if (itemData.amount != null) {
          if (itemData.amount is String) {
            totalAmount = double.tryParse(itemData.amount as String) ?? 0.0;
          } else if (itemData.amount is int) {
            totalAmount = (itemData.amount as int).toDouble();
          } else if (itemData.amount is double) {
            totalAmount = itemData.amount as double;
          }
        }
        Item item = Item(itemName, quantity, totalAmount);
        itemss.add(item);
        print("Added item: $item");
      } catch (e) {
        print('Error processing item: $e');
      }
    }
    double totalAmount = itemss.isEmpty ? 0.0 : itemss.map((item) => item.price).reduce((a, b) => a + b);
    if (widget.user.company == null) {
      print('No company data available');
      return;
    }
    if (registerData == null || registerIndex == null || registerIndex! >= registerData!.length) {
      print('Invalid register data');
      return;
    }
    DateTime? lastUpdated;
    try {
      lastUpdated = DateTime.parse(registerData![registerIndex!].lastUpdated);
    } catch (e) {
      print('Error parsing date: $e');
      lastUpdated = DateTime.now();
    }
    try {
      print("Company phone: ${widget.user.company?.phone}");
      await printSampleDocument(
          totalAmount,
          [],
          itemss,
          '',
          '',
          widget.user.company?.email ?? '',
          widget.user.company?.phone ?? '',
          widget.user.firstName ?? '',
          '',
          '',
          '',
          '',
          '',
          '',
          0.00,
          500,
          000.00,
          '0.00',
          lastUpdated,
          widget.user.company?.name ?? '',
          widget.user.company?.address ?? '',
          null);
      print('Document sent to printer successfully.');
    } catch (e) {
      print('Error printing document: $e');
    }
  }
}



// import 'dart:convert';
// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:spotstock_inventory/data/models/schema.dart';
// import 'package:spotstock_inventory/data/models/userdetails.dart';
// import 'package:spotstock_inventory/widgets/register_tile.dart';
// import 'package:spotstock_inventory/widgets/sidebar.dart';
// import 'package:spotstock_inventory/widgets/sidebar_inventory.dart';
// import 'package:spotstock_inventory/widgets/transaction_tile.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/print_desktop.dart';
// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import '../../../../widgets/dialogs.dart';
// import '../../../mobile/home/pages/transactions.dart';
// import '../../pos/list_printers.dart';
// import '../../pos/printusb.dart';
// import 'booking_report_widget.dart';
// import 'header.dart';
// import 'sales_report_widget.dart';

// class Body extends StatefulWidget {
//   final UserDetails user;
//   final SystemProvider systemProvider;
//   final Size mediaQuery;
//   final String? app;
//   const Body({
//     super.key,
//     required this.user,
//     required this.systemProvider,
//     required this.mediaQuery,
//     required this.app,
//   });

//   @override
//   State<Body> createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   DateTimeRange? _selectedDateRangeFromHeader;
//   String? _selectedRegisterId;
//   List? reportData;
//   List? hotelReportData;
//   List? registerData;
//   int? registerIndex;
//   final bool _isLoading = false;
//   final ValueNotifier<String> _activeItem = ValueNotifier<String>("Reports");

//   @override
//   void initState() {
//     _fetchRegisters(app: widget.app);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _activeItem.dispose();
//     super.dispose();
//   }

//   void _handleDateRangeSelection(DateTimeRange selectedDateRange) {
//     setState(() {
//       _selectedDateRangeFromHeader = selectedDateRange;
//     });
//     _fetchRegisters(app: widget.app);
//   }

//   Future<List<Register>> _fetchRegisters({String? app}) async {
//     print("---------- module register ----------");
//     print(app);
//     if (_selectedDateRangeFromHeader == null) {
//       var regData = await widget.systemProvider.getAllRegisters(app: widget.app);
//       setState(() {
//         registerData = regData;
//       });
//       return widget.systemProvider.getAllRegisters(app: widget.app);
//     }
//     var regData = await widget.systemProvider.getAllRegisterByDate(
//         _selectedDateRangeFromHeader!.start, _selectedDateRangeFromHeader!.end, widget.app!);
//     setState(() {
//       registerData = regData;
//     });
//     print("Register Data ==>> $registerData");
//     return widget.systemProvider.getAllRegisterByDate(
//         _selectedDateRangeFromHeader!.start,
//         _selectedDateRangeFromHeader!.end,
//         widget.app!);
//   }

//   Future<List<Orders>> _fetchSalesReport() async {
//     if (_selectedRegisterId == null) {
//       return [];
//     }
//     reportData = await widget.systemProvider.getTransactionsByRegister(_selectedRegisterId);
//     return widget.systemProvider.getTransactionsByRegister(_selectedRegisterId);
//   }

//   Future<List<BookingX>> _fetchBookingReport() async {
//     if (_selectedRegisterId == null) {
//       return [];
//     }
//     hotelReportData = await widget.systemProvider.getBookingsByRegister(_selectedRegisterId);
//     return widget.systemProvider.getBookingsByRegister(_selectedRegisterId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ConstrainedBox(
//                   constraints: BoxConstraints(
//                     maxHeight: MediaQuery.of(context).size.height,
//                   ),
//                   child: SizedBox(
//                     width: 200,
//                     child: widget.app == "HOTEL"
//                         ? SideBarHotel(
//                             vertical: 20,
//                             user: widget.user,
//                             systemProvider: widget.systemProvider,
//                           )
//                         : SideBarInventory(
//                             vertical: 20,
//                             user: widget.user,
//                             systemProvider: widget.systemProvider,
//                             activeItem: _activeItem,
//                           ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Header(
//                         title: "${widget.app} Accounting",
//                         user: widget.user,
//                         systemProvider: widget.systemProvider,
//                         onDateRangeSelected: _handleDateRangeSelection,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               flex: 3,
//                               child: Container(
//                                 constraints: BoxConstraints(
//                                   maxHeight: widget.mediaQuery.height * 0.96,
//                                 ),
//                                 padding: const EdgeInsets.all(16.0),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'Register',
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 10),
//                                     if (registerData != [] && registerData != null)
//                                       Expanded(
//                                         child: Container(
//                                           margin: EdgeInsets.only(bottom: 100),
//                                           child: ListView.builder(
//                                             reverse: false,
//                                             shrinkWrap: true,
//                                             itemCount: registerData?.length,
//                                             itemBuilder: (context, index) {
//                                               final register = registerData?[index];
//                                               final openingAmt = double.tryParse(register.opening) ?? 0.0;
//                                               final closingAmt = double.tryParse(register.closing) ?? 0.0;
//                                               final createdAt =
//                                                   DateTime.tryParse(register.lastUpdated) ?? DateTime.now();
//                                               return register.module == widget.app
//                                                   ? RegisterTile(
//                                                       openingAmt: openingAmt,
//                                                       closingAmt: closingAmt,
//                                                       isClosed: register.closing != '',
//                                                       createdAt: createdAt,
//                                                       onView: () {
//                                                         setState(() {
//                                                           registerIndex = index;
//                                                           _selectedRegisterId = register.id.toString();
//                                                         });
//                                                       },
//                                                       onClose: () async {
//                                                         double? closingAmount = await showDialog<double>(
//                                                           context: context,
//                                                           builder: (context) {
//                                                             TextEditingController amountController = TextEditingController();
//                                                             return AlertDialog(
//                                                               title: Text("Enter Closing Amount"),
//                                                               content: TextField(
//                                                                 controller: amountController,
//                                                                 keyboardType: TextInputType.number,
//                                                                 decoration: const InputDecoration(
//                                                                   labelText: "Closing Amount",
//                                                                   hintText: "Enter closing amount",
//                                                                 ),
//                                                               ),
//                                                               actions: [
//                                                                 TextButton(
//                                                                   onPressed: () {
//                                                                     Navigator.of(context).pop();
//                                                                   },
//                                                                   child: const Text("Cancel"),
//                                                                 ),
//                                                                 TextButton(
//                                                                   onPressed: () {
//                                                                     double? amount = double.tryParse(amountController.text);
//                                                                     if (amount != null) {
//                                                                       Navigator.of(context).pop(amount);
//                                                                     }
//                                                                   },
//                                                                   child: const Text("Confirm"),
//                                                                 ),
//                                                               ],
//                                                             );
//                                                           },
//                                                         );

//                                                         if (closingAmount != null) {
//                                                           widget.systemProvider.closeRegister(closingAmount, widget.app);
//                                                           _fetchRegisters(app: widget.app);
//                                                         }
//                                                       },
//                                                     )
//                                                   : SizedBox();
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                             Expanded(
//                               flex: 3,
//                               child: Container(
//                                 constraints: BoxConstraints(
//                                   maxHeight: widget.mediaQuery.height * 0.96,
//                                 ),
//                                 padding: const EdgeInsets.all(16.0),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         const Text(
//                                           'Sales Report',
//                                           style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         Row(
//                                           children: [
//                                             TextButton(
//                                               onPressed: () async {
//                                                 widget.systemProvider.syncAllTransactions(widget.user);
//                                               },
//                                               child: const Text(
//                                                 'Sync All',
//                                                 style: TextStyle(
//                                                   fontSize: 15,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             ),
//                                             TextButton(
//                                               onPressed: () {
//                                                 if (reportData != null) {
//                                                   downloadReport();
//                                                 } else if (hotelReportData != null) {
//                                                   downloadHotelReport();
//                                                 } else {
//                                                   print('No report data available');
//                                                 }
//                                               },
//                                               child: Text(
//                                                 'Download',
//                                                 style: TextStyle(
//                                                   fontSize: 15,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     Expanded(
//                                       child: widget.app == "INVENTORY"
//                                           ? SalesReportWidget(
//                                               fetchSalesReport: _fetchSalesReport,
//                                               user: widget.user,
//                                               systemProvider: widget.systemProvider,
//                                             )
//                                           : BookingReportWidget(
//                                               user: widget.user,
//                                               systemProvider: widget.systemProvider,
//                                               fetchBookingReport: _fetchBookingReport,
//                                             ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> downloadReport() async {
//     List<Item> itemss = [];
//     for (var itemData in reportData!) {
//       if (itemData.items != null) {
//         for (var items in jsonDecode(itemData.items)) {
//           if (items is Map<String, dynamic>) {
//             var product = items['product'];
//             print("productssss ==>> $product");
//             String itemName = product['name'] as String;
//             int quantity = items['quantity'] as int;
//             double totalAmount;
//             if (items['totalAmount'] is String) {
//               totalAmount = double.tryParse(items['totalAmount']) ?? 0.0;
//             } else if (items['totalAmount'] is int) {
//               totalAmount = (items['totalAmount'] as int).toDouble();
//             } else if (items['totalAmount'] is double) {
//               totalAmount = items['totalAmount'];
//             } else {
//               totalAmount = 0.0;
//             }
//             Item item = Item(itemName, quantity, totalAmount);
//             itemss.add(item);
//             print("Items to Download ==>> $itemss");
//           }
//         }
//       } else {
//         print('Expected itemData to be a Map, but got: $itemData');
//       }
//     }
//     double totalAmount = itemss.map((item) => item.price).reduce((a, b) => a + b);
//     try {
//       print("company data ==>> ${widget.user.company?.phone}");
//       await printSampleDocument(
//           totalAmount,
//           itemss,
//           [],
//           '',
//           '',
//           widget.user.company!.email,
//           widget.user.company!.phone,
//           widget.user.firstName,
//           '',
//           '',
//           '',
//           '',
//           '',
//           '',
//           0.00,
//           500,
//           000.00,
//           '0.00',
//           DateTime.parse(registerData![registerIndex!].lastUpdated),
//           widget.user.company!.name,
//           widget.user.company!.address,
//           null);
//       print('Document sent to printer successfully.');
//     } catch (e) {
//       print('Error printing document: $e');
//     }
//   }

//   Future<void> downloadHotelReport() async {
//     if (hotelReportData == null || hotelReportData!.isEmpty) {
//       print('No hotel report data available');
//       return;
//     }
//     List<Item> itemss = [];
//     print("Printing hotel report");
//     for (var itemData in hotelReportData!) {
//       try {
//         if (itemData == null) continue;
//         final String? itemName = itemData.roomName;
//         if (itemName == null) {
//           print('Skipping item with null roomName');
//           continue;
//         }
//         final int quantity = int.tryParse(itemData.duration ?? '0') ?? 0;
//         double totalAmount = 0.0;
//         if (itemData.amount != null) {
//           if (itemData.amount is String) {
//             totalAmount = double.tryParse(itemData.amount as String) ?? 0.0;
//           } else if (itemData.amount is int) {
//             totalAmount = (itemData.amount as int).toDouble();
//           } else if (itemData.amount is double) {
//             totalAmount = itemData.amount as double;
//           }
//         }
//         Item item = Item(itemName, quantity, totalAmount);
//         itemss.add(item);
//         print("Added item: $item");
//       } catch (e) {
//         print('Error processing item: $e');
//       }
//     }
//     double totalAmount = itemss.isEmpty ? 0.0 : itemss.map((item) => item.price).reduce((a, b) => a + b);
//     if (widget.user.company == null) {
//       print('No company data available');
//       return;
//     }
//     if (registerData == null || registerIndex == null || registerIndex! >= registerData!.length) {
//       print('Invalid register data');
//       return;
//     }
//     DateTime? lastUpdated;
//     try {
//       lastUpdated = DateTime.parse(registerData![registerIndex!].lastUpdated);
//     } catch (e) {
//       print('Error parsing date: $e');
//       lastUpdated = DateTime.now();
//     }
//     try {
//       print("Company phone: ${widget.user.company?.phone}");
//       await printSampleDocument(
//           totalAmount,
//           [],
//           itemss,
//           '',
//           '',
//           widget.user.company?.email ?? '',
//           widget.user.company?.phone ?? '',
//           widget.user.firstName ?? '',
//           '',
//           '',
//           '',
//           '',
//           '',
//           '',
//           0.00,
//           500,
//           000.00,
//           '0.00',
//           lastUpdated,
//           widget.user.company?.name ?? '',
//           widget.user.company?.address ?? '',
//           null);
//       print('Document sent to printer successfully.');
//     } catch (e) {
//       print('Error printing document: $e');
//     }
//   }
// }