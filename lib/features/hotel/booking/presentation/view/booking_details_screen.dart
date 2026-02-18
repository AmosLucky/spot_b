import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/colors/spotstock_colors.dart';
import '../providers/booking_history_provider.dart';
import 'widgets/add_premuim_service_tab.dart';
import 'widgets/booking_details_tab.dart';
import 'widgets/credit_request_tab.dart';
import 'widgets/discount_tab.dart';
import 'widgets/invoice_tab.dart';
import 'widgets/payments_tab.dart';

class BookingDetailScreen extends ConsumerStatefulWidget {
  const BookingDetailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BookingDetailScreen> createState() =>
      _BookingDetailScreenState();
}

class _BookingDetailScreenState extends ConsumerState<BookingDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final booking = ref.watch(bookingHistoryControllerProvider).selectedBooking;
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        //width: 700,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: SpotstockColors.c473069,
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Booking #${booking!.bookingNumber}",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: SpotstockColors.white),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Chip(
                          label: Text(booking.status),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.cancel_sharp,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.blue,
                tabs: const [
                  Tab(text: 'Details'),
                  // Tab(text: 'Operations'),
                  Tab(text: 'Payments'),
                  Tab(text: 'Discount'),
                  Tab(text: 'Credit'),

                  Tab(text: 'Add Sercive'),
                  Tab(text: 'Invoice'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BookingDetailsTab(),
                  // const Center(child: Text('Operations')),
                  PaymentsTab(),
                  DiscountTab(),
                  CreditRequestTab(),

                  AddPremiumServiceTab(),
                  InvoiceTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Invoice Tab
// class InvoiceTab extends StatelessWidget {
//   const InvoiceTab({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Container(
//         padding: const EdgeInsets.all(32),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: Colors.grey[300]!),
//         ),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 ElevatedButton.icon(
//                   onPressed: () {},
//                   icon: const Icon(Icons.print),
//                   label: const Text('Print Invoice'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 32),
//             // Logo placeholder
//             Container(
//               width: 80,
//               height: 80,
//               decoration: BoxDecoration(
//                 color: Colors.blue[100],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Icon(Icons.inventory, size: 40, color: Colors.blue),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'SPOT STOCK MANAGER',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Text('8 Ugwuoba Street Enugu'),
//             const Text('Phone: 08073764488  Email: 247okolo@gmail.com'),
//             const SizedBox(height: 24),
//             const Text(
//               'Attendant: SPOT STOCK MANAGER',
//               style: TextStyle(fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Invoice #: INV-4717604',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Date: Feb 14, 2026',
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(height: 32),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text(
//                         'Booking Details',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text(
//                         'Customer Details',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
