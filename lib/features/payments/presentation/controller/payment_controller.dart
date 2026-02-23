import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import '../../../../core/presentation/mesenger/app_messenger.dart';
import '../../domain/entities/payment_entity.dart';
import '../../domain/usecases/create_payment.dart';
import '../../domain/usecases/delete_payment.dart';
import '../../domain/usecases/get_all_payments.dart';
import '../../domain/usecases/get_payments_by_booking.dart';
import '../../domain/usecases/update_payment.dart';
import '../state/payment_state.dart';
import 'package:pdf/widgets.dart' as pw;


class PaymentController extends StateNotifier<PaymentState> {
  final GetPaymentsByBooking getPayments;
  final CreatePayment createPaymentUC;
  final UpdatePayment updatePaymentUC;
  final DeletePayment deletePaymentUC;
    final GetAllPayments getAllPayments;


  PaymentController(
    this.getPayments,
    this.createPaymentUC,
    this.updatePaymentUC,
    this.deletePaymentUC,
    this.getAllPayments,
  ) : super(PaymentState.initial());

  int? _bookingId;

  Future<void> loadPayments(int bookingId) async {
    _bookingId = bookingId;
    state = state.copyWith(isLoading: true);

    final data = await getPayments(bookingId);

    state = state.copyWith(
      payments: data,
      totalPaid: data.fold(0, (sum, e) => sum! + e.total),
      isLoading: false,
    );
  }

   /// 🔥 LOAD ALL PAYMENTS
  Future<void> loadAllPayments() async {
    state = state.copyWith(isLoading: true);

    try {
      final payments = await getAllPayments();

      state = state.copyWith(
        isLoading: false,
        allPayments: payments,
        payments: payments, // optional sync
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> addPayment(PaymentEntity payment) async {
    await createPaymentUC(payment);
    await loadPayments(_bookingId!);
    AppMessenger.showSuccess("Payment added successfully");
  }

  Future<void> deletePayment(int id) async {
    await deletePaymentUC(id);
    await loadPayments(_bookingId!);
  }

  Future<void> updatePayment(PaymentEntity payment) async {
    await updatePaymentUC(payment);
    await loadPayments(_bookingId!);
  }

  void setSearchQuery(String query) {
  state = state.copyWith(searchQuery: query);
}

void setRowsPerPage(int? value) {
  if (value == null) return;
  state = state.copyWith(rowsPerPage: value);
}

void viewPayment(PaymentEntity payment) {
  // Open dialog or navigate
}

Future<void> printSinglePayment(PaymentEntity payment) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [

            /// HEADER
            pw.Center(
              child: pw.Text(
                "PAYMENT RECEIPT",
                style: pw.TextStyle(
                  fontSize: 22,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),

            pw.SizedBox(height: 20),
            pw.Divider(),

            pw.SizedBox(height: 20),

            /// DETAILS
            _pdfRow("Payment ID", payment.id.toString()),
            _pdfRow("Booking ID", payment.bookingId.toString()),
            _pdfRow("Customer", "payment.customerName"),
            _pdfRow("Amount", payment.amount.toStringAsFixed(2)),
            _pdfRow("Method", "payment.method".toUpperCase()),
            _pdfRow("Status", "payment.status".toUpperCase()),
            _pdfRow("Date", payment.date.toString()),
            _pdfRow("Staff", "payment.staff"),

            pw.SizedBox(height: 30),
            pw.Divider(),

            pw.SizedBox(height: 20),

            /// FOOTER
            pw.Center(
              child: pw.Text(
                "Thank you for your business",
                style: const pw.TextStyle(fontSize: 12),
              ),
            ),
          ],
        );
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}

Future<void> printAllPayments() async {
  await exportAllToPdf();
}

Future<void> exportAllToExcel() async {
  final excel = Excel.createExcel();
  final sheet = excel['Payments'];

  sheet.appendRow([
    "ID",
    "Booking",
    "Customer",
    "Amount",
    "Method",
    "Status",
    "Date",
    "Staff",
  ]);

  for (final p in state.allPayments) {
    sheet.appendRow([
      p.id,
      p.bookingId,
      "p.customerName",
      p.amount,
     " p.method",
      "p.status",
      p.date.toString(),
      "p.staff",
    ]);
  }

  final dir = await getApplicationDocumentsDirectory();
  final file = File("${dir.path}/payments.xlsx");

  await file.writeAsBytes(excel.encode()!);

  await OpenFile.open(file.path);
}

Future<void> exportAllToPdf() async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) => [
        pw.Text("Payments Report",
            style: pw.TextStyle(
                fontSize: 20, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 20),
        pw.Table.fromTextArray(
          headers: [
            "ID",
            "Booking",
            "Customer",
            "Amount",
            "Method",
            "Status",
            "Date",
            "Staff"
          ],
          data: state.allPayments.map((p) {
            return [
              p.id.toString(),
              p.bookingId.toString(),
              "p.customerName",
              p.amount.toStringAsFixed(2),
             " p.method",
             " p.status",
              p.date.toString(),
              "p.staff",
            ];
          }).toList(),
        ),
      ],
    ),
  );

  await Printing.layoutPdf(
    onLayout: (format) async => pdf.save(),
  );
}


pw.Widget _pdfRow(String title, String value) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 6),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(value),
      ],
    ),
  );
}

}
