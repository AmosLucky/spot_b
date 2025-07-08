import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/screens/desktop/services/payment_reconciliation_service.dart';
// import '../services/payment_reconciliation_service.dart';

class PaymentReconciliationModel {
  final String transactionId;
  final double totalAmount;
  final double paidSoFar;
  final double balance;
  final String paymentStatus;
  final String paymentMethod;
  final double? partialAmount;
  final double? receivedAmount;
  final String? attendantId;
  final String? customerName;
  final String? tableId;

  PaymentReconciliationModel({
    required this.transactionId,
    required this.totalAmount,
    required this.paidSoFar,
    required this.balance,
    required this.paymentStatus,
    required this.paymentMethod,
    this.partialAmount,
    this.receivedAmount,
    this.attendantId,
    this.customerName,
    this.tableId,
  });

  factory PaymentReconciliationModel.fromOrder(Orders order) {
    final double totalAmount = order.amount;
    final double paidSoFar = order.receivedAmount ?? 0.0;
    final double balance = totalAmount - paidSoFar;

    // Normalize payment method using the service
    final normalizedPaymentMethod = PaymentReconciliationService.normalizePaymentMethod(order.paymentMethod);

    return PaymentReconciliationModel(
      transactionId: order.trxId,
      totalAmount: totalAmount,
      paidSoFar: paidSoFar,
      balance: balance,
      paymentStatus: order.paymentStatus ?? 'Unpaid',
      paymentMethod: normalizedPaymentMethod,
      partialAmount: order.partialAmount,
      receivedAmount: order.receivedAmount,
      attendantId: order.attendantId,
      customerName: order.customerName,
      tableId: order.tableId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'totalAmount': totalAmount,
      'paidSoFar': paidSoFar,
      'balance': balance,
      'paymentStatus': paymentStatus,
      'paymentMethod': paymentMethod,
      'partialAmount': partialAmount,
      'receivedAmount': receivedAmount,
      'attendantId': attendantId,
      'customerName': customerName,
      'tableId': tableId,
    };
  }
}




// import 'package:spotstock_inventory/data/models/schema.dart';

// class PaymentReconciliationModel {
//   final String transactionId;
//   final double totalAmount;
//   final double paidSoFar;
//   final double balance;
//   final String paymentStatus;
//   final String paymentMethod;
//   final double? partialAmount;
//   final double? receivedAmount;
//   final String? attendantId;
//   final String? customerName;
//   final String? tableId;

//   PaymentReconciliationModel({
//     required this.transactionId,
//     required this.totalAmount,
//     required this.paidSoFar,
//     required this.balance,
//     required this.paymentStatus,
//     required this.paymentMethod,
//     this.partialAmount,
//     this.receivedAmount,
//     this.attendantId,
//     this.customerName,
//     this.tableId,
//   });

//   factory PaymentReconciliationModel.fromOrder(Orders order) {
//     final double totalAmount = order.amount;
//     final double paidSoFar = order.receivedAmount ?? 0.0;
//     final double balance = totalAmount - paidSoFar;

//     return PaymentReconciliationModel(
//       transactionId: order.trxId,
//       totalAmount: totalAmount,
//       paidSoFar: paidSoFar,
//       balance: balance,
//       paymentStatus: order.paymentStatus ?? 'Unpaid',
//       paymentMethod: order.paymentMethod ?? 'Cash',
//       partialAmount: order.partialAmount,
//       receivedAmount: order.receivedAmount,
//       attendantId: order.attendantId,
//       customerName: order.customerName,
//       tableId: order.tableId,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'transactionId': transactionId,
//       'totalAmount': totalAmount,
//       'paidSoFar': paidSoFar,
//       'balance': balance,
//       'paymentStatus': paymentStatus,
//       'paymentMethod': paymentMethod,
//       'partialAmount': partialAmount,
//       'receivedAmount': receivedAmount,
//       'attendantId': attendantId,
//       'customerName': customerName,
//       'tableId': tableId,
//     };
//   }
// }
