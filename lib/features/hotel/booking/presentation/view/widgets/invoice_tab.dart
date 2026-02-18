import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class SpotstockColors1 {
  static const Color c473069 = Color(0xFF473069);
  static const Color cF5821F = Color(0xFFF5821F);
  static const Color cF7F8FA = Color(0xFFF7F8FA);
  static const Color cE8ECF0 = Color(0xFFE8ECF0);
  static const Color c2D3748 = Color(0xFF2D3748);
  static const Color c4A5568 = Color(0xFF4A5568);
  static const Color c718096 = Color(0xFF718096);
}

class InvoiceTab extends ConsumerWidget {
  const InvoiceTab({super.key});

  Future<void> printPage() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Booking Summary",
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text("Room: Deluxe Room"),
              pw.Text("Guest: John Doe"),
              pw.Text("Check-in: 12 Feb 2026"),
              pw.Text("Check-out: 15 Feb 2026"),
              pw.SizedBox(height: 20),
              pw.Text("Total: ₦50,000",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Replace with your actual providers
    // final booking = ref.watch(bookingHistoryControllerProvider).selectedBooking;
    // final payments = ref.watch(...);
    // final invoice = ref.watch(...);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Print Button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _PrintButton(
                onTap: printPage,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Invoice Card
          _InvoiceCard(),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PRINT BUTTON
// ─────────────────────────────────────────────
class _PrintButton extends StatelessWidget {
  Function()? onTap;
  _PrintButton({required this.onTap});
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: const Icon(Icons.print_outlined, size: 18),
      label: const Text(
        'Print Invoice',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: SpotstockColors1.c2D3748,
        side: BorderSide(color: SpotstockColors1.cE8ECF0, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// MAIN INVOICE CARD
// ─────────────────────────────────────────────
class _InvoiceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SpotstockColors1.cE8ECF0, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Header ──────────────────────────
          _InvoiceHeader(),

          _Divider(),

          // ── Booking + Customer Details ───────
          _DetailsSection(),

          _Divider(),

          // ── Rooms Table ──────────────────────
          _RoomsSection(),

          _Divider(),

          // ── Payments Table ───────────────────
          _PaymentsSection(),

          _Divider(),

          // ── Financial Summary ────────────────
          _FinancialSummary(),

          // ── Footer ───────────────────────────
          _InvoiceFooter(),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// HEADER — Logo + Company Info + Invoice Meta
// ─────────────────────────────────────────────
class _InvoiceHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Column(
        children: [
          // Logo
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Spot Stock logo approximation
              SizedBox(
                width: 72,
                height: 72,
                child: CustomPaint(painter: _LogoPainter()),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SPOT',
                    style: TextStyle(
                      color: SpotstockColors1.cF5821F,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    'STOCK',
                    style: TextStyle(
                      color: SpotstockColors1.c473069,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    'INVENTORY',
                    style: TextStyle(
                      color: SpotstockColors1.c473069,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.5,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Company Name
          Text(
            'SPOT STOCK MANAGER',
            style: TextStyle(
              color: SpotstockColors1.c2D3748,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '8 Ugwuoba Street Enugu',
            style: TextStyle(
              color: SpotstockColors1.c4A5568,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Phone: 08073764488  •  Email: 247okolo@gmail.com',
            style: TextStyle(
              color: SpotstockColors1.c4A5568,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 24),

          // Divider line
          Container(
            height: 1,
            color: SpotstockColors1.cE8ECF0,
          ),

          const SizedBox(height: 24),

          // Attendant + Invoice meta
          Text(
            'Attendant: SPOT STOCK MANAGER',
            style: TextStyle(
              color: SpotstockColors1.c4A5568,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _MetaChip(
                label: 'Invoice #:',
                value: 'INV-7288832',
                icon: Icons.receipt_outlined,
              ),
              const SizedBox(width: 24),
              _MetaChip(
                label: 'Date:',
                value: 'Feb 17, 2026',
                icon: Icons.calendar_today_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _MetaChip({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: SpotstockColors1.c473069),
        const SizedBox(width: 6),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$label ',
                style: TextStyle(
                  color: SpotstockColors1.c718096,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: value,
                style: TextStyle(
                  color: SpotstockColors1.c2D3748,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// BOOKING + CUSTOMER DETAILS
// ─────────────────────────────────────────────
class _DetailsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Booking Details
          Expanded(
            child: _DetailsBlock(
              title: 'Booking Details',
              rows: const [
                _DetailRow(label: 'Booking #:', value: '7288832'),
                _DetailRow(label: 'Check-in:', value: 'Feb 13, 2026'),
                _DetailRow(label: 'Check-out:', value: 'Feb 14, 2026'),
                _DetailRow(label: 'Status:', value: 'ACTIVE', isStatus: true),
              ],
            ),
          ),
          const SizedBox(width: 32),
          // Customer Details
          Expanded(
            child: _DetailsBlock(
              title: 'Customer Details',
              rows: const [
                _DetailRow(label: 'Name:', value: 'Obinna 1'),
                _DetailRow(label: 'Email:', value: 'ibenemeobinna0@gmail.com'),
                _DetailRow(label: 'Phone:', value: '80473636635'),
                _DetailRow(label: 'Address:', value: '—'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsBlock extends StatelessWidget {
  final String title;
  final List<_DetailRow> rows;

  const _DetailsBlock({required this.title, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: SpotstockColors1.c718096,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 14),
        ...rows,
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isStatus;

  const _DetailRow({
    required this.label,
    required this.value,
    this.isStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: TextStyle(
                color: SpotstockColors1.c4A5568,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: isStatus
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.green[200]!),
                    ),
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  )
                : Text(
                    value,
                    style: TextStyle(
                      color: SpotstockColors1.c2D3748,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ROOMS TABLE
// ─────────────────────────────────────────────
class _RoomsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(title: 'Rooms', icon: Icons.meeting_room_outlined),
          const SizedBox(height: 16),
          _InvoiceTable(
            columns: const ['Room Number', 'Type', 'Check-in', 'Check-out'],
            columnFlex: const [2, 2, 2, 2],
            rows: const [
              ['105', 'Standard', 'Feb 13, 2026', 'Feb 14, 2026'],
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PAYMENTS TABLE
// ─────────────────────────────────────────────
class _PaymentsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(title: 'Payments', icon: Icons.payments_outlined),
          const SizedBox(height: 16),
          _InvoiceTable(
            columns: const ['Date', 'Method', 'Description', 'Amount'],
            columnFlex: const [2, 2, 4, 2],
            rows: const [
              [
                'Feb 16, 2026',
                'WALLET',
                'Automatic payment from wallet funding',
                '₦25000.00'
              ],
            ],
            alignLastRight: true,
          ),
          const SizedBox(height: 8),
          // Total Paid Row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Total Paid:',
                style: TextStyle(
                  color: SpotstockColors1.c4A5568,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 32),
              Text(
                '₦25000.00',
                style: TextStyle(
                  color: SpotstockColors1.c2D3748,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// FINANCIAL SUMMARY
// ─────────────────────────────────────────────
class _FinancialSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            title: 'Financial Summary',
            icon: Icons.account_balance_wallet_outlined,
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: SpotstockColors1.cE8ECF0, width: 1.5),
            ),
            child: Column(
              children: [
                _SummaryRow(
                  label: 'Booking Fare:',
                  value: '₦25000.00',
                  isFirst: true,
                ),
                _SummaryRow(
                  label: 'Premium Services:',
                  value: '₦0.00',
                ),
                _SummaryRow(
                  label: 'Tax Charges:',
                  value: '₦0.00',
                ),
                _SummaryRow(
                  label: 'Total Cost:',
                  value: '₦25000.00',
                  isBold: true,
                  bgColor: SpotstockColors1.c473069.withOpacity(0.06),
                ),
                _SummaryRow(
                  label: 'Amount Paid:',
                  value: '₦25000.00',
                  isLast: true,
                  bgColor: Colors.green.withOpacity(0.05),
                  valueColor: Colors.green[700],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final bool isFirst;
  final bool isLast;
  final Color? bgColor;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.isFirst = false,
    this.isLast = false,
    this.bgColor,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: bgColor ?? Colors.transparent,
        borderRadius: BorderRadius.vertical(
          top: isFirst ? const Radius.circular(11) : Radius.zero,
          bottom: isLast ? const Radius.circular(11) : Radius.zero,
        ),
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: SpotstockColors1.cE8ECF0,
                  width: 1,
                ),
              ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: isBold
                    ? SpotstockColors1.c2D3748
                    : SpotstockColors1.c4A5568,
                fontSize: 15,
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor ??
                  (isBold
                      ? SpotstockColors1.c2D3748
                      : SpotstockColors1.c4A5568),
              fontSize: isBold ? 16 : 15,
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// FOOTER
// ─────────────────────────────────────────────
class _InvoiceFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            SpotstockColors1.c473069.withOpacity(0.06),
            SpotstockColors1.c473069.withOpacity(0.02),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 2,
            width: 60,
            decoration: BoxDecoration(
              color: SpotstockColors1.c473069.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Thank you for your business!',
            style: TextStyle(
              color: SpotstockColors1.c4A5568,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'SPOT STOCK MANAGER  •  8 Ugwuoba Street Enugu',
            style: TextStyle(
              color: SpotstockColors1.c718096,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// REUSABLE: Section Title
// ─────────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionTitle({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: SpotstockColors1.c473069.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: SpotstockColors1.c473069),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            color: SpotstockColors1.c2D3748,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// REUSABLE: Invoice Table
// ─────────────────────────────────────────────
class _InvoiceTable extends StatelessWidget {
  final List<String> columns;
  final List<int> columnFlex;
  final List<List<String>> rows;
  final bool alignLastRight;

  const _InvoiceTable({
    required this.columns,
    required this.columnFlex,
    required this.rows,
    this.alignLastRight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: SpotstockColors1.cE8ECF0, width: 1.5),
      ),
      child: Column(
        children: [
          // Header Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: SpotstockColors1.cF7F8FA,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(11),
                topRight: Radius.circular(11),
              ),
            ),
            child: Row(
              children: List.generate(columns.length, (i) {
                return Expanded(
                  flex: columnFlex[i],
                  child: Text(
                    columns[i],
                    textAlign: alignLastRight && i == columns.length - 1
                        ? TextAlign.right
                        : TextAlign.left,
                    style: TextStyle(
                      color: SpotstockColors1.c4A5568,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                );
              }),
            ),
          ),

          // Data Rows
          ...rows.asMap().entries.map((entry) {
            final isLast = entry.key == rows.length - 1;
            final row = entry.value;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: isLast
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(11),
                        bottomRight: Radius.circular(11),
                      )
                    : null,
                border: isLast
                    ? null
                    : Border(
                        top: BorderSide(
                          color: SpotstockColors1.cE8ECF0,
                          width: 1,
                        ),
                      ),
              ),
              child: Row(
                children: List.generate(row.length, (i) {
                  final isAmount = alignLastRight && i == row.length - 1;
                  return Expanded(
                    flex: columnFlex[i],
                    child: Text(
                      row[i],
                      textAlign: isAmount ? TextAlign.right : TextAlign.left,
                      style: TextStyle(
                        color: isAmount
                            ? SpotstockColors1.c473069
                            : SpotstockColors1.c2D3748,
                        fontSize: 14,
                        fontWeight:
                            isAmount ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// REUSABLE: Divider
// ─────────────────────────────────────────────
class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      color: SpotstockColors1.cE8ECF0,
    );
  }
}

// ─────────────────────────────────────────────
// LOGO PAINTER  (approximates the S-shape logo)
// ─────────────────────────────────────────────
class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final orange = Paint()
      ..color = SpotstockColors1.cF5821F
      ..style = PaintingStyle.fill;
    final purple = Paint()
      ..color = SpotstockColors1.c473069
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // Top orange bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.3, 0, w * 0.5, h * 0.18),
        const Radius.circular(4),
      ),
      orange,
    );
    // Middle-left purple bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, h * 0.25, w * 0.5, h * 0.18),
        const Radius.circular(4),
      ),
      purple,
    );
    // Middle-right purple bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.5, h * 0.45, w * 0.5, h * 0.18),
        const Radius.circular(4),
      ),
      purple,
    );
    // Bottom orange bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.1, h * 0.7, w * 0.5, h * 0.18),
        const Radius.circular(4),
      ),
      orange,
    );
    // S-connector vertical left
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.28, h * 0.12, w * 0.1, h * 0.35),
        const Radius.circular(3),
      ),
      purple,
    );
    // S-connector vertical right
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.62, h * 0.5, w * 0.1, h * 0.35),
        const Radius.circular(3),
      ),
      purple,
    );
  }

  @override
  bool shouldRepaint(_) => false;
}
