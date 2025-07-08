import 'package:flutter/material.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/widgets/reconcile_payment.dart';
// import 'package:spotstock_inventory/widgets/enhanced_reconcile_payment.dart';

class TransactionTile extends StatefulWidget {
  final String transactionId;
  final int? status;
  final String customer;
  final double amount;
  final DateTime createdAt;
  final bool isSynced;
  final String paymentMethod;
  final String? paymentStatus;
  final double? paidSoFar;
  final double? balance;
  final VoidCallback onPrint;
  final VoidCallback onSync;
  final VoidCallback? onPaymentUpdated;

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
    this.paidSoFar,
    this.balance,
    required this.onPrint,
    required this.onSync,
    this.onPaymentUpdated,
  });

  @override
  State<TransactionTile> createState() => _TransactionTileState();
}

class _TransactionTileState extends State<TransactionTile> {
  String _currentPaymentStatus = '';
  double _currentPaidSoFar = 0.0;
  double _currentBalance = 0.0;

  @override
  void initState() {
    super.initState();
    _updatePaymentInfo();
  }

  @override
  void didUpdateWidget(TransactionTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.paymentStatus != widget.paymentStatus ||
        oldWidget.paidSoFar != widget.paidSoFar ||
        oldWidget.balance != widget.balance) {
      _updatePaymentInfo();
    }
  }

  void _updatePaymentInfo() {
    setState(() {
      _currentPaymentStatus = _getPaymentStatusDisplay();
      _currentPaidSoFar = widget.paidSoFar ?? 0.0;
      _currentBalance = widget.balance ?? (widget.amount - _currentPaidSoFar);
    });
  }

  String _getPaymentStatusDisplay() {
    if (widget.paymentStatus != null && widget.paymentStatus!.isNotEmpty) {
      return widget.paymentStatus!;
    }
    if (widget.status != null) {
      switch (widget.status) {
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

  Color _getStatusColor() {
    switch (_currentPaymentStatus.toLowerCase()) {
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

  void _showReconcilePaymentDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ReconcilePaymentDialog(
          transactionId: widget.transactionId,
          onSubmit: (amount, paymentType) {
            print('Payment submitted: ₦$amount via $paymentType');
          },
          onPaymentUpdated: () {
            // Refresh the parent widget
            widget.onPaymentUpdated?.call();
            // Update local state
            _updatePaymentInfo();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double tileWidth = constraints.maxWidth;
        final double fontSize = (tileWidth * 0.035).clamp(10, 12);
        final double iconSize = (tileWidth * 0.05).clamp(16, 20);
        final double padding = tileWidth * 0.02;

        return Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: padding, horizontal: padding),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: widget.isSynced ? Colors.greenAccent : Colors.redAccent,
                  radius: (tileWidth * 0.025).clamp(6, 8),
                ),
                SizedBox(width: padding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaction ID: ${widget.transactionId}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: fontSize, color: blackColor),
                      ),
                      SizedBox(height: padding * 0.5),
                      Text(
                        Money.format(widget.amount),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: padding * 0.5),
                      if (_currentPaidSoFar > 0)
                        Text(
                          'Paid: ${Money.format(_currentPaidSoFar)}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: fontSize * 0.9,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      if (_currentBalance > 0)
                        Text(
                          'Balance: ${Money.format(_currentBalance)}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: fontSize * 0.9,
                            color: Colors.orange,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      Text(
                        'Customer: ${widget.customer}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: fontSize, color: blackColor),
                      ),
                      Text(
                        widget.paymentMethod,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: fontSize, color: secondaryColor),
                      ),
                      Text(
                        '${widget.createdAt.toLocal()}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: fontSize, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: padding),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: _showReconcilePaymentDialog,
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
                          _currentPaymentStatus,
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
                          icon: Icon(Icons.print, color: Colors.blue, size: iconSize),
                          onPressed: widget.onPrint,
                        ),
                        TextButton(
                          onPressed: () {
                            widget.onSync();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  widget.isSynced
                                      ? 'Resynced ${widget.transactionId}'
                                      : 'Synced ${widget.transactionId}',
                                ),
                              ),
                            );
                          },
                          child: Text(
                            widget.isSynced ? 'Resync' : 'Sync',
                            style: TextStyle(fontSize: fontSize * 0.9),
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
//   final String? paymentStatus;
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
//     this.paymentStatus,
//     required this.onPrint,
//     required this.onSync,
//   });

//   // Helper method to determine payment status display
//   String _getPaymentStatusDisplay() {
//     if (paymentStatus != null && paymentStatus!.isNotEmpty) {
//       return paymentStatus!;
//     }

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
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final double tileWidth = constraints.maxWidth;
//         final double fontSize = (tileWidth * 0.035).clamp(10, 12); // Dynamic font size
//         final double iconSize = (tileWidth * 0.05).clamp(16, 20); // Dynamic icon size
//         final double padding = tileWidth * 0.02; // Dynamic padding

//         return Card(
//           elevation: 2,
//           margin: EdgeInsets.symmetric(vertical: padding, horizontal: padding),
//           child: Padding(
//             padding: EdgeInsets.all(padding),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CircleAvatar(
//                   backgroundColor: isSynced ? Colors.greenAccent : Colors.redAccent,
//                   radius: (tileWidth * 0.025).clamp(6, 8),
//                 ),
//                 SizedBox(width: padding),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Transaction ID: $transactionId',
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: fontSize,
//                           color: blackColor,
//                         ),
//                       ),
//                       SizedBox(height: padding * 0.5),
//                       Text(
//                         Money.format(amount),
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: fontSize,
//                           color: blackColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: padding * 0.5),
//                       Text(
//                         'Customer: $customer',
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: fontSize,
//                           color: blackColor,
//                         ),
//                       ),
//                       Text(
//                         paymentMethod,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: fontSize,
//                           color: secondaryColor,
//                         ),
//                       ),
//                       Text(
//                         '${createdAt.toLocal()}',
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: fontSize,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(width: padding),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         showReconcilePaymentDialog(context);
//                       },
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                           vertical: padding * 0.3,
//                           horizontal: padding,
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(3),
//                           color: _getStatusColor(),
//                         ),
//                         child: Text(
//                           _getPaymentStatusDisplay(),
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: fontSize * 0.9,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: padding),
//                     Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: Icon(
//                             Icons.print,
//                             color: Colors.blue,
//                             size: iconSize,
//                           ),
//                           onPressed: onPrint,
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             onSync();
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                   isSynced
//                                       ? 'Resynced $transactionId'
//                                       : 'Synced $transactionId',
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Text(
//                             isSynced ? 'Resync' : 'Sync',
//                             style: TextStyle(
//                               fontSize: fontSize * 0.9,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
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