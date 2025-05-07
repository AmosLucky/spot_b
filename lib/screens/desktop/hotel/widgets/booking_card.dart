import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
import 'package:spotstock_inventory/common/provider/booking_history_models.dart';

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
                  // Row(
                  //   children: [
                  //     Text(
                  //       'Refund',
                  //       style: TextStyle(
                  //           fontSize: 8,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.green),
                  //     ),
                  //     Text(
                  //       booking.nights.toString(),
                  //       style: TextStyle(
                  //           fontSize: 10, fontWeight: FontWeight.bold),
                  //     ),
                  //     Gap(05),
                  //     Text(
                  //       'night',
                  //       style: TextStyle(fontSize: 8),
                  //     ),
                  //   ],
                  // ),
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
                  onTap: () {},
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
}
