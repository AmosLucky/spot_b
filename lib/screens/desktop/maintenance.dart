import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
import 'package:spotstock_inventory/common/provider/maintenance_provider.dart';
import 'package:spotstock_inventory/common/provider/markroomfor_maintenance_provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/schema.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/desktop/sales/widgets/dirty_room_available_dialog.dart';
import 'package:spotstock_inventory/screens/desktop/sales/widgets/mark_room_as_dirty.dart';
import 'package:spotstock_inventory/screens/desktop/sales/widgets/setroom_for_maintenance.dart';
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
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MarkDirtyRoomProvider>(context);
    final provideMaintenance =
        Provider.of<MarkRoomForMaintenanceProvider>(context);

    return Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // AppBAr

                      Row(children: [
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
                          width: MediaQuery.of(context).size.width * 0.75,
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
                                        fontSize: 16,
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () async {
                                        final provider = context
                                            .read<MarkDirtyRoomProvider>();
                                        final scaffold =
                                            ScaffoldMessenger.of(context);
                                        try {
                                          // Show loading indicator
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) => const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                          );

                                          // Refresh room data
                                          await provider.fetchMaintenanceRooms(
                                              refresh: true);

                                          // Close loading dialog
                                          if (context.mounted)
                                            Navigator.of(context).pop();

                                          // Show the mark dirty dialog
                                          if (context.mounted) {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  ChangeNotifierProvider.value(
                                                value: provider,
                                                child:
                                                    const MarkRoomDirtyDialog(),
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          // Close loading dialog if still open
                                          if (context.mounted)
                                            Navigator.of(context).pop();

                                          // Show error message
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Failed to load room data: ${e.toString()}'),
                                                duration:
                                                    const Duration(seconds: 3),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: ColorsRes.grey,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 2,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.build,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'Mark Room as Dirty',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<
                                                MarkRoomForMaintenanceProvider>()
                                            .fetchMaintenanceRooms()
                                            .then((_) {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const SetRoomForMaintenance(),
                                          );
                                        });
                                        // showDialog(
                                        //   context: context,
                                        //   builder: (context) =>
                                        //       ChangeNotifierProvider(
                                        //     create: (_) =>
                                        //         MarkRoomForMaintenanceProvider(

                                        //         ),
                                        //     child:
                                        //         const SetRoomForMaintenance(),
                                        //   ),
                                        // );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
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
                                            Gap(5),
                                            FittedBox(
                                              child: const Text(
                                                'Set Room for Maintenance',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Gap(30),
                                // Top Cards
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildInfoCard(
                                      icon: Icons.build,
                                      title: 'Rooms Under Maintenance',
                                      count: provider.roomsUnderMaintenance,
                                      subtitle:
                                          'of total ${provider.totalRooms}',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Search Field
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: ColorsRes.btndarkshadow,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        width: 200,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            prefixIcon:
                                                const Icon(Icons.search),
                                            hintText: 'Search by room number',
                                            hintStyle: TextStyle(fontSize: 12),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Gap(10),
                                      // Room Type Dropdown
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: ColorsRes.btndarkshadow,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        width: 200,
                                        child: DropdownButtonFormField<String>(
                                          hint: const Text(
                                            'Filter by room type',
                                            style: TextStyle(fontSize: 12),
                                          ),
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
                                      const Gap(10),
                                      // Status Dropdown
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: ColorsRes.btndarkshadow,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        width: 200,
                                        child: DropdownButtonFormField<String>(
                                          hint: Text(
                                            'Filter by status',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          items: ['Dirty Room', 'Maintenance']
                                              .map((status) => DropdownMenuItem(
                                                  value: status,
                                                  child: Text(status)))
                                              .toList(),
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
                                        icon: const Icon(
                                          Icons.filter_alt,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        label: const Text('Apply Filters',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.normal)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: ColorsRes.cardpurple,
                                          fixedSize: Size(120, 45),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                      const Gap(5),
                                      OutlinedButton(
                                        onPressed: provider.resetFilters,
                                        child: const Text(
                                          'Reset',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 20),
                                          side: const BorderSide(
                                              color: Colors.grey),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: _buildRoomStatusContent(
                                        provider, provideMaintenance),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ])
                    ]))));
  }

// Add this new helper method to your _RoomMaintenanceScreenState class:
  Widget _buildRoomStatusContent(
    MarkDirtyRoomProvider provider,
    MarkRoomForMaintenanceProvider provideMaintenance,
  ) {
    final hasMaintenanceRooms = provideMaintenance.maintenanceRooms.isNotEmpty;
    final hasDirtyRooms = provider.dirtyRoomsList.isNotEmpty;

    if (hasMaintenanceRooms || hasDirtyRooms) {
      return Column(
        children: [
          if (hasMaintenanceRooms)
            Column(
              children: [
                const Text(
                  'Rooms Under Maintenance',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provideMaintenance.maintenanceRooms.length,
                  itemBuilder: (context, index) {
                    final room = provideMaintenance.maintenanceRooms[index];
                    return _buildMaintenanceRoomCard(
                      room,
                      provideMaintenance,
                      index,
                      provideMaintenance.maintenanceRooms.length,
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          if (hasDirtyRooms)
            Column(
              children: [
                const Text(
                  'Dirty Rooms',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.dirtyRoomsList.length,
                  itemBuilder: (context, index) {
                    final room = provider.dirtyRoomsList[index];
                    return _buildDirtyRoomCard(
                      room,
                      provider,
                      index,
                      provider.dirtyRoomsList.length,
                    );
                  },
                ),
              ],
            ),
        ],
      );
    } else {
      return _buildAllRoomsAvailable(provider);
    }
  }

  Widget _buildDirtyRoomCard(MaintenanceRoom room,
      MarkDirtyRoomProvider provider, int index, int totalDirtyRooms) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 300), // Maximum width constraint
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Room Info Row
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Room ${room.roomNumber}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      room.roomTypeName,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const Spacer(), // Pushes the status to the right
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorsRes.bglightgrey,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 16),
                      SizedBox(width: 5),
                      Text('Needs Cleaning', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            const Text(
              '📌 Marked Dirty:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(DateFormat('MMM d, y').format(room.updatedAt)),

            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 16),
                SizedBox(width: 5),
                Text('Cleaning Required', style: TextStyle(fontSize: 12)),
              ],
            ),

            const SizedBox(height: 5),
            const Text(
              'This room requires cleaning before it can be made available.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),

            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: provider.isLoading
                    ? null
                    : () async {
                        try {
                          // Verify a room is selected
                          if (provider.selectedRoom == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a room first'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            return;
                          }

                          // Attempt to make room available
                          // await provider.makeRoomAvailable(context);
                          provider.showDialogBox();
                          showDialog(
                            context: context,
                            builder: (ctx) => const MakeRoomAvailableDialog(
                              roomNumber: "102",
                              roomType: "DELUXE",
                            ),
                          );
                        } catch (e) {
                          // Errors are already handled by the provider
                          // This catch prevents the exception from bubbling up
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  disabledBackgroundColor: Colors.green.withOpacity(0.5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                ),
                child: provider.isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Make Available',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
            ),

            if (index != totalDirtyRooms - 1)
              const Divider(height: 20, thickness: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildMaintenanceRoomCard(MaintenanceRoom room,
      MarkRoomForMaintenanceProvider provider, int index, int totalDirtyRooms) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 300), // Maximum width constraint
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Room Info Row
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Room ${room.roomNumber}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      room.roomTypeName,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const Spacer(), // Pushes the status to the right
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorsRes.bglightgrey,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 16),
                      SizedBox(width: 5),
                      Text('Needs Cleaning', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            const Text(
              '📌 Marked Dirty:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(DateFormat('MMM d, y').format(room.updatedAt)),

            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 16),
                SizedBox(width: 5),
                Text('Cleaning Required', style: TextStyle(fontSize: 12)),
              ],
            ),

            const SizedBox(height: 5),
            const Text(
              'This room requires cleaning before it can be made available.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),

            const SizedBox(height: 10),
            Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: provider.isLoading
                      ? null
                      : () async {
                          if (provider.selectedRoom == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please select a room first')),
                            );
                            return;
                          }

                          try {
                            // Extract the actual room ID from your room object
                            final selectedRoom = provider.allRooms.firstWhere(
                                (room) =>
                                    '${room.roomTypeName} ${room.roomNumber}' ==
                                    provider.selectedRoom,
                                orElse: () =>
                                    throw Exception('Selected room not found'));

                            await provider.makeRoomAvailable(
                                selectedRoom.id, context);
                          } on Exception catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    disabledBackgroundColor: Colors.green.withOpacity(0.5),
                  ),
                  child: provider.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle_outline,
                                color: Colors.white),
                            SizedBox(width: 8),
                            Text('Make Available',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                )),

            if (index != totalDirtyRooms - 1)
              const Divider(height: 20, thickness: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildAllRoomsAvailable(MarkDirtyRoomProvider provider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 60),
        const SizedBox(height: 10),
        const Text(
          'All Rooms Available',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        const Text(
          'There are no rooms under maintenance or requiring cleaning at the moment.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                provider.fetchMaintenanceRooms().then((_) {
                  showDialog(
                    context: context,
                    builder: (context) => const MarkRoomDirtyDialog(),
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.build, size: 15, color: Colors.white),
                  SizedBox(width: 10),
                  Text('Mark Room as Dirty',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: () {
                context
                    .read<MarkRoomForMaintenanceProvider>()
                    .fetchMaintenanceRooms()
                    .then((_) {
                  showDialog(
                    context: context,
                    builder: (context) => const SetRoomForMaintenance(),
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, size: 15, color: Colors.white),
                  SizedBox(width: 10),
                  Text('Set Room for Maintenance',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
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
        padding: const EdgeInsets.all(10),
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
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              '$count',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
