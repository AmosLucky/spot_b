import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:spotstock_inventory/core/constants/colors/spotstock_colors.dart';
import '../providers/dashboard_provider.dart';

class HotelDashboardPage extends ConsumerStatefulWidget {
  const HotelDashboardPage({super.key});

  @override
  ConsumerState<HotelDashboardPage> createState() => _HotelDashboardPageState();
}

class _HotelDashboardPageState extends ConsumerState<HotelDashboardPage> {
  // DateTime selectedDate = DateTime.now();

  // Future<void> _pickDate() async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2100),
  //   );

  //   if (picked != null) {
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(hotelDashboardControllerProvider);
    final controller = ref.read(hotelDashboardControllerProvider.notifier);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 1000,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => controller.pickDate(context),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        DateFormat('MM/dd/yyyy')
                            .format(state.selectedDate.toLocal()),
                        style: const TextStyle(
                          fontSize: 15,
                          //fontWeight: FontWeight.bold,
                          //color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      _actionBtn('Book a Room'),
                      _actionBtn('Booking History'),
                      _actionBtn('Maintenance'),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              GridView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    mainAxisExtent: 120, // item height
                  ),
                  itemBuilder: (context, index) {
                    return KpiCard(
                      title: 'Rooms',
                      value: '29 / 14 obi',
                      subtitle: '100% Occupancy',
                      color: Colors.indigo,
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              GridView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    mainAxisExtent: 120, // item height
                  ),
                  itemBuilder: (context, index) {
                    return KpiCard(
                      title: "Today's Revenue",
                      value: '₦4,424,000.00',
                      subtitle: 'Daily bookings',
                      color: Colors.green,
                    );
                  }),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Room Occupancy',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 280,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search room number or type...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              LayoutBuilder(builder: (context, constraints) {
                final width = constraints.maxWidth;

                int crossAxisCount = 4;
                double itemHeight = 400;

                if (width < 900) {
                  crossAxisCount = 2; // 👈 2 columns → 2 rows
                  itemHeight = 320;
                }

                if (width < 500) {
                  crossAxisCount = 1;
                  itemHeight = 280;
                }

                return GridView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      mainAxisExtent: 400, // item height
                    ),
                    itemBuilder: (context, index) {
                      return RoomCard(roomNo: "5", reserved: true);
                    });
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionBtn(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {},
          child: Text(
            text,
            style: TextStyle(color: SpotstockColors.white),
          )),
    );
  }
}

class KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color color;

  const KpiCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SpotstockColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final String roomNo;
  final bool reserved;

  const RoomCard({
    super.key,
    required this.roomNo,
    required this.reserved,
  });

  @override
  Widget build(BuildContext context) {
    final color = Colors.red; //statusColor(reserved);

    return Container(
      //height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Row(
        children: [
          // LEFT STATUS STRIP
          Container(
            width: 4,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(14),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        roomNo,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _statusPill(reserved),
                    ],
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Standard',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: const [
                      Icon(Icons.people_outline,
                          size: 18, color: Colors.indigo),
                      SizedBox(width: 6),
                      Text('2 Adults, 0 Children'),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: const [
                      Icon(Icons.attach_money, size: 18, color: Colors.green),
                      Text(
                        '₦25,000.00 / night',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  if (reserved) ...[
                    const SizedBox(height: 12),
                    _reservedBox(),
                  ],

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Icon(
                        reserved ? Icons.login : Icons.bed,
                        size: 18,
                      ),
                      onPressed: () {},
                      label: Text(
                        reserved ? 'Check-In Now' : 'Ready for check-in',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusPill(bool reserved) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red, //statusColor(reserved),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            reserved ? Icons.event_busy : Icons.check_circle,
            size: 14,
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            reserved ? 'Reserved' : 'Available',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _reservedBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1EC),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Reserved for: nonso'),
          SizedBox(height: 4),
          Text('Booking #: 2028327',
              style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 4),
          Text('Check-in: Dec 19, 2025'),
          Text('Check-out: Dec 20, 2025'),
          SizedBox(height: 6),
          Chip(
            label: Text('Keys Pending'),
            backgroundColor: Color(0xFFFFD8C2),
          ),
        ],
      ),
    );
  }
}
