import 'package:flutter/material.dart';

import '../../../domain/entities/payment_entity.dart';

class PaymentsTable extends StatelessWidget {
  final List<PaymentEntity> payments;
  final Function(PaymentEntity) onView;
  final Function(PaymentEntity) onPrint;

  const PaymentsTable({
    required this.payments,
    required this.onView,
    required this.onPrint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: DataTable(
        columnSpacing: 24,
        headingRowColor:
            MaterialStateProperty.all(const Color(0xfff1f2f6)),
        columns: const [
          DataColumn(label: Text("ID")),
          DataColumn(label: Text("Booking")),
          DataColumn(label: Text("Customer")),
          DataColumn(label: Text("Amount")),
          DataColumn(label: Text("Method")),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Date")),
          DataColumn(label: Text("Staff")),
          DataColumn(label: Text("Actions")),
        ],
        rows: payments.map((payment) {
          return DataRow(
            cells: [
              DataCell(Text(payment.id.toString())),
              DataCell(Text(payment.bookingId.toString())),
              DataCell(Text("payment.customerName")),
              DataCell(Text(payment.amount.toStringAsFixed(2))),
              DataCell(Text("payment.method")),
              DataCell(
                _StatusBadge(status: "payment.status"),
              ),
              DataCell(Text((payment.date.toString()))),
              DataCell(Text("payment.staff")),
              DataCell(
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.visibility_outlined),
                      onPressed: () => onView(payment),
                    ),
                    IconButton(
                      icon: const Icon(Icons.print_outlined),
                      onPressed: () => onPrint(payment),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}




class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final isCompleted = status.toLowerCase() == "completed";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isCompleted
            ? Colors.green.withOpacity(0.1)
            : Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isCompleted ? Colors.green : Colors.orange,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}