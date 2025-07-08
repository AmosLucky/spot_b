class PaymentStatusDebugHelper {
  static void debugTransactionStatus(dynamic sale) {
    print('=== DEBUG TRANSACTION STATUS ===');
    print('Transaction ID: ${sale.trxId}');
    print('Status (int): ${sale.status}');
    print('PaymentStatus (string): ${sale.paymentStatus}');
    print('PaymentMethod: ${sale.paymentMethod}');
    print('Customer: ${sale.customerName}');
    print('Amount: ${sale.amount}');
    print('ReceivedAmount: ${sale.receivedAmount}');
    print('PartialAmount: ${sale.partialAmount}');
    print('Sync Status: ${sale.sync}');
    print('Created: ${sale.createdAt}');
    print('=== END DEBUG ===');
  }

  static void debugPaymentReconciliation(String transactionId, Map<String, dynamic> result) {
    print('=== PAYMENT RECONCILIATION DEBUG ===');
    print('Transaction ID: $transactionId');
    print('Result: $result');
    print('Success: ${result['success']}');
    print('Message: ${result['message']}');
    print('Synced: ${result['synced']}');
    print('Local Updated: ${result['localUpdated']}');
    if (result['serverError'] != null) {
      print('Server Error: ${result['serverError']}');
    }
    if (result['networkError'] != null) {
      print('Network Error: ${result['networkError']}');
    }
    print('=== END RECONCILIATION DEBUG ===');
  }
}





// // Add this temporary debug helper to check your transaction data
// import 'package:spotstock_inventory/data/models/schema.dart';

// class PaymentStatusDebugHelper {
//   static void debugTransactionStatus(Orders sale) {
//     print('=== DEBUG TRANSACTION STATUS ===');
//     print('Transaction ID: ${sale.trxId}');
//     print('Status (int): ${sale.status}');
//     print('PaymentStatus (string): ${sale.paymentStatus}');
//     print('PaymentMethod: ${sale.paymentMethod}');
//     print('Customer: ${sale.customerName}');
//     print('Amount: ${sale.amount}');
//     print('Created: ${sale.createdAt}');
//     print('=== END DEBUG ===\n');
//   }
  
//   static void debugAllTransactions(List<Orders> sales) {
//     print('=== DEBUGGING ${sales.length} TRANSACTIONS ===');
//     for (int i = 0; i < sales.length && i < 5; i++) { // Debug first 5 transactions
//       debugTransactionStatus(sales[i]);
//     }
//   }
// }
