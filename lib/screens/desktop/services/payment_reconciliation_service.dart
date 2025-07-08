import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spotstock_inventory/data/api/api_client.dart';
import 'package:spotstock_inventory/common/helpers/database_engine.dart';
import 'package:spotstock_inventory/data/models/payment_reconciliation_model.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/common/utils/toast_utils.dart';
import 'package:spotstock_inventory/objectbox.g.dart';
// import '../models/payment_reconciliation_model.dart';

class PaymentReconciliationService {
  final ApiClient _apiClient = ApiClient();
  final GetStorage _storage = GetStorage();

  // Payment type mapping consistent with order summary
  static const Map<String, int> paymentTypeMapping = {
    'Cash': 1,
    'Cheque': 2,
    'Bank Transfer': 3,
    'Mobile Money': 4,
    'Card': 4,
    'Transfer': 3,
    'POS': 4,
  };

  static const Map<int, String> paymentTypeReverseMapping = {
    1: 'Cash',
    2: 'Cheque',
    3: 'Bank Transfer',
    4: 'Mobile Money',
  };

  // Database to display mapping for payment methods
  static const Map<String, String> databaseToDisplayMapping = {
    'CASH': 'Cash',
    'Cash': 'Cash',
    'cash': 'Cash',
    'CHEQUE': 'Cheque',
    'Cheque': 'Cheque',
    'cheque': 'Cheque',
    'BANK_TRANSFER': 'Bank Transfer',
    'Bank Transfer': 'Bank Transfer',
    'bank_transfer': 'Bank Transfer',
    'MOBILE_MONEY': 'Mobile Money',
    'Mobile Money': 'Mobile Money',
    'mobile_money': 'Mobile Money',
    'CARD': 'Card',
    'Card': 'Card',
    'card': 'Card',
    'TRANSFER': 'Bank Transfer',
    'Transfer': 'Bank Transfer',
    'transfer': 'Bank Transfer',
    'POS': 'Card',
    'pos': 'Card',
    'OTHER': 'Mobile Money',
    'other': 'Mobile Money',
  };

  // Convert database payment method to display format
  static String normalizePaymentMethod(String? paymentMethod) {
    if (paymentMethod == null || paymentMethod.isEmpty) {
      return 'Cash'; // Default fallback
    }
    
    return databaseToDisplayMapping[paymentMethod] ?? 'Cash';
  }

  // Get payment reconciliation data for a transaction
  Future<PaymentReconciliationModel?> getPaymentReconciliationData(String transactionId) async {
    try {
      final store = await DatabaseEngine.instance.getStore();
      final orderBox = store.box<Orders>();
      
      final query = orderBox.query(Orders_.trxId.equals(transactionId)).build();
      final order = query.findFirst();
      query.close();

      if (order != null) {
        return PaymentReconciliationModel.fromOrder(order);
      }
      return null;
    } catch (e) {
      print('Error getting payment reconciliation data: $e');
      return null;
    }
  }

  // Check internet connectivity
  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // Submit payment reconciliation to server
  Future<Map<String, dynamic>> submitPaymentReconciliation({
    required String transactionId,
    required double amount,
    required String paymentType,
    required String token,
  }) async {
    final int paymentTypeCode = paymentTypeMapping[paymentType] ?? 1;
    
    final url = Uri.parse('${_apiClient.baseUrl}sales/$transactionId/reconcile-payment');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode({
      'amount': amount,
      'payment_type': paymentTypeCode,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 || responseBody['status'] == true) {
        return {
          'success': true,
          'message': responseBody['message'] ?? 'Payment reconciled successfully',
          'isFullyPaid': responseBody['message']?.contains('already fully paid') ?? false,
        };
      } else {
        return {
          'success': false,
          'message': responseBody['message'] ?? 'Failed to reconcile payment',
          'isFullyPaid': responseBody['message']?.contains('already fully paid') ?? false,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e',
        'isFullyPaid': false,
      };
    }
  }

  // Update local order with payment reconciliation
  Future<bool> updateLocalOrderPayment({
    required String transactionId,
    required double amount,
    required String paymentType,
    required bool isSynced,
    required bool isFullyPaid,
  }) async {
    try {
      final store = await DatabaseEngine.instance.getStore();
      final orderBox = store.box<Orders>();
      
      final query = orderBox.query(Orders_.trxId.equals(transactionId)).build();
      final order = query.findFirst();
      
      if (order != null) {
        if (isFullyPaid) {
          // If server indicates fully paid, set status to Paid
          order.paymentStatus = 'Paid';
          order.receivedAmount = order.amount;
          order.partialAmount = 0.0;
        } else {
          // Calculate new payment values
          final newReceivedAmount = (order.receivedAmount ?? 0.0) + amount;
          final newBalance = order.amount - newReceivedAmount;
          
          String newPaymentStatus;
          if (newReceivedAmount >= order.amount) {
            newPaymentStatus = 'Paid';
          } else if (newReceivedAmount > 0) {
            newPaymentStatus = 'Partial';
          } else {
            newPaymentStatus = 'Unpaid';
          }
          
          order.receivedAmount = newReceivedAmount;
          order.paymentStatus = newPaymentStatus;
          
          // Update partial amount if it's a partial payment
          if (newPaymentStatus == 'Partial') {
            order.partialAmount = amount;
          }
        }
        
        order.paymentMethod = paymentType;
        order.sync = isSynced ? 1 : 0;
        
        orderBox.put(order);
        query.close();
        
        print('Updated order ${order.trxId} locally: ${order.paymentStatus}, received: ${order.receivedAmount}');
        return true;
      }
      
      query.close();
      return false;
    } catch (e) {
      print('Error updating local order: $e');
      return false;
    }
  }

  // Process complete payment reconciliation flow
  Future<Map<String, dynamic>> processPaymentReconciliation({
    required String transactionId,
    required double amount,
    required String paymentType,
    required String token,
  }) async {
    bool isOnline = await _checkInternetConnection();
    
    try {
      if (isOnline) {
        // Online: Submit to server first
        final serverResponse = await submitPaymentReconciliation(
          transactionId: transactionId,
          amount: amount,
          paymentType: paymentType,
          token: token,
        );
        
        if (serverResponse['success']) {
          // Update local database with synced status
          final localUpdateSuccess = await updateLocalOrderPayment(
            transactionId: transactionId,
            amount: amount,
            paymentType: paymentType,
            isSynced: true,
            isFullyPaid: serverResponse['isFullyPaid'] ?? false,
          );
          
          return {
            'success': true,
            'message': serverResponse['message'] ?? 'Payment reconciled successfully',
            'synced': true,
            'localUpdated': localUpdateSuccess,
          };
        } else {
          // Server failed, but update locally as unsynced for offline capability
          final localUpdateSuccess = await updateLocalOrderPayment(
            transactionId: transactionId,
            amount: amount,
            paymentType: paymentType,
            isSynced: false,
            isFullyPaid: false,
          );
          
          if (serverResponse['isFullyPaid'] == true) {
            return {
              'success': true,
              'message': 'Sale is already fully paid.',
              'synced': false,
              'localUpdated': localUpdateSuccess,
            };
          } else {
            // If local update succeeded, treat as success with warning
            if (localUpdateSuccess) {
              return {
                'success': true,
                'message': 'Payment saved locally. Server sync failed but will retry later.',
                'synced': false,
                'localUpdated': true,
                'serverError': serverResponse['message'],
              };
            } else {
              return {
                'success': false,
                'message': serverResponse['message'] ?? 'Failed to process payment',
                'synced': false,
                'localUpdated': false,
              };
            }
          }
        }
      } else {
        // Offline: Store locally as unsynced
        final localUpdateSuccess = await updateLocalOrderPayment(
          transactionId: transactionId,
          amount: amount,
          paymentType: paymentType,
          isSynced: false,
          isFullyPaid: false,
        );
        
        return {
          'success': localUpdateSuccess,
          'message': localUpdateSuccess 
              ? 'Payment saved offline. Will sync when online.'
              : 'Failed to save payment offline.',
          'synced': false,
          'localUpdated': localUpdateSuccess,
        };
      }
    } catch (e) {
      // Try to save locally even if there's an exception
      try {
        final localUpdateSuccess = await updateLocalOrderPayment(
          transactionId: transactionId,
          amount: amount,
          paymentType: paymentType,
          isSynced: false,
          isFullyPaid: false,
        );
        
        if (localUpdateSuccess) {
          return {
            'success': true,
            'message': 'Payment saved locally. Network error occurred but payment is recorded.',
            'synced': false,
            'localUpdated': true,
            'networkError': e.toString(),
          };
        }
      } catch (localError) {
        print('Local update also failed: $localError');
      }
      
      return {
        'success': false,
        'message': 'Failed to process payment: $e',
        'synced': false,
        'localUpdated': false,
      };
    }
  }
}






// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:spotstock_inventory/data/api/api_client.dart';
// import 'package:spotstock_inventory/common/helpers/database_engine.dart';
// import 'package:spotstock_inventory/data/models/payment_reconciliation_model.dart';
// import 'package:spotstock_inventory/data/models/schema.dart';
// // import 'package:spotstock_inventory/common/utils/toast_utils.dart';
// import 'package:spotstock_inventory/objectbox.g.dart';
// // import '../models/payment_reconciliation_model.dart';

// class PaymentReconciliationService {
//   final ApiClient _apiClient = ApiClient();
//   final GetStorage _storage = GetStorage();

//   // Payment type mapping consistent with order summary
//   static const Map<String, int> paymentTypeMapping = {
//     'Cash': 1,
//     'Cheque': 2,
//     'Bank Transfer': 3,
//     'Mobile Money': 4,
//     'Card': 4,
//     'Transfer': 3,
//     'POS': 4,
//   };

//   static const Map<int, String> paymentTypeReverseMapping = {
//     1: 'Cash',
//     2: 'Cheque',
//     3: 'Bank Transfer',
//     4: 'Mobile Money',
//   };

//   // Database to display mapping for payment methods
//   static const Map<String, String> databaseToDisplayMapping = {
//     'CASH': 'Cash',
//     'Cash': 'Cash',
//     'cash': 'Cash',
//     'CHEQUE': 'Cheque',
//     'Cheque': 'Cheque',
//     'cheque': 'Cheque',
//     'BANK_TRANSFER': 'Bank Transfer',
//     'Bank Transfer': 'Bank Transfer',
//     'bank_transfer': 'Bank Transfer',
//     'MOBILE_MONEY': 'Mobile Money',
//     'Mobile Money': 'Mobile Money',
//     'mobile_money': 'Mobile Money',
//     'CARD': 'Card',
//     'Card': 'Card',
//     'card': 'Card',
//     'TRANSFER': 'Bank Transfer',
//     'Transfer': 'Bank Transfer',
//     'transfer': 'Bank Transfer',
//     'POS': 'Card',
//     'pos': 'Card',
//     'OTHER': 'Mobile Money',
//     'other': 'Mobile Money',
//   };

//   // Convert database payment method to display format
//   static String normalizePaymentMethod(String? paymentMethod) {
//     if (paymentMethod == null || paymentMethod.isEmpty) {
//       return 'Cash'; // Default fallback
//     }
    
//     return databaseToDisplayMapping[paymentMethod] ?? 'Cash';
//   }

//   // Get payment reconciliation data for a transaction
//   Future<PaymentReconciliationModel?> getPaymentReconciliationData(String transactionId) async {
//     try {
//       final store = await DatabaseEngine.instance.getStore();
//       final orderBox = store.box<Orders>();
      
//       final query = orderBox.query(Orders_.trxId.equals(transactionId)).build();
//       final order = query.findFirst();
//       query.close();

//       if (order != null) {
//         return PaymentReconciliationModel.fromOrder(order);
//       }
//       return null;
//     } catch (e) {
//       print('Error getting payment reconciliation data: $e');
//       return null;
//     }
//   }

//   // Check internet connectivity
//   Future<bool> _checkInternetConnection() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     return connectivityResult != ConnectivityResult.none;
//   }

//   // Submit payment reconciliation to server
//   Future<Map<String, dynamic>> submitPaymentReconciliation({
//     required String transactionId,
//     required double amount,
//     required String paymentType,
//     required String token,
//   }) async {
//     final int paymentTypeCode = paymentTypeMapping[paymentType] ?? 1;
    
//     final url = Uri.parse('${_apiClient.baseUrl}sales/$transactionId/reconcile-payment');
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token',
//     };

//     final body = jsonEncode({
//       'amount': amount,
//       'payment_type': paymentTypeCode,
//     });

//     try {
//       final response = await http.post(url, headers: headers, body: body);
//       final responseBody = jsonDecode(response.body);

//       if (response.statusCode == 200 || responseBody['status'] == true) {
//         return {
//           'success': true,
//           'message': responseBody['message'] ?? 'Payment reconciled successfully',
//           'isFullyPaid': responseBody['message']?.contains('already fully paid') ?? false,
//         };
//       } else {
//         return {
//           'success': false,
//           'message': responseBody['message'] ?? 'Failed to reconcile payment',
//           'isFullyPaid': responseBody['message']?.contains('already fully paid') ?? false,
//         };
//       }
//     } catch (e) {
//       return {
//         'success': false,
//         'message': 'Network error: $e',
//         'isFullyPaid': false,
//       };
//     }
//   }

//   // Update local order with payment reconciliation
//   Future<bool> updateLocalOrderPayment({
//     required String transactionId,
//     required double amount,
//     required String paymentType,
//     required bool isSynced,
//     required bool isFullyPaid,
//   }) async {
//     try {
//       final store = await DatabaseEngine.instance.getStore();
//       final orderBox = store.box<Orders>();
      
//       final query = orderBox.query(Orders_.trxId.equals(transactionId)).build();
//       final order = query.findFirst();
      
//       if (order != null) {
//         if (isFullyPaid) {
//           // If server indicates fully paid, set status to Paid
//           order.paymentStatus = 'Paid';
//           order.receivedAmount = order.amount;
//           order.partialAmount = 0.0;
//         } else {
//           // Calculate new payment values
//           final newReceivedAmount = (order.receivedAmount ?? 0.0) + amount;
//           final newBalance = order.amount - newReceivedAmount;
          
//           String newPaymentStatus;
//           if (newReceivedAmount >= order.amount) {
//             newPaymentStatus = 'Paid';
//           } else if (newReceivedAmount > 0) {
//             newPaymentStatus = 'Partial';
//           } else {
//             newPaymentStatus = 'Unpaid';
//           }
          
//           order.receivedAmount = newReceivedAmount;
//           order.paymentStatus = newPaymentStatus;
          
//           // Update partial amount if it's a partial payment
//           if (newPaymentStatus == 'Partial') {
//             order.partialAmount = amount;
//           }
//         }
        
//         order.paymentMethod = paymentType;
//         order.sync = isSynced ? 1 : 0;
        
//         orderBox.put(order);
//         query.close();
        
//         print('Updated order ${order.trxId} locally: ${order.paymentStatus}, received: ${order.receivedAmount}');
//         return true;
//       }
      
//       query.close();
//       return false;
//     } catch (e) {
//       print('Error updating local order: $e');
//       return false;
//     }
//   }

//   // Process complete payment reconciliation flow
//   Future<Map<String, dynamic>> processPaymentReconciliation({
//     required String transactionId,
//     required double amount,
//     required String paymentType,
//     required String token,
//   }) async {
//     bool isOnline = await _checkInternetConnection();
    
//     try {
//       if (isOnline) {
//         // Online: Submit to server first
//         final serverResponse = await submitPaymentReconciliation(
//           transactionId: transactionId,
//           amount: amount,
//           paymentType: paymentType,
//           token: token,
//         );
        
//         if (serverResponse['success']) {
//           // Update local database with synced status
//           await updateLocalOrderPayment(
//             transactionId: transactionId,
//             amount: amount,
//             paymentType: paymentType,
//             isSynced: true,
//             isFullyPaid: serverResponse['isFullyPaid'] ?? false,
//           );
          
//           return {
//             'success': true,
//             'message': serverResponse['message'],
//             'synced': true,
//           };
//         } else {
//           // Server failed, store locally as unsynced
//           if (serverResponse['isFullyPaid'] == true) {
//             await updateLocalOrderPayment(
//               transactionId: transactionId,
//               amount: 0.0,
//               paymentType: paymentType,
//               isSynced: true,
//               isFullyPaid: true,
//             );
            
//             return {
//               'success': true,
//               'message': 'Sale is already fully paid.',
//               'synced': true,
//             };
//           } else {
//             await updateLocalOrderPayment(
//               transactionId: transactionId,
//               amount: amount,
//               paymentType: paymentType,
//               isSynced: false,
//               isFullyPaid: false,
//             );
            
//             return {
//               'success': false,
//               'message': serverResponse['message'],
//               'synced': false,
//             };
//           }
//         }
//       } else {
//         // Offline: Store locally as unsynced
//         await updateLocalOrderPayment(
//           transactionId: transactionId,
//           amount: amount,
//           paymentType: paymentType,
//           isSynced: false,
//           isFullyPaid: false,
//         );
        
//         return {
//           'success': true,
//           'message': 'Payment saved offline. Will sync when online.',
//           'synced': false,
//         };
//       }
//     } catch (e) {
//       return {
//         'success': false,
//         'message': 'Failed to process payment: $e',
//         'synced': false,
//       };
//     }
//   }
// }