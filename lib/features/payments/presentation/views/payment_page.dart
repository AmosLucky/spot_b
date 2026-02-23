import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/payment_providers.dart';
import 'widget/payment_table.dart';
import 'widget/payment_toolbar.dart';

class PaymentsPage extends ConsumerStatefulWidget {
  const PaymentsPage({super.key});

  @override
  ConsumerState<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends ConsumerState<PaymentsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(paymentControllerProvider.notifier).loadAllPayments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(paymentControllerProvider);
    final controller = ref.read(paymentControllerProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔥 HEADER
            const Text(
              "Payments",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "View and manage payment records",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 24),

            /// 🔥 SEARCH + ACTION BAR
            PaymentToolbar(
              onSearch: controller.setSearchQuery,
              onExportExcel: controller.exportAllToExcel,
              onExportPdf: controller.exportAllToPdf,
              onPrintAll: controller.printAllPayments,
              rowsPerPage: state.rowsPerPage,
              onRowsChanged: controller.setRowsPerPage,
            ),

            const SizedBox(height: 20),

            state.isLoading?
            Center(
              child: CircularProgressIndicator(),
            ):

            /// 🔥 TABLE
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: PaymentsTable(
                  payments: state.filteredPayments,
                  onView: controller.viewPayment,
                  onPrint: controller.printSinglePayment,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
