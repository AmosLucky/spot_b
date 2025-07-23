import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/widgets/custom_btn.dart';

class PaidInvoicesList extends StatefulWidget {
  final SystemProvider systemProvider;
  final UserDetails user;
  final Size mediaQuery;

  const PaidInvoicesList({
    super.key,
    required this.systemProvider,
    required this.user,
    required this.mediaQuery,
  });

  @override
  State<PaidInvoicesList> createState() => _PaidInvoicesListState();
}

class _PaidInvoicesListState extends State<PaidInvoicesList> {
  List<dynamic> _paidInvoices = [];
  bool _isLoading = true;
  double _totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _loadPaidInvoices();
  }

  void _loadPaidInvoices() async {
    try {
      var paidInvoices = await widget.systemProvider.getPaidInvoices();
      if (mounted) {
        setState(() {
          _paidInvoices = paidInvoices;
          _paidInvoices.sort((a, b) {
            String dateA = a['paidAt'] ?? '';
            String dateB = b['paidAt'] ?? '';
            return dateB.compareTo(dateA); // Newest first
          });
          _totalAmount = _paidInvoices.fold(0.0, (sum, invoice) => sum + (invoice['amount'] ?? 0.0));
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading paid invoices: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _clearPaidInvoices() async {
    try {
      await widget.systemProvider.clearPaidInvoices();
      if (mounted) {
        setState(() {
          _paidInvoices.clear();
          _totalAmount = 0.0;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Paid invoices cleared successfully')),
      );
    } catch (e) {
      print('Error clearing paid invoices: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error clearing paid invoices')),
      );
    }
  }

  void _showInvoiceDetails(Map<String, dynamic> invoice) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Invoice Details'),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Reference:', invoice['reference'] ?? 'N/A'),
              _buildDetailRow('Customer:', invoice['customerName'] ?? 'N/A'),
              if (invoice['attendantName'] != null)
                _buildDetailRow('Attendant:', invoice['attendantName']),
              _buildDetailRow('Amount:', Money.format(invoice['amount'] ?? 0)),
              _buildDetailRow('Paid At:', invoice['paidAt'] ?? 'N/A'),
              if (invoice['tableId'] != null && invoice['tableId'].isNotEmpty)
                _buildDetailRow('Table:', invoice['tableId']),
              if (invoice['customerPhone'] != null && invoice['customerPhone'].isNotEmpty)
                _buildDetailRow('Phone:', invoice['customerPhone']),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.mediaQuery.width * 0.35,
      constraints: BoxConstraints(
        maxHeight: widget.mediaQuery.height * 0.8,
      ),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Paid Invoices",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Icon(
                MdiIcons.checkCircleOutline,
                color: Colors.green,
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 10),
          
          // Summary Cards
          if (!_isLoading) ...[
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${_paidInvoices.length}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          'Total Invoices',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          Money.format(_totalAmount),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          'Total Amount',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          
          // Loading or Invoice List
          if (_isLoading)
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          else
            Expanded(
              child: _paidInvoices.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            MdiIcons.receiptTextOutline,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "No paid invoices available",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _paidInvoices.length,
                      itemBuilder: (context, index) {
                        var invoice = _paidInvoices[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            title: Text(
                              invoice['reference'] ?? 'N/A',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  invoice['attendantName'] != null
                                      ? "Attendant: ${invoice['attendantName']}"
                                      : "Customer: ${invoice['customerName'] ?? 'N/A'}",
                                  style: TextStyle(color: grayColor, fontSize: 12),
                                ),
                                Text(
                                  "Amount: ${Money.format(invoice['amount'] ?? 0)}",
                                  style: TextStyle(color: grayColor, fontSize: 12),
                                ),
                                Text(
                                  "Paid: ${_formatDate(invoice['paidAt'])}",
                                  style: TextStyle(color: Colors.green, fontSize: 11),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    MdiIcons.informationOutline,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                  onPressed: () => _showInvoiceDetails(invoice),
                                  tooltip: 'View Details',
                                ),
                                Icon(
                                  MdiIcons.checkCircle,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ],
                            ),
                            onTap: () => _showInvoiceDetails(invoice),
                          ),
                        );
                      },
                    ),
            ),
          
          // Clear All Button
          if (_paidInvoices.isNotEmpty) ...[
            const SizedBox(height: 10),
            CustomButton(
              label: "Clear All",
              icon: MdiIcons.deleteEmptyOutline,
              color: Colors.redAccent,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Confirm Clear'),
                    content: Text('Are you sure you want to clear all paid invoices? This action cannot be undone.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _clearPaidInvoices();
                        },
                        child: Text('Clear All'),
                        style: TextButton.styleFrom(foregroundColor: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'N/A';
    try {
      DateTime date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }
}




// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:spotstock_inventory/common/common.dart';
// import 'package:spotstock_inventory/common/money.dart';
// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:spotstock_inventory/data/models/user_details.dart';
// import 'package:spotstock_inventory/widgets/custom_btn.dart';

// class PaidInvoicesList extends StatefulWidget {
//   final SystemProvider systemProvider;
//   final UserDetails user;
//   final Size mediaQuery;
//   final VoidCallback onClose;

//   const PaidInvoicesList({
//     super.key,
//     required this.systemProvider,
//     required this.user,
//     required this.mediaQuery,
//     required this.onClose,
//   });

//   @override
//   State<PaidInvoicesList> createState() => _PaidInvoicesListState();
// }

// class _PaidInvoicesListState extends State<PaidInvoicesList> {
//   List<dynamic> _paidInvoices = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadPaidInvoices();
//   }

//   void _loadPaidInvoices() async {
//     try {
//       var paidInvoices = await widget.systemProvider.getPaidInvoices();
//       if (mounted) {
//         setState(() {
//           _paidInvoices = paidInvoices;
//           _paidInvoices.sort((a, b) {
//             String dateA = a['paidAt'] ?? '';
//             String dateB = b['paidAt'] ?? '';
//             return dateB.compareTo(dateA); // Newest first
//           });
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       print('Error loading paid invoices: $e');
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   Future<void> _clearPaidInvoices() async {
//     try {
//       await widget.systemProvider.clearPaidInvoices();
//       if (mounted) {
//         setState(() {
//           _paidInvoices.clear();
//         });
//       }
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Paid invoices cleared successfully')),
//       );
//     } catch (e) {
//       print('Error clearing paid invoices: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error clearing paid invoices')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.mediaQuery.width * 0.35,
//       constraints: BoxConstraints(
//         maxHeight: widget.mediaQuery.height * 0.8,
//       ),
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "Paid Invoices",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               InkWell(
//                 onTap: widget.onClose,
//                 child: Text(
//                   "Close",
//                   style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.red,
//                       fontWeight: FontWeight.normal),
//                 ),
//               )
//             ],
//           ),
//           const SizedBox(height: 10),
//           if (_isLoading)
//             const Center(child: CircularProgressIndicator())
//           else
//             Expanded(
//               child: _paidInvoices.isEmpty
//                   ? const Center(child: Text("No paid invoices available"))
//                   : ListView.builder(
//                       itemCount: _paidInvoices.length,
//                       itemBuilder: (context, index) {
//                         var invoice = _paidInvoices[index];
//                         return Card(
//                           margin: const EdgeInsets.symmetric(vertical: 4),
//                           child: ListTile(
//                             contentPadding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 8),
//                             title: Text(
//                               invoice['reference'] ?? 'N/A',
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 14),
//                             ),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Customer: ${invoice['customerName'] ?? 'N/A'}",
//                                   style: TextStyle(color: grayColor, fontSize: 12),
//                                 ),
//                                 if (invoice['attendantName'] != null)
//                                   Text(
//                                     "Attendant: ${invoice['attendantName']}",
//                                     style: TextStyle(color: grayColor, fontSize: 12),
//                                   ),
//                                 Text(
//                                   "Amount: ${Money.format(invoice['amount'] ?? 0)}",
//                                   style: TextStyle(color: grayColor, fontSize: 12),
//                                 ),
//                                 Text(
//                                   "Paid: ${invoice['paidAt'] ?? 'N/A'}",
//                                   style: TextStyle(color: Colors.green, fontSize: 11),
//                                 ),
//                               ],
//                             ),
//                             trailing: Icon(
//                               MdiIcons.checkCircle,
//                               color: Colors.green,
//                               size: 20,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           const SizedBox(height: 10),
//           if (_paidInvoices.isNotEmpty)
//             CustomButton(
//               label: "Clear All",
//               icon: MdiIcons.deleteEmptyOutline,
//               color: Colors.redAccent,
//               onTap: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: Text('Confirm Clear'),
//                     content: Text('Are you sure you want to clear all paid invoices?'),
//                     actions: [
//                       TextButton(
//                         onPressed: () => Navigator.of(context).pop(),
//                         child: Text('Cancel'),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                           _clearPaidInvoices();
//                         },
//                         child: Text('Clear All'),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }
