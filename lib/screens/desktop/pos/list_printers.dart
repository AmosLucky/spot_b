import 'dart:typed_data';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotstock_inventory/screens/desktop/pos/printusb.dart';

Future<Uint8List> generateSamplePdf(
  PdfPageFormat format,
  double total,
  String email,
  String phone,
  String staffName,
  String customerPhoneNumber,
  String branch,
  String paymentStatus,
  String tableId,
  List<Item> items,
  List hotelItems,
  String checkin,
  String checkout,
  String customerName,
  String transactionId,
  double subtotal,
  double receivedAmount,
  double change,
  String paymentMethod,
  DateTime createdAt,
  String companyName,
  String companyAddress,
  String? attendantName,
) async {
  final pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      pageFormat: format,
      build: (context) {
        return pw.Padding(
          padding: const pw.EdgeInsets.all(16.0),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  companyName,
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Center(
                child: pw.Text(companyAddress, style: pw.TextStyle(fontSize: 8)),
              ),
              pw.Center(
                child: pw.Text(email, style: pw.TextStyle(fontSize: 8)),
              ),
              pw.Center(
                child: pw.Text(phone, style: pw.TextStyle(fontSize: 8)),
              ),
              pw.SizedBox(height: 2),
              pw.Divider(thickness: 0.5, color: PdfColors.black),
              pw.SizedBox(height: 2),
              pw.Text(
                "SALES INVOICE",
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              branch != ''
                  ? pw.Text('Branch:  $branch', style: pw.TextStyle(fontSize: 8))
                  : pw.SizedBox(),
              if (customerName != '')
                pw.Text('Customer:  $customerName',
                    style: pw.TextStyle(fontSize: 8)),
              if (customerPhoneNumber != '')
                pw.Text('Customer Phone:  $customerPhoneNumber',
                    style: pw.TextStyle(fontSize: 8)),
              if (transactionId != '')
                pw.Text('Invoice no:  $transactionId',
                    style: pw.TextStyle(fontSize: 8)),
              if (paymentStatus != '')
                pw.Text('Payment Status:  $paymentStatus',
                    style: pw.TextStyle(fontSize: 8)),
              pw.Text('Sold By:  $staffName', style: pw.TextStyle(fontSize: 8)),
              if (attendantName != null && attendantName != '')
                pw.Text('Attendant:  $attendantName',
                    style: pw.TextStyle(fontSize: 8)),
              tableId != ''
                  ? pw.Text('Table: :  ${tableId.toString()}',
                      style: pw.TextStyle(fontSize: 8))
                  : pw.SizedBox(),
              pw.Text('Date:  $createdAt', style: pw.TextStyle(fontSize: 8)),
              if (checkin != '')
                pw.Text('Checkin Date:  $checkin',
                    style: pw.TextStyle(fontSize: 8)),
              if (checkout != '')
                pw.Text('Checkout Date:  $checkout',
                    style: pw.TextStyle(fontSize: 8)),
              pw.SizedBox(height: 2),
              pw.Divider(thickness: 0.5, color: PdfColors.black),
              pw.SizedBox(height: 2),
              pw.Center(
                child: hotelItems.isEmpty
                    ? pw.Table.fromTextArray(
                        context: context,
                        headerAlignment: pw.Alignment.center,
                        cellAlignment: pw.Alignment.center,
                        border: pw.TableBorder(
                            horizontalInside: pw.BorderSide.none),
                        data: <List<String>>[
                          ['Item', 'Qty', 'Price', 'Amount'],
                          ...items.map((item) {
                            return [
                              item.name,
                              item.quantity.toString(),
                              (item.price.toStringAsFixed(2)),
                              ((item.price * item.quantity).toStringAsFixed(2))
                            ];
                          }),
                        ],
                        cellPadding: pw.EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        headerStyle: pw.TextStyle(
                            fontSize: 8, fontWeight: pw.FontWeight.bold),
                      )
                    : pw.Table.fromTextArray(
                        context: context,
                        headerAlignment: pw.Alignment.center,
                        cellAlignment: pw.Alignment.center,
                        border: pw.TableBorder(
                            horizontalInside: pw.BorderSide.none),
                        data: <List<dynamic>>[
                          ['Item', 'Duration', 'Per Night', 'Amount'],
                          ...hotelItems.map((item) {
                            return [
                              item.name,
                              item.quantity.toString(),
                              (double.parse(item.price.toString())
                                  .toStringAsFixed(2)),
                              ((double.parse(item.price.toString()) *
                                      double.parse(item.quantity.toString()))
                                  .toStringAsFixed(2))
                            ];
                          }),
                        ],
                        cellPadding: pw.EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        headerStyle: pw.TextStyle(
                            fontSize: 8, fontWeight: pw.FontWeight.bold),
                      ),
              ),
              pw.SizedBox(height: 2),
              pw.Divider(thickness: 0.5, color: PdfColors.black),
              pw.SizedBox(height: 2),
              pw.Center(
                child: pw.Container(
                  width: 200,
                  child: pw.Table(
                    border: null,
                    columnWidths: {
                      0: pw.FixedColumnWidth(120),
                      1: pw.FixedColumnWidth(80),
                    },
                    children: [
                      pw.TableRow(
                        children: [
                          pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child:
                                pw.Text('Subtotal:', style: pw.TextStyle(fontSize: 8)),
                          ),
                          pw.Container(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text('NGN${subtotal.toStringAsFixed(2)}',
                                style: pw.TextStyle(
                                    fontSize: 8, fontWeight: pw.FontWeight.bold)),
                          ),
                        ],
                      ),
                      pw.TableRow(
                        children: [
                          pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child:
                                pw.Text('Discount:', style: pw.TextStyle(fontSize: 8)),
                          ),
                          pw.Container(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text('NGN0.00',
                                style: pw.TextStyle(
                                    fontSize: 8, fontWeight: pw.FontWeight.bold)),
                          ),
                        ],
                      ),
                      pw.TableRow(
                        children: [
                          pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text('Tax:', style: pw.TextStyle(fontSize: 8)),
                          ),
                          pw.Container(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text('NGN0.00',
                                style: pw.TextStyle(
                                    fontSize: 8, fontWeight: pw.FontWeight.bold)),
                          ),
                        ],
                      ),
                      pw.TableRow(
                        children: [
                          pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text('Grand Total:',
                                style: pw.TextStyle(fontSize: 8)),
                          ),
                          pw.Container(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text('NGN${total.toStringAsFixed(2)}',
                                style: pw.TextStyle(
                                    fontSize: 8, fontWeight: pw.FontWeight.bold)),
                          ),
                        ],
                      ),
                      pw.TableRow(
                        children: [
                          pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child:
                                pw.Text('Paid by:', style: pw.TextStyle(fontSize: 8)),
                          ),
                          pw.Container(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text(paymentMethod,
                                style: pw.TextStyle(
                                    fontSize: 8, fontWeight: pw.FontWeight.bold)),
                          ),
                        ],
                      ),
                      pw.TableRow(
                        children: [
                          pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text('Amount paid:',
                                style: pw.TextStyle(fontSize: 8)),
                          ),
                          pw.Container(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text('NGN${receivedAmount.toStringAsFixed(2)}',
                                style: pw.TextStyle(
                                    fontSize: 8, fontWeight: pw.FontWeight.bold)),
                          ),
                        ],
                      ),
                      pw.TableRow(
                        children: [
                          pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child:
                                pw.Text('Change:', style: pw.TextStyle(fontSize: 8)),
                          ),
                          pw.Container(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text('NGN${change.toStringAsFixed(2)}',
                                style: pw.TextStyle(
                                    fontSize: 8, fontWeight: pw.FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text('Thank You!',
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold)),
              )
            ],
          ),
        );
      },
    ),
  );
  return pdf.save();
}

Future<void> printSampleDocument(
  double total,
  List<Item> items,
  List hotelItems,
  String checkin,
  String checkout,
  String email,
  String phone,
  String staffName,
  String customerPhoneNumber,
  String branch,
  String paymentStatus,
  String tableId,
  String customerName,
  String transactionId,
  double subtotal,
  double receivedAmount,
  double change,
  String paymentMethod,
  DateTime createdAt,
  String companyName,
  String companyAddress,
  String? attendantName,
) async {
  try {
    await Printing.layoutPdf(
      onLayout: (format) async => await generateSamplePdf(
        format,
        total,
        email,
        phone,
        staffName,
        customerPhoneNumber,
        branch,
        paymentStatus,
        tableId,
        items,
        hotelItems,
        checkin,
        checkout,
        customerName,
        transactionId,
        subtotal,
        receivedAmount,
        change,
        paymentMethod,
        createdAt,
        companyName,
        companyAddress,
        attendantName,
      ),
    );
  } catch (e) {
    print('Error printing PDF: $e');
    final pdfBytes = await generateSamplePdf(
      PdfPageFormat.a4,
      total,
      email,
      phone,
      staffName,
      customerPhoneNumber,
      branch,
      paymentStatus,
      tableId,
      items,
      hotelItems,
      checkin,
      checkout,
      customerName,
      transactionId,
      subtotal,
      receivedAmount,
      change,
      paymentMethod,
      createdAt,
      companyName,
      companyAddress,
      attendantName,
    );
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/receipt_${transactionId}.pdf');
    await file.writeAsBytes(pdfBytes);
    print('PDF saved to ${file.path}');
    throw Exception('Failed to print. PDF saved to ${file.path}');
  }
}



// import 'dart:typed_data';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/printusb.dart';
// // import 'package:spotstock_inventory/common/common.dart';
// // import '../../../data/models/userdetails.dart';

// /// Generate a sample PDF document with centered table headers and summary sections.
// Future<Uint8List> generateSamplePdf(
//     PdfPageFormat format,
//     double total,
//     String email,
//     String phone,
//     String staffName,
//     String customerPhoneNumber,
//     String branch,
//     String paymentStatus,
//     String tableId,
//     List<Item> items,
//     List hotelItems,
//     String checkin,
//     String checkout,
//     String customerName,
//     String transactionId,
//     double subtotal,
//     double receivedAmount,
//     double change,
//     String paymentMethod,
//     DateTime createdAt,
//     String companyName,
//     String companyAddress,
//     String? attendantName, // Added attendantName parameter
//     ) async {
//   final pdf = pw.Document(); // Create a new PDF document.

//   pdf.addPage(
//     pw.Page(
//       pageFormat: format,
//       build: (context) {
//         return pw.Padding(
//             padding: const pw.EdgeInsets.all(16.0),
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 // Store Name and Address
//                 pw.Center(
//                   child: pw.Text(companyName,
//                       style: pw.TextStyle(
//                           fontSize: 12, fontWeight: pw.FontWeight.bold)),
//                 ),

//                 pw.Center(
//                   child: pw.Text(companyAddress,
//                       style: pw.TextStyle(fontSize: 8)),
//                 ),

//                 pw.Center(
//                   child: pw.Text(email, style: pw.TextStyle(fontSize: 8)),
//                 ),

//                 pw.Center(
//                   child: pw.Text(phone, style: pw.TextStyle(fontSize: 8)),
//                 ),

//                 pw.SizedBox(height: 2),

//                 pw.Divider(thickness: 0.5, color: PdfColors.black),

//                 pw.SizedBox(height: 2),

//                 pw.Text(
//                   "SALES INVOICE",
//                   style: pw.TextStyle(
//                       fontSize: 12, fontWeight: pw.FontWeight.bold),
//                 ),

//                 // Customer and Date
//                 branch != ''
//                     ? pw.Text('Branch:  $branch',
//                         style: pw.TextStyle(fontSize: 8))
//                     : pw.SizedBox(),
//                 if(customerName != '') pw.Text('Customer:  $customerName',
//                     style: pw.TextStyle(fontSize: 8)),
//                 if(customerPhoneNumber != '') pw.Text('Customer Phone:  $customerPhoneNumber',
//                     style: pw.TextStyle(fontSize: 8)),
//                 if(transactionId != '') pw.Text('Invoice no:  $transactionId',
//                     style: pw.TextStyle(fontSize: 8)),
//                 if(paymentStatus != '') pw.Text('Payment Status:  $paymentStatus',
//                     style: pw.TextStyle(fontSize: 8)),

//                 pw.Text('Sold By:  $staffName', style: pw.TextStyle(fontSize: 8)),
//                 if(attendantName != null && attendantName != '') pw.Text('Attendant:  $attendantName',
//                     style: pw.TextStyle(fontSize: 8)), // Added Attendant Name
//                 tableId != '' ? pw.Text('Table: :  ${tableId.toString()}', style: pw.TextStyle(fontSize: 8)) : pw.SizedBox(),
//                 pw.Text('Date:  $createdAt', style: pw.TextStyle(fontSize: 8)),
//                 if(checkin != '') pw.Text('Checkin Date:  $checkin', style: pw.TextStyle(fontSize: 8)),
//                 if(checkout != '')pw.Text('Checkout Date:  $checkout', style: pw.TextStyle(fontSize: 8)),

//                 pw.SizedBox(height: 2),

//                 pw.Divider(thickness: 0.5, color: PdfColors.black),

//                 pw.SizedBox(height: 2),

//                 // Table for items with fully centered headers and centered table
//                 pw.Center(
//                   child: hotelItems.isEmpty ? pw.Table.fromTextArray(
//                     context: context,
//                     headerAlignment: pw.Alignment.center, // Center align header labels
//                     cellAlignment: pw.Alignment.center, // Center align all cell content including header values
//                     border: pw.TableBorder(horizontalInside: pw.BorderSide.none),
//                     data: <List<String>>[
//                       ['Item', 'Qty', 'Price', 'Amount'], // Table header
//                       ...items.map((item) {
//                         // Map each item into a row
//                         return [
//                           item.name,
//                           item.quantity.toString(),
//                           (item.price.toStringAsFixed(2)),
//                           ((item.price * item.quantity).toStringAsFixed(2))
//                         ];
//                       }),
//                     ],
//                     cellPadding: pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//                     headerStyle: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
//                   ) : pw.Table.fromTextArray(
//                     context: context,
//                     headerAlignment: pw.Alignment.center, // Center align header labels
//                     cellAlignment: pw.Alignment.center, // Center align all cell content including header values
//                     border: pw.TableBorder(horizontalInside: pw.BorderSide.none),
//                     data: <List<dynamic>>[
//                       ['Item', 'Duration', 'Per Night', 'Amount'], // Table header
//                       ...hotelItems.map((item) {
//                         // Map each item into a row
//                         return [
//                           item.name,
//                           item.quantity.toString(),
//                           (double.parse(item.price.toString()).toStringAsFixed(2)),
//                           ((double.parse(item.price.toString()) * double.parse(item.quantity.toString())).toStringAsFixed(2))
//                         ];
//                       }),
//                     ],
//                     cellPadding: pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//                     headerStyle: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
//                   ),
//                 ),

//                 pw.SizedBox(height: 2),

//                 pw.Divider(thickness: 0.5, color: PdfColors.black),

//                 pw.SizedBox(height: 2),

//                 // Subtotal, VAT, Total, Paid By - Centered as a block
//                 pw.Center(
//                   child: pw.Container(
//                     width: 200, // Fixed width to ensure proper centering
//                     child: pw.Table(
//                       border: null,
//                       columnWidths: {
//                         0: pw.FixedColumnWidth(120), // Fixed width for labels
//                         1: pw.FixedColumnWidth(80),  // Fixed width for values
//                       },
//                       children: [
//                         pw.TableRow(
//                           children: [
//                             pw.Container(
//                               alignment: pw.Alignment.centerLeft,
//                               child: pw.Text('Subtotal:', style: pw.TextStyle(fontSize: 8)),
//                             ),
//                             pw.Container(
//                               alignment: pw.Alignment.centerRight,
//                               child: pw.Text('NGN${subtotal.toStringAsFixed(2)}',
//                                   style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
//                             ),
//                           ],
//                         ),
//                         pw.TableRow(
//                           children: [
//                             pw.Container(
//                               alignment: pw.Alignment.centerLeft,
//                               child: pw.Text('Discount:', style: pw.TextStyle(fontSize: 8)),
//                             ),
//                             pw.Container(
//                               alignment: pw.Alignment.centerRight,
//                               child: pw.Text('NGN0.00',
//                                   style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
//                             ),
//                           ],
//                         ),
//                         pw.TableRow(
//                           children: [
//                             pw.Container(
//                               alignment: pw.Alignment.centerLeft,
//                               child: pw.Text('Tax:', style: pw.TextStyle(fontSize: 8)),
//                             ),
//                             pw.Container(
//                               alignment: pw.Alignment.centerRight,
//                               child: pw.Text('NGN0.00',
//                                   style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
//                             ),
//                           ],
//                         ),
//                         pw.TableRow(
//                           children: [
//                             pw.Container(
//                               alignment: pw.Alignment.centerLeft,
//                               child: pw.Text('Grand Total:', style: pw.TextStyle(fontSize: 8)),
//                             ),
//                             pw.Container(
//                               alignment: pw.Alignment.centerRight,
//                               child: pw.Text('NGN${total.toStringAsFixed(2)}',
//                                   style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
//                             ),
//                           ],
//                         ),
//                         pw.TableRow(
//                           children: [
//                             pw.Container(
//                               alignment: pw.Alignment.centerLeft,
//                               child: pw.Text('Paid by:', style: pw.TextStyle(fontSize: 8)),
//                             ),
//                             pw.Container(
//                               alignment: pw.Alignment.centerRight,
//                               child: pw.Text(paymentMethod,
//                                   style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
//                             ),
//                           ],
//                         ),
//                         pw.TableRow(
//                           children: [
//                             pw.Container(
//                               alignment: pw.Alignment.centerLeft,
//                               child: pw.Text('Amount paid:', style: pw.TextStyle(fontSize: 8)),
//                             ),
//                             pw.Container(
//                               alignment: pw.Alignment.centerRight,
//                               child: pw.Text('NGN${receivedAmount.toStringAsFixed(2)}',
//                                   style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
//                             ),
//                           ],
//                         ),
//                         pw.TableRow(
//                           children: [
//                             pw.Container(
//                               alignment: pw.Alignment.centerLeft,
//                               child: pw.Text('Change:', style: pw.TextStyle(fontSize: 8)),
//                             ),
//                             pw.Container(
//                               alignment: pw.Alignment.centerRight,
//                               child: pw.Text('NGN${change.toStringAsFixed(2)}',
//                                   style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 pw.SizedBox(height: 10),

//                 // Thank you message
//                 pw.Center(
//                   child: pw.Text('Thank You!',
//                       style: pw.TextStyle(
//                           fontSize: 12, fontWeight: pw.FontWeight.bold)),
//                 )
//               ],
//             ));
//       },
//     ),
//   );

//   return pdf.save(); // Save the PDF document and return as Uint8List.
// }

// /// Print a sample document using the `printing` plugin.
// Future<void> printSampleDocument(
//     double total,
//     List<Item> items,
//     List hotelItems,
//     String checkin,
//     String checkout,
//     String email,
//     String phone,
//     String staffName,
//     String customerPhoneNumber,
//     String branch,
//     String paymentStatus,
//     String tableId,
//     String customerName,
//     String transactionId,
//     double subtotal,
//     double receivedAmount,
//     double change,
//     String paymentMethod,
//     DateTime createdAt,
//     String companyName,
//     String companyAddress,
//     String? attendantName, // Added attendantName parameter
//     ) async {
//   await Printing.layoutPdf(
//     onLayout: (format) async => await generateSamplePdf(
//         format,
//         total,
//         email,
//         phone,
//         staffName,
//         customerPhoneNumber,
//         branch,
//         paymentStatus,
//         tableId,
//         items,
//         hotelItems,
//         checkin,
//         checkout,
//         customerName,
//         transactionId,
//         subtotal,
//         receivedAmount,
//         change,
//         paymentMethod,
//         createdAt,
//         companyName,
//         companyAddress,
//         attendantName,
//     ),
//   );
// }