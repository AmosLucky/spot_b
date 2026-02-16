import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotstock_inventory/features/hotel/booking_premium_service/presentation/providers/booking_premium_service_providers.dart';
import 'package:spotstock_inventory/features/hotel/credit/presentation/providers/credit_providers.dart';
import 'package:spotstock_inventory/features/payments/presentation/providers/payment_providers.dart';

import '../../../../../../core/constants/colors/spotstock_colors.dart';
import '../../../../discount/presentation/providers/discount_providers.dart';
import '../../../../rooms/presentation/providers/room_providers.dart';
import '../../../domain/entities/booking_entity.dart';
import '../../providers/booking_history_provider.dart';
import 'booking_details_dialog_old.dart';
import '../booking_details_screen.dart';

class BookingCard extends ConsumerWidget {
  final BookingEntity booking;
  BookingCard({required this.booking});

  Color get statusColor {
    switch (booking.status) {
      case 'active':
        return Colors.green;
      case 'canceled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stayNights = booking.dateTo.difference(booking.dateFrom).inDays;

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          // ================= HEADER =================
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Booking #${booking.bookingNumber}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Created on ${_formatDate(booking.createdAt)}",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 10),

                // STATUS BADGE
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    booking.status.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          Divider(color: Colors.grey.shade200, height: 1),

          // ================= BODY =================
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Guest + Room
                Row(
                  children: [
                    const Icon(Icons.person, size: 18, color: Colors.blue),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        "Guest: ${booking.customerId}",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Icon(Icons.bed, size: 18, color: Colors.blue),
                    const SizedBox(width: 6),
                    Text("Room: ${booking.roomNumbers}"),
                  ],
                ),

                const SizedBox(height: 14),

                // Stay + Total
                Row(
                  children: [
                    const Icon(Icons.calendar_month, color: Colors.blue),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        "Stay: $stayNights night${stayNights > 1 ? 's' : ''}\n"
                        "${_formatDate(booking.dateFrom)} → ${_formatDate(booking.dateTo)}",
                      ),
                    ),
                    const Icon(Icons.payments, color: Colors.blue),
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "₦${booking.payableAmount.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          booking.paymentStatus.replaceAll('_', ' '),
                          style: TextStyle(color: Colors.grey.shade600),
                        )
                      ],
                    )
                  ],
                ),

                const SizedBox(height: 14),

                // ================= STATUS CHIPS =================
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _chip(
                      booking.paymentStatus == 'fully_paid'
                          ? "Paid"
                          : "Not Paid",
                      booking.paymentStatus == 'fully_paid'
                          ? Colors.green
                          : Colors.grey,
                    ),
                    _chip(
                      booking.checkInStatus == 'checked_in'
                          ? "Checked In"
                          : "Not Checked In",
                      booking.checkInStatus == 'checked_in'
                          ? Colors.green
                          : Colors.orange,
                    ),
                    _chip(
                      booking.checkOutStatus == 'checked_out'
                          ? "Checked Out"
                          : "N/A",
                      Colors.grey,
                    ),
                    _chip(
                      booking.roomKeyStatus == 'given' ? "Key Given" : "N/A",
                      Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ================= FOOTER =================
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(18),
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.delete, color: Colors.red),
                    label: const Text("Cancel",
                        style: TextStyle(color: Colors.red)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      //selectedBooking
                      ref
                          .read(bookingHistoryControllerProvider.notifier)
                          .selectBooking(booking);

                      ref
                          .read(paymentControllerProvider.notifier)
                          .loadPayments(booking.id!);

                      ref
                          .read(discountControllerProvider.notifier)
                          .loadDiscounts(booking.id!);

                      ref
                          .read(creditControllerProvider.notifier)
                          .loadCredits(booking.id!);

                      ref.watch(roomControllerProvider.notifier).getRooms();
                      ref
                          .watch(
                              bookingPremiumServiceControllerProvider.notifier)
                          .load(booking.id!);

                      showDialog(
                        context: context,
                        builder: (_) => const BookingDetailScreen(),
                      );
                    },
                    icon: const Icon(Icons.visibility),
                    label: const Text("View Details"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SpotstockColors.c4D2B5B,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // ================= HELPERS =================

  Widget _chip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  String _formatDate(DateTime d) => "${_month(d.month)} ${d.day}, ${d.year}";

  String _month(int m) => const [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec"
      ][m - 1];
}
