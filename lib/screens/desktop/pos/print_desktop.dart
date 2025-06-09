import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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

  const PrintScreenDialog(
      {super.key,
      required this.transactionData,
      this.type = 'receipt',
      required this.user});

  @override
  State<PrintScreenDialog> createState() => _PrintScreenDialogState();
}

class _PrintScreenDialogState extends State<PrintScreenDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
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
          child: Column(children: [
            Image.asset(
              'assets/images/spot-stock-logo.png',
              width: 200,
              height: 90,
            ),
          ]),
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
                      color: Colors.greenAccent),
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
                      "${widget.transactionData['trxId'] ?? widget.transactionData['trx']}",
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
                // ElevatedButton(onPressed: () {
                //   print("Reference ==> ${widget.transactionData['trxId'] ?? widget.transactionData['trx'] }");
                // }, child: Text("Print check")),
                Text(
                  widget.transactionData['trx'] == null
                      ? "You have successfully purchased goods worth of ${widget.transactionData['amount']} Naira"
                      : "You have successfully booked room ${widget.transactionData['roomName']} for a duration of ${widget.transactionData['duration']}day(s) for ${widget.transactionData['amount']} Naira only",
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
                        // printThisReceipt(); // Call the print function
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
      ]),
    );
  }

  printTheReceipt() async {
    var othersData = json.decode(widget.transactionData['others']);

    // Ensure the items data is in the correct format
    List<dynamic> itemsData;
    try {
      itemsData = json.decode(widget.transactionData['items']);
    } catch (e) {
      print("Error decoding items: $e");
      return; // Exit if decoding fails
    }

    List<Item> items = [];

    // Parse the items
    for (var itemData in itemsData) {
      if (itemData is Map<String, dynamic>) {
        var product = itemData['product'];

        // Check if product is a map
        if (product is Map<String, dynamic>) {
          String itemName = product['name'] as String;
          int quantity = itemData['quantity'] as int;

          double totalAmount;
          if (itemData['totalAmount'] is String) {
            totalAmount = double.tryParse(itemData['totalAmount']) ??
                0.0; // Handle String to double
          } else if (itemData['totalAmount'] is int) {
            totalAmount = (itemData['totalAmount'] as int)
                .toDouble(); // Convert int to double
          } else if (itemData['totalAmount'] is double) {
            totalAmount = itemData['totalAmount']; // Already a double
          } else {
            totalAmount = 0.0; // Default value in case of unexpected type
          }

          Item item = Item(itemName, quantity, totalAmount);
          items.add(item);
        } else {
          print('Expected product to be a Map, but got: $product');
        }
      } else {
        print('Expected itemData to be a Map, but got: $itemData');
      }
    }

    print("------------ items data -------------");

    print(items);

    // Extract other transaction details
    String customerName = widget.transactionData['customerName'];
    String transactionId = widget.transactionData['trxId'];
    double subtotal = othersData['subtotal'] is int
        ? (othersData['subtotal'] as int).toDouble()
        : (othersData['subtotal'] as double);
    double receivedAmount = othersData['receivedAmount'] is int
        ? (othersData['receivedAmount'] as int).toDouble()
        : (othersData['receivedAmount'] as double);
    double change = othersData['change'] is int
        ? (othersData['change'] as int).toDouble()
        : (othersData['change'] as double);
    String paymentMethod = widget.transactionData['paymentMethod'];

    DateTime createdAt = DateTime.parse(widget.transactionData['createdAt']);

    try {
      print("transaction data ==>> ${widget.transactionData}");
      print("company data ==>> ${widget.user.company?.phone}");
      var data = jsonDecode(widget.transactionData["items"]);
      var otherData = jsonDecode(widget.transactionData["others"]);
      String tableId = otherData['table'];
      await printSampleDocument(
          widget.transactionData['amount'],
          items,
          [],
          '',
          '',
          widget.user.company!.email,
          widget.user.company!.phone,
          widget.user.firstName,
          otherData['customerPhoneNumber'],
          data[0]['product']['warehouse'][0]['name'],
          otherData['paymentStatus'],
          tableId,
          customerName,
          transactionId,
          subtotal,
          receivedAmount,
          change,
          paymentMethod,
          createdAt,
        widget.user.company!.name,
        widget.user.company!.address,
      );

      print('Document sent to printer successfully.');
    } catch (e) {
      print('Error printing document: $e');
    }
  }

  printTheHotelReceipt() async {
    print("Printing for hotel");
    var othersData = json.decode(widget.transactionData['others']);
    print("Printing for hotel");
    // Ensure the items data is in the correct format
    // List<dynamic> itemsData;
    // try {
    //   itemsData = json.decode(widget.transactionData['items']);
    // } catch (e) {
    //   print("Error decoding items: $e");
    //   return; // Exit if decoding fails
    // }

    List<Item> hotelItems = [];

    // List hotelItems = [
    //   {
    //     "name": widget.transactionData['roomName'],
    //     "quantity": widget.transactionData['duration'],
    //     "price": widget.transactionData['perNight'],
    //   }
    // ];

    Item item = Item(widget.transactionData['roomName'], int.parse(widget.transactionData['duration']), double.parse(widget.transactionData['perNight']));
    hotelItems.add(item);

    print("Hotel item ==>> $hotelItems");

    // // Parse the items
    // for (var itemData in itemsData) {
    //   if (itemData is Map<String, dynamic>) {
    //     var product = itemData['product'];
    //
    //     // Check if product is a map
    //     if (product is Map<String, dynamic>) {
    //       String itemName = product['name'] as String;
    //       int quantity = itemData['quantity'] as int;
    //
    //       double totalAmount;
    //       if (itemData['totalAmount'] is String) {
    //         totalAmount = double.tryParse(itemData['totalAmount']) ??
    //             0.0; // Handle String to double
    //       } else if (itemData['totalAmount'] is int) {
    //         totalAmount = (itemData['totalAmount'] as int)
    //             .toDouble(); // Convert int to double
    //       } else if (itemData['totalAmount'] is double) {
    //         totalAmount = itemData['totalAmount']; // Already a double
    //       } else {
    //         totalAmount = 0.0; // Default value in case of unexpected type
    //       }
    //
    //       Item item = Item(itemName, quantity, totalAmount);
    //       items.add(item);
    //     } else {
    //       print('Expected product to be a Map, but got: $product');
    //     }
    //   } else {
    //     print('Expected itemData to be a Map, but got: $itemData');
    //   }
    // }

    print("------------ items data -------------");

    print(hotelItems);

    // Extract other transaction details
    print("customer name == ${othersData['customerName']}");
    String customerName = othersData['customerName'];
    String transactionId =
        widget.transactionData['trxId'] ?? widget.transactionData['trx'];
    double subtotal = othersData['subtotal'] is int
        ? (othersData['subtotal'] as int).toDouble()
        : (othersData['subtotal'] as double);
    double receivedAmount = othersData['receivedAmount'] is int
        ? (othersData['receivedAmount'] as int).toDouble()
        : (othersData['receivedAmount'] as double);
    double change = othersData['change'] is int
        ? (othersData['change'] as int).toDouble()
        : (othersData['change'] as double);
    String paymentMethod = widget.transactionData['paymentType'];

    DateTime createdAt =
        DateTime.parse(widget.transactionData['createdAt'].toString());

    try {
      print("Items ===>> $hotelItems");
      print("transaction data ==>> ${widget.transactionData}");
      var data = widget.transactionData["trxId"] != null
          ? jsonDecode(widget.transactionData["items"])
          : [];
      var otherData = jsonDecode(widget.transactionData["others"]);
      var folio = jsonDecode(widget.transactionData['folio']);
      print("Folio ======>> ${folio['folioName']}");
      String tableId = otherData['table'];
      print("Got here");
      await printSampleDocument(
          double.parse(widget.transactionData['amount'].toString()),
          [],
          hotelItems,
          widget.transactionData['checkin'],
          widget.transactionData['checkout'],
          widget.user.company!.email,
          widget.user.company!.phone,
          widget.user.firstName,
          otherData['customerPhoneNumber'],
          '',
          otherData['paymentStatus'],
          tableId,
          customerName,
          transactionId,
          subtotal,
          receivedAmount,
          change,
          paymentMethod,
          createdAt,
      widget.user.company!.name,
        widget.user.company!.address,
      );

      print('Document sent to printer successfully.');
    } catch (e) {
      print('Error printing document: $e');
    }
  }

  void onShowPrinters(BuildContext context, void Function(String) nextAction,
      UserDetails user, String? btnText) async {
    final store = await DatabaseEngine.instance.getStore();
    final storeBox = store.box<StoreX>();
    List<String> printers = listPrinters();

    if (printers.isNotEmpty) {
      // Correctly pass the nextAction to the printer selection dialog
      showPrinterSelectionDialog(
          context, printers, storeBox, nextAction, user, btnText);
    } else {
      print('No printers found');
      Dialogs.alertDialog(
          context, "Warning", "No printers found", "cancel", "save", []);
    }
  }
}
