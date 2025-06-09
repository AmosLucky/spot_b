import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:spotstock_inventory/common/provider/sales_provider.dart';
import 'package:spotstock_inventory/data/models/sales_models.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/desktop/pos/list_printers.dart';
import 'package:spotstock_inventory/screens/desktop/pos/printusb.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SalesPrintService {
  static final SalesPrintService _instance = SalesPrintService._internal();
  factory SalesPrintService() => _instance;
  SalesPrintService._internal();

  /// Print current page sales as individual receipts
  static Future<void> printCurrentPageSales(
    BuildContext context,
    List<Sale> sales,
    UserDetails user,
  ) async {
    await SalesPrintService()._printEachSaleAsIndividualReceipt(
      context: context,
      sales: sales,
      user: user,
      isCurrentPageOnly: true,
    );
  }

  /// Download and print all sales as individual receipts
  static Future<void> downloadAndPrintAllSales({
    required BuildContext context,
    required SalesProvider provider,
    required UserDetails user,
    String? customTitle,
  }) async {
    await SalesPrintService()._downloadAndPrintAllAsIndividualReceipts(
      context: context,
      provider: provider,
      user: user,
    );
  }

  /// Download all sales and print each as individual receipt
  Future<void> _downloadAndPrintAllAsIndividualReceipts({
    required BuildContext context,
    required SalesProvider provider,
    required UserDetails user,
  }) async {
    _showLoadingDialog(context, 'Fetching all sales data...');

    try {
      final allSales = await _fetchAllSalesData(provider);

      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      if (allSales.isNotEmpty) {
        await _printEachSaleAsIndividualReceipt(
          context: context,
          sales: allSales,
          user: user,
          isCurrentPageOnly: false,
        );
      } else {
        _showMessage(context, 'No sales data found to download');
      }
    } catch (e) {
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
      _showMessage(context, 'Error fetching sales data: $e', isError: true);
    }
  }

  /// Print each sale as individual receipt
  Future<void> _printEachSaleAsIndividualReceipt({
    required BuildContext context,
    required List<Sale> sales,
    required UserDetails user,
    bool isCurrentPageOnly = false,
  }) async {
    if (sales.isEmpty) {
      _showMessage(context, 'No sales data found to print', isError: true);
      return;
    }

    try {
      _showProgressDialog(context,
          'Generating ${sales.length} individual receipts...', 0, sales.length);

      int printedCount = 0;
      int failedCount = 0;

      for (int i = 0; i < sales.length; i++) {
        final sale = sales[i];

        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
          _showProgressDialog(
              context,
              'Printing receipt ${i + 1} of ${sales.length}...',
              i + 1,
              sales.length);
        }

        try {
          await printSingleSaleReceipt(sale, user);
          printedCount++;
          await Future.delayed(const Duration(milliseconds: 200));
        } catch (e) {
          debugPrint('Error printing sale ${sale.referenceCode}: $e');
          failedCount++;
        }
      }

      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      _showPrintCompletionMessage(
        context,
        printedCount,
        failedCount,
        sales.length,
        isCurrentPageOnly,
      );
    } catch (e) {
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
      _showMessage(context, 'Error printing sales receipts: $e', isError: true);
    }
  }

  /// Print single sale receipt
  Future<void> printSingleSaleReceipt(Sale sale, UserDetails user) async {
    final items = sale.saleItems.map<Item>((saleItem) {
      return Item(
        _getItemName(saleItem),
        saleItem.quantity,
        saleItem.subTotal,
      );
    }).toList();

    String paymentStatus;
    if (sale.dueAmount <= 0) {
      paymentStatus = 'PAID';
    } else if (sale.paidAmount > 0) {
      paymentStatus = 'PARTIALLY PAID';
    } else {
      paymentStatus = 'UNPAID';
    }

    String paymentMethod = _getPaymentMethodFromSale(sale);

    await printSampleDocument(
      sale.grandTotal,
      items,
      [],
      DateFormat('yyyy-MM-dd HH:mm:ss').format(sale.date),
      DateFormat('yyyy-MM-dd HH:mm:ss').format(sale.date),
      user.company?.email ?? '247okolo@gmail.com',
      user.company?.phone ?? '08073764488',
      user.firstName ?? 'Staff',
      sale.customerName,
      sale.warehouseName,
      paymentStatus,
      '',
      'SALES INVOICE',
      sale.referenceCode,
      sale.grandTotal,
      sale.paidAmount,
      sale.dueAmount,
      paymentMethod,
      sale.date,
      user.company?.name ?? 'SPOT STOCK MANAGER',
      user.company?.address ?? '8 Ugwuoba Street Enugu',
      null, // No Added attendantName
    );
  }

  String _getItemName(SaleItem saleItem) {
    return saleItem.saleUnit.name ?? 'Product ${saleItem.productId}';
  }

  String _getPaymentMethodFromSale(Sale sale) {
    if (sale.dueAmount <= 0) {
      return 'CASH';
    } else if (sale.paidAmount > 0) {
      return 'PARTIAL';
    } else {
      return 'PENDING';
    }
  }

  void _showProgressDialog(
      BuildContext context, String message, int current, int total) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: total > 0 ? current / total : 0,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 8),
            Text('$current of $total completed', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  void _showPrintCompletionMessage(
    BuildContext context,
    int printedCount,
    int failedCount,
    int totalCount,
    bool isCurrentPageOnly,
  ) {
    final reportType = isCurrentPageOnly ? 'Current page' : 'All';
    final buffer = StringBuffer();

    buffer.writeln('$reportType sales receipts generated!');
    buffer.writeln('✅ Successfully printed: $printedCount');

    if (failedCount > 0) {
      buffer.writeln('❌ Failed to print: $failedCount');
    }

    buffer.writeln('📄 Total receipts: $totalCount');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(buffer.toString()),
        backgroundColor: failedCount == 0 ? Colors.green : Colors.orange,
        duration: const Duration(seconds: 6),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  Future<List<Sale>> _fetchAllSalesData(SalesProvider provider) async {
    final currentPage = provider.currentPage;
    List<Sale> allSales = [];
    int page = 1;
    bool hasMoreData = true;

    while (hasMoreData) {
      provider.setCurrentPage(page);
      await provider.fetchSales();

      if (provider.sales.isNotEmpty) {
        allSales.addAll(provider.sales);
        page++;
        hasMoreData = provider.meta != null && page <= provider.meta!.lastPage;
      } else {
        hasMoreData = false;
      }
    }

    provider.setCurrentPage(currentPage);
    await provider.fetchSales();
    return allSales;
  }

  void _showLoadingDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : null,
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:path/path.dart';
// import 'package:spotstock_inventory/common/provider/sales_provider.dart';
// import 'package:spotstock_inventory/data/models/sales_models.dart';
// import 'package:spotstock_inventory/data/models/userdetails.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/list_printers.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/printusb.dart';
// import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// // services/sales_print_service.dart
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class SalesPrintService {
//   static final SalesPrintService _instance = SalesPrintService._internal();
//   factory SalesPrintService() => _instance;
//   SalesPrintService._internal();

//   /// Print current page sales as individual receipts (same format as your image)
//   static Future<void> printCurrentPageSales(
//     BuildContext context,
//     List<Sale> sales,
//     UserDetails user,
//   ) async {
//     await SalesPrintService()._printEachSaleAsIndividualReceipt(
//       context: context,
//       sales: sales,
//       user: user,
//       isCurrentPageOnly: true,
//     );
//   }

//   /// Download and print all sales as individual receipts (same format as your image)
//   static Future<void> downloadAndPrintAllSales({
//     required BuildContext context,
//     required SalesProvider provider,
//     required UserDetails user,
//     String? customTitle,
//   }) async {
//     await SalesPrintService()._downloadAndPrintAllAsIndividualReceipts(
//       context: context,
//       provider: provider,
//       user: user,
//     );
//   }

//   /// Download all sales and print each as individual receipt
//   Future<void> _downloadAndPrintAllAsIndividualReceipts({
//     required BuildContext context,
//     required SalesProvider provider,
//     required UserDetails user,
//   }) async {
//     _showLoadingDialog(context, 'Fetching all sales data...');

//     try {
//       final allSales = await _fetchAllSalesData(provider);

//       if (Navigator.canPop(context)) {
//         Navigator.of(context).pop();
//       }

//       if (allSales.isNotEmpty) {
//         await _printEachSaleAsIndividualReceipt(
//           context: context,
//           sales: allSales,
//           user: user,
//           isCurrentPageOnly: false,
//         );
//       } else {
//         _showMessage(context, 'No sales data found to download');
//       }
//     } catch (e) {
//       if (Navigator.canPop(context)) {
//         Navigator.of(context).pop();
//       }
//       _showMessage(context, 'Error fetching sales data: $e', isError: true);
//     }
//   }

//   /// Print each sale as individual receipt using the EXACT same format as your image
//   Future<void> _printEachSaleAsIndividualReceipt({
//     required BuildContext context,
//     required List<Sale> sales,
//     required UserDetails user,
//     bool isCurrentPageOnly = false,
//   }) async {
//     if (sales.isEmpty) {
//       _showMessage(context, 'No sales data found to print', isError: true);
//       return;
//     }

//     try {
//       // Show progress dialog
//       _showProgressDialog(context,
//           'Generating ${sales.length} individual receipts...', 0, sales.length);

//       int printedCount = 0;
//       int failedCount = 0;

//       // Print each sale as individual receipt using the same format
//       for (int i = 0; i < sales.length; i++) {
//         final sale = sales[i];

//         // Update progress
//         if (Navigator.canPop(context)) {
//           Navigator.of(context).pop();
//           _showProgressDialog(
//               context,
//               'Printing receipt ${i + 1} of ${sales.length}...',
//               i + 1,
//               sales.length);
//         }

//         try {
//           await printSingleSaleReceipt(sale, user);
//           printedCount++;

//           // Small delay between prints
//           await Future.delayed(const Duration(milliseconds: 200));
//         } catch (e) {
//           debugPrint('Error printing sale ${sale.referenceCode}: $e');
//           failedCount++;
//         }
//       }

//       // Close progress dialog
//       if (Navigator.canPop(context)) {
//         Navigator.of(context).pop();
//       }

//       // Show success message
//       _showPrintCompletionMessage(
//         context,
//         printedCount,
//         failedCount,
//         sales.length,
//         isCurrentPageOnly,
//       );
//     } catch (e) {
//       if (Navigator.canPop(context)) {
//         Navigator.of(context).pop();
//       }
//       _showMessage(context, 'Error printing sales receipts: $e', isError: true);
//     }
//   }

//   /// Print single sale receipt using the EXACT same format as your image
//   Future<void> printSingleSaleReceipt(Sale sale, UserDetails user) async {
//     // Convert sale items to the Item format from printusb.dart
//     final items = sale.saleItems.map<Item>((saleItem) {
//       // Use the Item constructor from printusb.dart
//       return Item(
//         _getItemName(saleItem), // Product name or ID
//         saleItem.quantity, // Quantity
//         saleItem.subTotal, // Amount (subtotal for this item)
//       );
//     }).toList();

//     // Determine payment status text
//     String paymentStatus;
//     if (sale.dueAmount <= 0) {
//       paymentStatus = 'PAID';
//     } else if (sale.paidAmount > 0) {
//       paymentStatus = 'PARTIALLY PAID';
//     } else {
//       paymentStatus = 'UNPAID';
//     }

//     // Determine payment method
//     String paymentMethod = _getPaymentMethodFromSale(sale);

//     // Use the EXISTING printSampleDocument function with individual sale data
//     await printSampleDocument(
//       sale.grandTotal, // totalAmount
//       items, // items list (now using correct Item class)
//       [], // hotelItems (empty for sales)
//       DateFormat('yyyy-MM-dd HH:mm:ss')
//           .format(sale.date), // checkinDate (sale date)
//       DateFormat('yyyy-MM-dd HH:mm:ss')
//           .format(sale.date), // checkoutDate (sale date)
//       user.company?.email ?? '247okolo@gmail.com', // companyEmail
//       user.company?.phone ?? '08073764488', // companyPhone
//       user.firstName ?? 'Staff', // staffName
//       sale.customerName, // customerName
//       sale.warehouseName, // warehouseName
//       paymentStatus, // paymentStatus
//       '', // tableNumber (empty for sales)
//       'SALES INVOICE', // title
//       sale.referenceCode, // referenceCode (Invoice no)
//       sale.grandTotal, // grandTotal
//       sale.paidAmount, // paidAmount
//       sale.dueAmount, // dueAmount
//       paymentMethod, // paymentMethod
//       sale.date, // saleDate
//       user.company?.name ?? 'SPOT STOCK MANAGER', // companyName
//       user.company?.address ?? '8 Ugwuoba Street Enugu', // companyAddress
//     );
//   }

//   /// Extract item name from sale item
//   String _getItemName(SaleItem saleItem) {
//     // Use product name if available, otherwise use product ID
//     return saleItem.saleUnit.name ?? 'Product ${saleItem.productId}';
//   }

//   /// Determine payment method from sale data
//   String _getPaymentMethodFromSale(Sale sale) {
//     // You can enhance this based on your sale model
//     // For now, we'll use simple logic
//     if (sale.dueAmount <= 0) {
//       return 'CASH';
//     } else if (sale.paidAmount > 0) {
//       return 'PARTIAL';
//     } else {
//       return 'PENDING';
//     }

//     // If you have a paymentMethod field in your Sale model, use:
//     // return sale.paymentMethod ?? 'CASH';
//   }

//   /// Show progress dialog
//   void _showProgressDialog(
//       BuildContext context, String message, int current, int total) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const CircularProgressIndicator(),
//             const SizedBox(height: 16),
//             Text(message, textAlign: TextAlign.center),
//             const SizedBox(height: 12),
//             LinearProgressIndicator(
//               value: total > 0 ? current / total : 0,
//               backgroundColor: Colors.grey[300],
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//             ),
//             const SizedBox(height: 8),
//             Text('$current of $total completed',
//                 style: TextStyle(fontSize: 12)),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Show completion message
//   void _showPrintCompletionMessage(
//     BuildContext context,
//     int printedCount,
//     int failedCount,
//     int totalCount,
//     bool isCurrentPageOnly,
//   ) {
//     final reportType = isCurrentPageOnly ? 'Current page' : 'All';
//     final buffer = StringBuffer();

//     buffer.writeln('$reportType sales receipts generated!');
//     buffer.writeln('✅ Successfully printed: $printedCount');

//     if (failedCount > 0) {
//       buffer.writeln('❌ Failed to print: $failedCount');
//     }

//     buffer.writeln('📄 Total receipts: $totalCount');

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(buffer.toString()),
//         backgroundColor: failedCount == 0 ? Colors.green : Colors.orange,
//         duration: const Duration(seconds: 6),
//         action: SnackBarAction(
//           label: 'OK',
//           textColor: Colors.white,
//           onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
//         ),
//       ),
//     );
//   }

//   /// Fetch all sales data from all pages
//   Future<List<Sale>> _fetchAllSalesData(SalesProvider provider) async {
//     final currentPage = provider.currentPage;
//     List<Sale> allSales = [];
//     int page = 1;
//     bool hasMoreData = true;

//     while (hasMoreData) {
//       provider.setCurrentPage(page);
//       await provider.fetchSales();

//       if (provider.sales.isNotEmpty) {
//         allSales.addAll(provider.sales);
//         page++;
//         hasMoreData = provider.meta != null && page <= provider.meta!.lastPage;
//       } else {
//         hasMoreData = false;
//       }
//     }

//     // Restore original page
//     provider.setCurrentPage(currentPage);
//     await provider.fetchSales();
//     return allSales;
//   }

//   /// Show loading dialog
//   void _showLoadingDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         content: Row(
//           children: [
//             const CircularProgressIndicator(),
//             const SizedBox(width: 16),
//             Expanded(child: Text(message)),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Show message to user
//   void _showMessage(BuildContext context, String message,
//       {bool isError = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: isError ? Colors.red : null,
//       ),
//     );
//   }
// }