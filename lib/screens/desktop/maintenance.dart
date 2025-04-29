import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
import 'package:spotstock_inventory/common/provider/maintenance_provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/desktop/sales/widgets/mark_room_as_dirty.dart';
import 'package:spotstock_inventory/widgets/sidebar.dart';

class RoomMaintenanceScreen extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final Size mediaQuery;
  const RoomMaintenanceScreen({
    Key? key,
    required this.user,
    required this.systemProvider,
    required this.mediaQuery,
  }) : super(key: key);

  @override
  State<RoomMaintenanceScreen> createState() => _RoomMaintenanceScreenState();
}

class _RoomMaintenanceScreenState extends State<RoomMaintenanceScreen> {
  //  final _searchController = TextEditingController();
  // FolioDataProvider? folioProvider;
  // bool isLoading = true;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _initializeData();
  //   });
  // }

  // Future<void> _initializeData() async {
  //   final store = await DatabaseEngine.instance.getStore();
  //   final folioBox = store.box<FolioX>();
  //   final bookingBox = store.box<BookingX>();

  //   setState(() {
  //     folioProvider = FolioDataProvider(folioBox, bookingBox);
  //     isLoading = false;
  //   });
  // }
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MaintenanceProvider>(context);

    return Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AppBAr

                Row(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height,
                      ),
                      child: SizedBox(
                        width: 200,
                        child: SideBarHotel(
                          vertical: 20,
                          user: widget.user,
                          systemProvider: widget.systemProvider,
                        ),
                      ),
                    ),
                    Container(
                      // height: 100,
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Room Maintenance & Cleaning',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          ChangeNotifierProvider(
                                        create: (_) => MarkRoomDirtyProvider(),
                                        child: const MarkRoomDirtyDialog(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: ColorsRes.grey,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.build,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                          Gap(10),
                                          const Text(
                                            'Mark Room as Dirty',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: ColorsRes.cardpurple,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      Gap(10),
                                      const Text(
                                        'Set Room for Maintenance',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Gap(30),
                            // Top Cards
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildInfoCard(
                                  icon: Icons.build,
                                  title: 'Rooms Under Maintenance',
                                  count: provider.roomsUnderMaintenance,
                                  subtitle: 'of total ${provider.totalRooms}',
                                  color: Colors.blueAccent,
                                ),
                                Gap(10),
                                _buildInfoCard(
                                  icon: Icons.cleaning_services,
                                  title: 'Dirty Rooms',
                                  count: provider.dirtyRooms,
                                  subtitle: 'need cleaning',
                                  color: Colors.grey,
                                ),
                                Gap(10),
                                _buildInfoCard(
                                  icon: Icons.pie_chart,
                                  title: 'Maintenance Rate',
                                  count: provider.maintenanceRate.toInt(),
                                  subtitle: 'percentage of total rooms',
                                  color: Colors.green,
                                ),
                                Gap(10),
                                _buildInfoCard(
                                  icon: Icons.warning,
                                  title: 'Overdue Maintenance',
                                  count: provider.overdueMaintenance,
                                  subtitle: 'rooms require attention',
                                  color: Colors.orange,
                                ),
                              ],
                            ),
                            Gap(20),
                            // Search and Filters
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 60),
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Search Field
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: ColorsRes.btndarkshadow,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    width: 210,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.search),
                                        hintText: 'Search by room number',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Gap(20),
                                  // Room Type Dropdown
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: ColorsRes.btndarkshadow,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    width: 250,
                                    child: DropdownButtonFormField<String>(
                                      hint: const Text('Filter by room type'),
                                      items: const [],
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Gap(20),
                                  // Status Dropdown
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: ColorsRes.btndarkshadow,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    width: 250,
                                    child: DropdownButtonFormField<String>(
                                      hint: const Text('Filter by status'),
                                      items: const [],
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Gap(10),
                                  const Spacer(),
                                  // Buttons
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      // apply filters
                                    },
                                    icon: const Icon(Icons.filter_alt,
                                        color: Colors.white),
                                    label: const Text('Apply Filters',
                                        style: TextStyle(color: Colors.white)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorsRes.cardpurple,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  const Gap(10),
                                  OutlinedButton(
                                    onPressed: provider.resetFilters,
                                    child: const Text('Reset'),
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 20),
                                      side:
                                          const BorderSide(color: Colors.grey),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gap(20),
                            // Empty Room Message
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 50),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.check_circle,
                                        color: Colors.green, size: 60),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'All Rooms Available',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                      'There are no rooms under maintenance or requiring cleaning at the moment.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 10),
                                            decoration: BoxDecoration(
                                              color: ColorsRes.grey,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.build,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                                Gap(10),
                                                const Text(
                                                  'Mark Room as Dirty',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            )),
                                        const SizedBox(width: 12),
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 10),
                                            decoration: BoxDecoration(
                                              color: ColorsRes.cardpurple,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                                Gap(10),
                                                const Text(
                                                  'Set Room for Maintenance',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 20),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ));
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required int count,
    required String subtitle,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              '$count',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
