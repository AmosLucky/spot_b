import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/common/utils/toast_utils.dart';
import 'package:spotstock_inventory/data/models/payment_reconciliation_model.dart';
import 'package:spotstock_inventory/screens/desktop/services/payment_reconciliation_service.dart';
// import '../services/payment_reconciliation_service.dart';
// import '../models/payment_reconciliation_model.dart';

class ReconcilePaymentDialog extends StatefulWidget {
  final String transactionId;
  final Function(double amount, String paymentType)? onSubmit;
  final VoidCallback? onPaymentUpdated;

  const ReconcilePaymentDialog({
    Key? key,
    required this.transactionId,
    this.onSubmit,
    this.onPaymentUpdated,
  }) : super(key: key);

  @override
  State<ReconcilePaymentDialog> createState() => _ReconcilePaymentDialogState();
}

class _ReconcilePaymentDialogState extends State<ReconcilePaymentDialog> {
  final TextEditingController _amountController = TextEditingController();
  final PaymentReconciliationService _paymentService = PaymentReconciliationService();
  
  String _selectedPaymentType = 'Cash';
  bool _isLoading = false;
  bool _isSubmitted = false;
  PaymentReconciliationModel? _paymentData;

  // Consistent payment types list
  final List<String> _paymentTypes = [
    'Cash',
    'Cheque',
    'Bank Transfer',
    'Mobile Money',
    'Card',
  ];

  @override
  void initState() {
    super.initState();
    _loadPaymentData();
  }

  Future<void> _loadPaymentData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final paymentData = await _paymentService.getPaymentReconciliationData(widget.transactionId);
      if (paymentData != null) {
        setState(() {
          _paymentData = paymentData;
          // Ensure the payment method is valid for the dropdown
          if (_paymentTypes.contains(paymentData.paymentMethod)) {
            _selectedPaymentType = paymentData.paymentMethod;
          } else {
            // Fallback to Cash if the payment method is not in our list
            _selectedPaymentType = 'Cash';
            print('Warning: Payment method "${paymentData.paymentMethod}" not found in dropdown options. Defaulting to Cash.');
          }
        });
      } else {
        ToastUtils.showErrorToast(context, 'Error', 'Transaction not found');
        Navigator.of(context).pop();
      }
    } catch (e) {
      print('Error loading payment data: $e');
      ToastUtils.showErrorToast(context, 'Error', 'Failed to load payment data: $e');
      Navigator.of(context).pop();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Color get _statusColor {
    if (_paymentData == null) return Colors.grey;
    
    switch (_paymentData!.paymentStatus.toLowerCase()) {
      case 'partial':
        return Colors.orange;
      case 'paid':
        return Colors.green;
      case 'pending':
      case 'unpaid':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Future<void> _submitPayment() async {
    if (_isSubmitted || _paymentData == null) return;

    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      ToastUtils.showErrorToast(context, 'Error', 'Please enter a valid amount');
      return;
    }

    if (amount > _paymentData!.balance) {
      ToastUtils.showErrorToast(context, 'Error', 'Amount cannot exceed the balance');
      return;
    }

    setState(() {
      _isLoading = true;
      _isSubmitted = true;
    });

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final systemProvider = Provider.of<SystemProvider>(context, listen: false);
      final token = userProvider.user.token ?? '';

      if (token.isEmpty) {
        ToastUtils.showErrorToast(context, 'Error', 'Authentication token not found');
        setState(() {
          _isLoading = false;
          _isSubmitted = false;
        });
        return;
      }

      final result = await _paymentService.processPaymentReconciliation(
        transactionId: widget.transactionId,
        amount: amount,
        paymentType: _selectedPaymentType,
        token: token,
      );

      print('Payment reconciliation result: $result');

      // Handle different success scenarios
      if (result['success'] == true) {
        String message = result['message'] ?? 'Payment processed successfully';
        
        // Show appropriate toast based on sync status
        if (result['synced'] == true) {
          ToastUtils.showSuccessToast(context, 'Success', message);
        } else if (result['localUpdated'] == true) {
          // Local update succeeded but server sync failed
          if (result['serverError'] != null) {
            ToastUtils.showInfoToast(context, 'Saved Locally', 
              'Payment saved locally. Server sync will retry automatically.');
          } else {
            ToastUtils.showInfoToast(context, 'Offline Mode', message);
          }
        } else {
          ToastUtils.showSuccessToast(context, 'Success', message);
        }
        
        // Always notify parent components if local update succeeded
        if (result['localUpdated'] == true) {
          widget.onSubmit?.call(amount, _selectedPaymentType);
          widget.onPaymentUpdated?.call();
          
          // Refresh the system provider to update UI
          try {
            await systemProvider.loadOrders();
          } catch (e) {
            print('Error refreshing orders: $e');
          }
        }
        
        // Close dialog on any success
        if (mounted) {
          Navigator.of(context).pop();
        }
        
      } else {
        // Handle failure cases
        String errorMessage = result['message'] ?? 'Failed to process payment';
        
        if (errorMessage.toLowerCase().contains('already fully paid')) {
          ToastUtils.showInfoToast(context, 'Info', errorMessage);
          if (mounted) {
            Navigator.of(context).pop();
          }
        } else {
          ToastUtils.showErrorToast(context, 'Error', errorMessage);
        }
      }
    
  } catch (e) {
    print('Error submitting payment: $e');
    ToastUtils.showErrorToast(context, 'Error', 'Failed to process payment: $e');
  } finally {
    if (mounted) {
      setState(() {
        _isLoading = false;
        _isSubmitted = false;
      });
    }
  }
}

  @override
  Widget build(BuildContext context) {
    if (_isLoading && _paymentData == null) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading payment data...'),
            ],
          ),
        ),
      );
    }

    if (_paymentData == null) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error, color: Colors.red, size: 48),
              SizedBox(height: 16),
              Text('Failed to load payment data'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Close'),
              ),
            ],
          ),
        ),
      );
    }

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Reconcile Payment',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, size: 24, color: Colors.grey),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Payment details
            _buildDetailRow('Reference:', _paymentData!.transactionId),
            const SizedBox(height: 12),
            _buildDetailRow('Total Amount:', '₦${_paymentData!.totalAmount.toStringAsFixed(0)}'),
            const SizedBox(height: 12),
            _buildDetailRow('Paid So Far:', '₦${_paymentData!.paidSoFar.toStringAsFixed(0)}'),
            const SizedBox(height: 12),
            _buildDetailRow('Balance:', '₦${_paymentData!.balance.toStringAsFixed(0)}'),
            const SizedBox(height: 12),

            // Status row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Status:',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _statusColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    _paymentData!.paymentStatus,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
            )],
            ),
            const SizedBox(height: 32),

            // Payment Amount input
            const Text(
              'Payment Amount',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  hintText: 'Enter amount',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                enabled: !_isLoading,
              ),
            ),
            const SizedBox(height: 24),

            // Payment Type dropdown
            const Text(
              'Payment Type',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedPaymentType,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                  onChanged: _isLoading
                      ? null
                      : (String? newValue) {
                          if (newValue != null && _paymentTypes.contains(newValue)) {
                            setState(() {
                              _selectedPaymentType = newValue;
                            });
                          }
                        },
                  items: _paymentTypes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade400),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: (_isLoading || _isSubmitted) ? null : _submitPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6B4E9D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Submit Payment',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}





// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:spotstock_inventory/common/provider/user_provider.dart';
// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:spotstock_inventory/common/utils/toast_utils.dart';
// import 'package:spotstock_inventory/data/models/payment_reconciliation_model.dart';
// import 'package:spotstock_inventory/screens/desktop/services/payment_reconciliation_service.dart';
// // import '../services/payment_reconciliation_service.dart';
// // import '../models/payment_reconciliation_model.dart';

// class ReconcilePaymentDialog extends StatefulWidget {
//   final String transactionId;
//   final Function(double amount, String paymentType)? onSubmit;
//   final VoidCallback? onPaymentUpdated;

//   const ReconcilePaymentDialog({
//     Key? key,
//     required this.transactionId,
//     this.onSubmit,
//     this.onPaymentUpdated,
//   }) : super(key: key);

//   @override
//   State<ReconcilePaymentDialog> createState() => _ReconcilePaymentDialogState();
// }

// class _ReconcilePaymentDialogState extends State<ReconcilePaymentDialog> {
//   final TextEditingController _amountController = TextEditingController();
//   final PaymentReconciliationService _paymentService = PaymentReconciliationService();
  
//   String _selectedPaymentType = 'Cash';
//   bool _isLoading = false;
//   bool _isSubmitted = false;
//   PaymentReconciliationModel? _paymentData;

//   // Consistent payment types list
//   final List<String> _paymentTypes = [
//     'Cash',
//     'Cheque',
//     'Bank Transfer',
//     'Mobile Money',
//     'Card',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _loadPaymentData();
//   }

//   Future<void> _loadPaymentData() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final paymentData = await _paymentService.getPaymentReconciliationData(widget.transactionId);
//       if (paymentData != null) {
//         setState(() {
//           _paymentData = paymentData;
//           // Ensure the payment method is valid for the dropdown
//           if (_paymentTypes.contains(paymentData.paymentMethod)) {
//             _selectedPaymentType = paymentData.paymentMethod;
//           } else {
//             // Fallback to Cash if the payment method is not in our list
//             _selectedPaymentType = 'Cash';
//             print('Warning: Payment method "${paymentData.paymentMethod}" not found in dropdown options. Defaulting to Cash.');
//           }
//         });
//       } else {
//         ToastUtils.showErrorToast(context, 'Error', 'Transaction not found');
//         Navigator.of(context).pop();
//       }
//     } catch (e) {
//       print('Error loading payment data: $e');
//       ToastUtils.showErrorToast(context, 'Error', 'Failed to load payment data: $e');
//       Navigator.of(context).pop();
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   Color get _statusColor {
//     if (_paymentData == null) return Colors.grey;
    
//     switch (_paymentData!.paymentStatus.toLowerCase()) {
//       case 'partial':
//         return Colors.orange;
//       case 'paid':
//         return Colors.green;
//       case 'pending':
//       case 'unpaid':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }

//   Future<void> _submitPayment() async {
//     if (_isSubmitted || _paymentData == null) return;

//     final amount = double.tryParse(_amountController.text);
//     if (amount == null || amount <= 0) {
//       ToastUtils.showErrorToast(context, 'Error', 'Please enter a valid amount');
//       return;
//     }

//     if (amount > _paymentData!.balance) {
//       ToastUtils.showErrorToast(context, 'Error', 'Amount cannot exceed the balance');
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//       _isSubmitted = true;
//     });

//     try {
//       final userProvider = Provider.of<UserProvider>(context, listen: false);
//       final systemProvider = Provider.of<SystemProvider>(context, listen: false);
//       final token = userProvider.user.token ?? '';

//       if (token.isEmpty) {
//         ToastUtils.showErrorToast(context, 'Error', 'Authentication token not found');
//         return;
//       }

//       final result = await _paymentService.processPaymentReconciliation(
//         transactionId: widget.transactionId,
//         amount: amount,
//         paymentType: _selectedPaymentType,
//         token: token,
//       );

//       if (result['success']) {
//         ToastUtils.showSuccessToast(context, 'Success', result['message']);
        
//         // Notify parent components about the payment update
//         widget.onSubmit?.call(amount, _selectedPaymentType);
//         widget.onPaymentUpdated?.call();
        
//         // Refresh the system provider to update UI
//         systemProvider.loadOrders();
        
//         Navigator.of(context).pop();
//       } else {
//         if (result['message'].toString().toLowerCase().contains('already fully paid')) {
//           ToastUtils.showInfoToast(context, 'Info', result['message']);
//           Navigator.of(context).pop();
//         } else {
//           ToastUtils.showErrorToast(context, 'Error', result['message']);
//         }
//       }
//     } catch (e) {
//       print('Error submitting payment: $e');
//       ToastUtils.showErrorToast(context, 'Error', 'Failed to process payment: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//         _isSubmitted = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading && _paymentData == null) {
//       return Dialog(
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               CircularProgressIndicator(),
//               SizedBox(height: 16),
//               Text('Loading payment data...'),
//             ],
//           ),
//         ),
//       );
//     }

//     if (_paymentData == null) {
//       return Dialog(
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(Icons.error, color: Colors.red, size: 48),
//               SizedBox(height: 16),
//               Text('Failed to load payment data'),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text('Close'),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return Dialog(
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.5,
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Reconcile Payment',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   icon: const Icon(Icons.close, size: 24, color: Colors.grey),
//                   padding: EdgeInsets.zero,
//                   constraints: const BoxConstraints(),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),

//             // Payment details
//             _buildDetailRow('Reference:', _paymentData!.transactionId),
//             const SizedBox(height: 12),
//             _buildDetailRow('Total Amount:', '₦${_paymentData!.totalAmount.toStringAsFixed(0)}'),
//             const SizedBox(height: 12),
//             _buildDetailRow('Paid So Far:', '₦${_paymentData!.paidSoFar.toStringAsFixed(0)}'),
//             const SizedBox(height: 12),
//             _buildDetailRow('Balance:', '₦${_paymentData!.balance.toStringAsFixed(0)}'),
//             const SizedBox(height: 12),

//             // Status row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Status:',
//                   style: TextStyle(fontSize: 16, color: Colors.black87),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: _statusColor,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Text(
//                     _paymentData!.paymentStatus,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 32),

//             // Payment Amount input
//             const Text(
//               'Payment Amount',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade300, width: 2),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: TextField(
//                 controller: _amountController,
//                 keyboardType: TextInputType.number,
//                 style: const TextStyle(fontSize: 16),
//                 decoration: const InputDecoration(
//                   hintText: 'Enter amount',
//                   hintStyle: TextStyle(color: Colors.grey),
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                 ),
//                 enabled: !_isLoading,
//               ),
//             ),
//             const SizedBox(height: 24),

//             // Payment Type dropdown
//             const Text(
//               'Payment Type',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade300),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   value: _selectedPaymentType,
//                   icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
//                   style: const TextStyle(fontSize: 16, color: Colors.black87),
//                   onChanged: _isLoading
//                       ? null
//                       : (String? newValue) {
//                           if (newValue != null && _paymentTypes.contains(newValue)) {
//                             setState(() {
//                               _selectedPaymentType = newValue;
//                             });
//                           }
//                         },
//                   items: _paymentTypes.map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 32),

//             // Action buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
//                     style: OutlinedButton.styleFrom(
//                       side: BorderSide(color: Colors.grey.shade400),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                     ),
//                     child: const Text(
//                       'Cancel',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: (_isLoading || _isSubmitted) ? null : _submitPayment,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF6B4E9D),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                     ),
//                     child: _isLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                             'Submit Payment',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white,
//                             ),
//                           ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(fontSize: 16, color: Colors.black87),
//         ),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//             color: Colors.black,
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     _amountController.dispose();
//     super.dispose();
//   }
// }