import 'dart:convert';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/cart_provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/user_details.dart';
import '../print_invoices.dart';
import '../printusb.dart';
import 'select_attendantdialog.dart';
import '../../model/select_attendant_model.dart';
import '../../providers/select_attendant_provider.dart';
import '../dialogs/select_attendant_pin.dart';

class InvoiceList extends StatefulWidget {
  final List<dynamic> products;
  final Size mediaQuery;
  final SystemProvider systemProvider;
  final Map registerInfo;
  final UserDetails user;
  final VoidCallback closeInvoice;

  const InvoiceList({
    super.key,
    required this.products,
    required this.mediaQuery,
    required this.systemProvider,
    required this.registerInfo,
    required this.closeInvoice,
    required this.user,
  });

  @override
  _InvoiceListState createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  List<dynamic> _invoices = [];
  int? selectedInvoiceIndex;
  late SelectAttendantProvider _selectAttendantProvider;

  @override
  void initState() {
    super.initState();
    _selectAttendantProvider = Provider.of<SelectAttendantProvider>(context, listen: false);
    _loadInvoices();
  }

  void _loadInvoices() async {
    var invoices = await getInvoices();
    if (mounted) {
      setState(() {
        _invoices = invoices;
        _invoices.sort((a, b) {
          String dateA = a['lastUpdated'] ?? '';
          String dateB = b['lastUpdated'] ?? '';
          return dateB.compareTo(dateA);
        });
      });
      print("Invoices ==>> $_invoices");
    }
  }

  Future<List<dynamic>> getInvoices() async {
    try {
      return await widget.systemProvider.getInvoices(widget.registerInfo['id']);
    } catch (e) {
      print('Error fetching invoices: $e');
      return [];
    }
  }

  Future<void> deleteInvoice(int id) async {
    try {
      await widget.systemProvider.deleteInvoice(id);
      if (mounted) {
        setState(() {
          _invoices.removeWhere((invoice) => invoice['id'] == id);
        });
      }
      print('Invoice $id deleted successfully.');
    } catch (e) {
      print('Error deleting invoice $id: $e');
    }
  }

  Future<void> clearInvoices() async {
    try {
      await widget.systemProvider.clearInvoices();
      if (mounted) {
        setState(() {
          _invoices.clear();
        });
      }
      print('All invoices cleared for register ${widget.registerInfo['id']}');
    } catch (e) {
      print('Error clearing invoices: $e');
    }
  }

  // Get attendant name by ID
  Future<String?> _getAttendantNameById(String? attendantId) async {
    if (attendantId == null || attendantId.isEmpty) return null;
    
    try {
      final attendants = await _selectAttendantProvider.loadAttendants();
      final attendant = _selectAttendantProvider.attendants.firstWhere(
        (a) => a.apiId.toString() == attendantId,
        orElse: () => throw Exception('Attendant not found'),
      );
      return attendant.fullName;
    } catch (e) {
      print('Error getting attendant name: $e');
      return 'Unknown Attendant';
    }
  }

  // Show attendant verification dialog for printing
  void _showAttendantVerificationForPrint(Map<String, dynamic> invoiceItem) {
    showDialog(
      context: context,
      builder: (context) => ChangeNotifierProvider.value(
        value: _selectAttendantProvider,
        child: SelectAttendantDialog(
          onAttendantSelected: (attendant) {
            _promptForPinVerification(attendant, invoiceItem);
          },
          previouslySelectedAttendant: null,
        ),
      ),
    );
  }

  void _promptForPinVerification(SelectAttendantModel attendant, Map<String, dynamic> invoiceItem) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SelectAttendantPinDialog(
        attendant: attendant,
        onPinVerified: (verified) {
          if (verified) {
            // Print with attendant information
            printInvoice(invoiceItem, attendant.fullName);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Printing authorized by ${attendant.fullName}'),
                backgroundColor: Colors.green,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Print authorization failed'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              "Hold List",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: widget.closeInvoice,
              child: Text(
                "Close",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                    fontWeight: FontWeight.normal),
              ),
            )
          ]),
          const SizedBox(height: 5),
          Expanded(
            child: _invoices.isEmpty
                ? const Center(child: Text("No items available"))
                : ListView.builder(
                    itemCount: _invoices.length,
                    itemBuilder: (context, index) {
                      var item = _invoices[index];
                      return Dismissible(
                        key: ValueKey<int>(item['id']),
                        direction: DismissDirection.horizontal,
                        background: Container(
                          color: primaryColor,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          deleteInvoice(item['id']);
                        },
                        child: FutureBuilder<String?>(
                          future: _getAttendantNameById(item['attendantId']),
                          builder: (context, snapshot) {
                            String displayName;
                            if (item['attendantId'] != null && item['attendantId'].isNotEmpty) {
                              displayName = snapshot.data ?? 'Loading...';
                            } else {
                              displayName = item['customerName'] ?? 'Walk-in Customer';
                            }

                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 1, vertical: 1),
                              title: Text(
                                item['reference'],
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['attendantId'] != null && item['attendantId'].isNotEmpty
                                        ? "Attendant: $displayName"
                                        : "Customer: $displayName",
                                    style: TextStyle(color: grayColor),
                                  ),
                                  if (item['attendantId'] != null && item['attendantId'].isNotEmpty)
                                    Text(
                                      "Attendant ID: ${item['attendantId']}",
                                      style: TextStyle(color: grayColor, fontSize: 11),
                                    ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Amount: ${Money.format(item['amount'])}",
                                        style: TextStyle(color: grayColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(MdiIcons.redoVariant),
                                    onPressed: () {
                                      Provider.of<CartProvider>(context, listen: false)
                                          .redoInvoice(
                                        item['invoice'],
                                        item['id'],
                                        index,
                                        originalReference: item['reference'],
                                        attendantId: item['attendantId'],
                                        customerName: item['customerName'],
                                      );
                                      widget.closeInvoice();
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(MdiIcons.printer),
                                    onPressed: () {
                                      setState(() {
                                        selectedInvoiceIndex = index;
                                      });
                                      // Show attendant verification dialog for printing
                                      _showAttendantVerificationForPrint(item);
                                    },
                                  ),
                                ]
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 10),
          _invoices.isEmpty
              ? const SizedBox()
              : CustomButton(
                  label: "Clear all",
                  icon: MdiIcons.deleteEmptyOutline,
                  color: Colors.redAccent,
                  onTap: clearInvoices,
                ),
        ],
      ),
    );
  }

  printInvoice(Map<String, dynamic> invoiceItem, String? printingAttendantName) async {
    List<dynamic> itemsData;
    var invoiceData = jsonDecode(invoiceItem['invoice']);
    var invoice = invoiceItem;
    print(invoice);
    String invoiceId = invoice['reference'];
    List<Item> items = [];
    print("invoicess ==>> $invoiceData");

    for (var itemData in invoiceData) {
      if (itemData is Map<String, dynamic>) {
        var product = itemData['product'];
        print("productssss ==>> $product");
        String itemName = product['name'] as String;
        int quantity = itemData['quantity'] as int;
        double totalAmount;
        if (itemData['totalAmount'] is String) {
          totalAmount = double.tryParse(itemData['totalAmount']) ?? 0.0;
        } else if (itemData['totalAmount'] is int) {
          totalAmount = (itemData['totalAmount'] as int).toDouble();
        } else if (itemData['totalAmount'] is double) {
          totalAmount = itemData['totalAmount'];
        } else {
          totalAmount = 0.0;
        }
        Item item = Item(itemName, quantity, totalAmount);
        items.add(item);
      } else {
        print('Expected itemData to be a Map, but got: $itemData');
      }
    }

    double totalAmount = items.map((item) => item.price).reduce((a, b) => a + b);
    print("------------ items data -------------");
    print(items);

    // Determine customer/attendant display
    String customerOrAttendantName;
    bool hasAttendant = invoice['attendantId'] != null && invoice['attendantId'].isNotEmpty;
    
    if (hasAttendant) {
      String? attendantName = await _getAttendantNameById(invoice['attendantId']);
      customerOrAttendantName = attendantName ?? 'Unknown Attendant';
    } else {
      customerOrAttendantName = invoice['customerName'] ?? 'Walk-in Customer';
    }

    try {
      await printInvoiceDocument(
        invoice['amount'],
        items,
        widget.user.company!.email,
        widget.user.company!.phone,
        widget.user.firstName,
        0.00,
        0.00,
        DateTime.now(),
        invoice['reference'],
        invoice['lastUpdated'],
        invoiceData[0]['product']['warehouse'][0]['name'],
        widget.user.company!.name,
        widget.user.company!.address,
        customerOrAttendantName,
        invoice['customerPhone'] ?? "",
        invoice['tableId'] ?? "",
        hasAttendant, // Pass flag to indicate if this is an attendant
        printingAttendantName, // Pass the name of attendant who authorized the print
      );
      print('Document sent to printer successfully.');
    } catch (e) {
      print('Error printing document: $e');
    }
  }
}






// import 'dart:convert';
// import 'package:spotstock_inventory/common/common.dart';
// import 'package:spotstock_inventory/common/money.dart';
// import 'package:spotstock_inventory/common/provider/cart_provider.dart';
// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:spotstock_inventory/widgets/custom_btn.dart';
// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:provider/provider.dart';
// import '../../../../data/models/user_details.dart';
// import '../print_invoices.dart';
// import '../printusb.dart';

// class InvoiceList extends StatefulWidget {
//   final List<dynamic> products;
//   final Size mediaQuery;
//   final SystemProvider systemProvider;
//   final Map registerInfo;
//   final UserDetails user;
//   final VoidCallback closeInvoice;

//   const InvoiceList({
//     super.key,
//     required this.products,
//     required this.mediaQuery,
//     required this.systemProvider,
//     required this.registerInfo,
//     required this.closeInvoice,
//     required this.user,
//   });

//   @override
//   _InvoiceListState createState() => _InvoiceListState();
// }

// class _InvoiceListState extends State<InvoiceList> {
//   List<dynamic> _invoices = [];
//   int? selectedInvoiceIndex;

//   @override
//   void initState() {
//     super.initState();
//     _loadInvoices();
//   }

//   void _loadInvoices() async {
//     var invoices = await getInvoices();
//     if (mounted) {
//       setState(() {
//         // **FIX 1: Sort invoices by lastUpdated in descending order (newest first)**
//         _invoices = invoices;
//         _invoices.sort((a, b) {
//           String dateA = a['lastUpdated'] ?? '';
//           String dateB = b['lastUpdated'] ?? '';
//           return dateB.compareTo(dateA); // Descending order (newest first)
//         });
//       });
//       print("Invoices ==>> $_invoices");
//     }
//   }

//   Future<List<dynamic>> getInvoices() async {
//     try {
//       return await widget.systemProvider.getInvoices(widget.registerInfo['id']);
//     } catch (e) {
//       print('Error fetching invoices: $e');
//       return [];
//     }
//   }

//   Future<void> deleteInvoice(int id) async {
//     try {
//       await widget.systemProvider.deleteInvoice(id);
//       if (mounted) {
//         setState(() {
//           _invoices.removeWhere((invoice) => invoice['id'] == id);
//         });
//       }
//       print('Invoice $id deleted successfully.');
//     } catch (e) {
//       print('Error deleting invoice $id: $e');
//     }
//   }

//   Future<void> clearInvoices() async {
//     try {
//       await widget.systemProvider.clearInvoices();
//       if (mounted) {
//         setState(() {
//           _invoices.clear();
//         });
//       }
//       print('All invoices cleared for register ${widget.registerInfo['id']}');
//     } catch (e) {
//       print('Error clearing invoices: $e');
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.mediaQuery.width * 0.3,
//       constraints: BoxConstraints(
//         maxHeight: widget.mediaQuery.height * 0.96,
//       ),
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             const Text(
//               "Hold List",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             InkWell(
//               onTap: widget.closeInvoice,
//               child: Text(
//                 "Close",
//                 style: TextStyle(
//                     fontSize: 15,
//                     color: Colors.red,
//                     fontWeight: FontWeight.normal),
//               ),
//             )
//           ]),
//           const SizedBox(height: 5),
//           Expanded(
//             child: _invoices.isEmpty
//                 ? const Center(child: Text("No items available"))
//                 : ListView.builder(
//                     itemCount: _invoices.length,
//                     itemBuilder: (context, index) {
//                       var item = _invoices[index];
//                       return Dismissible(
//                         key: ValueKey<int>(item['id']),
//                         direction: DismissDirection.horizontal,
//                         background: Container(
//                           color: primaryColor,
//                           alignment: Alignment.centerLeft,
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: const Icon(Icons.delete, color: Colors.white),
//                         ),
//                         secondaryBackground: Container(
//                           color: Colors.red,
//                           alignment: Alignment.centerRight,
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: const Icon(Icons.delete, color: Colors.white),
//                         ),
//                         onDismissed: (direction) {
//                           deleteInvoice(item['id']);
//                         },
//                         child: ListTile(
//                             contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 1, vertical: 1),
//                             title: Text(
//                               item['reference'],
//                               overflow: TextOverflow.ellipsis,
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 13),
//                             ),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Customer: ${item['customerName']}",
//                                   style: TextStyle(color: grayColor),
//                                 ),
//                                 if (item['attendantId'] != null)
//                                   Text(
//                                     "Attendant ID: ${item['attendantId']}",
//                                     style: TextStyle(color: grayColor, fontSize: 11),
//                                   ),
//                                 Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Text(
//                                       "Amount: ${Money.format(item['amount'])}",
//                                       style: TextStyle(color: grayColor),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             trailing:
//                                 Row(mainAxisSize: MainAxisSize.min, children: [
//                               IconButton(
//                                 icon: Icon(MdiIcons.redoVariant),
//                                 onPressed: () {
//                                   // Updated redoInvoice call with additional parameters
//                                   Provider.of<CartProvider>(context,
//                                           listen: false)
//                                       .redoInvoice(
//                                         item['invoice'],
//                                          item['id'],
//                                          index,
//                                         originalReference: item['reference'],
//                                         attendantId: item['attendantId'],
//                                         customerName: item['customerName'],
//                                       );
//                                   widget.closeInvoice();
//                                 },
//                               ),
//                               IconButton(
//                                 icon: Icon(MdiIcons.printer),
//                                 onPressed: () {
//                                   // **FIX 1: Use the actual invoice ID instead of index for print selection**
//                                   setState(() {
//                                     selectedInvoiceIndex = index;
//                                   });
//                                   printInvoice(item); // Pass the actual item
//                                 },
//                               ),
//                             ])),
//                       );
//                     },
//                   ),
//           ),
//           const SizedBox(height: 10),
//           _invoices.isEmpty
//               ? const SizedBox()
//               : CustomButton(
//                   label: "Clear all",
//                   icon: MdiIcons.deleteEmptyOutline,
//                   color: Colors.redAccent,
//                   onTap: clearInvoices,
//                 ),
//         ],
//       ),
//     );
//   }

//   // **FIX 1: Modified printInvoice to accept the specific invoice item**
//   printInvoice(Map<String, dynamic> invoiceItem) async {
//     List<dynamic> itemsData;
//     var invoiceData = jsonDecode(invoiceItem['invoice']);
//     var invoice = invoiceItem;
//     print(invoice);
//     String invoiceId = invoice['reference'];
//     List<Item> items = [];
//     print("invoicess ==>> $invoiceData");
    
//     for (var itemData in invoiceData) {
//       if (itemData is Map<String, dynamic>) {
//         var product = itemData['product'];
//         print("productssss ==>> $product");
//         String itemName = product['name'] as String;
//         int quantity = itemData['quantity'] as int;
//         double totalAmount;
//         if (itemData['totalAmount'] is String) {
//           totalAmount = double.tryParse(itemData['totalAmount']) ?? 0.0;
//         } else if (itemData['totalAmount'] is int) {
//           totalAmount = (itemData['totalAmount'] as int).toDouble();
//         } else if (itemData['totalAmount'] is double) {
//           totalAmount = itemData['totalAmount'];
//         } else {
//           totalAmount = 0.0;
//         }
//         Item item = Item(itemName, quantity, totalAmount);
//         items.add(item);
//       } else {
//         print('Expected itemData to be a Map, but got: $itemData');
//       }
//     }

//     double totalAmount = items.map((item) => item.price).reduce((a, b) => a + b);
//     print("------------ items data -------------");
//     print(items);
    
//     try {
//       await printInvoiceDocument(
//           invoice['amount'],
//           items,
//           widget.user.company!.email,
//           widget.user.company!.phone,
//           widget.user.firstName,
//           0.00,
//           0.00,
//           DateTime.now(),
//       invoice['reference'],
//       invoice['lastUpdated'],
//           invoiceData[0]['product']['warehouse'][0]['name'],
//         widget.user.company!.name,
//         widget.user.company!.address,
//         invoice['customerName'] ?? "",
//         invoice['customerPhone'] ?? "",
//         invoice['tableId'] ?? "",
//       );
//       print('Document sent to printer successfully.');
//     } catch (e) {
//       print('Error printing document: $e');
//     }
//   }
// }