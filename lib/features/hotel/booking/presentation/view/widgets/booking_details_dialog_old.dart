import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/booking_history_provider.dart';

class BookingDetailsDialog extends ConsumerWidget {
  const BookingDetailsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingHistoryControllerProvider).selectedBooking;

    if (booking == null) return const SizedBox();

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: 700,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Booking #${booking.id}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Chip(
                    label: Text(booking.status),
                  )
                ],
              ),

              const SizedBox(height: 20),

              _sectionTitle("Booking Information"),
              _info("Check-in", booking.checkInStatus),
              _info("Check-out", booking.checkInStatus),
              _info("Key Status", booking.roomKeyStatus),
              _info("Payment Status", booking.paymentStatus),

              const SizedBox(height: 20),

              _sectionTitle("Customer Details"),
              _info("Name", "booking.customerName"),
              _info("Email", "booking.customerEmail"),
              _info("Phone", "booking.customerPhone"),

              const SizedBox(height: 20),

              _sectionTitle("Financial Summary"),
              _info("Booking Fare", "₦${booking.totalAmount}"),
              _info("Amount Paid", "₦${"booking.amountPaid"}"),
              _info("Balance Due", "₦${"booking.balanceDue"}"),

              const SizedBox(height: 30),

              /// ACTIONS
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Check In"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Add Service"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 140, child: Text("$label:")),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
