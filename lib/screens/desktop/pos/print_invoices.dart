import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/screens/desktop/pos/printusb.dart';

import '../../../data/models/userdetails.dart';

/// Generate a sample PDF document.
Future<Uint8List> generateSamplePdf(
    PdfPageFormat format,
    double total,
    String email,
    String phone,
    String staffName,
    List<Item> items,
    double receivedAmount,
    double change,
    DateTime createdAt,
    String invoiceReference,
    String updateDate,
    String branch,
    String companyName,
    String companyAddress,
    String? customerName,
    String? customerPhone,
    String? tableId
    ) async {
  final pdf = pw.Document(); // Create a new PDF document.

  pdf.addPage(
    pw.Page(
      pageFormat: format,
      build: (context) {
        return pw.Padding(
            padding: const pw.EdgeInsets.all(16.0),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Store Name and Address
                pw.Center(
                  child: pw.Text(companyName,
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold)),
                ),

                pw.Center(
                  child: pw.Text(companyName,
                      style: pw.TextStyle(fontSize: 8)),
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
                      fontSize: 12, fontWeight: pw.FontWeight.bold),
                ),

                // // Customer and Date
                branch != ''
                    ? pw.Text('Branch:  $branch',
                    style: pw.TextStyle(fontSize: 8))
                    : pw.SizedBox(),
                // pw.Text('Customer:  $customerName',
                //     style: pw.TextStyle(fontSize: 8)),
                // pw.Text('Customer Phone:  $customerPhoneNumber',
                //     style: pw.TextStyle(fontSize: 8)),
                pw.Text('Invoice no:  $invoiceReference',
                    style: pw.TextStyle(fontSize: 8)),
                pw.Text('Customer:  ${customerName ?? ''}', style: pw.TextStyle(fontSize: 8)),
                pw.Text('Customer Phone:  ${customerPhone ?? ''}', style: pw.TextStyle(fontSize: 8)),
                pw.Text('Table:  ${tableId ?? ''}', style: pw.TextStyle(fontSize: 8)),
                pw.Text('Sold By:  $staffName', style: pw.TextStyle(fontSize: 8)),
                pw.Text('Date:  $updateDate', style: pw.TextStyle(fontSize: 8,)),


                pw.SizedBox(height: 2),

                pw.Divider(thickness: 0.5, color: PdfColors.black),

                pw.SizedBox(height: 2),

                // Table for items

                pw.Table.fromTextArray(
                  context: context,
                  headerAlignment: pw.Alignment.centerLeft,
                  border: pw.TableBorder(horizontalInside: pw.BorderSide.none),
                  data: <List<String>>[
                    ['Item', 'Qty', 'Price', 'Amount'], // Table header
                    ...items.map((item) {
                      // Map each item into a row
                      return [
                        item.name,
                        item.quantity.toString(),
                        (item.price.toStringAsFixed(2)),
                        ((item.price * item.quantity).toStringAsFixed(2))
                      ];
                    }).toList(),
                  ],
                  cellAlignment: pw.Alignment.centerLeft,
                  cellPadding: pw.EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                  headerStyle: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold,),
                  //headerDecoration: pw.BoxDecoration(color: PdfColors.blue),
                ),

                pw.SizedBox(height: 2),

                pw.Divider(thickness: 0.5, color: PdfColors.black),

                pw.SizedBox(height: 2),

                // Subtotal, VAT, Total, Paid By
                // pw.Row(
                //     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                //     children: [
                //       pw.Text('Subtotal:', style: pw.TextStyle(fontSize: 8)),
                //       //pw.SizedBox(width: 20),
                //       pw.Text('NGN$subtotal',
                //           style: pw.TextStyle(
                //               fontSize: 8, fontWeight: pw.FontWeight.bold)),
                //     ]),

                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Discount:', style: pw.TextStyle(fontSize: 8)),
                      //pw.SizedBox(width: 40),
                      pw.Text('NGN0.00',
                          style: pw.TextStyle(
                              fontSize: 8, fontWeight: pw.FontWeight.bold)),
                    ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Tax:', style: pw.TextStyle(fontSize: 8)),
                      //pw.SizedBox(width: 40),
                      pw.Text('NGN0.00',
                          style: pw.TextStyle(
                              fontSize: 8, fontWeight: pw.FontWeight.bold)),
                    ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Grand Total:', style: pw.TextStyle(fontSize: 8)),
                      //pw.SizedBox(width: 38),
                      pw.Text('NGN$total',
                          style: pw.TextStyle(
                              fontSize: 8, fontWeight: pw.FontWeight.bold)),
                    ]),

                // Payment details
                // pw.Row(
                //     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                //     children: [
                //       pw.Text('Paid by:', style: pw.TextStyle(fontSize: 8)),
                //       //pw.SizedBox(width: 20),
                //       pw.Text(paymentMethod,
                //           style: pw.TextStyle(
                //               fontSize: 8, fontWeight: pw.FontWeight.bold)),
                //     ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Amount paid:', style: pw.TextStyle(fontSize: 8)),
                      //pw.SizedBox(width: 34),
                      pw.Text('NGN$receivedAmount',
                          style: pw.TextStyle(
                              fontSize: 8, fontWeight: pw.FontWeight.bold)),
                    ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Change:', style: pw.TextStyle(fontSize: 8)),
                      //pw.SizedBox(width: 25),
                      pw.Text('NGN$change',
                          style: pw.TextStyle(
                              fontSize: 8, fontWeight: pw.FontWeight.bold)),
                    ]),

                pw.SizedBox(height: 10),

                // Thank you message
                pw.Center(
                  child: pw.Text('Thank You!',
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold)),
                )
              ],
            ));
      },
    ),
  );

  return pdf.save(); // Save the PDF document and return as Uint8List.
}

/// Print a sample document using the `printing` plugin.
Future<void> printInvoiceDocument(
    double total,
    List<Item> items,
    String email,
    String phone,
    String staffName,
    double receivedAmount,
    double change,
    DateTime createdAt,
    String invoiceReference,
    String updateDate,
    String branch,
    String companyName,
    String companyAddress,
    String customerName,
    String customerPhone,
    String tableId
    ) async {
  await Printing.layoutPdf(
    onLayout: (format) async => await generateSamplePdf(
        format,
        total,
        email,
        phone,
        staffName,
        items,
        receivedAmount,
        change,
        createdAt,
        invoiceReference,
        updateDate,
      branch,
      companyName,
      companyAddress,
      customerName,
      customerPhone,
      tableId
    ),
  );
}
