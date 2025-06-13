import 'package:flutter/material.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/widgets/transaction_tile.dart';
import 'package:spotstock_inventory/screens/desktop/pos/print_desktop.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'debug_helper.dart';
import 'package:flutter/foundation.dart';

import '../../helpers/debug_helper.dart';

class SalesReportWidget extends StatelessWidget {
  final Future<List<Orders>> Function() fetchSalesReport;
  final UserDetails user;
  final SystemProvider systemProvider;

  const SalesReportWidget({
    super.key,
    required this.fetchSalesReport,
    required this.user,
    required this.systemProvider,
  });

  // Helper method to extract payment status from order - Updated logic
  String _extractPaymentStatus(Orders sale) {
    // First check if there's an explicit paymentStatus field
    if (sale.paymentStatus != null && sale.paymentStatus!.isNotEmpty) {
      return sale.paymentStatus!;
    }
    
    // Then check the status field for payment information (status is int, not String)
    if (sale.status != null) {
      switch (sale.status) {
        case 0:
          return 'Pending';
        case 1:
          return 'Paid';
        case 2:
          return 'Partial';
        case 3:
          return 'Failed';
        case 4:
          return 'Cancelled';
        default:
          return 'Unknown';
      }
    }
    
    // Last fallback - check if payment method exists (but don't assume it means "Paid")
    if (sale.paymentMethod != null && sale.paymentMethod!.isNotEmpty) {
      return 'Pending'; // Changed from 'Paid' to 'Pending'
    }
    
    return 'Unpaid';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder<List<Orders>>(
              future: fetchSalesReport(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text('Error fetching sales report'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('No sales found for this register'));
                }

                final sales = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: sales.length,
                  itemBuilder: (context, index) {
                    final sale = sales[index];
                    
                    // Add debug logging
                    if (index < 3) { // Debug first 3 items
                      PaymentStatusDebugHelper.debugTransactionStatus(sale);
                    }
                    
                    return TransactionTile(
                      transactionId: sale.trxId,
                      amount: sale.amount,
                      customer: sale.customerName,
                      createdAt: sale.createdAt,
                      isSynced: sale.sync == 1,
                      paymentMethod: sale.paymentMethod ?? 'Unknown',
                      paymentStatus: _extractPaymentStatus(sale),
                      status: sale.status,
                      onPrint: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => PrintScreenDialog(
                            user: user,
                            transactionData: sale.toMap(),
                          ),
                        ));
                      },
                      onSync: () {
                        _syncSingleTransaction(sale);
                      },
                    );
                  },
                );
              },
            ),
          ),
          if (kDebugMode)
            ElevatedButton(
              onPressed: _runDataMigration,
              child: Text('Update Payment Statuses'),
            ),
        ],
      ),
    );
  }

  // Helper method to sync a single transaction
  void _syncSingleTransaction(Orders sale) {
    // Since syncTransaction doesn't exist, we can either:
    // 1. Call the existing syncAllTransactions method
    // 2. Show a message that sync will happen with "Sync All"
    // 3. Implement individual transaction sync
    
    // Option 1: Use existing sync all method
    systemProvider.syncAllTransactions(user).then((result) {
      print('Sync result: $result');
    }).catchError((error) {
      print('Sync error: $error');
    });
    
    // Option 2: Just show a message (uncomment if you prefer this approach)
    // print('Individual sync not implemented. Use "Sync All" button.');
  }

  void _runDataMigration() async {
    // await PaymentStatusMigrationHelper.updateExistingTransactionStatuses(user); // Assuming this exists
    // Force rebuild
    // setState(() {}); // setState is not available in StatelessWidget
  }
}







// import 'package:flutter/material.dart';
// import 'package:spotstock_inventory/data/models/schema.dart';
// import 'package:spotstock_inventory/widgets/transaction_tile.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/print_desktop.dart';
// import 'package:spotstock_inventory/data/models/userdetails.dart';
// import 'package:spotstock_inventory/common/provider/system_provider.dart';

// class SalesReportWidget extends StatelessWidget {
//   final Future<List<Orders>> Function() fetchSalesReport;
//   final UserDetails user;
//   final SystemProvider systemProvider;

//   const SalesReportWidget({
//     super.key,
//     required this.fetchSalesReport,
//     required this.user,
//     required this.systemProvider,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: FutureBuilder<List<Orders>>(
//               future: fetchSalesReport(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return const Center(
//                       child: Text('Error fetching sales report'));
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return const Center(
//                       child: Text('No sales found for this register'));
//                 }

//                 final sales = snapshot.data!;
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: sales.length,
//                   itemBuilder: (context, index) {
//                     final sale = sales[index];
//                     //print("Sales Report data ==> ${sale.}");
//                     return TransactionTile(
//                       transactionId: sale.trxId,
//                       amount: sale.status.toDouble(),
//                       customer: sale.customerName,
//                       createdAt: sale.createdAt,
//                       isSynced: sale.sync == 1,
//                       paymentMethod: sale.paymentMethod,
//                       onPrint: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (_) => PrintScreenDialog(
//                             user: user,
//                             transactionData: sale.toMap(),
//                           ),
//                         ));
//                       },
//                       onSync: () {},
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }