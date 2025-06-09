import 'dart:convert';

import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/desktop/pos/list_printers.dart';
import 'package:spotstock_inventory/screens/desktop/pos/print_desktop.dart';
import 'package:flutter/material.dart';
import 'package:spotstock_inventory/screens/desktop/pos/printusb.dart';
import 'package:spotstock_inventory/widgets/sidebar_inventory.dart';
import 'package:spotstock_inventory/widgets/transaction_tile.dart';

import 'header.dart';

class Body extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final Size mediaQuery;

  const Body(
      {super.key,
      required this.user,
      required this.systemProvider,
      required this.mediaQuery});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime? _selectedDateFromHeader;
  String? _selectedRegisterId; // Store selected register ID
  List? reportData;
  List? hotelReportData;
  List? registerData;
  int? registerIndex;

  void _handleDateSelection(DateTime selectedDate) {
    setState(() {
      _selectedDateFromHeader = selectedDate;
    });
  }

  Future<List<Orders>> _fetchTransactions() async {
    return widget.systemProvider.getTransactionsByDate(_selectedDateFromHeader);
  }

  Future<List<Orders>> _fetchWaitingToSync() {
    return widget.systemProvider.getWaitingSyncDate(_selectedDateFromHeader);
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
                    width: 200,
                    child: SideBarInventory(
                      vertical: 20,
                      user: widget.user,
                      systemProvider: widget.systemProvider,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SalesHeader(
                        user: widget.user,
                        systemProvider: widget.systemProvider,
                        onDateSelected: _handleDateSelection,
                      ),
                      const SizedBox(height: 10),

                      // Row for displaying both History and Waiting to Sync sections side by side
                      Row(
                        children: [
                          // History Section
                          Expanded(
                            flex: 1,
                            child: FutureBuilder<List<Orders>>(
                              future: _fetchTransactions(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return const Center(
                                      child:
                                          Text('Error fetching transactions'));
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                      child: Text('No transactions found'));
                                }

                                final transactions = snapshot.data!;
                                return Container(
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              //     : downloadHotelReport();
                                              _printAllTransactions(
                                                  transactions);
                                            },
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color:
                                                        ColorsRes.cardpurple),
                                                child: Text(
                                                  'Download All',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        'History',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: transactions.length,
                                        itemBuilder: (context, index) {
                                          final transaction =
                                              transactions[index];
                                          return TransactionTile(
                                            transactionId: transaction.trxId,
                                            amount: transaction.amount,
                                            customer: transaction.customerName,
                                            createdAt: transaction.createdAt,
                                            isSynced: transaction.sync == 1,
                                            paymentMethod:
                                                transaction.paymentMethod,
                                            onPrint: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          PrintScreenDialog(
                                                            user: widget.user,
                                                            transactionData:
                                                                transaction
                                                                    .toMap(),
                                                          )));
                                            },
                                            onSync: () {},
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(
                              width:
                                  20), // Add some space between the two sections

                          // Waiting to Sync Section
                          Expanded(
                            flex: 1,
                            child: FutureBuilder<List<Orders>>(
                              future: _fetchWaitingToSync(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return const Center(
                                      child: Text(
                                          'Error fetching waiting to sync transactions'));
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                      child: Text(
                                          'No transactions waiting to sync'));
                                }

                                final waitingToSync = snapshot.data!;
                                return Container(
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              //     : downloadHotelReport();
                                              _printAllTransactions(
                                                  waitingToSync);
                                            },
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color:
                                                        ColorsRes.cardpurple),
                                                child: Text(
                                                  'Download All',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          ),
                                        ),
                                      ),
                                      Gap(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Waiting to Sync',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // Add sync functionality here
                                            },
                                            child: const Text(
                                              'Sync All',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: waitingToSync.length,
                                        itemBuilder: (context, index) {
                                          final syncItem = waitingToSync[index];
                                          return TransactionTile(
                                            transactionId: syncItem.trxId,
                                            amount: syncItem.amount,
                                            // status: syncItem.status,
                                            customer: syncItem.customerName,
                                            createdAt: syncItem.createdAt,
                                            isSynced: syncItem.sync == 1,
                                            paymentMethod:
                                                syncItem.paymentMethod,
                                            onPrint: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      PrintScreenDialog(
                                                    user: widget.user,
                                                    transactionData:
                                                        syncItem.toMap(),
                                                  ),
                                                ),
                                              );
                                            },
                                            onSync: () {},
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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



  void _printAllTransactions(List<Orders> transactions) {
    // Create a map to aggregate items by name
    Map<String, Map<String, dynamic>> itemsMap = {};
    Map<String, Map<String, dynamic>> hotelItemsMap = {};

    // Variables to store aggregated totals
    double totalAmount = 0.0;

    // Extract and aggregate data from all transactions
    for (var transaction in transactions) {
      final transactionData = transaction.toMap();
      totalAmount += transaction.amount;

      try {
        // Process regular sales items
        if (transactionData['items'] != null) {
          List<dynamic> itemsData = json.decode(transactionData['items']);

          for (var itemData in itemsData) {
            if (itemData is Map<String, dynamic>) {
              var product = itemData['product'];

              if (product is Map<String, dynamic>) {
                String itemName = product['name'];
                int quantity = itemData['quantity'];
                double itemTotal = 0.0;

                if (itemData['totalAmount'] is String) {
                  itemTotal = double.tryParse(itemData['totalAmount']) ?? 0.0;
                } else if (itemData['totalAmount'] is int) {
                  itemTotal = (itemData['totalAmount'] as int).toDouble();
                } else if (itemData['totalAmount'] is double) {
                  itemTotal = itemData['totalAmount'];
                }

                // Update our aggregation map
                if (itemsMap.containsKey(itemName)) {
                  itemsMap[itemName]!['quantity'] += quantity;
                  itemsMap[itemName]!['price'] += itemTotal;
                } else {
                  itemsMap[itemName] = {
                    'quantity': quantity,
                    'price': itemTotal
                  };
                }
              }
            }
          }
        }

        // Process hotel room items if applicable
        if (transactionData['roomName'] != null &&
            transactionData['duration'] != null) {
          String roomName = transactionData['roomName'];
          int duration = int.tryParse(transactionData['duration']) ?? 0;
          double perNight =
              double.tryParse(transactionData['perNight'] ?? '0') ?? 0.0;
          double roomTotal = perNight * duration;

          // Update our hotel items aggregation map
          if (hotelItemsMap.containsKey(roomName)) {
            hotelItemsMap[roomName]!['quantity'] += duration;
            hotelItemsMap[roomName]!['price'] += roomTotal;
          } else {
            hotelItemsMap[roomName] = {
              'quantity': duration,
              'price': roomTotal
            };
          }
        }
      } catch (e) {
        print('Error processing transaction ${transaction.trxId}: $e');
      }
    }

    // Convert maps to lists of Item objects
    List<Item> allItems = itemsMap.entries.map((entry) {
      return Item(entry.key, entry.value['quantity'], entry.value['price']);
    }).toList();

    List<Item> allHotelItems = hotelItemsMap.entries.map((entry) {
      return Item(entry.key, entry.value['quantity'], entry.value['price']);
    }).toList();

    // Get date range
    DateTime firstDate =
        DateTime.parse(transactions.first.createdAt.toString());
    DateTime lastDate = DateTime.parse(transactions.last.createdAt.toString());

    // Print the aggregated summary
    _printSummaryReceipt(
      allItems,
      allHotelItems,
      totalAmount,
      transactions.length,
      firstDate,
      lastDate,
    );
  }

  Future<void> _printSummaryReceipt(
    List<Item> items,
    List<Item> hotelItems,
    double totalAmount,
    int transactionCount,
    DateTime firstDate,
    DateTime lastDate,
  ) async {
    try {
      // Create a summary header text
      String dateRangeText = '';
      if (firstDate.day == lastDate.day &&
          firstDate.month == lastDate.month &&
          firstDate.year == lastDate.year) {
        // Same day report
        dateRangeText = DateFormat('dd/MM/yyyy').format(firstDate);
      } else {
        // Date range report
        dateRangeText =
            '${DateFormat('dd/MM/yyyy').format(firstDate)} - ${DateFormat('dd/MM/yyyy').format(lastDate)}';
      }

      // Create a summary receipt
      await printSampleDocument(
        totalAmount,
        items,
        hotelItems,
        DateFormat('yyyy-MM-dd HH:mm:ss')
            .format(firstDate), // First transaction date
        DateFormat('yyyy-MM-dd HH:mm:ss')
            .format(lastDate), // Last transaction date
        widget.user.company!.email,
        widget.user.company!.phone,
        widget.user.firstName,
        '', // No specific customer for a summary
        '', // No specific warehouse for a summary
        'PAID', // Assuming all transactions are paid
        '', // No specific table for a summary
        'Summary Report ($transactionCount transactions)', // Custom title with transaction count
        'SUMMARY-${DateTime.now().millisecondsSinceEpoch}', // Generate a unique ID for the summary
        totalAmount, // subtotal equals total for summary
        totalAmount, // received amount equals total for summary
        0.0, // No change for a summary report
        'VARIOUS', // Payment method as "VARIOUS" for a summary
        DateTime.now(), // Current date/time for the report
        widget.user.company!.name,
        widget.user.company!.address,
        null // No Added attendantName
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Summary report generated for $transactionCount transactions'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Error printing summary report: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error generating summary report: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> downloadReport() async {
    // Parse the items
    List<Item> itemss = [];

    for (var itemData in reportData!) {
      if (itemData.items != null) {
        for (var items in jsonDecode(itemData.items)) {
          if (items is Map<String, dynamic>) {
            var product = items['product'];
            print("productssss ==>> $product");

            // Check if product is a map
            String itemName = product['name'] as String;
            int quantity = items['quantity'] as int;

            double totalAmount;
            if (items['totalAmount'] is String) {
              totalAmount = double.tryParse(items['totalAmount']) ??
                  0.0; // Handle String to double
            } else if (items['totalAmount'] is int) {
              totalAmount = (items['totalAmount'] as int)
                  .toDouble(); // Convert int to double
            } else if (items['totalAmount'] is double) {
              totalAmount = items['totalAmount']; // Already a double
            } else {
              totalAmount = 0.0; // Default value in case of unexpected type
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

    double totalAmount =
        itemss.map((item) => item.price).reduce((a, b) => a + b);

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
        null // No Added attendantName
      );

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

    double totalAmount = itemss.isEmpty
        ? 0.0
        : itemss.map((item) => item.price).reduce((a, b) => a + b);

    if (widget.user.company == null) {
      print('No company data available');
      return;
    }

    if (registerData == null ||
        registerIndex == null ||
        registerIndex! >= registerData!.length) {
      print('Invalid register data');
      return;
    }

    // Parse date safely
    DateTime? lastUpdated;
    try {
      lastUpdated = DateTime.parse(registerData![registerIndex!].lastUpdated);
    } catch (e) {
      print('Error parsing date: $e');
      lastUpdated = DateTime.now(); // fallback to current date
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
        null // No Added attendantName
      );

      print('Document sent to printer successfully.');
    } catch (e) {
      print('Error printing document: $e');
      // Consider showing an error message to the user
    }
  }
}


  // void _printAllTransactions(List<Orders> transactions) {
  //   List<Map<String, dynamic>> allTransactions = [];
  //   for (var transaction in transactions) {
  //     allTransactions.add(transaction.toMap());
  //   }
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (_) => PrintScreenDialog(
  //         user: widget.user,
  //         transactionData: allTransactions.fold<Map<String, dynamic>>(
  //           {},
  //           (previous, current) => {...previous, ...current},
  //         ), // Ensure PrintScreenDialog can handle a list
  //       ),
  //     ),
  //   );
  // }