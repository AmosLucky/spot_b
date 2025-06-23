import 'package:flutter/material.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/widgets/reconcile_payment.dart';

class TransactionTile extends StatelessWidget {
  final String transactionId;
  final int? status;
  final String customer;
  final double amount;
  final DateTime createdAt;
  final bool isSynced;
  final String paymentMethod;
  final String? paymentStatus;
  final VoidCallback onPrint;
  final VoidCallback onSync;

  const TransactionTile({
    super.key,
    required this.transactionId,
    this.status,
    required this.customer,
    required this.amount,
    required this.createdAt,
    required this.isSynced,
    required this.paymentMethod,
    this.paymentStatus,
    required this.onPrint,
    required this.onSync,
  });

  // Helper method to determine payment status display
  String _getPaymentStatusDisplay() {
    if (paymentStatus != null && paymentStatus!.isNotEmpty) {
      return paymentStatus!;
    }

    if (status != null) {
      switch (status) {
        case 0:
          return 'Pending';
        case 1:
          return 'Paid';
        case 2:
          return 'Partial';
        case 3:
          return 'Failed';
        default:
          return 'Unknown';
      }
    }

    return 'Unpaid';
  }

  // Helper method to get status color
  Color _getStatusColor() {
    String statusText = _getPaymentStatusDisplay();
    switch (statusText.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'partial':
        return Colors.orange;
      case 'pending':
        return Colors.blue;
      case 'failed':
        return Colors.red;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double tileWidth = constraints.maxWidth;
        final double fontSize = (tileWidth * 0.035).clamp(10, 12); // Dynamic font size
        final double iconSize = (tileWidth * 0.05).clamp(16, 20); // Dynamic icon size
        final double padding = tileWidth * 0.02; // Dynamic padding

        return Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: padding, horizontal: padding),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: isSynced ? Colors.greenAccent : Colors.redAccent,
                  radius: (tileWidth * 0.025).clamp(6, 8),
                ),
                SizedBox(width: padding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaction ID: $transactionId',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: blackColor,
                        ),
                      ),
                      SizedBox(height: padding * 0.5),
                      Text(
                        Money.format(amount),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: padding * 0.5),
                      Text(
                        'Customer: $customer',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: blackColor,
                        ),
                      ),
                      Text(
                        paymentMethod,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: secondaryColor,
                        ),
                      ),
                      Text(
                        '${createdAt.toLocal()}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: padding),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showReconcilePaymentDialog(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: padding * 0.3,
                          horizontal: padding,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: _getStatusColor(),
                        ),
                        child: Text(
                          _getPaymentStatusDisplay(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize * 0.9,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: padding),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.print,
                            color: Colors.blue,
                            size: iconSize,
                          ),
                          onPressed: onPrint,
                        ),
                        TextButton(
                          onPressed: () {
                            onSync();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isSynced
                                      ? 'Resynced $transactionId'
                                      : 'Synced $transactionId',
                                ),
                              ),
                            );
                          },
                          child: Text(
                            isSynced ? 'Resync' : 'Sync',
                            style: TextStyle(
                              fontSize: fontSize * 0.9,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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
          status: _getPaymentStatusDisplay(),
          onSubmit: (amount, paymentType) {
            print('Payment submitted: ₦$amount via $paymentType');
          },
        );
      },
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:spotstock_inventory/common/common.dart';
// import 'package:spotstock_inventory/common/money.dart';
// import 'package:spotstock_inventory/widgets/reconcile_payment.dart';

// class TransactionTile extends StatelessWidget {
//   final String transactionId;
//   final int? status;
//   final String customer;
//   final double amount;
//   final DateTime createdAt;
//   final bool isSynced;
//   final String paymentMethod;
//   final String? paymentStatus; // Add this field for actual payment status
//   final VoidCallback onPrint;
//   final VoidCallback onSync;

//   const TransactionTile({
//     super.key,
//     required this.transactionId,
//     this.status,
//     required this.customer,
//     required this.amount,
//     required this.createdAt,
//     required this.isSynced,
//     required this.paymentMethod,
//     this.paymentStatus, // Add this parameter
//     required this.onPrint,
//     required this.onSync,
//   });

//   // Helper method to determine payment status display
//   String _getPaymentStatusDisplay() {
//     // If paymentStatus is provided, use it
//     if (paymentStatus != null && paymentStatus!.isNotEmpty) {
//       return paymentStatus!;
//     }
    
//     // Fallback to status interpretation
//     if (status != null) {
//       switch (status) {
//         case 0:
//           return 'Pending';
//         case 1:
//           return 'Paid';
//         case 2:
//           return 'Partial';
//         case 3:
//           return 'Failed';
//         default:
//           return 'Unknown';
//       }
//     }
    
//     return 'Unpaid';
//   }

//   // Helper method to get status color
//   Color _getStatusColor() {
//     String statusText = _getPaymentStatusDisplay();
//     switch (statusText.toLowerCase()) {
//       case 'paid':
//         return Colors.green;
//       case 'partial':
//         return Colors.orange;
//       case 'pending':
//         return Colors.blue;
//       case 'failed':
//         return Colors.red;
//       default:
//         return Colors.red;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.symmetric(vertical: 5),
//       child: ListTile(
//         dense: false,
//         isThreeLine: true,
//         leading: CircleAvatar(
//           backgroundColor: isSynced ? Colors.greenAccent : Colors.redAccent,
//           radius: 12,
//         ),
//         title: Text('Transaction ID: $transactionId'),
//         subtitle: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   Money.format(amount),
//                   style: TextStyle(
//                     color: blackColor, 
//                     fontWeight: FontWeight.bold
//                   ),
//                 ),
//                 Text(
//                   "Customer: $customer",
//                   style: TextStyle(
//                     color: blackColor, 
//                     fontWeight: FontWeight.bold
//                   ),
//                 ),
//                 Text(
//                   paymentMethod,
//                   style: TextStyle(
//                     color: secondaryColor, 
//                     fontWeight: FontWeight.normal
//                   ),
//                 ),
//                 Text('${createdAt.toLocal()}'),
//               ],
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(3),
//                     color: _getStatusColor(),
//                   ),
//                   child: GestureDetector(
//                     onTap: () {
//                       showReconcilePaymentDialog(context);
//                     },
//                     child: Text(
//                       _getPaymentStatusDisplay(),
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Column(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.print),
//                           onPressed: onPrint,
//                         ),
//                       ],
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         onSync();
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(isSynced
//                                 ? 'Resynced $transactionId'
//                                 : 'Synced $transactionId'),
//                           ),
//                         );
//                       },
//                       child: Text(isSynced ? 'Resync' : 'Sync'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void showReconcilePaymentDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return ReconcilePaymentDialog(
//           reference: transactionId,
//           totalAmount: amount,
//           paidSoFar: 50.0,
//           status: _getPaymentStatusDisplay(),
//           onSubmit: (amount, paymentType) {
//             print('Payment submitted: ₦$amount via $paymentType');
//           },
//         );
//       },
//     );
//   }
// }