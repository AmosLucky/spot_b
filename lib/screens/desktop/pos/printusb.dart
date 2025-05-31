import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:win32/win32.dart';
import 'package:intl/intl.dart';

// Function to list printers
// void listPrinters() {
//   final pPrinterInfo = calloc<Pointer<PRINTER_INFO_2>>();
//   final pcbNeeded = calloc<DWORD>();
//   final pcReturned = calloc<DWORD>();

//   // Get the size of the buffer needed
//   EnumPrinters(PRINTER_ENUM_LOCAL | PRINTER_ENUM_CONNECTIONS, nullptr, 2,
//       nullptr, 0, pcbNeeded, pcReturned);

//   if (pcbNeeded.value == 0) {
//     print('No printers found.');
//     return;
//   }

//   // Allocate the necessary buffer
//   pPrinterInfo.value = calloc<BYTE>(pcbNeeded.value) as Pointer<PRINTER_INFO_2>;

//   // Retrieve printer information
//   if (EnumPrinters(
//           PRINTER_ENUM_LOCAL | PRINTER_ENUM_CONNECTIONS,
//           nullptr,
//           2,
//           pPrinterInfo.value as Pointer<Uint8>,
//           pcbNeeded.value,
//           pcbNeeded,
//           pcReturned) !=
//       0) {
//     final printerInfoList = pPrinterInfo.value.cast<PRINTER_INFO_2>();
//     for (int i = 0; i < pcReturned.value; i++) {
//       final printerName = printerInfoList[i].pPrinterName.toDartString();
//       print('Printer Name: $printerName');
//     }
//   } else {
//     print('Failed to enumerate printers.');
//   }

//   // Clean up
//   calloc.free(pPrinterInfo.value);
//   calloc.free(pcbNeeded);
//   calloc.free(pcReturned);
// }
// List<String> listPrinters() {
//   final pPrinterInfo = calloc<Pointer<PRINTER_INFO_2>>();
//   final pcbNeeded = calloc<DWORD>();
//   final pcReturned = calloc<DWORD>();

//   List<String> printers = [];

//   // Get the size of the buffer needed
//   EnumPrinters(PRINTER_ENUM_LOCAL | PRINTER_ENUM_CONNECTIONS, nullptr, 2,
//       nullptr, 0, pcbNeeded, pcReturned);

//   if (pcbNeeded.value == 0) {
//     print('No printers found.');
//     return printers;
//   }

//   // Allocate the necessary buffer
//   pPrinterInfo.value = calloc<BYTE>(pcbNeeded.value) as Pointer<PRINTER_INFO_2>;

//   // Retrieve printer information
//   if (EnumPrinters(
//           PRINTER_ENUM_LOCAL | PRINTER_ENUM_CONNECTIONS,
//           nullptr,
//           2,
//           pPrinterInfo.value as Pointer<Uint8>,
//           pcbNeeded.value,
//           pcbNeeded,
//           pcReturned) !=
//       0) {
//     final printerInfoList = pPrinterInfo.value.cast<PRINTER_INFO_2>();
//     for (int i = 0; i < pcReturned.value; i++) {
//       final printerName = printerInfoList[i].pPrinterName.toDartString();
//       printers.add(printerName);
//     }
//   } else {
//     print('Failed to enumerate printers.');
//   }

//   // Clean up
//   calloc.free(pPrinterInfo.value);
//   calloc.free(pcbNeeded);
//   calloc.free(pcReturned);

//   return printers;
// }

List<String> listPrinters() {
  final pcbNeeded = calloc<DWORD>();
  final pcReturned = calloc<DWORD>();

  List<String> printers = [];

  try {
    // Step 1: Determine the size of the buffer needed
    EnumPrinters(
      PRINTER_ENUM_LOCAL | PRINTER_ENUM_CONNECTIONS,
      nullptr,
      2,
      nullptr,
      0,
      pcbNeeded,
      pcReturned,
    );

    if (pcbNeeded.value == 0) {
      print('No printers found.');
      return printers;
    }

    // Step 2: Allocate the necessary buffer
    final pPrinterInfo = calloc<Uint8>(pcbNeeded.value);
    try {
      // Step 3: Retrieve printer information
      if (EnumPrinters(PRINTER_ENUM_LOCAL | PRINTER_ENUM_CONNECTIONS, nullptr,
              2, pPrinterInfo, pcbNeeded.value, pcbNeeded, pcReturned) !=
          0) {
        final printerInfoList =
            pPrinterInfo.cast<PRINTER_INFO_2>(); // Cast to PRINTER_INFO_2
        for (int i = 0; i < pcReturned.value; i++) {
          final printerName = printerInfoList[i].pPrinterName.toDartString();
          printers.add(printerName);
        }
      } else {
        print('Failed to enumerate printers.');
      }
    } finally {
      // Free the allocated buffer for printer information
      calloc.free(pPrinterInfo);
    }
  } finally {
    // Clean up memory for needed size and returned count
    calloc.free(pcbNeeded);
    calloc.free(pcReturned);
  }

  return printers;
}

// Function to print receipt
void printReceipt(String printerName, UserDetails user, Map transactData,
    String customerName, List<Item> items) {
  final hPrinter = calloc<HANDLE>();

  // Open printer
  final result = OpenPrinter(printerName.toNativeUtf16(), hPrinter, nullptr);

  if (result != 0) {
    print('Printer opened successfully');

    // Prepare the document info structure
    final docInfo = calloc<DOC_INFO_1>();
    docInfo.ref.pDocName = 'Order Receipt'.toNativeUtf16();
    docInfo.ref.pOutputFile = nullptr;
    docInfo.ref.pDatatype = 'RAW'.toNativeUtf16();

    // Start a document and a page
    StartDocPrinter(hPrinter.value, 1, docInfo);
    StartPagePrinter(hPrinter.value);

    // Get current date and time
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    final txnID = transactData["trxId"];

    // Initialize the receipt data
    final List<int> data = [
      0x1B, 0x40, // Initialize printer
      0x1B, 0x61, 0x01, // Center alignment
      0x1B, 0x21, 0x10, // Double height text for company name
      ...user.company!.name.codeUnits,
      0x0A, // New line
      ...user.company!.address.codeUnits,
      0x0A, // New line
      0x1B, 0x21, 0x00, // Normal font size
      0x1B, 0x61, 0x00, // Left alignment
      0x0A, // New line
      ...'Customer: $customerName'.codeUnits,
      0x0A, // New line
      ...'Date: $formattedDate'.codeUnits,
      0x0A, // New line
      ...'Txn ID: $txnID'.codeUnits,
      0x0A, // New line
      0x0A, // New line
      ...'Order Receipt'.codeUnits,
      0x0A,
      ...'----------------------------------------------'.codeUnits,
      0x0A,
      ...'Item                          Qty     Price'
          .codeUnits, // Header of the table
      0x0A,
      ...'----------------------------------------------'.codeUnits,
      0x0A,
    ];

    // Initialize subtotal variable
    double subtotal = 0;
    double discount = 0; // Set discount value here
    double vatRate = 0.00; // 5% VAT
    double paidAmount = transactData['others']['receivedAmount'] is int
        ? (transactData['others']['receivedAmount'] as int).toDouble()
        : (transactData['others']['receivedAmount']
            as double); // Amount paid by customer
    double partialAmount = transactData['others']['partialAmount'] is int
        ? (transactData['others']['partialAmount'] as int).toDouble()
        : (transactData['others']['partialAmount']
            as double); // If payment is partial, set this value

    // Add each item to the receipt
    for (var item in items) {
      subtotal += item.price * item.quantity;

      // Format the row for each item with full-width alignment
      String itemRow =
          '${item.name.padRight(28)}' // Item name, adjust padding for width
          '${item.quantity.toString().padLeft(5)}' // Quantity with right alignment
          '${'N${item.price.toStringAsFixed(2)}'.padLeft(10)}'; // Price with right alignment

      data.addAll(itemRow.codeUnits);
      data.add(0x0A); // New line
    }

    // Apply tax and discount calculations
    double tax = subtotal * vatRate; // Calculate VAT (e.g., 5% VAT)
    discount = subtotal * 0.0; // For example, 10% discount

    // Calculate the total
    double total = subtotal + tax - discount;

    // Calculate change if payment is greater than total
    double change = paidAmount - total;
    if (change < 0) {
      change = 0; // Ensure no negative change
    }

    // Footer details (full-width and compact version)
    data.addAll([
      0x0A,
      ...'--------------------------------'.codeUnits,
      0x0A,
      // Adding padding to each footer line to align values
      ...'Subtotal:               ${'N${subtotal.toStringAsFixed(2)}'.padRight(18)}'
          .codeUnits, // Right align value
      0x0A,
      ...'Disc:                   ${'N${discount.toStringAsFixed(2)}'.padRight(18)}'
          .codeUnits, // Right align value
      0x0A,
      ...'VAT (${(vatRate * 100).toStringAsFixed(0)}%):               ${'N${tax.toStringAsFixed(2)}'.padRight(18)}'
          .codeUnits, // Display VAT
      0x0A,
      ...'Total:                  ${'N${total.toStringAsFixed(2)}'.padRight(18)}'
          .codeUnits, // Right align value
      0x0A,
      ...'Paid By:                ${'${transactData['method']}'.padRight(18)}'
          .codeUnits, // Right align value
      0x0A,
      ...'Partial:                ${'N${partialAmount.toStringAsFixed(2)}'.padRight(18)}'
          .codeUnits, // Right align value
      0x0A,
      ...'Change:                 ${'N${transactData['change']}'.padRight(18)}'
          .codeUnits, // Right align value
      0x0A,
      ...'Thank you!'.codeUnits, // Shortened "Thank you for your order"
      0x0A,
      0x0A, // New line after "Thank you!"
      ...'--------------------------------'
          .codeUnits, // Line after "Thank you!"
      0x0A, // Additional new line
    ]);

    // Add feed and delay commands
    data.addAll([
      0x0A, // Feed the paper after printing content
      0x1B, 0x64, 0x02, // Feed paper command with a small amount of space
      0x1D, 0x56, 0x00, // Full cut paper command
    ]);

    // If the printer has a flush or another mechanism, include it here to ensure printing is completed.
    data.addAll([
      0x1B, 0x56, 0x00, // Print and cut paper command (if necessary)
    ]);

    final writtenBytes = calloc<DWORD>();
    final success = WritePrinter(
        hPrinter.value, data.toNativeInt8(), data.length, writtenBytes);

    if (success != 0) {
      print('Data sent to printer successfully');
    } else {
      print('Failed to open printer: Error Code ${GetLastError()}');
    }

    // End the page and document
    EndPagePrinter(hPrinter.value);
    EndDocPrinter(hPrinter.value);

    // Close the printer handle
    ClosePrinter(hPrinter.value);

    // Clean up for docInfo
    calloc.free(docInfo.ref.pDocName); // Free the allocated native string
    calloc.free(docInfo.ref.pDatatype); // Free the allocated native string
  } else {
    print('Failed to open printer');
  }

  // Clean up
  calloc.free(hPrinter);
}

class OrderSyncItem {
  final int id;
  final int quantity;
  final double price;

  OrderSyncItem(this.id, this.quantity, this.price);
}

class Item {
  final String name;
  final int quantity;
  final double price;

  Item(this.name, this.quantity, this.price);
}

class HotelItem {
  final String name;
  final int quantity;
  final double price;

  HotelItem(this.name, this.quantity, this.price);
}

extension on List<int> {
  Pointer<Uint8> toNativeInt8() {
    final ptr = calloc<Uint8>(length);
    final nativeList = ptr.asTypedList(length);
    nativeList.setAll(0, this);
    return ptr;
  }
}
