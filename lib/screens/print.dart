import 'dart:convert';
import 'dart:developer';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/mobile/home/home_screen_mobile.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import '../common/provider/user_provider.dart';
import '../widgets/custom_btn.dart';
import 'desktop/pos/list_printers.dart';
import 'desktop/pos/printusb.dart';

class PrintReceipt extends StatefulWidget {
  final Map<String, dynamic> data;
  final Map<String, dynamic> others;
  final List items;
  const PrintReceipt({super.key, required this.data, required this.items, required this.others});

  @override
  State<PrintReceipt> createState() => _PrintReceiptState();
}

class _PrintReceiptState extends State<PrintReceipt> {
  @override
  void initState() {
    if (Platform.isAndroid) {}
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
            Text(
              "Reprint ${widget.data['customerName']}'s\ntransaction receipt",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2.h),
            Container(
              margin: const EdgeInsets.all(7.0),
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor, width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Column(
                children: [
                  Text(
                    "Transaction Reference",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  ),
                  SizedBox(height: 0.h),
                  Text(
                    widget.data['trxId'],
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            CustomButton(
              label: "Print Receipt",
              icon: MdiIcons.printer,
              color: primaryColor,
              onTap: () {
                printTheReceipt();
              },
            ),
          ],
        ),
      ),
    );
  }

  printTheReceipt() async {
    UserDetails user = Provider.of<UserProvider>(context, listen: false).user;

    List<Item> items = [];

    for (var itemData in widget.items) {
      if (itemData is Map<String, dynamic>) {
        var product = itemData['product'];
        if (product is Map<String, dynamic>) {
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
          print('Expected product to be a Map, but got: $product');
        }
      } else {
        print('Expected itemData to be a Map, but got: $itemData');
      }
    }

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
    String? attendantName = widget.others['attendantName']; // Extract attendantName
    DateTime createdAt = DateTime.parse(widget.data['createdAt']);

    try {
      var data = jsonDecode(widget.data["items"]);
      var otherData = jsonDecode(widget.data["others"]);
      String tableId = widget.data["tableId"].toString();
      log("Ok ==>> $tableId");
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
        attendantName, // Added attendantName
      );
      print('Document sent to printer successfully.');
    } catch (e) {
      print('Error printing document: $e');
    }
  }
}



// import 'dart:convert';
// import 'dart:developer';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:spotstock_inventory/common/common.dart';
// import 'package:spotstock_inventory/data/models/userdetails.dart';
// import 'package:spotstock_inventory/screens/mobile/home/home_screen_mobile.dart';
// import 'package:flutter/material.dart' hide Image;
// import 'package:flutter/services.dart';
// import 'dart:io' show Platform;
// import '../common/provider/user_provider.dart';
// import '../widgets/custom_btn.dart';
// import 'desktop/pos/list_printers.dart';
// import 'desktop/pos/printusb.dart';

// class PrintReceipt extends StatefulWidget {
//   final Map<String, dynamic> data;
//   final Map<String, dynamic> others;
//   final List items;
//   const PrintReceipt({super.key, required this.data, required this.items, required this.others,});

//   @override
//   State<PrintReceipt> createState() => _PrintReceiptState();
// }

// class _PrintReceiptState extends State<PrintReceipt> {
//   // PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
//   // List<PrinterBluetooth> _devices = [];
//   // String? _devicesMsg;
//   // BluetoothManager bluetoothManager = BluetoothManager.instance;

//   @override
//   void initState() {
//     if (Platform.isAndroid) {
//       // bluetoothManager.state.listen((val) {
//       //   print('state = $val');
//       //   if (!mounted) return;
//       //   if (val == 12) {
//       //     print('on');
//       //     initPrinter();
//       //   } else if (val == 10) {
//       //     print('off');
//       //     setState(() => _devicesMsg = 'Bluetooth Disconnected!');
//       //   }
//       // });
//     } else {
//       // initPrinter();
//     }

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     UserDetails user = Provider.of<UserProvider>(context).user;
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         backgroundColor: primaryColor,
//         centerTitle: true,
//         title: const Text(
//           'Print',
//           style: TextStyle(color: whiteColor),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.home, color: Colors.white),
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 return HomeScreenMobile();
//               }));
//             },
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [

//             Text("Reprint ${widget.data['customerName']}'s\ntransaction receipt",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.bold,
//                   ),),

//             SizedBox(height: 2.h,),

//             Container(
//               margin: const EdgeInsets.all(7.0),
//               padding: const EdgeInsets.all(30.0),
//               decoration: BoxDecoration(
//                   border: Border.all(color: primaryColor, width: 3),
//                   borderRadius:
//                   BorderRadius.all(Radius.circular(10.0))),
//               child: Column(
//                 children: [
//                   Text("Transaction Reference",
//                     style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.deepPurple),),

//                   SizedBox(height: 0.h,),

//                   Text(widget.data['trxId'],
//                     style: TextStyle(
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.deepPurple),),
//                 ],
//               ),
//             ),

//             SizedBox(height: 8.h,),

//             CustomButton(
//               label: "Print Receipt",
//               icon: MdiIcons.printer,
//               color: primaryColor,
//               onTap: () {
//                 printTheReceipt();
//                 //  printThisReceipt(); // Call the print function
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }



//   printTheReceipt() async {
//     UserDetails user = Provider.of<UserProvider>(context, listen: false).user;

//     List<Item> items = [];

//     // Parse the items
//     for (var itemData in widget.items) {
//       if (itemData is Map<String, dynamic>) {
//         var product = itemData['product'];

//         // Check if product is a map
//         if (product is Map<String, dynamic>) {
//           String itemName = product['name'] as String;
//           int quantity = itemData['quantity'] as int;

//           double totalAmount;
//           if (itemData['totalAmount'] is String) {
//             totalAmount = double.tryParse(itemData['totalAmount']) ??
//                 0.0; // Handle String to double
//           } else if (itemData['totalAmount'] is int) {
//             totalAmount = (itemData['totalAmount'] as int)
//                 .toDouble(); // Convert int to double
//           } else if (itemData['totalAmount'] is double) {
//             totalAmount = itemData['totalAmount']; // Already a double
//           } else {
//             totalAmount = 0.0; // Default value in case of unexpected type
//           }

//           Item item = Item(itemName, quantity, totalAmount);
//           items.add(item);
//         } else {
//           print('Expected product to be a Map, but got: $product');
//         }
//       } else {
//         print('Expected itemData to be a Map, but got: $itemData');
//       }
//     }

//     print("------------ items data -------------");

//     print(items);

//     // Extract other transaction details
//     String customerName = widget.data['customerName'];
//     String transactionId = widget.data['trxId'];
//     double subtotal = widget.others['subtotal'] is int
//         ? (widget.others['subtotal'] as int).toDouble()
//         : (widget.others['subtotal'] as double);
//     double receivedAmount = widget.others['receivedAmount'] is int
//         ? (widget.others['receivedAmount'] as int).toDouble()
//         : (widget.others['receivedAmount'] as double);
//     double change = widget.others['change'] is int
//         ? (widget.others['change'] as int).toDouble()
//         : (widget.others['change'] as double);
//     String paymentMethod = widget.data['paymentMethod'];

//     DateTime createdAt = DateTime.parse(widget.data['createdAt']);

//     try {
//       var data = jsonDecode(widget.data["items"]);
//       var otherData = jsonDecode(widget.data["others"]);
//       String tableId = widget.data["tableId"].toString() ;
//       log("Ok ==>> $tableId");
//       await printSampleDocument(
//           widget.data['amount'],
//           items,
//           [],
//           '',
//           '',
//           user.email,
//           user.phone,
//           user.firstName,
//           otherData['customerPhoneNumber'],
//           data[0]['product']['warehouse'][0]['name'],
//           otherData['paymentStatus'],
//           tableId,
//           customerName,
//           transactionId,
//           subtotal,
//           receivedAmount,
//           change,
//           paymentMethod,
//           createdAt,
//         user.company!.name,
//         user.company!.address,
//       );
//       print('Document sent to printer successfully.');
//     } catch (e) {
//       print('Error printing document: $e');
//     }
//   }
// }