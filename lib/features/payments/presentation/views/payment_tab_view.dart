import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dialogs/add_payment_dialog.dart';
import '../providers/payment_providers.dart';
import '../widgets/payment_tile.dart';

class PaymentTabView extends ConsumerStatefulWidget {
  final int bookingId;
  const PaymentTabView({super.key, required this.bookingId});

  @override
  ConsumerState<PaymentTabView> createState() => _PaymentTabViewState();
}

class _PaymentTabViewState extends ConsumerState<PaymentTabView> {

     @override
  void initState() {
    super.initState();

    /// run AFTER build frame
    Future.microtask(() {
      ref.read(paymentControllerProvider.notifier)
          .loadPayments(widget.bookingId);
    });
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(paymentControllerProvider);
    final controller = ref.read(paymentControllerProvider.notifier);

 

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [

        /// SUMMARY BAR
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xffF5F7FA),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Text("Total Paid: ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text("₦${state.totalPaid.toStringAsFixed(2)}"),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => AddPaymentDialog(bookingId: widget.bookingId),
                ),
                icon: const Icon(Icons.add),
                label: const Text("Add Payment"),
              )
            ],
          ),
        ),

        const SizedBox(height: 15),

        /// LIST
        Expanded(
          child: ListView.builder(
            itemCount: state.payments.length,
            itemBuilder: (_, i) {
              final payment = state.payments[i];
              return PaymentTile(payment: payment);
            },
          ),
        ),
      ],
    );
  }
}
