import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
import 'package:spotstock_inventory/common/provider/booking_history_models.dart';
import 'package:spotstock_inventory/screens/desktop/hotel/widgets/discount_form.dart';
import 'package:spotstock_inventory/screens/desktop/hotel/widgets/invoice_screen.dart';
import 'package:spotstock_inventory/screens/desktop/hotel/widgets/operations.dart';
import 'package:spotstock_inventory/screens/desktop/hotel/widgets/payment.dart';

// class BookingCard extends StatelessWidget {class BookingCard extends StatelessWidget {
class BookingCard extends StatelessWidget {
  final Booking booking; // Assuming you have a Booking model class

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsRes.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorsRes.btndarkshadow),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Booking header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Booking #${booking.bookingNumber}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: ColorsRes.cardpurple,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(booking.status),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  booking.status.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),

          // Dates and guest info
          Row(
            children: [
              Icon(Icons.calendar_today, size: 10, color: ColorsRes.cardpurple),
              SizedBox(width: 8),
              Text(
                'Created on',
                style: TextStyle(fontSize: 8),
              ),
              Gap(05),
              Text(
                '${_formatDate(booking.createdAt)}',
                style: TextStyle(fontSize: 10),
              ),
              // Spacer(),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.calendar_today, size: 10, color: ColorsRes.cardpurple),
              SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Guest:',
                        style:
                            TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                      ),
                      Gap(05),
                      Icon(Icons.person, size: 10, color: ColorsRes.cardpurple),
                      SizedBox(width: 8),
                      Text(
                        booking.customer.name,
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        booking.customer.email,
                        style: TextStyle(fontSize: 7),
                      ),
                      Gap(05),
                      Text(
                        booking.customer.phone,
                        style: TextStyle(fontSize: 7),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Text(
                'Room||',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              Gap(05),
              Text(
                booking.bookedRooms.first.roomNumber,
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        'Stay',
                        style:
                            TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        booking.nights.toString(),
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      Gap(05),
                      Text(
                        'night',
                        style: TextStyle(fontSize: 8),
                      ),
                    ],
                  ),
                  Gap(05),
                ],
              ),
              Spacer(),
              Text(
                'Total: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              Text(
                'N',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              // Gap(05),
              Text(
                booking.totalAmount.toString(),
                style: TextStyle(
                  fontSize: 10,
                ),
              )
            ],
          ),
          SizedBox(height: 5),

          // Room information
          Row(
            children: [
              Icon(Icons.king_bed, size: 16, color: ColorsRes.cardpurple),
              SizedBox(width: 8),
              Text(
                'Room ${booking.bookingNumber} (${booking.bookingNumber}),',
                style: TextStyle(fontSize: 10),
              ),
              Spacer(),
              Text('M${booking.totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
            ],
          ),
          SizedBox(height: 3),

          // Payment status
          Row(
            children: [
              Icon(Icons.payment, size: 10, color: ColorsRes.cardpurple),
              SizedBox(width: 5),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.green),
                child: Text(
                  '${booking.paymentStatus}',
                  style: TextStyle(fontSize: 8, color: Colors.white),
                ),
              ),
              Gap(05),
              if (booking.status == 'active')
                TextButton(
                  onPressed: () {
                    // Check-in action
                  },
                  child: Text('Check-in',
                      style:
                          TextStyle(color: ColorsRes.cardpurple, fontSize: 10)),
                ),
              Spacer(),
              if (booking.pendingAmount > 0)
                Text('Pending: M${booking.pendingAmount.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.red, fontSize: 10)),
            ],
          ),
          // SizedBox(height: 5),

          // Actions
          Gap(03),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(05),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(05),
                  border: Border.all(
                    color: Colors.blue,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    // showBookingDetailsDialog(context);
                    showDialog(
                      context: context,
                      builder: (context) => const BookingDetailsDialog(),
                    );
                  },
                  child: Text(
                    'View Details',
                    style: TextStyle(color: ColorsRes.cardblue, fontSize: 8),
                  ),
                ),
              ),
              // TextButton(
              //   onPressed: () {
              //     // View details action
              //   },
              //   child:
              // ),
              // SizedBox(width: 5),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'completed':
        return Colors.blue;
      case 'checked out':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void showBookingDetailsDialog(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SingleChildScrollView(
          child: Container(
            width: 700,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Booking Details #2874170",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 16),

                // Booking Info
                // Wrap(
                //   spacing: 16,
                //   runSpacing: 12,
                //   children: [
                //     //   _infoTile(Icons.calendar_today, "Check-in", "May 1, 2025"),
                //     //   _infoTile(Icons.calendar_today, "Check-out", "May 2, 2025"),
                //     //   _infoTile(Icons.vpn_key, "Key Status", "Given"),
                //     //   _infoTile(Icons.payment, "Payment Status", "Fully Paid",
                //     //       color: Colors.green),
                //   ],
                // ),
                const SizedBox(height: 24),

                // Customer Details
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Customer Details",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text("Name: TONIA ADA"),
                      Text("Email: agujo18@gmail.com"),
                      Text("Phone: 0803675434342"),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BookingDetailsDialog extends StatefulWidget {
  const BookingDetailsDialog({super.key});

  @override
  State<BookingDetailsDialog> createState() => _BookingDetailsDialogState();
}

class _BookingDetailsDialogState extends State<BookingDetailsDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Booking Details #2874170',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: const [
                Tab(text: 'Details'),
                Tab(text: 'Operations'),
                Tab(text: 'Payments'),
                Tab(text: 'Discount'),
                Tab(text: 'Invoice'),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Details Tab
                  _buildDetailsTab(),
                  // Operations Tab
                  OperationsScreen(),
                  // const Center(child: Text('Operations content goes here')),
                  // Payments Tab
                  PaymentScreen(),
                  // const Center(child: Text('Payments content goes here')),
                  // Discount Tab
                  // const Center(child: Text('Discount content goes here')),
                  DiscountFormScreen(),
                  // Invoice Tab
                  // const Center(child: Text('Invoice content goes here')),
                  InvoiceScreen()
                ],
              ),
            ),
            const SizedBox(height: 16),
            Align(
              // alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Add Services",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      child: Container(
        width: 700,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Booking Details #2874170",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 16),

            // Booking Info
            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: [
                _infoTile(Icons.calendar_today, "Check-in", "May 1, 2025"),
                _infoTile(Icons.calendar_today, "Check-out", "May 2, 2025"),
                _infoTile(Icons.vpn_key, "Key Status", "Given"),
                _infoTile(Icons.payment, "Payment Status", "Fully Paid",
                    color: Colors.green),
              ],
            ),
            const SizedBox(height: 24),

            // Customer Details
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Customer Details",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Name: TONIA ADA"),
                  Text("Email: agujo18@gmail.com"),
                  Text("Phone: 0803675434342"),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Booked Room Table
            _sectionHeader("Booked Rooms"),
            const SizedBox(height: 8),
            _roomTable(),

            const SizedBox(height: 24),

            // Financial Summary
            _sectionHeader("Financial Summary"),
            const SizedBox(height: 8),
            _financeRow("Booking Fare:", "₦64500.00"),
            _financeRow("Premium Services:", "₦15000.00"),
            _financeRow("Tax Charges:", "₦0.00"),
            _financeRow("Total Cost:", "₦79500.00",
                bold: true, color: Colors.deepPurple[100]),
            _financeRow("Amount Paid:", "₦100000.00"),
            _financeRow("Refund Customer:", "₦20500.00",
                color: Colors.green[100]),

            const SizedBox(height: 24),

            // Buttons
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       TextButton(
            //         onPressed: () => Navigator.pop(context),
            //         child: const Text("Close"),
            //       ),
            //       const SizedBox(width: 8),
            //       ElevatedButton(
            //         onPressed: () {
            //           showAddServicesDialog(context);
            //         },
            //         child: const Text("Add Services"),
            //       )
            //     ],
            //   )
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: isBold ? const TextStyle(fontWeight: FontWeight.bold) : null,
          ),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value, {Color? color}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 4),
        Text("$label: "),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color ?? Colors.grey[200],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            value,
            style: TextStyle(
                color: color != null ? Colors.green[800] : Colors.black),
          ),
        )
      ],
    );
  }

  Widget _sectionHeader(String text) => Text(text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16));

  Widget _roomTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(1.5),
      },
      children: [
        _tableRow(["ROOM", "TYPE", "FROM", "TO", "STATUS"], isHeader: true),
        _tableRow(["302", "EXECUTIVE", "May 1, 2025", "May 2, 2025", "active"]),
      ],
    );
  }

  TableRow _tableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      children: cells.map((cell) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            cell,
            style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal),
          ),
        );
      }).toList(),
    );
  }

  Widget _financeRow(String label, String value,
      {bool bold = false, Color? color}) {
    return Container(
      color: color,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value,
              style: TextStyle(
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  void showAddServicesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Premium Services to Booking #2874170'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Service Date',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('2025-05-07'),
              const SizedBox(height: 16),
              const Text('Services',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('Service'),
              DropdownButtonFormField<String>(
                value: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '-- Select Service --',
                ),
                items: const [],
                onChanged: (value) {},
              ),
              TextButton(
                onPressed: () {},
                child: const Text('+ Add Another Service'),
              ),
              const SizedBox(height: 16),
              const Text('Select Room',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '-- Select Room --',
                ),
                items: const [],
                onChanged: (value) {},
              ),
              const Text('No rooms booked for this date',
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              const Text('Quantity',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                initialValue: '1',
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Add Services'),
          ),
        ],
      ),
    );
  }
}
