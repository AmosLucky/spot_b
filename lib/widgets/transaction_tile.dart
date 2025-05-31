import 'package:flutter/material.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/money.dart';

class TransactionTile extends StatelessWidget {
  final String transactionId;
  final String customer;
  final double amount;
  final DateTime createdAt;
  final bool isSynced; // Sync status
  final String paymentMethod; // Payment method
  final VoidCallback onPrint; // Callback for print action
  final VoidCallback onSync; // Callback for sync action

  const TransactionTile({
    super.key,
    required this.transactionId,
    required this.customer,
    required this.amount,
    required this.createdAt,
    required this.isSynced,
    required this.paymentMethod, // Include payment method in the constructor
    required this.onPrint, // Accept print callback
    required this.onSync, // Accept sync callback
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Optional: Adds a card effect for better separation
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isSynced ? Colors.greenAccent : Colors.redAccent,
          radius: 12,
        ),
        title: Text('Transaction ID: $transactionId'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Money.format(amount),
              style: TextStyle(color: blackColor, fontWeight: FontWeight.bold),
            ),
            Text(
              "Customer: $customer",
              style: TextStyle(color: blackColor, fontWeight: FontWeight.bold),
            ),
            Text(
              paymentMethod,
              style: TextStyle(
                  color: secondaryColor, fontWeight: FontWeight.normal),
            ), // Display payment method
            Text('${createdAt.toLocal()}'), // Convert to local time
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min, // Shrinks the Row to fit its content
          children: [
            // Print button
            IconButton(
              icon: const Icon(Icons.print),
              onPressed: onPrint, // Call print function
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
      ),
    );
  }
}
