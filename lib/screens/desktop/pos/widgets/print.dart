// import 'package:spotstock_inventory/common/money.dart';
import 'package:flutter/material.dart';

class PrintDialog extends StatelessWidget {
  final Map<String, dynamic> transactionData;

  const PrintDialog({super.key, required this.transactionData});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Transaction Information"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text("Transaction ID: ${transactionData['txnID']}"),
            // Text("Amount: ${Money.format(transactionData['amount'])}"),
            // Text("Payment Type: ${transactionData['paymentType']}"),
            // Text("Change: ${Money.format(transactionData['change'])}"),
            // Add more fields as needed
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Implement the print logic here
            print("Printing transaction: ${transactionData['trxId']}");
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Print"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Close"),
        ),
      ],
    );
  }
}
