import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spotstock_inventory/common/helpers/database_engine.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/widgets/transaction_tile.dart';
import 'package:spotstock_inventory/screens/desktop/pos/print_desktop.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
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

  // Helper method to extract payment status from order
  String _extractPaymentStatus(Orders sale) {
    // Rely solely on paymentStatus field
    if (sale.paymentStatus != null && sale.paymentStatus!.isNotEmpty) {
      switch (sale.paymentStatus) {
        case 'Paid':
        case 'Unpaid':
        case 'Partial':
          return sale.paymentStatus!;
        default:
          return 'Unpaid'; // Default to Unpaid for invalid values
      }
    }
    // Fallback if paymentStatus is null or empty
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
    systemProvider.syncAllTransactions(user).then((result) {
      print('Sync result: $result');
    }).catchError((error) {
      print('Sync error: $error');
    });
  }

  void _runDataMigration() async {
    // Migration script to update existing Orders
    final store = await DatabaseEngine.instance.getStore();
    final orderBox = store.box<Orders>();
    final orders = orderBox.getAll();

    for (var order in orders) {
      if (order.paymentStatus == null || order.paymentStatus!.isEmpty) {
        // Extract payment status from others field if available
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
  }
}