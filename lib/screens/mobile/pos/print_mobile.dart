import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/helpers/database_engine.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/screens/desktop/pos/list_printers.dart';
import 'package:spotstock_inventory/screens/desktop/pos/printusb.dart';
import 'package:spotstock_inventory/widgets/custom_btn.dart';
import 'package:spotstock_inventory/widgets/dialogs.dart';
import 'package:spotstock_inventory/widgets/show_printers.dart';

class PrintMobileScreenDialog extends StatefulWidget {
  final Map<String, dynamic> transactionData;
  final UserDetails user;
  final String? type;

  const PrintMobileScreenDialog(
      {super.key,
      required this.transactionData,
      this.type = 'receipt',
      required this.user});

  @override
  State<PrintMobileScreenDialog> createState() => _PrintScreenDialogState();
}

class _PrintScreenDialogState extends State<PrintMobileScreenDialog> {
  @override

  final int _counter = 0;
  File? _imageFile;

//Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();
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

            SizedBox(height: 10.h,),

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
            height: 450,
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
                      "${widget.transactionData['trxId']}",
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
                  "You have successfully purchased goods worth of ${widget.transactionData['amount']} Naira",
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
                        printTheReceipt();
                        //  printThisReceipt(); // Call the print function
                      },
                    ),
                    // CustomButton(
                    //   label: "Change Printer",
                    //   icon: MdiIcons.cog,
                    //   color: Colors.teal,
                    //   onTap: () async {
                    //     printTheReceipt();

                    //     // onShowPrinters(context, (printerName) {
                    //     //   ScaffoldMessenger.of(context).showSnackBar(
                    //     //     SnackBar(
                    //     //         content: Text(
                    //     //             'Printer changed successfully to $printerName!')),
                    //     //   );
                    //     // }, widget.user, 'Save Printer');
                    //   },
                    // ),
                    CustomButton(
                      label: "Back",
                      icon: MdiIcons.close,
                      color: Colors.red,
                      onTap: () => Navigator.of(context).pop(),
                    ),

                  ],
                ),

                SizedBox(height: 5.h,),

                CustomButton(
                  label: "Share Receipt",
                  icon: MdiIcons.share,
                  color: primaryColor,
                  onTap: () {
                    shareTheReceipt();
                    //  printThisReceipt(); // Call the print function
                  },
                ),

                // ElevatedButton(onPressed: () {
                //   shareTheReceipt();
                // }, child: Text("Share Receipt")),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void printThisReceipt() async {
    print("---------- transaction data --------");
    print(widget.transactionData);

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
    String createdAtFormatted =
        '${createdAt.day}-${createdAt.month}-${createdAt.year} ${createdAt.hour}:${createdAt.minute}';

    // Print the receipt
    for (var item in items) {
      print('${item.name} (x${item.quantity}): N${item.price}');
    }
    print('Thank you for your purchase!');
    var transData = {"txnData": widget.transactionData, "others": othersData};

    var printers = await context.read<SystemProvider>().getPrinters();

    //  print("Thank mee later $printers");
    if (printers.isNotEmpty) {
      printReceipt(printers['value'], widget.user, transData,
          widget.transactionData['customerName'], items);
    } else {
      onShowPrinters(context, (printerName) {
        print(printerName);
        printReceipt(printerName, widget.user, transData,
            widget.transactionData['customerName'], items);
      }, widget.user, 'Print Now');
    }

    // listPrinters();
    // printReceipt(
    //     'XP-90', widget.user, widget.transactionData['customerName'], items);
  }

  shareTheReceipt() async {
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
    String customerPhoneNumber = othersData['customerPhoneNumber'];
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
      var data = jsonDecode(widget.transactionData["items"]);
      var otherData = jsonDecode(widget.transactionData["others"]);
      String tableId = otherData['table'] ;

      screenshotController
          .captureFromWidget(Container(
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text('SPOT STOCK MANAGER',
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
              ),

              Center(
                child: Text('8 Ugwuoba Street Enugu',
                    style: TextStyle(fontSize: 10, color: Colors.black)),
              ),

              Center(
                child: Text(widget.user.email,
                    style: TextStyle(fontSize: 10, color: Colors.black)),
              ),

              Center(
                child: Text(widget.user.phone,
                    style: TextStyle(fontSize: 10, color: Colors.black)),
              ),

              SizedBox(height: 2),

              Divider(thickness: 0.5, color: Colors.black),

              SizedBox(height: 2),

              Text("SALES INVOICE",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),),

              // Customer and Date
              Text('Branch:  ${data[0]['product']['warehouse'][0]['name']}',
              style: TextStyle(fontSize: 10, color: Colors.black)),
              Text('Customer:  $customerName',
              style: TextStyle(fontSize: 10, color: Colors.black)),
              Text('Customer phone:  $customerPhoneNumber',
                  style: TextStyle(fontSize: 10, color: Colors.black)),
              Text('Invoice no:  $transactionId',
              style: TextStyle(fontSize: 10, color: Colors.black)),
              Text('Payment status:  ${otherData['paymentStatus']}',
              style: TextStyle(fontSize: 10, color: Colors.black)),
              Text('Sold By:  ${widget.user.firstName}', style: TextStyle(fontSize: 10, color: Colors.black)),
              Text('Table: :  $tableId', style: TextStyle(fontSize: 10, color: Colors.black)),
              Text('Date:  $createdAt', style: TextStyle(fontSize: 10, color: Colors.black,)),

              SizedBox(height: 1),

              Divider(thickness: 0.5, color: Colors.black),

              DataTable(
                dividerThickness: 0.00000000001,
                checkboxHorizontalMargin: 0,
                horizontalMargin: 0,
                  dataRowHeight: 3.h,
                headingRowHeight: 3.h,
                  columns: [
                    DataColumn(
                      headingRowAlignment: MainAxisAlignment.start,
                      label: Text('Item',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 10,
                      ),),
                    ),
                    DataColumn(
                      label: Text('Qty',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 10
                      ),),
                    ),
                    DataColumn(
                      label: Text('Price',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 10
                      ),),
                    ),
                    DataColumn(
                      label: Text('Amount',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 10
                      ),),
                    ),
                  ],
                  rows: items
                      .map(
                        (e) => DataRow(
                      cells: [
                        DataCell(
                          SizedBox(
                            width: 16.w,
                            child: Text(
                              e.name,
                              style: TextStyle(
                                fontStyle: FontStyle.italic, color: Colors.black, fontSize: 10
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            e.quantity.toString(),
                            style: TextStyle(
                              fontStyle: FontStyle.italic,color: Colors.black,
                                fontSize: 10
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            e.price.toStringAsFixed(2),
                            style: TextStyle(
                              fontStyle: FontStyle.italic,color: Colors.black,
                              fontSize: 10
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                          (e.price * e.quantity).toStringAsFixed(2),
                            style: TextStyle(
                              fontStyle: FontStyle.italic,color: Colors.black, fontSize: 10
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).toList()),

              SizedBox(height: 1),

              Divider(thickness: 0.5, color: Colors.black),

              SizedBox(height: 1),

              // Subtotal, VAT, Total, Paid By
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal:', style: TextStyle(fontSize: 10, color: Colors.black)),
                    //pw.SizedBox(width: 20),
                    Text('NGN$subtotal',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
                  ]),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Discount:', style: TextStyle(fontSize: 10, color: Colors.black)),
                    //pw.SizedBox(width: 40),
                    Text('NGN0.00',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tax:', style: TextStyle(fontSize: 10, color: Colors.black)),
                    //pw.SizedBox(width: 40),
                    Text('NGN0.00',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Grand Total:', style: TextStyle(fontSize: 10, color: Colors.black)),
                    //pw.SizedBox(width: 38),
                    Text('NGN${widget.transactionData['amount']}',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
                  ]),

              // Payment details
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Paid by:', style: TextStyle(fontSize: 10, color: Colors.black)),
                    //pw.SizedBox(width: 20),
                    Text(paymentMethod,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Amount paid:', style:TextStyle(fontSize: 10, color: Colors.black)),
                    //pw.SizedBox(width: 34),
                    Text('NGN$receivedAmount',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Change:', style: TextStyle(fontSize: 10, color: Colors.black)),
                    //pw.SizedBox(width: 25),
                    Text('NGN$change',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
                  ]),

              SizedBox(height: 10),

              // Thank you message
              Center(child: Text('Thank You!',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),)
            ],
          )))
          .then((capturedImage) async{
        File? file;
        final Directory? appDir = Platform.isAndroid
            ? await getExternalStorageDirectory()
            : await getApplicationDocumentsDirectory();
        String tempPath = appDir!.path;
        String fileName =
            "${DateTime.now().microsecondsSinceEpoch}TransactionReceipt(Trustbanc).jpeg";
        file = File('$tempPath/$fileName');
        if (!await file.exists()) {
          await file.create();
        }
        await file.writeAsBytes(capturedImage as List<int>);

        print(file.path);
        final box = context.findRenderObject() as RenderBox?;
        final result = await Share.shareXFiles([XFile(file.path)],
            sharePositionOrigin: Rect.fromLTWH(0, 0, MediaQuery.of(context).size.width, MediaQuery.of(context).size.height / 2));
        if (result.status == ShareResultStatus.success) {
          debugPrint('Thank you for sharing the receipt!');
        }
      });
      print('Document sent to printer successfully.');
    } catch (e) {
      print('Error printing document: $e');
    }
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
      var data = jsonDecode(widget.transactionData["items"]);
      var otherData = jsonDecode(widget.transactionData["others"]);
      String tableId = otherData['table'] ;
      await printSampleDocument(
          widget.transactionData['amount'],
          items,
          [],
          '',
          '',
          widget.user.email,
          widget.user.phone,
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
        null //No attendant selected
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
