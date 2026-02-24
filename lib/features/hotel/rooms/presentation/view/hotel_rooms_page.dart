import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/constants/colors/spotstock_colors.dart';
import '../../../room_types/presentation/providers/room_type_provider.dart';
import '../../domain/entities/room_entity.dart';
import '../providers/room_providers.dart';
import 'widgets/create_room_dialog.dart';

class HotelRoomsPage extends ConsumerStatefulWidget {
  const HotelRoomsPage({super.key});

  @override
  ConsumerState<HotelRoomsPage> createState() => _HotelRoomsPageState();
}

class _HotelRoomsPageState extends ConsumerState<HotelRoomsPage> {
  final searchController = TextEditingController();
  // String _selectedFilter = 'All';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ---------------- DELETE DIALOG ----------------

  void showDeleteDialog(RoomEntity room) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: SpotstockColors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.delete_outline,
                  color: SpotstockColors.red,
                  size: 48,
                ),
              ),
              const SizedBox(height: 20),

              // Title
              const Text(
                'Delete Room',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // Message
              Text(
                'Are you sure you want to delete room ${room.roomNumber}? This action cannot be undone.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),

              // Actions
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey.shade700,
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: SpotstockColors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                      ),
                      onPressed: () {
                        ref
                            .read(roomControllerProvider.notifier)
                            .deleteRoom(room.id!);
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Room ${room.roomNumber} deleted'),
                            backgroundColor: SpotstockColors.green,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(roomControllerProvider);
    final controller = ref.read(roomControllerProvider.notifier);
    final roomTypes = ref.watch(roomTypeControllerProvider).roomTypes;

    // Filter rooms based on status
    final filteredRooms = state.selectedFilter == 'All'
        ? state.filtered
        : state.filtered
            .where((room) => room.status == state.selectedFilter)
            .toList();

    // Statistics
    // Statistics
    final totalRooms = state.all.length;
    final activeRooms =
        state.all.where((r) => r.status.toLowerCase() == 'active').length;
    final dirtyRooms =
        state.all.where((r) => r.status.toLowerCase() == 'dirty').length;
    final maintenanceRooms =
        state.all.where((r) => r.status.toLowerCase() == 'maintenance').length;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hotel Rooms',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Manage and monitor your room inventory',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () => showCreateRoomDialog(context, ref),
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text(
                    'Create Room',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: SpotstockColors.c473069,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// STATISTICS CARDS
            Row(
              children: [
                _buildStatCard(
                  'Total Rooms',
                  totalRooms.toString(),
                  Icons.meeting_room,
                  SpotstockColors.c473069,
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  'Active',
                  activeRooms.toString(),
                  Icons.check_circle,
                  SpotstockColors.green,
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  'Dirty',
                  dirtyRooms.toString(),
                  Icons.cleaning_services,
                  SpotstockColors.orange,
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  'Maintenance',
                  maintenanceRooms.toString(),
                  Icons.build,
                  SpotstockColors.red,
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// MAIN CONTENT CARD
            Expanded(
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      /// SEARCH AND FILTER BAR
                      Row(
                        children: [
                          // Search
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                hintText: 'Search by room number...',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey.shade400,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade50,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade200,
                                  ),
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
                              onChanged: controller.search,
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Filter Dropdown
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: DropdownButton<String>(
                              value: state.selectedFilter,
                              underline: const SizedBox(),
                              icon: Icon(
                                Icons.filter_list,
                                color: SpotstockColors.c473069,
                              ),
                              items: ['All', 'Active', 'Dirty', 'Maintenance']
                                  .map((filter) {
                                return DropdownMenuItem(
                                  value: filter,
                                  child: Text(
                                    filter,
                                    style: TextStyle(
                                      fontWeight: state.selectedFilter == filter
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                controller.setSelectedFilter(value);
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      /// TABLE
                      Expanded(
                        child: state.isLoading
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: SpotstockColors.c473069,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Loading rooms...',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : filteredRooms.isEmpty
                                ? _buildEmptyState(ref)
                                : Column(
                                    children: [
                                      // Table Header
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                          horizontal: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'ROOM NUMBER',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey.shade700,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'ROOM TYPE',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey.shade700,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'STATUS',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey.shade700,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 80,
                                              child: Text(
                                                'ACTIONS',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Table Rows
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: filteredRooms.length,
                                          itemBuilder: (_, index) {
                                            final room = filteredRooms[index];
                                            final type = roomTypes.firstWhere(
                                              (t) => t.id == room.roomTypeId,
                                              orElse: () => roomTypes.first,
                                            );

                                            return _buildRoomRow(
                                              room,
                                              type.name,
                                              index,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomRow(RoomEntity room, String roomTypeName, int index) {
    final controller = ref.read(roomControllerProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: index.isEven ? Colors.white : Colors.grey.shade50,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          /// ROOM NUMBER
          Expanded(
            flex: 2,
            child: Row(
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
                const SizedBox(width: 12),
                Text(
                  room.roomNumber,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          /// ROOM TYPE
          Expanded(
            flex: 2,
            child: Text(
              roomTypeName,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
          ),

          /// STATUS
          Expanded(
            flex: 2,
            child: _buildStatusBadge(room.status),
          ),

          /// ACTIONS
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Edit Button
                IconButton(
                  icon: Icon(
                    Icons.edit_outlined,
                    size: 20,
                    color: Colors.grey.shade600,
                  ),
                  onPressed: () {
                    showCreateRoomDialog(
                      context,
                      ref,
                      room: room,
                    );
                  },
                  tooltip: 'Edit',
                  splashRadius: 20,
                ),

                // More Options
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'delete') {
                      showDeleteDialog(room);
                    } else {
                      controller.updateRoom(
                        room.copyWith(status: value),
                      );
                    }
                  },
                  itemBuilder: (_) => [
                    _buildPopupMenuItem(
                      'Active',
                      Icons.check_circle,
                      SpotstockColors.green,
                    ),
                    _buildPopupMenuItem(
                      'Dirty',
                      Icons.cleaning_services,
                      SpotstockColors.orange,
                    ),
                    _buildPopupMenuItem(
                      'Maintenance',
                      Icons.build,
                      SpotstockColors.red,
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline,
                            size: 18,
                            color: SpotstockColors.red,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Delete',
                            style: TextStyle(
                              color: SpotstockColors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  icon: Icon(
                    Icons.more_vert,
                    size: 20,
                    color: Colors.grey.shade600,
                  ),
                  splashRadius: 20,
                  offset: const Offset(0, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(
    String label,
    IconData icon,
    Color color,
  ) {
    return PopupMenuItem(
      value: label,
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 12),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;
    IconData icon;

    switch (status) {
      case 'Active':
        backgroundColor = SpotstockColors.green.withOpacity(0.1);
        textColor = SpotstockColors.green;
        icon = Icons.check_circle;
        break;
      case 'Dirty':
        backgroundColor = SpotstockColors.orange.withOpacity(0.1);
        textColor = SpotstockColors.orange;
        icon = Icons.cleaning_services;
        break;
      case 'Maintenance':
        backgroundColor = SpotstockColors.red.withOpacity(0.1);
        textColor = SpotstockColors.red;
        icon = Icons.build;
        break;
      default:
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade700;
        icon = Icons.info;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(
              color: textColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No rooms found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            ref.read(roomControllerProvider).selectedFilter == 'All'
                ? 'Try adjusting your search'
                : 'No rooms with status ',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 24),
          TextButton.icon(
            onPressed: () {
              ref
                  .read(roomControllerProvider.notifier)
                  .setSelectedFilter("All");
              searchController.clear();

              ref.read(roomControllerProvider.notifier).search('');
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Clear Filters'),
            style: TextButton.styleFrom(
              foregroundColor: SpotstockColors.c473069,
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Active':
        return SpotstockColors.green;
      case 'Dirty':
        return SpotstockColors.orange;
      case 'Maintenance':
        return SpotstockColors.red;
      default:
        return SpotstockColors.c4D2B5B;
    }
  }
}
