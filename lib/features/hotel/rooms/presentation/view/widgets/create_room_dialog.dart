import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../room_types/presentation/providers/room_type_provider.dart';
import '../../../domain/entities/room_entity.dart';
import '../../providers/room_providers.dart';


// void showCreateRoomDialog(BuildContext context, WidgetRef ref) {
//   final roomController = ref.read(roomControllerProvider.notifier);
//   final roomTypes = ref.read(roomTypeControllerProvider).roomTypes;

//   final List<TextEditingController> roomCtrls = [
//     TextEditingController()
//   ];

//   int? selectedRoomTypeId;
//   String status = 'Active';

//   showDialog(
//     context: context,
//     builder: (_) {
//       return AlertDialog(
//         title: const Text('Create Room'),
//         content: StatefulBuilder(
//           builder: (context, setState) {
//             return SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('Room Numbers *'),
//                   ...roomCtrls.map(
//                     (c) => Padding(
//                       padding: const EdgeInsets.only(top: 8),
//                       child: TextField(
//                         controller: c,
//                         decoration: const InputDecoration(
//                           hintText: 'Enter room number',
//                         ),
//                       ),
//                     ),
//                   ),
//                   TextButton.icon(
//                     onPressed: () {
//                       setState(() {
//                         roomCtrls.add(TextEditingController());
//                       });
//                     },
//                     icon: const Icon(Icons.add),
//                     label: const Text('Add Room Number'),
//                   ),
//                   const SizedBox(height: 16),

//                   const Text('Room Type *'),
//                   DropdownButtonFormField<int>(
//                     items: roomTypes
//                         .map(
//                           (r) => DropdownMenuItem(
//                             value: r.id,
//                             child: Text(r.name),
//                           ),
//                         )
//                         .toList(),
//                     onChanged: (v) => selectedRoomTypeId = v,
//                     hint: const Text('Select room type'),
//                   ),

//                   const SizedBox(height: 16),

//                   const Text('Status *'),
//                   DropdownButton<String>(
//                     value: status,
//                     items: const [
//                       DropdownMenuItem(value: 'Active', child: Text('Active')),
//                       DropdownMenuItem(
//                           value: 'Inactive', child: Text('Inactive')),
//                     ],
//                     onChanged: (v) => setState(() => status = v!),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               await roomController.addRooms(
//                 roomNumbers:
//                     roomCtrls.map((e) => e.text.trim()).toList(),
//                 roomTypeId: selectedRoomTypeId!,
//                 status: status.toLowerCase(),
//               );
//               Navigator.pop(context);
//             },
//             child: const Text('Save'),
//           ),
//         ],
//       );
//     },
//   );
// }


void showCreateRoomDialog(
  BuildContext context,
  WidgetRef ref, {
  RoomEntity? room,
}) {
  final roomController = ref.read(roomControllerProvider.notifier);
  final roomTypes = ref.read(roomTypeControllerProvider).roomTypes;

  /// Room number controllers
  final List<TextEditingController> roomCtrls = [
    TextEditingController(text: room?.roomNumber ?? '')
  ];

  /// Initial values (for EDIT)
  int? selectedRoomTypeId = room?.roomTypeId;
  String status = room?.status ?? 'active';
  String availability = room?.bookingStatus ?? 'available';

  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text(room == null ? 'Create Room' : 'Edit Room'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ROOM NUMBER
                  const Text('Room Number *'),
                  const SizedBox(height: 6),
                  ...roomCtrls.map(
                    (c) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TextField(
                        controller: c,
                        decoration: const InputDecoration(
                          hintText: 'Enter room number',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),

                  /// ADD MULTIPLE ROOMS (CREATE ONLY)
                  if (room == null)
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          roomCtrls.add(TextEditingController());
                        });
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Room Number'),
                    ),

                  const SizedBox(height: 16),

                  /// ROOM TYPE
                  const Text('Room Type *'),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<int>(
                    value: selectedRoomTypeId,
                    items: roomTypes
                        .map(
                          (r) => DropdownMenuItem(
                            value: r.id,
                            child: Text(r.name),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => selectedRoomTypeId = v,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Select room type',
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// STATUS (Active / Inactive)
                  const Text('Status *'),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    value: status,
                    items: const [
                      DropdownMenuItem(
                          value: 'active', child: Text('Active')),
                      DropdownMenuItem(
                          value: 'inactive', child: Text('Inactive')),
                    ],
                    onChanged: (v) => setState(() => status = v!),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// AVAILABILITY (Available / Booked)
                  const Text('Availability *'),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<String>(
                    value: availability,
                    items: const [
                      DropdownMenuItem(
                          value: 'available', child: Text('Available')),
                      DropdownMenuItem(
                          value: 'booked', child: Text('Booked')),
                    ],
                    onChanged: (v) => setState(() => availability = v!),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),

          /// SAVE BUTTON
          ElevatedButton(
            onPressed: () async {
              if (selectedRoomTypeId == null) return;

              /// CREATE
              if (room == null) {
                await roomController.addRooms(
                  roomNumbers:
                      roomCtrls.map((e) => e.text.trim()).toList(),
                  roomTypeId: selectedRoomTypeId!,
                  status: status,
                 // bookingStatus: availability,
                );
              }

              /// UPDATE
              else {
                await roomController.updateRoom(
                  room.copyWith(
                    roomNumber: roomCtrls.first.text.trim(),
                    roomTypeId: selectedRoomTypeId!,
                    status: status,
                   // bookingStatus: availability,
                  ),
                );
              }

              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}

