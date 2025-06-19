import 'package:flutter/material.dart';
import 'package:spotstock_inventory/common/helpers/database_engine.dart';
import 'package:spotstock_inventory/data/api/api_client.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/common/utils/toast_utils.dart';
// import 'package:spotstock_inventory/data/api_client.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spotstock_inventory/objectbox.g.dart';

class ReconcilePaymentDialog extends StatefulWidget {
  final String reference; // Transaction ID
  final double totalAmount; // Total amount of the sale
  final double paidSoFar; // Amount paid so far
  final String status; // Current payment status
  final Function(double amount, String paymentType)? onSubmit; // Callback for UI updates

  const ReconcilePaymentDialog({
    Key? key,
    required this.reference,
    required this.totalAmount,
    required this.paidSoFar,
    required this.status,
    this.onSubmit,
  }) : super(key: key);

  @override
  State<ReconcilePaymentDialog> createState() => _ReconcilePaymentDialogState();
}

class _ReconcilePaymentDialogState extends State<ReconcilePaymentDialog> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedPaymentType = 'Cash';
  bool _isLoading = false;
  bool _isSubmitted = false; // Track if payment has been submitted
  final GetStorage _storage = GetStorage();

  final List<String> _paymentTypes = [
    'Cash',
    'Cheque',
    'Bank Transfer',
    'Mobile Money',
    'Card',
  ];

  // Map UI payment types to server-expected payment_type values
  int _mapPaymentTypeToServerValue(String paymentType) {
    switch (paymentType.toLowerCase()) {
      case 'cash':
        return 1; // CASH
      case 'cheque':
        return 2; // CHEQUE
      case 'bank transfer':
        return 3; // BANK_TRANSFER
      default:
        return 4; // OTHER (Mobile Money, Card, etc.)
    }
  }

  // Map payment type number to string for storage/display
  String _mapPaymentTypeNumberToString(int paymentType) {
    switch (paymentType) {
      case 1:
        return 'CASH';
      case 2:
        return 'CHEQUE';
      case 3:
        return 'BANK_TRANSFER';
      case 4:
      default:
        return 'OTHER';
    }
  }

  double get balance => widget.totalAmount - widget.paidSoFar;

  Color get statusColor {
    switch (widget.status.toLowerCase()) {
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

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  // Check internet connectivity
  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // Update local Orders entity in ObjectBox
  Future<void> _updateLocalOrder({
    required double amount,
    required int paymentType,
    required bool isSynced,
    required bool isFullyPaid, // Flag to handle "Sale already fully paid"
  }) async {
    final store = await DatabaseEngine.instance.getStore();
    final orderBox = store.box<Orders>();

    // Find the order by trxId
    final query = orderBox.query(Orders_.trxId.equals(widget.reference)).build();
    final order = query.findFirst();

    if (order != null) {
      if (isFullyPaid) {
        // If server indicates fully paid, set status to Paid and match total amount
        order.paymentStatus = 'Paid';
        order.receivedAmount = order.amount; // Ensure receivedAmount equals total amount
        order.partialAmount = 0.0;
        order.sync = isSynced ? 1 : 0;
        order.paymentMethod = _mapPaymentTypeNumberToString(paymentType);
      } else {
        // Calculate new values for normal payment
        final newReceivedAmount = (order.receivedAmount ?? 0.0) + amount;
        final newPartialAmount = order.partialAmount ?? 0.0;
        final newBalance = order.amount - newReceivedAmount;
        String newPaymentStatus;

        if (newReceivedAmount >= order.amount) {
          newPaymentStatus = 'Paid';
        } else if (newReceivedAmount > 0) {
          newPaymentStatus = 'Partial';
        } else {
          newPaymentStatus = 'Unpaid';
        }

        // Update order fields
        order.receivedAmount = newReceivedAmount;
        order.partialAmount = newPartialAmount;
        order.paymentStatus = newPaymentStatus;
        order.paymentMethod = _mapPaymentTypeNumberToString(paymentType);
        order.sync = isSynced ? 1 : 0; // Mark as unsynced if offline
      }

      // Save to ObjectBox
      orderBox.put(order);
      print('Updated order ${order.trxId} locally: ${order.paymentStatus}, received: ${order.receivedAmount}');
    } else {
      print('Order with trxId ${widget.reference} not found in local database');
    }

    query.close();
  }

  // Submit payment to server
  Future<Map<String, dynamic>> _submitPaymentToServer(double amount, int paymentType) async {
    final apiClient = ApiClient();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String token = userProvider.user.token ?? _storage.read('token') ?? '';

    if (token.isEmpty) {
      return {
        'success': false,
        'message': 'Authentication token not found',
      };
    }

    final url = Uri.parse('${apiClient.baseUrl}sales/${widget.reference}/reconcile-payment');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      'amount': amount,
      'payment_type': paymentType,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 || responseBody['status'] == true) {
        return {
          'success': true,
          'message': responseBody['message'] ?? 'Payment reconciled successfully',
          'isFullyPaid': responseBody['message'] == 'Sale already fully paid.',
        };
      } else {
        return {
          'success': false,
          'message': responseBody['message'] ?? 'Failed to reconcile payment',
          'isFullyPaid': responseBody['message'] == 'Sale already fully paid.',
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

  void _submitPayment() async {
    if (_isSubmitted) {
      return; // Prevent duplicate submissions
    }

    final amount = double.tryParse(_amountController.text);

    if (amount == null || amount <= 0) {
      ToastUtils.showErrorToast(context, 'Error', 'Please enter a valid amount');
      return;
    }

    if (amount > balance) {
      ToastUtils.showErrorToast(context, 'Error', 'Amount cannot exceed the balance');
      return;
    }

    setState(() {
      _isLoading = true;
      _isSubmitted = true; // Mark as submitted to prevent duplicates
    });

    final paymentType = _mapPaymentTypeToServerValue(_selectedPaymentType);
    bool isOnline = await _checkInternetConnection();

    try {
      if (isOnline) {
        // Online: Submit to server and update local database
        final serverResponse = await _submitPaymentToServer(amount, paymentType);
        if (serverResponse['success']) {
          // Update local database with synced status
          await _updateLocalOrder(
            amount: amount,
            paymentType: paymentType,
            isSynced: true,
            isFullyPaid: serverResponse['isFullyPaid'] ?? false,
          );
          ToastUtils.showSuccessToast(context, 'Success', serverResponse['message']);
          widget.onSubmit?.call(amount, _selectedPaymentType);
          Navigator.of(context).pop();
        } else {
          // Handle "Sale already fully paid" or other errors
          if (serverResponse['isFullyPaid'] == true) {
            await _updateLocalOrder(
              amount: 0.0, // No additional amount since already paid
              paymentType: paymentType,
              isSynced: true,
              isFullyPaid: true,
            );
            ToastUtils.showInfoToast(context, 'Info', 'Sale is already fully paid.');
            Navigator.of(context).pop();
          } else {
            // Server failed, store locally as unsynced
            await _updateLocalOrder(
              amount: amount,
              paymentType: paymentType,
              isSynced: false,
              isFullyPaid: false,
            );
            ToastUtils.showErrorToast(context, 'Error', serverResponse['message']);
          }
        }
      } else {
        // Offline: Store locally as unsynced
        await _updateLocalOrder(
          amount: amount,
          paymentType: paymentType,
          isSynced: false,
          isFullyPaid: false,
        );
        ToastUtils.showSuccessToast(context, 'Success', 'Payment saved offline. Will sync when online.');
        widget.onSubmit?.call(amount, _selectedPaymentType);
        Navigator.of(context).pop();
      }
    } catch (e) {
      ToastUtils.showErrorToast(context, 'Error', 'Failed to process payment: $e');
      setState(() {
        _isSubmitted = false; // Allow retry on error
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            // Header with title and close button
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
                  icon: const Icon(
                    Icons.close,
                    size: 24,
                    color: Colors.grey,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Payment details
            _buildDetailRow('Reference:', widget.reference),
            const SizedBox(height: 12),
            _buildDetailRow(
                'Total Amount:', '₦${widget.totalAmount.toStringAsFixed(0)}'),
            const SizedBox(height: 12),
            _buildDetailRow(
                'Paid So Far:', '₦${widget.paidSoFar.toStringAsFixed(0)}'),
            const SizedBox(height: 12),
            _buildDetailRow('Balance:', '₦${balance.toStringAsFixed(0)}'),
            const SizedBox(height: 12),

            // Status row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Status:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    widget.status,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
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
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                  icon:
                      const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                  onChanged: _isLoading
                      ? null
                      : (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedPaymentType = newValue;
                            });
                          }
                        },
                  items: _paymentTypes
                      .map<DropdownMenuItem<String>>((String value) {
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
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
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
}


// import 'package:flutter/material.dart';

// class ReconcilePaymentDialog extends StatefulWidget {
//   final String reference;
//   final double totalAmount;
//   final double paidSoFar;
//   final String status;
//   final Function(double amount, String paymentType)? onSubmit;

//   const ReconcilePaymentDialog({
//     Key? key,
//     required this.reference,
//     required this.totalAmount,
//     required this.paidSoFar,
//     required this.status,
//     this.onSubmit,
//   }) : super(key: key);

//   @override
//   State<ReconcilePaymentDialog> createState() => _ReconcilePaymentDialogState();
// }

// class _ReconcilePaymentDialogState extends State<ReconcilePaymentDialog> {
//   final TextEditingController _amountController = TextEditingController();
//   String _selectedPaymentType = 'Cash';

//   final List<String> _paymentTypes = [
//     'Cash',
//     'Card',
//     'Bank Transfer',
//     'Mobile Money',
//     'Cheque',
//   ];

//   double get balance => widget.totalAmount - widget.paidSoFar;

//   Color get statusColor {
//     switch (widget.status.toLowerCase()) {
//       case 'partial':
//         return Colors.orange;
//       case 'paid':
//         return Colors.green;
//       case 'pending':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   void dispose() {
//     _amountController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
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
//             // Header with title and close button
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
//                   icon: const Icon(
//                     Icons.close,
//                     size: 24,
//                     color: Colors.grey,
//                   ),
//                   padding: EdgeInsets.zero,
//                   constraints: const BoxConstraints(),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 24),

//             // Payment details
//             _buildDetailRow('Reference:', widget.reference),
//             const SizedBox(height: 12),
//             _buildDetailRow(
//                 'Total Amount:', '₦${widget.totalAmount.toStringAsFixed(0)}'),
//             const SizedBox(height: 12),
//             _buildDetailRow(
//                 'Paid So Far:', '₦${widget.paidSoFar.toStringAsFixed(0)}'),
//             const SizedBox(height: 12),
//             _buildDetailRow('Balance:', '₦${balance.toStringAsFixed(0)}'),
//             const SizedBox(height: 12),

//             // Status row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Status:',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: statusColor,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Text(
//                     widget.status,
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
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                 ),
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
//                   icon:
//                       const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
//                   style: const TextStyle(fontSize: 16, color: Colors.black87),
//                   onChanged: (String? newValue) {
//                     if (newValue != null) {
//                       setState(() {
//                         _selectedPaymentType = newValue;
//                       });
//                     }
//                   },
//                   items: _paymentTypes
//                       .map<DropdownMenuItem<String>>((String value) {
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
//                     onPressed: () => Navigator.of(context).pop(),
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
//                     onPressed: _submitPayment,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF6B4E9D), // Purple color
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                     ),
//                     child: const Text(
//                       'Submit Payment',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.white,
//                       ),
//                     ),
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
//           style: const TextStyle(
//             fontSize: 16,
//             color: Colors.black87,
//           ),
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

//   void _submitPayment() {
//     final amount = double.tryParse(_amountController.text);

//     if (amount == null || amount <= 0) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please enter a valid amount'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     if (amount > balance) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Amount cannot exceed the balance'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     // Call the callback function
//     widget.onSubmit?.call(amount, _selectedPaymentType);

//     // Close the dialog
//     Navigator.of(context).pop();
//   }
// }
