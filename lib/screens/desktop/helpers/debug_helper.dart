// Add this temporary debug helper to check your transaction data
import 'package:spotstock_inventory/data/models/schema.dart';

class PaymentStatusDebugHelper {
  static void debugTransactionStatus(Orders sale) {
    print('=== DEBUG TRANSACTION STATUS ===');
    print('Transaction ID: ${sale.trxId}');
    print('Status (int): ${sale.status}');
    print('PaymentStatus (string): ${sale.paymentStatus}');
    print('PaymentMethod: ${sale.paymentMethod}');
    print('Customer: ${sale.customerName}');
    print('Amount: ${sale.amount}');
    print('Created: ${sale.createdAt}');
    print('=== END DEBUG ===\n');
  }
  
  static void debugAllTransactions(List<Orders> sales) {
    print('=== DEBUGGING ${sales.length} TRANSACTIONS ===');
    for (int i = 0; i < sales.length && i < 5; i++) { // Debug first 5 transactions
      debugTransactionStatus(sales[i]);
    }
  }
}
