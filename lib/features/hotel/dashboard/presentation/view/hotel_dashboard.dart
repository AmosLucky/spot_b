import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:spotstock_inventory/core/constants/colors/spotstock_colors.dart';
import 'package:spotstock_inventory/features/payments/presentation/state/payment_state.dart';
import '../../../../payments/presentation/providers/payment_providers.dart';
import '../../../booking/domain/entities/booking_entity.dart';
import '../../../booking/presentation/providers/booking_history_provider.dart';
import '../../../rooms/presentation/providers/room_providers.dart';
import '../providers/dashboard_provider.dart';

class HotelDashboardPage extends ConsumerStatefulWidget {
  const HotelDashboardPage({super.key});

  @override
  ConsumerState<HotelDashboardPage> createState() => _HotelDashboardPageState();
}

class _HotelDashboardPageState extends ConsumerState<HotelDashboardPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(hotelDashboardControllerProvider);
    final controller = ref.read(hotelDashboardControllerProvider.notifier);
    final roomState = ref.watch(roomControllerProvider);
    final bookingHistoryState = ref.watch(bookingHistoryControllerProvider);
    final PaymentState = ref.watch(paymentControllerProvider);

    final allRooms = roomState.all;

    final selectedDate = state.selectedDate.toLocal();

// Helper to normalize a date to just Y-M-D
    DateTime normalizeDate(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

    final normalizedSelected = normalizeDate(selectedDate);

// Filter bookings where selectedDate is between dateFrom and dateTo (inclusive)
    final todaysBookings =
        bookingHistoryState.allBookings.where((BookingEntity booking) {
      final start = normalizeDate(booking.dateFrom.toLocal());
      final end = normalizeDate(booking.dateTo.toLocal());

      return !normalizedSelected.isBefore(start) &&
          !normalizedSelected.isAfter(end);
    }).toList();

// Get all booked room numbers
    final bookedRoomNumbers = <String>{};
    for (final booking in todaysBookings) {
      final rooms = booking.roomNumbers.split(',').map((r) => r.trim());
      bookedRoomNumbers.addAll(rooms);
    }

// Separate rooms
    final bookedRooms = allRooms
        .where((room) => bookedRoomNumbers.contains(room.roomNumber))
        .toList();
    final availableRooms = allRooms
        .where((room) => !bookedRoomNumbers.contains(room.roomNumber))
        .toList();

    final maintenanceRooms = roomState.all
        .where((r) => r.status.toLowerCase() == 'maintenance')
        .length;

    final activeRooms =
        roomState.all.where((r) => r.status.toLowerCase() == 'active').length;

    final checkedInBookings =
        todaysBookings.where((b) => b.checkInStatus == 'checked_in').toList();

    final checkedOutBookings =
        todaysBookings.where((b) => b.checkOutStatus == 'checked_out').toList();

    /// Step 2: Get the booking IDs
    final todaysBookingIds = todaysBookings.map((b) => b.id).toSet();

// Step 3: Get all payments for these bookings
    final todaysPayments = PaymentState.allPayments.where((payment) {
      return todaysBookingIds.contains(payment.bookingId);
    }).toList();

// Step 4: Sum the payment amounts
    final totalRevenue = todaysPayments.fold<double>(
      0.0,
      (sum, payment) => sum + payment.amount,
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER SECTION
            _buildHeader(context, state, controller),
            const SizedBox(height: 24),

            // KPI CARDS - OCCUPANCY & ROOMS
            _buildOccupancySection(roomState, bookedRooms.length.toString(),
                activeRooms.toString(), maintenanceRooms.toString()),
            const SizedBox(height: 16),

            // KPI CARDS - REVENUE & BOOKINGS
            _buildRevenueSection("$totalRevenue", "${checkedInBookings.length}",
                "${checkedOutBookings.length}", "51"),
            const SizedBox(height: 32),

            // ROOM OCCUPANCY SECTION
            _buildRoomOccupancyHeader(),
            const SizedBox(height: 20),

            // ROOM CARDS GRID
            _buildRoomGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    dynamic state,
    dynamic controller,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Title and Date
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => controller.pickDate(context),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: SpotstockColors.c473069,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('EEEE, MMMM d, yyyy')
                          .format(state.selectedDate.toLocal()),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // Action Buttons
        Row(
          children: [
            _actionButton(
              'Book Room',
              Icons.add_business,
              SpotstockColors.c473069,
              () {},
            ),
            const SizedBox(width: 12),
            _actionButton(
              'Booking History',
              Icons.history,
              Colors.blue,
              () {},
            ),
            const SizedBox(width: 12),
            _actionButton(
              'Maintenance',
              Icons.build,
              Colors.orange,
              () {},
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {},
                tooltip: 'Refresh',
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _actionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
    );
  }

  Widget _buildOccupancySection(dynamic roomState, bookedRoomsCount,
      availableRoomsCount, maintenanceRooms) {
    return Row(
      children: [
        Expanded(
          child: _buildKpiCard(
            title: 'Total Rooms',
            value: roomState.all.length.toString(),
            subtitle: 'Available in hotel',
            icon: Icons.meeting_room,
            color: SpotstockColors.c473069,
            trend: null,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKpiCard(
            title: 'Occupied Rooms',
            value: bookedRoomsCount,
            subtitle: '48% Occupancy',
            icon: Icons.bed,
            color: Colors.blue,
            trend: '+12%',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKpiCard(
            title: 'Available Rooms',
            value: availableRoomsCount,
            subtitle: 'Ready for check-in',
            icon: Icons.check_circle,
            color: SpotstockColors.green,
            trend: null,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKpiCard(
            title: 'Maintenance',
            value: maintenanceRooms,
            subtitle: 'Under maintenance',
            icon: Icons.build,
            color: Colors.orange,
            trend: null,
          ),
        ),
      ],
    );
  }

  Widget _buildRevenueSection(String revenue, String checkedInBookings,
      String checkedOutBookings, String guest) {
    return Row(
      children: [
        Expanded(
          child: _buildKpiCard(
            title: "Today's Revenue",
            value: '₦ $revenue',
            subtitle: 'From 14 bookings',
            icon: Icons.attach_money,
            color: SpotstockColors.green,
            trend: '+18%',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKpiCard(
            title: 'Check-ins Today',
            value: checkedInBookings,
            subtitle: '5 pending check-in',
            icon: Icons.login,
            color: Colors.indigo,
            trend: null,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKpiCard(
            title: 'Check-outs Today',
            value: checkedOutBookings,
            subtitle: '3 completed',
            icon: Icons.logout,
            color: Colors.purple,
            trend: null,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildKpiCard(
            title: 'Total Guests',
            value: guest,
            subtitle: 'Currently staying',
            icon: Icons.people,
            color: Colors.teal,
            trend: null,
          ),
        ),
      ],
    );
  }

  Widget _buildKpiCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
    String? trend,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              if (trend != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: SpotstockColors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_upward,
                        size: 12,
                        color: SpotstockColors.green,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        trend,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: SpotstockColors.green,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomOccupancyHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Room Occupancy',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 320,
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search room number or type...',
              hintStyle: TextStyle(color: Colors.grey.shade400),
              prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: SpotstockColors.c473069,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoomGrid() {
    // Sample data - replace with actual data from provider
    final rooms = [
      {
        'roomNo': '101',
        'type': 'Standard',
        'reserved': true,
        'status': 'Reserved',
        'guest': 'John Doe',
        'bookingNo': 'BK202401001',
        'checkIn': 'Dec 19, 2025',
        'checkOut': 'Dec 20, 2025',
        'adults': 2,
        'children': 0,
        'price': 25000.00,
        'keyStatus': 'Keys Pending',
      },
      {
        'roomNo': '102',
        'type': 'Deluxe',
        'reserved': false,
        'status': 'Available',
        'adults': 2,
        'children': 1,
        'price': 35000.00,
      },
      {
        'roomNo': '103',
        'type': 'Standard',
        'reserved': true,
        'status': 'Occupied',
        'guest': 'Jane Smith',
        'bookingNo': 'BK202401002',
        'checkIn': 'Dec 18, 2025',
        'checkOut': 'Dec 21, 2025',
        'adults': 2,
        'children': 0,
        'price': 25000.00,
        'keyStatus': 'Keys Issued',
      },
      {
        'roomNo': '104',
        'type': 'Suite',
        'reserved': false,
        'status': 'Available',
        'adults': 4,
        'children': 2,
        'price': 50000.00,
      },
      {
        'roomNo': '201',
        'type': 'Standard',
        'reserved': false,
        'status': 'Maintenance',
        'adults': 2,
        'children': 0,
        'price': 25000.00,
      },
      {
        'roomNo': '202',
        'type': 'Deluxe',
        'reserved': true,
        'status': 'Reserved',
        'guest': 'Mike Johnson',
        'bookingNo': 'BK202401003',
        'checkIn': 'Dec 20, 2025',
        'checkOut': 'Dec 22, 2025',
        'adults': 2,
        'children': 1,
        'price': 35000.00,
        'keyStatus': 'Keys Pending',
      },
      {
        'roomNo': '203',
        'type': 'Standard',
        'reserved': false,
        'status': 'Available',
        'adults': 2,
        'children': 0,
        'price': 25000.00,
      },
      {
        'roomNo': '204',
        'type': 'Suite',
        'reserved': false,
        'status': 'Dirty',
        'adults': 4,
        'children': 2,
        'price': 50000.00,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        int crossAxisCount = 4;

        if (width < 1400) crossAxisCount = 3;
        if (width < 1000) crossAxisCount = 2;
        if (width < 600) crossAxisCount = 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            mainAxisExtent: 340,
          ),
          itemCount: rooms.length,
          itemBuilder: (context, index) {
            final room = rooms[index];
            return _RoomCard(room: room);
          },
        );
      },
    );
  }
}

// ============================================================
// ROOM CARD WIDGET
// ============================================================

class _RoomCard extends StatelessWidget {
  final Map<String, dynamic> room;

  const _RoomCard({required this.room});

  @override
  Widget build(BuildContext context) {
    final status = room['status'] as String;
    final color = _getStatusColor(status);
    final isReserved = status == 'Reserved' || status == 'Occupied';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Status Bar
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: SpotstockColors.c473069.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.door_front_door,
                              color: SpotstockColors.c473069,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Room ${room['roomNo']}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      _buildStatusBadge(status, color),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Room Type
                  Text(
                    room['type'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Capacity
                  Row(
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 18,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${room['adults']} Adults, ${room['children']} Children',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Price
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        size: 18,
                        color: SpotstockColors.green,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '₦${NumberFormat('#,##0.00').format(room['price'])} / night',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: SpotstockColors.green,
                        ),
                      ),
                    ],
                  ),

                  if (isReserved) ...[
                    const SizedBox(height: 16),
                    _buildReservationInfo(room),
                  ],

                  const Spacer(),

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    child: _buildActionButton(status),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Available':
        return SpotstockColors.green;
      case 'Reserved':
        return Colors.orange;
      case 'Occupied':
        return Colors.blue;
      case 'Maintenance':
        return SpotstockColors.red;
      case 'Dirty':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  Widget _buildStatusBadge(String status, Color color) {
    IconData icon;
    switch (status) {
      case 'Available':
        icon = Icons.check_circle;
        break;
      case 'Reserved':
        icon = Icons.event_busy;
        break;
      case 'Occupied':
        icon = Icons.person;
        break;
      case 'Maintenance':
        icon = Icons.build;
        break;
      case 'Dirty':
        icon = Icons.cleaning_services;
        break;
      default:
        icon = Icons.info;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationInfo(Map<String, dynamic> room) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, size: 14, color: Colors.grey.shade700),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  room['guest'] ?? 'Guest Name',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Booking #${room['bookingNo']}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.login, size: 12, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Text(
                room['checkIn'],
                style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.logout, size: 12, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Text(
                room['checkOut'],
                style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
              ),
            ],
          ),
          if (room['keyStatus'] != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: room['keyStatus'] == 'Keys Issued'
                    ? SpotstockColors.green.withOpacity(0.2)
                    : Colors.orange.shade200,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    room['keyStatus'] == 'Keys Issued'
                        ? Icons.key
                        : Icons.key_off,
                    size: 12,
                    color: room['keyStatus'] == 'Keys Issued'
                        ? SpotstockColors.green
                        : Colors.orange.shade800,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    room['keyStatus'],
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: room['keyStatus'] == 'Keys Issued'
                          ? SpotstockColors.green
                          : Colors.orange.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton(String status) {
    String label;
    IconData icon;
    Color color;

    switch (status) {
      case 'Available':
        label = 'Book Room';
        icon = Icons.add_business;
        color = SpotstockColors.c473069;
        break;
      case 'Reserved':
        label = 'Check-In Now';
        icon = Icons.login;
        color = Colors.blue;
        break;
      case 'Occupied':
        label = 'View Details';
        icon = Icons.info_outline;
        color = Colors.indigo;
        break;
      case 'Maintenance':
        label = 'Mark Available';
        icon = Icons.build_circle;
        color = SpotstockColors.green;
        break;
      case 'Dirty':
        label = 'Mark Clean';
        icon = Icons.cleaning_services;
        color = Colors.teal;
        break;
      default:
        label = 'View Room';
        icon = Icons.visibility;
        color = Colors.grey;
    }

    return ElevatedButton.icon(
      icon: Icon(icon, size: 18),
      onPressed: () {},
      label: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
      ),
    );
  }
}
