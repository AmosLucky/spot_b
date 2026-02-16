// Credit Tab
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotstock_inventory/features/hotel/credit/presentation/providers/credit_providers.dart';

import '../../providers/booking_history_provider.dart';
import 'table_cell.dart';
import 'table_cell_status.dart';
import 'table_header.dart';

class CreditRequestTab extends ConsumerStatefulWidget {
  const CreditRequestTab({super.key});

  @override
  ConsumerState<CreditRequestTab> createState() => _CreditRequestTabState();
}

class _CreditRequestTabState extends ConsumerState<CreditRequestTab> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final creditRequestController = ref.read(creditControllerProvider.notifier);
    final discountState = ref.watch(creditControllerProvider);
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
              const Text(
                'Request Credit',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Description',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter credit reason',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onChanged: (value) {
                  creditRequestController.setDescription(value);
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Date',
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
                onChanged: (value) {
                  final date = DateTime.tryParse(value);
                  creditRequestController.setDate(date ?? DateTime.now());
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Credit Amount',
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
                  creditRequestController.setAmount(value);
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
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await creditRequestController.create(
                        bookingId: ref
                            .read(bookingHistoryControllerProvider)
                            .selectedBooking!
                            .id!,
                        userId: 1,
                        registerId: 1,
                      );
                    }
                  },
                  child: const Text(
                    'Add Credit',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Consumer(
                builder: (context, ref, _) {
                  final creditState = ref.watch(creditControllerProvider);
                  final bookingHistoryState =
                      ref.watch(bookingHistoryControllerProvider);

                  if (bookingHistoryState.selectedBooking?.id == null) {
                    return const SizedBox();
                  }

                  if (creditState.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (creditState.credits.isEmpty) {
                    return const Text("No credit requests found");
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
                          'Credit Requests',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Table(
                          border: TableBorder.all(
                            color: Colors.grey[300]!,
                          ),
                          children: [
                            /// HEADER
                            TableRow(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                              ),
                              children: const [
                                TableHeader('Amount'),
                                TableHeader('Reason'),
                                TableHeader('Date Requested'),
                                TableHeader('Status'),
                              ],
                            ),

                            /// DATA ROWS
                            ...creditState.credits.map(
                              (credit) => TableRow(
                                children: [
                                  MTableCell("₦${credit.amount}"),
                                  MTableCell(
                                    credit.description ?? "-",
                                  ),
                                  MTableCell(
                                    credit.dateCreated.toString(),
                                  ),
                                  TableCellStatus(
                                    credit.status,
                                    credit.status == "Approved"
                                        ? Colors.green
                                        : credit.status == "Rejected"
                                            ? Colors.red
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
