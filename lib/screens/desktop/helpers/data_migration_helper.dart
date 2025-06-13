// Add this helper to update existing transaction status values
import 'package:spotstock_inventory/common/helpers/database_engine.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/objectbox.g.dart';

class PaymentStatusMigrationHelper {
  static Future<void> updateExistingTransactionStatuses(UserDetails user) async {
    final store = await DatabaseEngine.instance.getStore();
    final orderBox = store.box<Orders>();
    
    // Get all user's transactions
    final transactions = orderBox
        .query(Orders_.billerId.equals(user.id))
        .build()
        .find();
    
    print('Found ${transactions.length} transactions to potentially update');
    
    int updatedCount = 0;
    for (var transaction in transactions) {
      bool needsUpdate = false;
      
      // If paymentStatus is null or empty, derive it from status
      if (transaction.paymentStatus == null || transaction.paymentStatus!.isEmpty) {
        switch (transaction.status) {
          case 0:
            transaction.paymentStatus = 'Pending';
            needsUpdate = true;
            break;
          case 1:
            transaction.paymentStatus = 'Paid';
            needsUpdate = true;
            break;
          case 2:
            transaction.paymentStatus = 'Partial';
            needsUpdate = true;
            break;
          case 3:
            transaction.paymentStatus = 'Failed';
            needsUpdate = true;
            break;
          default:
            transaction.paymentStatus = 'Unknown';
            needsUpdate = true;
            break;
        }
      }
      
      if (needsUpdate) {
        orderBox.put(transaction);
        updatedCount++;
      }
    }
    
    print('Updated $updatedCount transactions with payment status');
  }
  
  static Future<void> setRandomStatusesForTesting(UserDetails user) async {
    final store = await DatabaseEngine.instance.getStore();
    final orderBox = store.box<Orders>();
    
    final transactions = orderBox
        .query(Orders_.billerId.equals(user.id))
        .build()
        .find();
    
    // Set different statuses for testing
    for (int i = 0; i < transactions.length; i++) {
      final transaction = transactions[i];
      // Rotate through different statuses for testing
      transaction.status = i % 4; // 0=Pending, 1=Paid, 2=Partial, 3=Failed
      transaction.paymentStatus = null; // Clear explicit status to test logic
      orderBox.put(transaction);
    }
    
    print('Set test statuses for ${transactions.length} transactions');
  }
}
