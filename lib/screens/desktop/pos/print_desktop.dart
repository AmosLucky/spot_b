import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/helpers/database_engine.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/desktop/pos/list_printers.dart';
import 'package:spotstock_inventory/widgets/custom_btn.dart';
import 'package:spotstock_inventory/widgets/dialogs.dart';
import 'package:spotstock_inventory/widgets/show_printers.dart';
import 'printusb.dart';

class PrintScreenDialog extends StatefulWidget {
  final Map<String, dynamic> transactionData;
  final UserDetails user;
  final String? type;

  const PrintScreenDialog({
    super.key,
    required this.transactionData,
    this.type = 'receipt',
    required this.user,
  });

  @override
  State<PrintScreenDialog> createState() => _PrintScreenDialogState();
}

class _PrintScreenDialogState extends State<PrintScreenDialog> {
  // Validation function to check required transaction data
  bool validateTransactionData(Map<String, dynamic> data, bool isHotel) {
    final requiredFields = ['others', 'amount', 'createdAt'];
    if (isHotel) {
      requiredFields.addAll(['roomName', 'duration', 'perNight', 'paymentType']);
    } else {
      requiredFields.addAll(['items', 'customerName', 'paymentMethod', 'trxId']);
    }

    for (var field in requiredFields) {
      if (data[field] == null) {
        print('Validation failed: Missing $field');
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF2FCFE),
                  Color(0xFFFAF1FE),
                ],
                stops: [0, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/spot-stock-logo.png',
                  width: 200,
                  height: 90,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 500,
              height: 350,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Success",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.greenAccent,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.all(7.0),
                      padding: const EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor, width: 3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: SelectableText(
                        "${widget.transactionData['trxId'] ?? widget.transactionData['trx'] ?? 'N/A'}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Text(' Txn Reference '),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    widget.transactionData['trx'] == null
                        ? "You have successfully purchased goods worth of ${widget.transactionData['amount']?.toString() ?? '0.0'} Naira"
                        : "You have successfully booked room ${widget.transactionData['roomName'] ?? 'N/A'} for a duration of ${widget.transactionData['duration']?.toString() ?? '0'} day(s) for ${widget.transactionData['amount']?.toString() ?? '0.0'} Naira only",
                    style:
                        const TextStyle(color: Color(0xff063057), fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        label: "Print",
                        icon: MdiIcons.printer,
                        color: primaryColor,
                        onTap: () {
                          print("id==>> ${widget.transactionData['trxId']}");
                          widget.transactionData['trxId'] != null
                              ? printTheReceipt()
                              : printTheHotelReceipt();
                        },
                      ),
                      CustomButton(
                        label: "Change Printer",
                        icon: MdiIcons.cog,
                        color: Colors.teal,
                        onTap: () {
                          onShowPrinters(context, (printerName) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Printer changed successfully to $printerName!')),
                            );
                          }, widget.user, 'Save Printer');
                        },
                      ),
                      CustomButton(
                        label: "Back",
                        icon: MdiIcons.close,
                        color: Colors.red,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  printTheReceipt() async {
    try {
      List<String> printers = listPrinters();
      if (printers.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No printers found. Please select a printer.')),
        );
        onShowPrinters(context, (printerName) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Printer set to $printerName')),
          );
        }, widget.user, 'Save Printer');
        return;
      }

      if (!validateTransactionData(widget.transactionData, false)) {
        throw Exception('Invalid transaction data: missing required fields');
      }

      var othersData = json.decode(widget.transactionData['others']);
      List<dynamic> itemsData;
      try {
        itemsData = json.decode(widget.transactionData['items']);
      } catch (e) {
        throw Exception("Error decoding items: $e");
      }

      List<Item> items = [];
      for (var itemData in itemsData) {
        if (itemData is Map<String, dynamic>) {
          var product = itemData['product'];
          if (product is Map<String, dynamic>) {
            String itemName = product['name'] as String? ?? 'Unknown Item';
            int quantity = itemData['quantity'] as int? ?? 1;
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
            items.add(Item(itemName, quantity, totalAmount));
          } else {
            print('Expected product to be a Map, but got: $product');
          }
        } else {
          print('Expected itemData to be a Map, but got: $itemData');
        }
      }

      String customerName = widget.transactionData['customerName'] as String? ?? 'N/A';
      String transactionId = widget.transactionData['trxId'] as String? ?? 'N/A';
      double subtotal = othersData['subtotal'] is int
          ? (othersData['subtotal'] as int).toDouble()
          : (othersData['subtotal'] as double?) ?? 0.0;
      double receivedAmount = othersData['receivedAmount'] is int
          ? (othersData['receivedAmount'] as int).toDouble()
          : (othersData['receivedAmount'] as double?) ?? 0.0;
      double change = othersData['change'] is int
          ? (othersData['change'] as int).toDouble()
          : (othersData['change'] as double?) ?? 0.0;
      String paymentMethod = widget.transactionData['paymentMethod'] as String? ?? 'N/A';
      String? attendantName = othersData['attendantName'] as String?;
      DateTime createdAt = DateTime.tryParse(widget.transactionData['createdAt']?.toString() ?? '') ?? DateTime.now();
      String tableId = othersData['table'] as String? ?? 'N/A';
      String customerPhoneNumber = othersData['customerPhoneNumber'] as String? ?? 'N/A';
      String branch = itemsData.isNotEmpty && itemsData[0]['product']?['warehouse']?[0]?['name'] != null
          ? itemsData[0]['product']['warehouse'][0]['name'] as String
          : 'N/A';
      String paymentStatus = othersData['paymentStatus'] as String? ?? 'N/A';

      await printSampleDocument(
        widget.transactionData['amount']?.toDouble() ?? 0.0,
        items,
        [],
        '',
        '',
        widget.user.company?.email ?? 'N/A',
        widget.user.company?.phone ?? 'N/A',
        widget.user.firstName ?? 'N/A',
        customerPhoneNumber,
        branch,
        paymentStatus,
        tableId,
        customerName,
        transactionId,
        subtotal,
        receivedAmount,
        change,
        paymentMethod,
        createdAt,
        widget.user.company?.name ?? 'N/A',
        widget.user.company?.address ?? 'N/A',
        attendantName,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Receipt printed successfully!')),
      );
    } catch (e, stackTrace) {
      print('Error printing document: Missouri$stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to print receipt: $e')),
      );
    }
  }

  printTheHotelReceipt() async {
    try {
      List<String> printers = listPrinters();
      if (printers.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No printers found. Please select a printer.')),
        );
        onShowPrinters(context, (printerName) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Printer set to $printerName')),
          );
        }, widget.user, 'Save Printer');
        return;
      }

      if (!validateTransactionData(widget.transactionData, true)) {
        throw Exception('Invalid transaction data: missing required fields');
      }

      var othersData = json.decode(widget.transactionData['others']);
      List<Item> hotelItems = [];
      Item item = Item(
        widget.transactionData['roomName'] as String? ?? 'N/A',
        int.tryParse(widget.transactionData['duration']?.toString() ?? '1') ?? 1,
        double.tryParse(widget.transactionData['perNight']?.toString() ?? '0.0') ?? 0.0,
      );
      hotelItems.add(item);

      String customerName = othersData['customerName'] as String? ?? 'N/A';
      String transactionId = widget.transactionData['trxId'] as String? ?? widget.transactionData['trx'] as String? ?? 'N/A';
      double subtotal = othersData['subtotal'] is int
          ? (othersData['subtotal'] as int).toDouble()
          : (othersData['subtotal'] as double?) ?? 0.0;
      double receivedAmount = othersData['receivedAmount'] is int
          ? (othersData['receivedAmount'] as int).toDouble()
          : (othersData['receivedAmount'] as double?) ?? 0.0;
      double change = othersData['change'] is int
          ? (othersData['change'] as int).toDouble()
          : (othersData['change'] as double?) ?? 0.0;
      String paymentMethod = widget.transactionData['paymentType'] as String? ?? 'N/A';
      String? attendantName = othersData['attendantName'] as String?;
      DateTime createdAt = DateTime.tryParse(widget.transactionData['createdAt']?.toString() ?? '') ?? DateTime.now();
      String tableId = othersData['table'] as String? ?? 'N/A';
      String customerPhoneNumber = othersData['customerPhoneNumber'] as String? ?? 'N/A';

      await printSampleDocument(
        double.tryParse(widget.transactionData['amount']?.toString() ?? '0.0') ?? 0.0,
        [],
        hotelItems,
        widget.transactionData['checkin'] as String? ?? 'N/A',
        widget.transactionData['checkout'] as String? ?? 'N/A',
        widget.user.company?.email ?? 'N/A',
        widget.user.company?.phone ?? 'N/A',
        widget.user.firstName ?? 'N/A',
        customerPhoneNumber,
        '',
        othersData['paymentStatus'] as String? ?? 'N/A',
        tableId,
        customerName,
        transactionId,
        subtotal,
        receivedAmount,
        change,
        paymentMethod,
        createdAt,
        widget.user.company?.name ?? 'N/A',
        widget.user.company?.address ?? 'N/A',
        attendantName,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hotel receipt printed successfully!')),
      );
    } catch (e, stackTrace) {
      print('Error printing document: $e\nStackTrace: $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to print hotel receipt: $e')),
      );
    }
  }

  void onShowPrinters(BuildContext context, void Function(String) nextAction,
      UserDetails user, String? btnText) async {
    final store = await DatabaseEngine.instance.getStore();
    final storeBox = store.box<StoreX>();
    List<String> printers = listPrinters();

    if (printers.isNotEmpty) {
      showPrinterSelectionDialog(
        context,
        printers,
        storeBox,
        (printerName) async {
          try {
            await Printing.layoutPdf(
              onLayout: (format) async {
                final pdf = pw.Document();
                pdf.addPage(
                  pw.Page(
                    build: (context) => pw.Center(
                      child: pw.Text('Test Print Successful'),
                    ),
                  ),
                );
                return pdf.save();
              },
            );
            nextAction(printerName);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Printer test successful: $printerName')),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Printer test failed: $e')),
            );
          }
        },
        user,
        btnText,
      );
    } else {
      Dialogs.alertDialog(
        context,
        "Warning",
        "No printers found",
        "cancel",
        "save",
        [],
      );
    }
  }
}





// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/widgets.dart' as pw; // Add this import
// import 'package:printing/printing.dart';
// import 'package:spotstock_inventory/common/common.dart';
// import 'package:spotstock_inventory/common/helpers/database_engine.dart';
// import 'package:spotstock_inventory/data/models/schema.dart';
// import 'package:spotstock_inventory/data/models/userdetails.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/list_printers.dart';
// import 'package:spotstock_inventory/widgets/custom_btn.dart';
// import 'package:spotstock_inventory/widgets/dialogs.dart';
// import 'package:spotstock_inventory/widgets/show_printers.dart';
// import 'printusb.dart';

// class PrintScreenDialog extends StatefulWidget {
//   final Map<String, dynamic> transactionData;
//   final UserDetails user;
//   final String? type;

//   const PrintScreenDialog({
//     super.key,
//     required this.transactionData,
//     this.type = 'receipt',
//     required this.user,
//   });

//   @override
//   State<PrintScreenDialog> createState() => _PrintScreenDialogState();
// }

// class _PrintScreenDialogState extends State<PrintScreenDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color(0xFFF2FCFE),
//                   Color(0xFFFAF1FE),
//                 ],
//                 stops: [0, 1],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: Column(
//               children: [
//                 Image.asset(
//                   'assets/images/spot-stock-logo.png',
//                   width: 200,
//                   height: 90,
//                 ),
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: Container(
//               width: 500,
//               height: 350,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: Colors.white,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Success",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                       color: Colors.greenAccent,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Container(
//                       margin: const EdgeInsets.all(7.0),
//                       padding: const EdgeInsets.all(30.0),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: primaryColor, width: 3),
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(10.0)),
//                       ),
//                       child: SelectableText(
//                         "${widget.transactionData['trxId'] ?? widget.transactionData['trx']}",
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.justify,
//                       ),
//                     ),
//                   ),
//                   const Align(
//                     alignment: Alignment.topCenter,
//                     child: DecoratedBox(
//                       decoration: BoxDecoration(color: Colors.white),
//                       child: Text(' Txn Reference '),
//                     ),
//                   ),
//                   const SizedBox(height: 25),
//                   Text(
//                     widget.transactionData['trx'] == null
//                         ? "You have successfully purchased goods worth of ${widget.transactionData['amount']} Naira"
//                         : "You have successfully booked room ${widget.transactionData['roomName']} for a duration of ${widget.transactionData['duration']}day(s) for ${widget.transactionData['amount']} Naira only",
//                     style:
//                         const TextStyle(color: Color(0xff063057), fontSize: 14),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 25),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       CustomButton(
//                         label: "Print",
//                         icon: MdiIcons.printer,
//                         color: primaryColor,
//                         onTap: () {
//                           print("id==>> ${widget.transactionData['trxId']}");
//                           widget.transactionData['trxId'] != null
//                               ? printTheReceipt()
//                               : printTheHotelReceipt();
//                         },
//                       ),
//                       CustomButton(
//                         label: "Change Printer",
//                         icon: MdiIcons.cog,
//                         color: Colors.teal,
//                         onTap: () {
//                           onShowPrinters(context, (printerName) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                   content: Text(
//                                       'Printer changed successfully to $printerName!')),
//                             );
//                           }, widget.user, 'Save Printer');
//                         },
//                       ),
//                       CustomButton(
//                         label: "Back",
//                         icon: MdiIcons.close,
//                         color: Colors.red,
//                         onTap: () => Navigator.of(context).pop(),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   printTheReceipt() async {
//     try {
//       // Check for printers
//       List<String> printers = listPrinters();
//       if (printers.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('No printers found. Please select a printer.')),
//         );
//         onShowPrinters(context, (printerName) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Printer set to $printerName')),
//           );
//         }, widget.user, 'Save Printer');
//         return;
//       }

//       // Validate transaction data
//       if (widget.transactionData['items'] == null ||
//           widget.transactionData['others'] == null) {
//         throw Exception('Invalid transaction data: missing items or others');
//       }

//       var othersData = json.decode(widget.transactionData['others']);
//       List<dynamic> itemsData;
//       try {
//         itemsData = json.decode(widget.transactionData['items']);
//       } catch (e) {
//         throw Exception("Error decoding items: $e");
//       }

//       List<Item> items = [];
//       for (var itemData in itemsData) {
//         if (itemData is Map<String, dynamic>) {
//           var product = itemData['product'];
//           if (product is Map<String, dynamic>) {
//             String itemName = product['name'] as String;
//             int quantity = itemData['quantity'] as int;
//             double totalAmount;
//             if (itemData['totalAmount'] is String) {
//               totalAmount = double.tryParse(itemData['totalAmount']) ?? 0.0;
//             } else if (itemData['totalAmount'] is int) {
//               totalAmount = (itemData['totalAmount'] as int).toDouble();
//             } else if (itemData['totalAmount'] is double) {
//               totalAmount = itemData['totalAmount'];
//             } else {
//               totalAmount = 0.0;
//             }
//             Item item = Item(itemName, quantity, totalAmount);
//             items.add(item);
//           } else {
//             print('Expected product to be a Map, but got: $product');
//           }
//         } else {
//           print('Expected itemData to be a Map, but got: $itemData');
//         }
//       }

//       String customerName = widget.transactionData['customerName'];
//       String transactionId = widget.transactionData['trxId'];
//       double subtotal = othersData['subtotal'] is int
//           ? (othersData['subtotal'] as int).toDouble()
//           : (othersData['subtotal'] as double);
//       double receivedAmount = othersData['receivedAmount'] is int
//           ? (othersData['receivedAmount'] as int).toDouble()
//           : (othersData['receivedAmount'] as double);
//       double change = othersData['change'] is int
//           ? (othersData['change'] as int).toDouble()
//           : (othersData['change'] as double);
//       String paymentMethod = widget.transactionData['paymentMethod'];
//       String? attendantName = othersData['attendantName'];
//       DateTime createdAt = DateTime.parse(widget.transactionData['createdAt']);

//       var otherData = jsonDecode(widget.transactionData["others"]);
//       String tableId = otherData['table'];
//       await printSampleDocument(
//         widget.transactionData['amount'],
//         items,
//         [],
//         '',
//         '',
//         widget.user.company!.email,
//         widget.user.company!.phone,
//         widget.user.firstName,
//         otherData['customerPhoneNumber'],
//         itemsData[0]['product']['warehouse'][0]['name'],
//         otherData['paymentStatus'],
//         tableId,
//         customerName,
//         transactionId,
//         subtotal,
//         receivedAmount,
//         change,
//         paymentMethod,
//         createdAt,
//         widget.user.company!.name,
//         widget.user.company!.address,
//         attendantName,
//       );

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Receipt printed successfully!')),
//       );
//     } catch (e) {
//       print('Error printing document: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to print receipt: $e')),
//       );
//     }
//   }

//   printTheHotelReceipt() async {
//     try {
//       // Check for printers
//       List<String> printers = listPrinters();
//       if (printers.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('No printers found. Please select a printer.')),
//         );
//         onShowPrinters(context, (printerName) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Printer set to $printerName')),
//           );
//         }, widget.user, 'Save Printer');
//         return;
//       }

//       // Validate transaction data
//       if (widget.transactionData['others'] == null) {
//         throw Exception('Invalid transaction data: missing others');
//       }

//       var othersData = json.decode(widget.transactionData['others']);
//       List<Item> hotelItems = [];
//       Item item = Item(
//         widget.transactionData['roomName'],
//         int.parse(widget.transactionData['duration']),
//         double.parse(widget.transactionData['perNight']),
//       );
//       hotelItems.add(item);

//       String customerName = othersData['customerName'];
//       String transactionId =
//           widget.transactionData['trxId'] ?? widget.transactionData['trx'];
//       double subtotal = othersData['subtotal'] is int
//           ? (othersData['subtotal'] as int).toDouble()
//           : (othersData['subtotal'] as double);
//       double receivedAmount = othersData['receivedAmount'] is int
//           ? (othersData['receivedAmount'] as int).toDouble()
//           : (othersData['receivedAmount'] as double);
//       double change = othersData['change'] is int
//           ? (othersData['change'] as int).toDouble()
//           : (othersData['change'] as double);
//       String paymentMethod = widget.transactionData['paymentType'];
//       String? attendantName = othersData['attendantName'];
//       DateTime createdAt =
//           DateTime.parse(widget.transactionData['createdAt'].toString());

//       var otherData = jsonDecode(widget.transactionData["others"]);
//       String tableId = otherData['table'];
//       await printSampleDocument(
//         double.parse(widget.transactionData['amount'].toString()),
//         [],
//         hotelItems,
//         widget.transactionData['checkin'],
//         widget.transactionData['checkout'],
//         widget.user.company!.email,
//         widget.user.company!.phone,
//         widget.user.firstName,
//         otherData['customerPhoneNumber'],
//         '',
//         otherData['paymentStatus'],
//         tableId,
//         customerName,
//         transactionId,
//         subtotal,
//         receivedAmount,
//         change,
//         paymentMethod,
//         createdAt,
//         widget.user.company!.name,
//         widget.user.company!.address,
//         attendantName,
//       );

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Hotel receipt printed successfully!')),
//       );
//     } catch (e) {
//       print('Error printing document: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to print hotel receipt: $e')),
//       );
//     }
//   }

//   void onShowPrinters(BuildContext context, void Function(String) nextAction,
//       UserDetails user, String? btnText) async {
//     final store = await DatabaseEngine.instance.getStore();
//     final storeBox = store.box<StoreX>();
//     List<String> printers = listPrinters();

//     if (printers.isNotEmpty) {
//       showPrinterSelectionDialog(
//         context,
//         printers,
//         storeBox,
//         (printerName) async {
//           try {
//             await Printing.layoutPdf(
//               onLayout: (format) async {
//                 final pdf = pw.Document();
//                 pdf.addPage(
//                   pw.Page(
//                     build: (context) => pw.Center(
//                       child: pw.Text('Test Print Successful'),
//                     ),
//                   ),
//                 );
//                 return pdf.save();
//               },
//             );
//             nextAction(printerName);
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Printer test successful: $printerName')),
//             );
//           } catch (e) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Printer test failed: $e')),
//             );
//           }
//         },
//         user,
//         btnText,
//       );
//     } else {
//       Dialogs.alertDialog(
//         context,
//         "Warning",
//         "No printers found",
//         "cancel",
//         "save",
//         [],
//       );
//     }
//   }
// }