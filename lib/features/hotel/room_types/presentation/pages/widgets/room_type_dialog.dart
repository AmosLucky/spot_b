import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/constants/colors/spotstock_colors.dart';
import '../../../../amenities/presentation/providers/amenities_provider.dart';
import '../../../../bed_type/presentation/providers/bed_types_provider.dart';
import '../../../../facilities/presentation/providers/facilities_provider.dart';
import '../../../domain/entities/room_type_entities.dart';
import '../../providers/room_type_provider.dart';

// ============================================================
// ROOM TYPE DIALOG WIDGET
// ============================================================

class RoomTypeDialog extends ConsumerStatefulWidget {
  final RoomTypeEntity? roomType;
  final WidgetRef ref;

  const RoomTypeDialog({
    this.roomType,
    required this.ref,
  });

  @override
  ConsumerState<RoomTypeDialog> createState() => _RoomTypeDialogState();
}

class _RoomTypeDialogState extends ConsumerState<RoomTypeDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _adultsCtrl;
  late TextEditingController _childrenCtrl;
  late TextEditingController _bedsCtrl;
  late TextEditingController _fareCtrl;
  late TextEditingController _keywordsCtrl;
  late TextEditingController _descriptionCtrl;
  late TextEditingController _cancelFeeCtrl;
  late TextEditingController _cancelPolicyCtrl;

  //bool _isActive = true;
  // bool _isSubmitting = false;

  // List<int> _selectedAmenityIds = [];
  // List<int> _selectedFacilityIds = [];
  // List<int> _selectedBedTypeIds = [];

  @override
  void initState() {
    super.initState();
    final roomType = widget.roomType;

    _nameCtrl = TextEditingController(text: roomType?.name ?? '');
    _adultsCtrl =
        TextEditingController(text: roomType?.totalAdults.toString() ?? '1');
    _childrenCtrl =
        TextEditingController(text: roomType?.totalChildren.toString() ?? '0');
    _bedsCtrl =
        TextEditingController(text: roomType?.totalBeds.toString() ?? '0');
    _fareCtrl = TextEditingController(text: roomType?.fare.toString() ?? '0');
    _keywordsCtrl = TextEditingController(text: roomType?.keywords ?? '');
    _descriptionCtrl = TextEditingController(text: roomType?.description ?? '');
    _cancelFeeCtrl = TextEditingController(
        text: roomType?.cancellationFee.toString() ?? '0');
    _cancelPolicyCtrl =
        TextEditingController(text: roomType?.cancellationPolicy ?? '');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final controller = ref.read(roomTypeControllerProvider.notifier);
        controller.initForm(
          selectedAmenityIds: widget.roomType?.amenityIds.toList() ?? [],
          selectedBedTypeIds: widget.roomType?.bedTypeIds.toList() ?? [],
          selectedFacilityIds: widget.roomType?.facilityIds.toList() ?? [],
        );
      }
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _adultsCtrl.dispose();
    _childrenCtrl.dispose();
    _bedsCtrl.dispose();
    _fareCtrl.dispose();
    _keywordsCtrl.dispose();
    _descriptionCtrl.dispose();
    _cancelFeeCtrl.dispose();
    _cancelPolicyCtrl.dispose();
    super.dispose();
  }

  void _updateBeds() {
    final adults = int.tryParse(_adultsCtrl.text) ?? 0;
    final children = int.tryParse(_childrenCtrl.text) ?? 0;
    _bedsCtrl.text = (adults + children).toString();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    if (ref.read(roomTypeControllerProvider).selectedBedTypeIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Select at least one bed type'),
          backgroundColor: SpotstockColors.red,
        ),
      );
      return;
    }

    try {
      final controller = widget.ref.read(roomTypeControllerProvider.notifier);

      final entity = RoomTypeEntity(
        id: widget.roomType?.id,
        name: _nameCtrl.text.trim(),
        totalAdults: int.parse(_adultsCtrl.text),
        totalChildren: int.tryParse(_childrenCtrl.text) ?? 0,
        totalBeds: int.parse(_bedsCtrl.text),
        fare: double.parse(_fareCtrl.text),
        keywords: _keywordsCtrl.text.trim(),
        description: _descriptionCtrl.text.trim(),
        cancellationFee: double.tryParse(_cancelFeeCtrl.text) ?? 0,
        cancellationPolicy: _cancelPolicyCtrl.text.trim(),
        amenityIds: ref.read(roomTypeControllerProvider).selectedAmenityIds,
        facilityIds: ref.read(roomTypeControllerProvider).selectedFacilityIds,
        bedTypeIds: ref.read(roomTypeControllerProvider).selectedBedTypeIds,
        isActive: ref.read(roomTypeControllerProvider).isActive,
      );

      widget.roomType == null
          ? await controller.addRoomType(entity)
          : await controller.updateRoomType(entity);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.roomType == null
                  ? 'Room type created successfully'
                  : 'Room type updated successfully',
            ),
            backgroundColor: SpotstockColors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: SpotstockColors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.roomType != null;
    final amenities = ref.read(amenitiesControllerProvider).amenities;
    final facilities = ref.read(facilitiesControllerProvider).facilities;
    final bedTypes = ref.read(bedTypesControllerProvider).bedTypes;
    final roomTypeState = ref.watch(roomTypeControllerProvider);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        constraints: const BoxConstraints(maxWidth: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: SpotstockColors.c473069,
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
                          isEditing ? 'Edit Room Type' : 'Add Room Type',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isEditing
                              ? 'Update room type information'
                              : 'Configure a new room category',
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
                      // Basic Information
                      _buildSectionTitle('Basic Information', Icons.info),
                      const SizedBox(height: 16),

                      _buildTextField(
                        controller: _nameCtrl,
                        label: 'Name',
                        hint: 'e.g., Deluxe Suite',
                        icon: Icons.label,
                        validator: (v) => v?.trim().isEmpty ?? true
                            ? 'Name is required'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      _buildTextField(
                        controller: _descriptionCtrl,
                        label: 'Description',
                        hint: 'Describe this room type',
                        icon: Icons.description,
                        maxLines: 3,
                        validator: (v) => v?.trim().isEmpty ?? true
                            ? 'Description is required'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      _buildTextField(
                        controller: _keywordsCtrl,
                        label: 'Keywords',
                        hint: 'luxury, spacious, ocean view (comma separated)',
                        icon: Icons.local_offer,
                      ),

                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 24),

                      // Capacity
                      _buildSectionTitle('Capacity', Icons.people),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            child: _buildNumberField(
                              controller: _adultsCtrl,
                              label: 'Adults',
                              icon: Icons.person,
                              onChanged: (_) => _updateBeds(),
                              validator: (v) {
                                final val = int.tryParse(v ?? '0') ?? 0;
                                return val < 1 ? 'Min 1 adult' : null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildNumberField(
                              controller: _childrenCtrl,
                              label: 'Children',
                              icon: Icons.child_care,
                              onChanged: (_) => _updateBeds(),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildNumberField(
                              controller: _bedsCtrl,
                              label: 'Beds',
                              icon: Icons.bed,
                              enabled: false,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 24),

                      // Pricing
                      _buildSectionTitle('Pricing', Icons.attach_money),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: _fareCtrl,
                              label: 'Fare per Night',
                              hint: '0.00',
                              icon: Icons.money,
                              keyboardType: TextInputType.number,
                              validator: (v) {
                                final val = double.tryParse(v ?? '0') ?? 0;
                                return val <= 0 ? 'Fare must be > 0' : null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              controller: _cancelFeeCtrl,
                              label: 'Cancellation Fee',
                              hint: '0.00',
                              icon: Icons.money_off,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      _buildTextField(
                        controller: _cancelPolicyCtrl,
                        label: 'Cancellation Policy',
                        hint: 'Describe the cancellation terms',
                        icon: Icons.policy,
                        maxLines: 2,
                        validator: (v) => v?.trim().isEmpty ?? true
                            ? 'Policy is required'
                            : null,
                      ),

                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 24),

                      // Bed Types
                      _buildSectionTitle('Bed Types', Icons.bed,
                          required: true),
                      const SizedBox(height: 12),
                      _buildChipGroup(
                        items: bedTypes,
                        selectedIds: roomTypeState.selectedBedTypeIds,
                        onChanged: (id, value) {
                          ref
                              .read(roomTypeControllerProvider.notifier)
                              .toggleBedType(id);
                        },
                      ),

                      const SizedBox(height: 24),

                      // Amenities
                      _buildSectionTitle('Amenities', Icons.star),
                      const SizedBox(height: 12),
                      _buildChipGroup(
                        items: amenities,
                        selectedIds: roomTypeState.selectedAmenityIds,
                        onChanged: (id, value) {
                          ref
                              .read(roomTypeControllerProvider.notifier)
                              .toggleAmenity(id);
                        },
                      ),

                      const SizedBox(height: 24),

                      // Facilities
                      _buildSectionTitle('Facilities', Icons.business),
                      const SizedBox(height: 12),
                      _buildChipGroup(
                        items: facilities,
                        selectedIds: roomTypeState.selectedFacilityIds,
                        onChanged: (id, value) {
                          ref
                              .read(roomTypeControllerProvider.notifier)
                              .toggleFacility(id);
                        },
                      ),

                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 24),

                      // Status
                      _buildSectionTitle('Status', Icons.toggle_on),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: SwitchListTile(
                          value: roomTypeState.isActive,
                          onChanged: (value) {
                            ref
                                .read(roomTypeControllerProvider.notifier)
                                .toggleIsActive();
                          },
                          title: Text(
                            roomTypeState.isActive ? 'Active' : 'Inactive',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            roomTypeState.isActive
                                ? 'This room type is available for booking'
                                : 'This room type is hidden from guests',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          activeColor: SpotstockColors.c473069,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
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
                    onPressed: () => Navigator.pop(context),
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
                    onPressed: _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SpotstockColors.c473069,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isEditing ? Icons.save : Icons.add,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isEditing ? 'Update' : 'Create',
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

  Widget _buildSectionTitle(String title, IconData icon,
      {bool required = false}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: SpotstockColors.c473069),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        if (required) ...[
          const SizedBox(width: 4),
          const Text(
            '*',
            style: TextStyle(
              color: SpotstockColors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: SpotstockColors.c473069),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: SpotstockColors.c473069, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
    );
  }

  Widget _buildNumberField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool enabled = true,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: SpotstockColors.c473069),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: SpotstockColors.c473069, width: 2),
        ),
        filled: true,
        fillColor: enabled ? Colors.grey.shade50 : Colors.grey.shade100,
      ),
      keyboardType: TextInputType.number,
      validator: validator,
      onChanged: onChanged,
    );
  }

  Widget _buildChipGroup({
    required List<dynamic> items,
    required List<int> selectedIds,
    required void Function(int, bool) onChanged,
  }) {
    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'No items available',
          style: TextStyle(color: Colors.grey.shade500),
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        final isSelected = selectedIds.contains(item.id);
        return FilterChip(
          label: Text(item.name),
          selected: isSelected,
          onSelected: (value) => onChanged(item.id, value),
          backgroundColor: Colors.grey.shade100,
          selectedColor: SpotstockColors.c473069.withOpacity(0.2),
          checkmarkColor: SpotstockColors.c473069,
          labelStyle: TextStyle(
            color: isSelected ? SpotstockColors.c473069 : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color:
                  isSelected ? SpotstockColors.c473069 : Colors.grey.shade300,
            ),
          ),
        );
      }).toList(),
    );
  }
}
