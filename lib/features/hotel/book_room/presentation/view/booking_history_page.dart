import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/colors/spotstock_colors.dart';
import '../../domain/entities/booking_entity.dart';
import '../providers/booking_history_provider.dart';
import 'widgets/booking_card.dart';
import 'widgets/booking_history_filter_section.dart';

class BookingHistoryPage extends ConsumerStatefulWidget {
  const BookingHistoryPage({super.key});

  @override
  ConsumerState<BookingHistoryPage> createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends ConsumerState<BookingHistoryPage> {
  @override
  void initState() {
    Future.microtask(() =>
        ref.read(bookingHistoryControllerProvider.notifier).loadBookings());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final state = ref.watch(bookingHistoryControllerProvider);
    final controller = ref.read(bookingHistoryControllerProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Booking History"),
        backgroundColor: SpotstockColors.c4D2B5B,
      ),
      body: Column(
        children: [
          BookingHistoryFilterSection(controller: controller, state: state),
          Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.filteredBookings.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 🔥 3 per row
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.78, // important for card height
                      ),
                      itemBuilder: (_, index) {
                        final booking = state.filteredBookings[index];
                        return BookingCard(booking: booking);
                      },
                    )),
        ],
      ),
    );
  }
}
