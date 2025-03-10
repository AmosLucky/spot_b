import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/mobile/home/home_screen_mobile.dart';
import 'package:flutter/material.dart' hide Image;
// import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'dart:io' show Platform;
import 'package:image/image.dart';
import 'package:permission_handler/permission_handler.dart';

import '../common/provider/user_provider.dart';
import '../widgets/custom_btn.dart';
import 'desktop/pos/list_printers.dart';
import 'desktop/pos/printusb.dart';

class PrintReceipt extends StatefulWidget {
  final Map<String, dynamic> data;
  final Map<String, dynamic> others;
  final List items;
  const PrintReceipt({super.key, required this.data, required this.items, required this.others,});

  @override
  State<PrintReceipt> createState() => _PrintReceiptState();
}

class _PrintReceiptState extends State<PrintReceipt> {
  // PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
  // List<PrinterBluetooth> _devices = [];
  // String? _devicesMsg;
  // BluetoothManager bluetoothManager = BluetoothManager.instance;

  @override
  void initState() {
    if (Platform.isAndroid) {
      // bluetoothManager.state.listen((val) {
      //   print('state = $val');
      //   if (!mounted) return;
      //   if (val == 12) {
      //     print('on');
      //     initPrinter();
      //   } else if (val == 10) {
      //     print('off');
      //     setState(() => _devicesMsg = 'Bluetooth Disconnected!');
      //   }
      // });
    } else {
      // initPrinter();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserDetails user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          'Print',
          style: TextStyle(color: whiteColor),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HomeScreenMobile();
              }));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Reprint ${widget.data['customerName']}'s\ntransaction receipt",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  ),),

            SizedBox(height: 2.h,),

            Container(
              margin: const EdgeInsets.all(7.0),
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor, width: 3),
                  borderRadius:
                  BorderRadius.all(Radius.circular(10.0))),
              child: Column(
                children: [
                  Text("Transaction Reference",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),),

                  SizedBox(height: 0.h,),

                  Text(widget.data['trxId'],
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),),
                ],
              ),
            ),

            SizedBox(height: 8.h,),

            CustomButton(
              label: "Print Receipt",
              icon: MdiIcons.printer,
              color: primaryColor,
              onTap: () {
                printTheReceipt();
                //  printThisReceipt(); // Call the print function
              },
            ),
          ],
        ),
      ),
    );
  }

  // _devices.isEmpty
  //         ? Center(child: Text(_devicesMsg ?? ''))
  //         : ListView.builder(
  //             itemCount: _devices.length,
  //             itemBuilder: (c, i) {
  //               return ListTile(
  //                 leading: const Icon(Icons.print),
  //                 title: Text(_devices[i].name!),
  //                 subtitle: Text(_devices[i].address!),
  //                 onTap: () {
  //                   _startPrint(_devices[i]);
  //                 },
  //               );
  //             },
  //           )

  // void initPrinter() async {
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.location,
  //     Permission.bluetoothScan,
  //     Permission.bluetoothConnect
  //   ].request();
  //   for (var status in statuses.entries) {
  //     if (status.key == Permission.location) {
  //       if (status.value.isGranted) {
  //         debugPrint('Location permission granted');
  //       } else {
  //         debugPrint("Location permission not granted");
  //       }
  //     } else if (status.key == Permission.bluetoothScan) {
  //       if (status.value.isGranted) {
  //         debugPrint('Bluetooth scan permission granted');
  //       } else {
  //         debugPrint('Bluetooth scan permission not granted');
  //       }
  //     } else if (status.key == Permission.bluetoothConnect) {
  //       if (status.value.isGranted) {
  //         debugPrint('Bluetooth connect permission granted');
  //       } else {
  //         debugPrint('Bluetooth connect permission not granted');
  //       }
  //     }
  //   }
  //   _printerManager.startScan(const Duration(seconds: 2));
  //   _printerManager.scanResults.listen((val) {
  //     print("========= bluetooth ========");
  //     print(val);
  //     if (!mounted) return;
  //     setState(() => _devices = val);
  //     if (_devices.isEmpty) setState(() => _devicesMsg = 'No Devices');
  //   });
  // }

  // Future<void> _startPrint(PrinterBluetooth printer) async {
  //   _printerManager.selectPrinter(printer);
  //   final result =
  //       await _printerManager.printTicket(await _ticket(PaperSize.mm80));
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       content: Text(result.msg),
  //     ),
  //   );
  // }

  // Future<List<int>> _ticket(PaperSize paper) async {
  //   final profile = await CapabilityProfile.load();
  //   final generator = Generator(PaperSize.mm80, profile);
  //   List<int> bytes = [];

  //   // Image assets
  //   final ByteData data = await rootBundle.load('assets/logo/nl.png');
  //   final Uint8List imgBytes = data.buffer.asUint8List();
  //   final Image image = decodeImage(imgBytes)!;
  //   bytes += generator.image(image);

  //   bytes += generator.row([
  //     // PosColumn(
  //     //   text: 'col3',
  //     //   width: 3,
  //     //   styles: const PosStyles(align: PosAlign.center, underline: true),
  //     // ),
  //     PosColumn(
  //       text: 'Items',
  //       width: 6,
  //       styles: const PosStyles(align: PosAlign.center, underline: true),
  //     ),
  //     PosColumn(
  //       text: 'Amount',
  //       width: 3,
  //       styles: const PosStyles(align: PosAlign.center, underline: true),
  //     ),
  //   ]);

  //   bytes += generator.text(
  //     'Ebeano Inventory',
  //     styles: const PosStyles(
  //         align: PosAlign.center,
  //         height: PosTextSize.size2,
  //         width: PosTextSize.size2),
  //     linesAfter: 1,
  //   );

  //   var items = widget.items;

  //   for (var i = 0; i < items.length; i++) {
  //     var item = items[i]['product'];
  //     var qtyAmt = item['Net_price'] * items[i]['quantity'];
  //     bytes += generator.text(item['name']);
  //     bytes += generator.row([
  //       PosColumn(
  //           text: '${item['Net_price']} x ${items[i]['quantity']}', width: 6),
  //       PosColumn(text: 'N$qtyAmt', width: 6),
  //     ]);
  //   }

  //   bytes += generator.feed(1);
  //   bytes += generator.row([
  //     PosColumn(text: 'Total', width: 6, styles: const PosStyles(bold: true)),
  //     PosColumn(
  //         text: 'N${widget.data["amount"]}',
  //         width: 6,
  //         styles: const PosStyles(bold: true)),
  //   ]);
  //   bytes += generator.row([
  //     PosColumn(
  //         text: 'Customer Name', width: 6, styles: const PosStyles(bold: true)),
  //     PosColumn(
  //         text: '${widget.data["customer_name"]}',
  //         width: 6,
  //         styles: const PosStyles(bold: true)),
  //   ]);
  //   bytes += generator.row([
  //     PosColumn(
  //         text: 'Receipt No', width: 6, styles: const PosStyles(bold: true)),
  //     PosColumn(
  //         text: '${widget.data["trxId"]}',
  //         width: 6,
  //         styles: const PosStyles(bold: true)),
  //   ]);
  //   bytes += generator.row([
  //     PosColumn(
  //         text: 'Date Issued: ', width: 6, styles: const PosStyles(bold: true)),
  //     PosColumn(
  //         text: '${widget.data["created_at"]}',
  //         width: 6,
  //         styles: const PosStyles(bold: true)),
  //   ]);
  //   bytes += generator.feed(2);
  //   bytes += generator.text('Thank You',
  //       styles: const PosStyles(align: PosAlign.center, bold: true));
  //   bytes += generator.cut();
  //   return bytes;
  // }

  // @override
  // void dispose() {
  //   _printerManager.stopScan();
  //   super.dispose();
  // }

  printTheReceipt() async {
    UserDetails user = Provider.of<UserProvider>(context, listen: false).user;
    // var othersData = json.decode(widget.transactionData['others']);
    //
    // // Ensure the items data is in the correct format
    // List<dynamic> itemsData;
    // try {
    //   itemsData = json.decode(widget.transactionData['items']);
    // } catch (e) {
    //   print("Error decoding items: $e");
    //   return; // Exit if decoding fails
    // }

    List<Item> items = [];

    // Parse the items
    for (var itemData in widget.items) {
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
    String customerName = widget.data['customerName'];
    String transactionId = widget.data['trxId'];
    double subtotal = widget.others['subtotal'] is int
        ? (widget.others['subtotal'] as int).toDouble()
        : (widget.others['subtotal'] as double);
    double receivedAmount = widget.others['receivedAmount'] is int
        ? (widget.others['receivedAmount'] as int).toDouble()
        : (widget.others['receivedAmount'] as double);
    double change = widget.others['change'] is int
        ? (widget.others['change'] as int).toDouble()
        : (widget.others['change'] as double);
    String paymentMethod = widget.data['paymentMethod'];

    DateTime createdAt = DateTime.parse(widget.data['createdAt']);

    try {
      var data = jsonDecode(widget.data["items"]);
      var otherData = jsonDecode(widget.data["others"]);
      String tableId = widget.data["tableId"].toString() ;
      log("Ok ==>> ${tableId}");
      await printSampleDocument(
          widget.data['amount'],
          items,
          [],
          '',
          '',
          user.email,
          user.phone,
          user.firstName,
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
        user.company!.name,
        user.company!.address,
      );
      print('Document sent to printer successfully.');
    } catch (e) {
      print('Error printing document: $e');
    }
  }
}
