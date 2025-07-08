import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:spotstock_inventory/common/helpers/database_engine.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
// import 'package:spotstock_inventory/widgets/enhanced_transaction_tile.dart';
import 'package:spotstock_inventory/screens/desktop/pos/print_desktop.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:spotstock_inventory/widgets/transaction_tile.dart';
import '../../helpers/debug_helper.dart';

class SalesReportWidget extends StatefulWidget {
  final Future<List<Orders>> Function() fetchSalesReport;
  final UserDetails user;
  final SystemProvider systemProvider;

  const SalesReportWidget({
    super.key,
    required this.fetchSalesReport,
    required this.user,
    required this.systemProvider,
  });

  @override
  State<SalesReportWidget> createState() => _SalesReportWidgetState();
}

class _SalesReportWidgetState extends State<SalesReportWidget> {
  List<Orders> _currentSales = [];

  String _extractPaymentStatus(Orders sale) {
    if (sale.paymentStatus != null && sale.paymentStatus!.isNotEmpty) {
      switch (sale.paymentStatus) {
        case 'Paid':
        case 'Unpaid':
        case 'Partial':
          return sale.paymentStatus!;
        default:
          return 'Unpaid';
      }
    }
    return 'Unpaid';
  }

  double _calculatePaidSoFar(Orders sale) {
    return sale.receivedAmount ?? 0.0;
  }

  double _calculateBalance(Orders sale) {
    final paidSoFar = _calculatePaidSoFar(sale);
    return sale.amount - paidSoFar;
  }

  Future<void> _refreshSalesData() async {
    try {
      print('Refreshing sales data...');
      final sales = await widget.fetchSalesReport();
      if (mounted) {
        setState(() {
          _currentSales = sales;
        });
        print('Sales data refreshed: ${sales.length} transactions');
      }
    } catch (e) {
      print('Error refreshing sales data: $e');
    }
  }

  // Add this method to force refresh from parent
  void refreshData() {
    _refreshSalesData();
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
              future: widget.fetchSalesReport(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching sales report'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No sales found for this register'));
                }

                final sales = snapshot.data!;
                _currentSales = sales;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: sales.length,
                  itemBuilder: (context, index) {
                    final sale = sales[index];
                    
                    if (index < 3) {
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
                      paidSoFar: _calculatePaidSoFar(sale),
                      balance: _calculateBalance(sale),
                      status: sale.status,
                      onPrint: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => PrintScreenDialog(
                            user: widget.user,
                            transactionData: sale.toMap(),
                          ),
                        ));
                      },
                      onSync: () {
                        _syncSingleTransaction(sale);
                      },
                      onPaymentUpdated: () {
                        // Force refresh of sales data
                        print('Payment updated callback triggered');
                        _refreshSalesData();
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

  void _syncSingleTransaction(Orders sale) {
    widget.systemProvider.syncAllTransactions(widget.user).then((result) {
      print('Sync result: $result');
      // Refresh the data after sync
      _refreshSalesData();
    }).catchError((error) {
      print('Sync error: $error');
    });
  }

  void _runDataMigration() async {
    final store = await DatabaseEngine.instance.getStore();
    final orderBox = store.box<Orders>();
    final orders = orderBox.getAll();
    
    for (var order in orders) {
      if (order.paymentStatus == null || order.paymentStatus!.isEmpty) {
        if (order.others != null && order.others!.isNotEmpty) {
          try {
            final paymentData = jsonDecode(order.others!);
            String newPaymentStatus = paymentData['paymentStatus'] ?? 'Unpaid';
            order.paymentStatus = newPaymentStatus;
            orderBox.put(order);
          } catch (e) {
            print('Error decoding others field for order ${order.trxId}: $e');
          }
        } else {
          order.paymentStatus = 'Unpaid';
          orderBox.put(order);
        }
      }
    }
    
    print('Data migration completed for payment statuses');
    _refreshSalesData();
  }
}





// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:spotstock_inventory/common/helpers/database_engine.dart';
// import 'package:spotstock_inventory/data/models/schema.dart';
// // import 'package:spotstock_inventory/widgets/enhanced_transaction_tile.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/print_desktop.dart';
// import 'package:spotstock_inventory/data/models/user_details.dart';
// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:flutter/foundation.dart';
// import 'package:spotstock_inventory/widgets/transaction_tile.dart';
// import '../../helpers/debug_helper.dart';

// class SalesReportWidget extends StatefulWidget {
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
//   State<SalesReportWidget> createState() => _SalesReportWidgetState();
// }

// class _SalesReportWidgetState extends State<SalesReportWidget> {
//   List<Orders> _currentSales = [];

//   String _extractPaymentStatus(Orders sale) {
//     if (sale.paymentStatus != null && sale.paymentStatus!.isNotEmpty) {
//       switch (sale.paymentStatus) {
//         case 'Paid':
//         case 'Unpaid':
//         case 'Partial':
//           return sale.paymentStatus!;
//         default:
//           return 'Unpaid';
//       }
//     }
//     return 'Unpaid';
//   }

//   double _calculatePaidSoFar(Orders sale) {
//     return sale.receivedAmount ?? 0.0;
//   }

//   double _calculateBalance(Orders sale) {
//     final paidSoFar = _calculatePaidSoFar(sale);
//     return sale.amount - paidSoFar;
//   }

//   Future<void> _refreshSalesData() async {
//     try {
//       final sales = await widget.fetchSalesReport();
//       setState(() {
//         _currentSales = sales;
//       });
//     } catch (e) {
//       print('Error refreshing sales data: $e');
//     }
//   }

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
//               future: widget.fetchSalesReport(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return const Center(child: Text('Error fetching sales report'));
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return const Center(child: Text('No sales found for this register'));
//                 }

//                 final sales = snapshot.data!;
//                 _currentSales = sales;

//                 return ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: sales.length,
//                   itemBuilder: (context, index) {
//                     final sale = sales[index];
                    
//                     if (index < 3) {
//                       PaymentStatusDebugHelper.debugTransactionStatus(sale);
//                     }

//                     return TransactionTile(
//                       transactionId: sale.trxId,
//                       amount: sale.amount,
//                       customer: sale.customerName,
//                       createdAt: sale.createdAt,
//                       isSynced: sale.sync == 1,
//                       paymentMethod: sale.paymentMethod ?? 'Unknown',
//                       paymentStatus: _extractPaymentStatus(sale),
//                       paidSoFar: _calculatePaidSoFar(sale),
//                       balance: _calculateBalance(sale),
//                       status: sale.status,
//                       onPrint: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (_) => PrintScreenDialog(
//                             user: widget.user,
//                             transactionData: sale.toMap(),
//                           ),
//                         ));
//                       },
//                       onSync: () {
//                         _syncSingleTransaction(sale);
//                       },
//                       onPaymentUpdated: () {
//                         // Refresh the sales data when payment is updated
//                         _refreshSalesData();
//                       },
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           if (kDebugMode)
//             ElevatedButton(
//               onPressed: _runDataMigration,
//               child: Text('Update Payment Statuses'),
//             ),
//         ],
//       ),
//     );
//   }

//   void _syncSingleTransaction(Orders sale) {
//     widget.systemProvider.syncAllTransactions(widget.user).then((result) {
//       print('Sync result: $result');
//       // Refresh the data after sync
//       _refreshSalesData();
//     }).catchError((error) {
//       print('Sync error: $error');
//     });
//   }

//   void _runDataMigration() async {
//     final store = await DatabaseEngine.instance.getStore();
//     final orderBox = store.box<Orders>();
//     final orders = orderBox.getAll();
    
//     for (var order in orders) {
//       if (order.paymentStatus == null || order.paymentStatus!.isEmpty) {
//         if (order.others != null && order.others!.isNotEmpty) {
//           try {
//             final paymentData = jsonDecode(order.others!);
//             String newPaymentStatus = paymentData['paymentStatus'] ?? 'Unpaid';
//             order.paymentStatus = newPaymentStatus;
//             orderBox.put(order);
//           } catch (e) {
//             print('Error decoding others field for order ${order.trxId}: $e');
//           }
//         } else {
//           order.paymentStatus = 'Unpaid';
//           orderBox.put(order);
//         }
//       }
//     }
    
//     print('Data migration completed for payment statuses');
//     _refreshSalesData();
//   }
// }