// Discount Tab
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotstock_inventory/features/hotel/book_room/presentation/providers/booking_history_provider.dart';
import 'package:spotstock_inventory/features/hotel/book_room/presentation/providers/booking_provider.dart';

import '../../../../discount/presentation/providers/discount_providers.dart';
import 'table_cell.dart';
import 'table_cell_status.dart';
import 'table_header.dart';

class DiscountTab extends ConsumerStatefulWidget {
  const DiscountTab({super.key});

  @override
  ConsumerState<DiscountTab> createState() => _DiscountTabState();
}

class _DiscountTabState extends ConsumerState<DiscountTab> {
  final _formKey = GlobalKey<FormState>();
  //final TextEditingController amount

  @override
  Widget build(BuildContext context) {
    final discountController = ref.read(discountControllerProvider.notifier);
    final discountState = ref.watch(discountControllerProvider);
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
                'Add Discount',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Discount Amount',
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
                  discountController.setAmount(value);
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
                  discountController.setDate(date ?? DateTime.now());
                },
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
                  hintText: 'Enter discount description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onChanged: (value) {
                  discountController.setDescription(value);
                },
              ),
              SizedBox(
                height: 20,
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
                      await ref
                          .read(discountControllerProvider.notifier)
                          .create(
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
                    'Add Discount',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Consumer(
                builder: (context, ref, _) {
                  final discountState = ref.watch(discountControllerProvider);
                  final bookingHistoryState =
                      ref.watch(bookingHistoryControllerProvider);

                  if (bookingHistoryState.selectedBooking?.id == null) {
                    return const SizedBox();
                  }

                  if (discountState.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (discountState.discounts.isEmpty) {
                    return const Text("No discounts found");
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
                          'Discounts',
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
                              decoration:
                                  BoxDecoration(color: Colors.grey[100]),
                              children: const [
                                TableHeader('Amount'),
                                TableHeader('Description'),
                                TableHeader('Date'),
                                TableHeader('Status'),
                              ],
                            ),

                            /// DATA ROWS
                            ...discountState.discounts.map(
                              (discount) => TableRow(
                                children: [
                                  MTableCell("₦${discount.amount}"),
                                  MTableCell(
                                    discount.description ?? "-",
                                  ),
                                  MTableCell(
                                    discount.dateCreated != null
                                        ? "${discount.dateCreated!.day}/${discount.dateCreated!.month}/${discount.dateCreated!.year}"
                                        : "-",
                                  ),
                                  TableCellStatus(
                                    discount.status,
                                    discount.status == "Approved"
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
