import 'package:flutter/material.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/widgets/reconcile_paymeent.dart';

class TransactionTile extends StatelessWidget {
  final String transactionId;
  final int? status;
  final String customer;
  final double amount;
  final DateTime createdAt;
  final bool isSynced; // Sync status
  final String paymentMethod; // Payment method
  final VoidCallback onPrint; // Callback for print action
  final VoidCallback onSync; // Callback for sync action

  const TransactionTile({
    Key? key,
    required this.transactionId,
    this.status,
    required this.customer,
    required this.amount,
    required this.createdAt,
    required this.isSynced,
    required this.paymentMethod, // Include payment method in the constructor
    required this.onPrint, // Accept print callback
    required this.onSync, // Accept sync callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // Optional: Adds a card effect for better separation
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        // contentPadding: EdgeInsets.symmetric(vertical: 8),
        // minTileHeight: 300,
        // style: ,
        dense: false,
        isThreeLine: true,
        // style: ListTileStyle,
        leading: CircleAvatar(
          backgroundColor: isSynced ? Colors.greenAccent : Colors.redAccent,
          radius: 12,
        ),
        title: Text('Transaction ID: $transactionId'),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Money.format(amount),
                  style:
                      TextStyle(color: blackColor, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Customer: $customer",
                  style:
                      TextStyle(color: blackColor, fontWeight: FontWeight.bold),
                ),
                Text(
                  paymentMethod,
                  style: TextStyle(
                      color: secondaryColor, fontWeight: FontWeight.normal),
                ), // Display payment method
                Text('${createdAt.toLocal()}'), // Convert to local time
              ],
            ),

            // Trailing section
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // TextButton(onPressed: () {}, child: Text('unpaid')),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.red),
                  child: GestureDetector(
                    onTap: () {
                      showReconcilePaymentDialog(context);
                    },
                    child: Text(
                      // status.toString(),
                      'Unpaid',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize:
                      MainAxisSize.min, // Shrinks the Row to fit its content
                  children: [
                    // Print button
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.print),
                          onPressed: onPrint, // Call print function
                        ),
                      ],
                    ),
                    // Sync/Resync button

                    TextButton(
                      onPressed: () {
                        onSync(); // Call sync function
                        // Show a snackbar or toast for feedback
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isSynced
                                ? 'Resynced $transactionId'
                                : 'Synced $transactionId'),
                          ),
                        );
                      },
                      child: Text(isSynced ? 'Resync' : 'Sync'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // trailing: SizedBox(
        //   height: 200,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       // TextButton(onPressed: () {}, child: Text('unpaid')),
        //       Container(
        //         padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(3), color: Colors.red),
        //         child: Text(
        //           'Unpaid',
        //           style: TextStyle(color: Colors.white),
        //         ),
        //       ),
        //       Row(
        //         mainAxisSize:
        //             MainAxisSize.min, // Shrinks the Row to fit its content
        //         children: [
        //           // Print button
        //           Column(
        //             children: [
        //               IconButton(
        //                 icon: const Icon(Icons.print),
        //                 onPressed: onPrint, // Call print function
        //               ),
        //             ],
        //           ),
        //           // Sync/Resync button

        //           TextButton(
        //             onPressed: () {
        //               onSync(); // Call sync function
        //               // Show a snackbar or toast for feedback
        //               ScaffoldMessenger.of(context).showSnackBar(
        //                 SnackBar(
        //                   content: Text(isSynced
        //                       ? 'Resynced $transactionId'
        //                       : 'Synced $transactionId'),
        //                 ),
        //               );
        //             },
        //             child: Text(isSynced ? 'Resync' : 'Sync'),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  void showReconcilePaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ReconcilePaymentDialog(
          reference: transactionId,
          totalAmount: amount,
          paidSoFar: 50.0,
          status: 'Partial',
          onSubmit: (amount, paymentType) {
            print('Payment submitted: ₦$amount via $paymentType');
            // Handle the payment submission here
          },
        );
      },
    );
  }
}
