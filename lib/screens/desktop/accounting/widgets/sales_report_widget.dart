import 'package:flutter/material.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/widgets/transaction_tile.dart';
import 'package:spotstock_inventory/screens/desktop/pos/print_desktop.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';

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
                    //print("Sales Report data ==> ${sale.}");
                    return TransactionTile(
                      transactionId: sale.trxId,
                      amount: sale.status.toDouble(),
                      customer: sale.customerName,
                      createdAt: sale.createdAt,
                      isSynced: sale.sync == 1,
                      paymentMethod: sale.paymentMethod,
                      onPrint: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => PrintScreenDialog(
                            user: user,
                            transactionData: sale.toMap(),
                          ),
                        ));
                      },
                      onSync: () {},
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
