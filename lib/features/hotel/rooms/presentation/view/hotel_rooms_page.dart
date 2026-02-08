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

  // ---------------- DELETE DIALOG ----------------

  void showDeleteDialog(RoomEntity room) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Room'),
        content: const Text('Are you sure you want to delete this room?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: SpotstockColors.red,
            ),
            onPressed: () {
              ref
                  .read(roomControllerProvider.notifier)
                  .deleteRoom(room.id!);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(roomControllerProvider);
    final controller = ref.read(roomControllerProvider.notifier);
    final roomTypes = ref.watch(roomTypeControllerProvider).roomTypes;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hotel Rooms',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () => showCreateRoomDialog(context, ref),
                  icon: const Icon(Icons.add),
                  label: const Text('Create Room'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// CONTENT CARD
            Expanded(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      /// SEARCH
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search rooms...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onChanged: controller.search,
                      ),

                      const SizedBox(height: 20),

                      /// TABLE HEADER
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: SpotstockColors.grey300,
                            ),
                          ),
                        ),
                        child: Row(
                          children: const [
                            Expanded(flex: 2, child: Text('Room Number')),
                            Expanded(flex: 2, child: Text('Room Type')),
                            Expanded(flex: 2, child: Text('Status')),
                            Expanded(flex: 1, child: Text('Actions')),
                          ],
                        ),
                      ),

                      /// LIST
                      Expanded(
                        child: state.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                itemCount: state.filtered.length,
                                itemBuilder: (_, index) {
                                  final room = state.filtered[index];
                                  final type = roomTypes.firstWhere(
                                    (t) => t.id == room.roomTypeId,
                                    orElse: () => roomTypes.first,
                                  );

                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: SpotstockColors.grey200,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        /// ROOM NUMBER
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            room.roomNumber,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),

                                        /// ROOM TYPE
                                        Expanded(
                                          flex: 2,
                                          child: Text(type.name),
                                        ),

                                        /// STATUS
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            room.status,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: _statusColor(room.status),
                                            ),
                                          ),
                                        ),

                                        /// ACTIONS
                                        Expanded(
                                          flex: 1,
                                          child: PopupMenuButton<String>(
                                            onSelected: (value) {
                                              if (value == 'edit') {
                                                showCreateRoomDialog(
                                                  context,
                                                  ref,
                                                  room: room,
                                                );
                                              } else if (value == 'delete') {
                                                showDeleteDialog(room);
                                              } else {
                                                controller.updateRoom(
                                                  room.copyWith(status: value),
                                                );
                                              }
                                            },
                                            itemBuilder: (_) => [
                                              const PopupMenuItem(
                                                value: 'edit',
                                                child: Text('Edit'),
                                              ),
                                              const PopupMenuItem(
                                                value: 'Active',
                                                child: Text('Mark Active'),
                                              ),
                                              const PopupMenuItem(
                                                value: 'Dirty',
                                                child: Text('Mark Dirty'),
                                              ),
                                              const PopupMenuItem(
                                                value: 'Maintenance',
                                                child:
                                                    Text('Mark Maintenance'),
                                              ),
                                              const PopupMenuDivider(),
                                              const PopupMenuItem(
                                                value: 'delete',
                                                child: Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                    color:
                                                        SpotstockColors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                            icon: const Icon(Icons.more_vert),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
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
