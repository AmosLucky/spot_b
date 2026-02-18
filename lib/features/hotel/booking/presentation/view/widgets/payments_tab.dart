// Payments Tab
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotstock_inventory/features/hotel/booking/presentation/providers/booking_history_provider.dart';

import '../../../../../payments/presentation/providers/payment_providers.dart';
import 'table_cell.dart';
import 'table_cell_status.dart';
import 'table_header.dart';

class PaymentsTab extends ConsumerStatefulWidget {
  const PaymentsTab({super.key});

  @override
  ConsumerState<PaymentsTab> createState() => _PaymentsTabState();
}

class _PaymentsTabState extends ConsumerState<PaymentsTab> {
  final _formKey = GlobalKey<FormState>();

  // final amountController = TextEditingController();
  // final taxController = TextEditingController(text: "0");
  // final descriptionController = TextEditingController();

  @override
  void dispose() {
    // amountController.dispose();
    // taxController.dispose();
    // descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final PaymentState = ref.watch(paymentControllerProvider);
    final bookingHistoryState = ref.watch(bookingHistoryControllerProvider);
    final paymentController = ref.read(paymentControllerProvider.notifier);

    final formState = ref.watch(paymentFormControllerProvider);
    final formController = ref.read(paymentFormControllerProvider.notifier);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add Payment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (v) {}),
                      const Text('Multiple Payment Methods'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Tax Rate (%)',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter tax rate percentage',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onChanged: (value) {
                  formController.setTax(value);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Amount is required';
                  }

                  final number = double.tryParse(value);

                  if (number == null) {
                    return 'Enter a valid number';
                  }

                  if (number <= 0) {
                    return 'Amount must be greater than zero';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Amount',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: '0',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          onChanged: (value) {
                            formController.setAmount(value);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Payment Method',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: 'Cash',
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                                value: 'Cash', child: Text('Cash')),
                            DropdownMenuItem(
                                value: 'Card', child: Text('Card')),
                            DropdownMenuItem(
                                value: 'Transfer', child: Text('Transfer')),
                          ],
                          onChanged: (v) {
                            formController.setPaymentMethod(v!);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Payment Date',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: '02/14/2026',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            suffixIcon: const Icon(Icons.calendar_today),
                          ),
                          onSaved: (newValue) {
                            // formController.set(value!);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter payment description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          onSaved: (newValue) {
                            formController.setDescription(newValue!);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Total: ₦0.00',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      print(bookingHistoryState.selectedBooking);

                      formController.submit(
                          bookingId: bookingHistoryState.selectedBooking!.id!,
                          userId: bookingHistoryState.selectedBooking!.id!,
                          registerId: bookingHistoryState.selectedBooking!.id!);
                      paymentController.getPayments(
                          bookingHistoryState.selectedBooking!.id!);

                      _formKey.currentState!.reset();
                    },
                    icon: const Icon(Icons.add),
                    label: formState.isSubmitting
                        ? CircularProgressIndicator()
                        : Text('Add Payment'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                    ),
                  ),
                ],
              ),
              Consumer(
                builder: (context, ref, _) {
                  final paymentState = ref.watch(paymentControllerProvider);

                  if (bookingHistoryState.selectedBooking!.id == null) {
                    return const SizedBox();
                  }

                  if (paymentState.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (paymentState.payments.isEmpty) {
                    return const Text("No payments found");
                  }

                  return Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Payments',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Table(
                          border: TableBorder.all(color: Colors.grey[300]!),
                          children: [
                            /// HEADER
                            TableRow(
                              decoration:
                                  BoxDecoration(color: Colors.grey[100]),
                              children: const [
                                TableHeader('Amount'),
                                TableHeader('Method'),
                                TableHeader('Desc'),
                                TableHeader('Date'),
                                TableHeader('Status'),
                              ],
                            ),

                            /// DATA ROWS
                            ...paymentState.payments.map(
                              (payment) => TableRow(
                                children: [
                                  MTableCell("₦${payment.amount}"),
                                  MTableCell(payment.paymentMethod),
                                  MTableCell("payment.description"),
                                  MTableCell(("payment.status")),
                                  TableCellStatus(
                                    payment.paymentMethod,
                                    payment.paymentMethod == "completed"
                                        ? Colors.green
                                        : Colors.orange,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
