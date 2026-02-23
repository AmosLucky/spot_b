import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../room_types/presentation/providers/room_type_provider.dart';
import '../../../domain/entities/room_entity.dart';
import '../../providers/room_providers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import your entities and providers
// import 'your_room_entity_path.dart';
// import 'your_room_controller_provider.dart';
// import 'your_room_type_provider.dart';

void showCreateRoomDialog(
  BuildContext context,
  WidgetRef ref, {
  RoomEntity? room,
}) {
  final roomController = ref.read(roomControllerProvider.notifier);
  final roomTypes = ref.read(roomTypeControllerProvider).roomTypes;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => _CreateRoomDialog(
      roomController: roomController,
      roomTypes: roomTypes,
      room: room,
    ),
  );
}

class _CreateRoomDialog extends StatefulWidget {
  final dynamic roomController;
  final List<dynamic> roomTypes;
  final RoomEntity? room;

  const _CreateRoomDialog({
    required this.roomController,
    required this.roomTypes,
    this.room,
  });

  @override
  State<_CreateRoomDialog> createState() => _CreateRoomDialogState();
}

class _CreateRoomDialogState extends State<_CreateRoomDialog> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _roomControllers = [];

  int? _selectedRoomTypeId;
  String _status = 'active';
  String _availability = 'available';
  bool _isSubmitting = false;

  // Primary color
  static const Color _primaryColor = Color(0xFFC473069);

  @override
  void initState() {
    super.initState();

    // Initialize with existing room data or empty
    _roomControllers.add(
      TextEditingController(text: widget.room?.roomNumber ?? ''),
    );
    _selectedRoomTypeId = widget.room?.roomTypeId;
    _status = widget.room?.status ?? 'active';
    _availability = widget.room?.bookingStatus ?? 'available';
  }

  @override
  void dispose() {
    for (var controller in _roomControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addRoomField() {
    setState(() {
      _roomControllers.add(TextEditingController());
    });
  }

  void _removeRoomField(int index) {
    if (_roomControllers.length > 1) {
      setState(() {
        _roomControllers[index].dispose();
        _roomControllers.removeAt(index);
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedRoomTypeId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a room type'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      if (widget.room == null) {
        // CREATE
        await widget.roomController.addRooms(
          roomNumbers: _roomControllers
              .map((e) => e.text.trim())
              .where((text) => text.isNotEmpty)
              .toList(),
          roomTypeId: _selectedRoomTypeId!,
          status: _status,
        );
      } else {
        // UPDATE
        await widget.roomController.updateRoom(
          widget.room!.copyWith(
            roomNumber: _roomControllers.first.text.trim(),
            roomTypeId: _selectedRoomTypeId!,
            status: _status,
          ),
        );
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.room == null
                  ? 'Room(s) created successfully'
                  : 'Room updated successfully',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.room != null;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: _primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      isEditing ? Icons.edit : Icons.add_business,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isEditing ? 'Edit Room' : 'Create Room',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isEditing
                              ? 'Update room information'
                              : 'Add new room(s) to your inventory',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Body
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Room Numbers Section
                      _buildSectionTitle(
                        'Room Number(s)',
                        Icons.meeting_room,
                      ),
                      const SizedBox(height: 12),

                      ..._roomControllers.asMap().entries.map((entry) {
                        final index = entry.key;
                        final controller = entry.value;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                    hintText: 'e.g., 101, 102, A-205',
                                    prefixIcon: Icon(
                                      Icons.door_front_door_outlined,
                                      color: _primaryColor,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: _primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade50,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Room number is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              if (!isEditing &&
                                  _roomControllers.length > 1) ...[
                                const SizedBox(width: 8),
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => _removeRoomField(index),
                                  tooltip: 'Remove',
                                ),
                              ],
                            ],
                          ),
                        );
                      }),

                      // Add Room Button (Create mode only)
                      if (!isEditing)
                        OutlinedButton.icon(
                          onPressed: _addRoomField,
                          icon: const Icon(Icons.add),
                          label: const Text('Add Another Room'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: _primaryColor,
                            side: BorderSide(color: _primaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),

                      const SizedBox(height: 24),

                      // Room Type Section
                      _buildSectionTitle('Room Type', Icons.category),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<int>(
                        initialValue: _selectedRoomTypeId,
                        decoration: InputDecoration(
                          hintText: 'Select room type',
                          prefixIcon: Icon(
                            Icons.bed_outlined,
                            color: _primaryColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: _primaryColor,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        items: widget.roomTypes
                            .map(
                              (roomType) => DropdownMenuItem<int>(
                                value: roomType.id,
                                child: Text(roomType.name),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() => _selectedRoomTypeId = value);
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a room type';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),

                      // Status & Availability Row
                      Row(
                        children: [
                          // Status
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSectionTitle('Status', Icons.toggle_on),
                                const SizedBox(height: 12),
                                DropdownButtonFormField<String>(
                                  initialValue: _status,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      _status == 'active'
                                          ? Icons.check_circle
                                          : Icons.cancel,
                                      color: _status == 'active'
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: _primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade50,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'active',
                                      child: Text('Active'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'inactive',
                                      child: Text('Inactive'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() => _status = value!);
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Availability
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSectionTitle(
                                  'Availability',
                                  Icons.event_available,
                                ),
                                const SizedBox(height: 12),
                                DropdownButtonFormField<String>(
                                  initialValue: _availability,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      _availability == 'available'
                                          ? Icons.check_circle
                                          : Icons.block,
                                      color: _availability == 'available'
                                          ? Colors.blue
                                          : Colors.red,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: _primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade50,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'available',
                                      child: Text('Available'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'booked',
                                      child: Text('Booked'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() => _availability = value!);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Footer Actions
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed:
                        _isSubmitting ? null : () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey.shade700,
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      elevation: 0,
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isEditing ? Icons.save : Icons.add,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                isEditing ? 'Update Room' : 'Create Room',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: _primaryColor),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          '*',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}


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




