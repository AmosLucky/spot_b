// Details Tab
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/booking_history_provider.dart';
import 'table_cell.dart';
import 'table_cell_status.dart';
import 'table_header.dart';

class BookingDetailsTab extends ConsumerStatefulWidget {
  const BookingDetailsTab({Key? key}) : super(key: key);

  @override
  ConsumerState<BookingDetailsTab> createState() => _DetailsTabState();
}

class _DetailsTabState extends ConsumerState<BookingDetailsTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: BookingInformationCard(),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: CustomerDetailsCard(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          BookedRoomsCard(),
          const SizedBox(height: 24),
          PaymentInformation(),
        ],
      ),
    );
  }
}

class BookingInformationCard extends ConsumerWidget {
  const BookingInformationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingHistoryControllerProvider).selectedBooking;
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
            'Booking Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildInfoRow(
            Icons.calendar_today,
            'Check-in:',
            booking!.checkInStatus,
            Colors.blue,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            Icons.calendar_today,
            'Check-out:',
            booking.checkOutStatus,
            Colors.red,
          ),
          const SizedBox(height: 16),
          _buildInfoRowWithStatus(
            Icons.vpn_key,
            'Key Status:',
            booking.roomKeyStatus,
            Colors.amber,
            Colors.grey,
          ),
          const SizedBox(height: 16),
          _buildInfoRowWithStatus(
            Icons.payment,
            'Payment Status:',
            booking.paymentStatus,
            Colors.green,
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      IconData icon, String label, String value, Color iconColor) {
    return Row(
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRowWithStatus(IconData icon, String label, String value,
      Color iconColor, Color statusColor) {
    return Row(
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: statusColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomerDetailsCard extends StatelessWidget {
  const CustomerDetailsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            'Customer Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildDetailRow(Icons.person, 'Name:', 'Uche Nwodo'),
          const SizedBox(height: 16),
          _buildDetailRow(Icons.email, 'Email:', 'uche.nwodo@gmail.com'),
          const SizedBox(height: 16),
          _buildDetailRow(Icons.phone, 'Phone:', '08023435678'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class BookedRoomsCard extends StatelessWidget {
  const BookedRoomsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            'Booked Rooms',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Table(
            border: TableBorder.all(color: Colors.grey[300]!),
            children: [
              TableRow(
                decoration: BoxDecoration(color: Colors.grey[100]),
                children: const [
                  TableHeader('Room'),
                  TableHeader('Type'),
                  TableHeader('From'),
                  TableHeader('To'),
                  TableHeader('Status'),
                ],
              ),
              const TableRow(
                children: [
                  MTableCell('201'),
                  MTableCell('Delux'),
                  MTableCell('Jan 31, 2026'),
                  MTableCell('Feb 1, 2026'),
                  TableCellStatus('active', Colors.green),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PaymentInformation extends ConsumerWidget {
  const PaymentInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingHistoryControllerProvider).selectedBooking;
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
            'Financial Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildInfoRow(
            Icons.attach_money,
            'Booking Fare:',
            "₦${booking!.totalAmount}",
            Colors.blue,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            Icons.mobile_friendly,
            'Amount Paid:',
            "₦${"booking.amountPaid"}",
            Colors.red,
          ),
          const SizedBox(height: 16),
          _buildInfoRowWithStatus(
            Icons.balance,
            'Balance Due:',
            "₦${"booking.balanceDue"}",
            Colors.amber,
            Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      IconData icon, String label, String value, Color iconColor) {
    return Row(
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRowWithStatus(IconData icon, String label, String value,
      Color iconColor, Color statusColor) {
    return Row(
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: statusColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
