// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:spotstock_inventory/data/models/userdetails.dart';
// import 'dart:convert';

// import 'package:spotstock_inventory/screens/desktop/pos/list_printers.dart';


// class PrintScreenDialog extends StatefulWidget {
//   final List<Map<String, dynamic>> transactionData;
//   final UserDetails user;
//   final String? type;

//   const PrintScreenDialog({
//     super.key,
//     required this.transactionData,
//     this.type = 'receipt',
//     required this.user,
//   });

//   @override
//   State<PrintScreenDialog> createState() => _PrintScreenDialogState();
// }

// class _PrintScreenDialogState extends State<PrintScreenDialog> {
//   bool _isPrinting = false;
//   final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Transaction Printing'),
//         actions: [
//           if (!_isPrinting) ...[
//             IconButton(
//               icon: const Icon(Icons.picture_as_pdf),
//               tooltip: 'Export as PDF',
//               onPressed: printAllTransactionsAsPdf,
//             ),
//             IconButton(
//               icon: const Icon(Icons.print),
//               tooltip: 'Print all receipts',
//               onPressed: printAllTransactions,
//             ),
//           ],
//           if (_isPrinting)
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: CircularProgressIndicator(),
//             ),
//         ],
//       ),
//       body: _buildTransactionList(),
//     );
//   }

//   Widget _buildTransactionList() {
//     if (widget.transactionData.isEmpty) {
//       return const Center(child: Text('No transactions to display'));
//     }

//     return ListView.builder(
//       itemCount: widget.transactionData.length,
//       itemBuilder: (context, index) {
//         final transaction = widget.transactionData[index];
//         return _buildTransactionCard(transaction);
//       },
//     );
//   }

//   Widget _buildTransactionCard(Map<String, dynamic> transaction) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       elevation: 2,
//       child: InkWell(
//         onTap: () => _showTransactionDetails(transaction),
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'TRX #${transaction['trxId']}',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   Chip(
//                     label: Text(
//                       '${transaction['amount']} NGN',
//                       style: const TextStyle(color: Colors.white),),
//                     backgroundColor: Colors.blue,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Customer: ${transaction['customerName'] ?? 'N/A'}',
//                 style: const TextStyle(fontSize: 14),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 'Date: ${_dateFormat.format(DateTime.parse(transaction['createdAt']))}',
//                 style: const TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//               const SizedBox(height: 8),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: IconButton(
//                   icon: const Icon(Icons.print, size: 20),
//                   onPressed: () => printSingleTransaction(transaction),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> printAllTransactionsAsPdf() async {
//     setState(() => _isPrinting = true);
//     try {
//       final pdf = pw.Document();

//       for (final transaction in widget.transactionData) {
//         final items = _parseItems(transaction);
//         final othersData = json.decode(transaction['others']);

//         pdf.addPage(
//           pw.Page(
//             pageFormat: PdfPageFormat.a4,
//             build: (pw.Context context) {
//               return _buildPdfReceipt(transaction, items, othersData);
//             },
//           ),
//         );
//       }

//       final bytes = await pdf.save();
//       await Printing.sharePdf(
//         bytes: bytes,
//         filename: 'transactions_${DateTime.now().millisecondsSinceEpoch}.pdf',
//       );
//     } catch (e) {
//       _showErrorSnackbar('PDF generation failed: ${e.toString()}');
//     } finally {
//       setState(() => _isPrinting = false);
//     }
//   }

//   pw.Widget _buildPdfReceipt(
//     Map<String, dynamic> transaction,
//     List<Item> items,
//     Map<String, dynamic> othersData,
//   ) {
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pw.Header(
//           level: 0,
//           child: pw.Text(widget.user.company?.name ?? 'Receipt'),
//         ),
//         pw.SizedBox(height: 10),
//         pw.Row(
//           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//           children: [
//             pw.Text('Transaction #${transaction['trxId']}'),
//             pw.Text(_dateFormat.format(DateTime.parse(transaction['createdAt']))),
//           ],
//         ),
//         pw.Divider(),
//         pw.Text('Customer: ${transaction['customerName']}'),
//         pw.SizedBox(height: 10),
//         pw.Text('Items:',
//          style:  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//         pw.Table(
//           border: pw.TableBorder.all(),
//           children: [
//             pw.TableRow(
//               children: [
//                 pw.Padding(
//                   padding: const pw.EdgeInsets.all(4),
//                   child: pw.Text('Item', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                 ),
//                 pw.Padding(
//                   padding: const pw.EdgeInsets.all(4),
//                   child: pw.Text('Qty', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                 ),
//                 pw.Padding(
//                   padding: const pw.EdgeInsets.all(4),
//                   child: pw.Text('Amount', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                 ),
//               ],
//             ),
//             ...items.map((item) => pw.TableRow(
//               children: [
//                 pw.Padding(
//                   padding: const pw.EdgeInsets.all(4),
//                   child: pw.Text(item.name),
//                 ),
//                 pw.Padding(
//                   padding: const pw.EdgeInsets.all(4),
//                   child: pw.Text(item.quantity.toString()),
//                 ),
//                 pw.Padding(
//                   padding: const pw.EdgeInsets.all(4),
//                   child: pw.Text(item.totalAmount.toStringAsFixed(2)),
//                 ),
//               ],
//             )),
//           ],
//         ),
//         pw.SizedBox(height: 10),
//         pw.Row(
//           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//           children: [
//             pw.Text('Subtotal:'),
//             pw.Text(othersData['subtotal'].toString()),
//           ],
//         ),
//         pw.Row(
//           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//           children: [
//             pw.Text('Amount Paid:'),
//             pw.Text(othersData['receivedAmount'].toString()),
//           ],
//         ),
//         pw.Row(
//           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//           children: [
//             pw.Text('Change:'),
//             pw.Text(othersData['change'].toString()),
//           ],
//         ),
//         pw.SizedBox(height: 10),
//         pw.Text('Payment Method: ${transaction['paymentMethod']}'),
//         pw.SizedBox(height: 20),
//         pw.Center(
//           child: pw.Text(
//             'Thank you for your business!',
//             style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//           ),
//         ),
//         if (widget.user.company?.address != null)
//           pw.Center(
//             child: pw.Text(
//               widget.user.company!.address!,
//               style: const pw.TextStyle(fontSize: 10),
//             ),
//           ),
//       ],
//     );
//   }

//   Future<void> printAllTransactions() async {
//     setState(() => _isPrinting = true);
//     try {
//       for (final transaction in widget.transactionData) {
//         await printSingleTransaction(transaction);
//         await Future.delayed(const Duration(seconds: 1));
//       }
//     } catch (e) {
//       _showErrorSnackbar('Printing failed: ${e.toString()}');
//     } finally {
//       setState(() => _isPrinting = false);
//     }
//   }

//   Future<void> printSingleTransaction(Map<String, dynamic> transaction) async {
//     try {
//       final othersData = json.decode(transaction['others']);
//       final items = _parseItems(transaction);

//       await printSampleDocument(
//         transaction['amount'],
//         items,
//         [],
//         '',
//         '',
//         widget.user.company!.email,
//         widget.user.company!.phone,
//         widget.user.firstName,
//         othersData['customerPhoneNumber'],
//         items.isNotEmpty ? items[0].warehouse : '',
//         othersData['paymentStatus'],
//         othersData['table'],
//         transaction['customerName'],
//         transaction['trxId'],
//         othersData['subtotal'],
//         othersData['receivedAmount'],
//         othersData['change'],
//         transaction['paymentMethod'],
//         DateTime.parse(transaction['createdAt']),
//         widget.user.company!.name,
//         widget.user.company!.address,
//       );
//     } catch (e) {
//       _showErrorSnackbar('Failed to print: ${e.toString()}');
//     }
//   }

//   List<Item> _parseItems(Map<String, dynamic> transaction) {
//     try {
//       final itemsData = json.decode(transaction['items']);
//       final List<Item> items = [];

//       for (var itemData in itemsData) {
//         if (itemData is Map<String, dynamic>) {
//           final product = itemData['product'];
//           if (product is Map<String, dynamic>) {
//             items.add(Item(
//               product['name'] ?? 'Unknown Item',
//               (itemData['quantity'] as num).toInt(),
//               (itemData['totalAmount'] as num).toDouble(),
//               warehouse: product['warehouse']?[0]['name'] ?? '',
//             ));
//           }
//         }
//       }
//       return items;
//     } catch (e) {
//       _showErrorSnackbar('Error parsing items: ${e.toString()}');
//       return [];
//     }
//   }

//   void _showTransactionDetails(Map<String, dynamic> transaction) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Transaction #${transaction['trxId']}'),
//         content: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Customer: ${transaction['customerName']}'),
//               Text('Date: ${_dateFormat.format(DateTime.parse(transaction['createdAt']))}'),
//               const SizedBox(height: 16),
//               const Text('Items:', style: TextStyle(fontWeight: FontWeight.bold)),
//               ..._parseItems(transaction).map((item) => Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4),
//                 child: Text('${item.name} x ${item.quantity} - ${item.totalAmount}'),
//               )),
//               const SizedBox(height: 16),
//               Text('Total: ${transaction['amount']}'),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               printSingleTransaction(transaction);
//             },
//             child: const Text('Print Receipt'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showErrorSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }
// }

// class Item {
//   final String name;
//   final int quantity;
//   final double totalAmount;
//   final String warehouse;

//   Item(this.name, this.quantity, this.totalAmount, {this.warehouse = ''});
// }