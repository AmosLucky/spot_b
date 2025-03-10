// import 'dart:typed_data';
// import 'package:flutter/services.dart';
// import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
// import 'package:image/image.dart' as Imag;
//
// class Item {
//   final String name;
//   final int quantity;
//   final double price;
//
//   Item(this.name, this.quantity, this.price);
// }
//
// class UserDetails {
//   final String companyName;
//   final String companyAddress;
//
//   UserDetails(this.companyName, this.companyAddress);
// }
//
// class ReceiptPrinter {
//   Future<List<BluetoothInfo>> listPairedPrinters() async {
//     final List<BluetoothInfo> printers =
//         await PrintBluetoothThermal.pairedBluetooths;
//
//     if (printers.isEmpty) {
//       print("No paired printers found.");
//     } else {
//       for (var printer in printers) {
//         print('Printer Name: ${printer.name}, Address: ${printer.macAdress}');
//       }
//     }
//     return printers;
//   }
//
//   Future<void> printOrderReceipt(String printerAddress, UserDetails user,
//       String customerName, List<Item> items) async {
//     bool connectionStatus = await PrintBluetoothThermal.connectionStatus;
//
//     if (connectionStatus) {
//       List<int> ticket = await createReceipt(user, customerName, items);
//       final result = await PrintBluetoothThermal.writeBytes(ticket);
//       print("Print result: $result");
//     } else {
//       print('No connected printer.');
//     }
//   }
//
//   Future<List<int>> createReceipt(
//       UserDetails user, String customerName, List<Item> items) async {
//     List<int> bytes = [];
//
//     // Using default profile
//     final profile = await CapabilityProfile.load();
//     final generator = Generator(PaperSize.mm58, profile);
//     bytes += generator.reset();
//
//     // Load logo image
//     final ByteData data = await rootBundle.load('assets/mylogo.jpg');
//     final Uint8List bytesImg = data.buffer.asUint8List();
//     final image = Imag.decodeImage(bytesImg);
//     bytes += generator.image(image!);
//
//     // Receipt header
//     bytes += generator.text(user.companyName,
//         styles: PosStyles(bold: true, align: PosAlign.center));
//     bytes += generator.text(user.companyAddress,
//         styles: PosStyles(align: PosAlign.center));
//     bytes += generator.text('Customer: $customerName', styles: PosStyles());
//     bytes += generator.text('Date: ${DateTime.now()}', styles: PosStyles());
//     bytes += generator.text('Order Receipt',
//         styles: PosStyles(bold: true, align: PosAlign.center));
//     bytes +=
//         generator.text('--------------------------------', styles: PosStyles());
//     bytes += generator.text('Item          Qty   Price', styles: PosStyles());
//     bytes +=
//         generator.text('--------------------------------', styles: PosStyles());
//
//     double subtotal = 0;
//
//     // Add items to the receipt
//     for (var item in items) {
//       subtotal += item.price * item.quantity;
//       bytes += generator.text(
//           '${item.name.padRight(12)} ${item.quantity}  \N${item.price.toStringAsFixed(2)}',
//           styles: PosStyles());
//     }
//
//     // Footer details
//     bytes +=
//         generator.text('--------------------------------', styles: PosStyles());
//     bytes += generator.text('Subtotal:    \N${subtotal.toStringAsFixed(2)}',
//         styles: PosStyles());
//     bytes += generator.text('Total:       \N${subtotal.toStringAsFixed(2)}',
//         styles: PosStyles());
//     bytes += generator.text('Thank you for your order!', styles: PosStyles());
//     bytes += generator.feed(2);
//     bytes += generator.cut();
//
//     return bytes;
//   }
// }
