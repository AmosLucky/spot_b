import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../amenities/presentation/providers/amenities_provider.dart';
import '../../../bed_type/presentation/providers/bed_types_provider.dart';
import '../../../facilities/presentation/providers/facilities_provider.dart';
import '../providers/room_type_provider.dart';

class RoomTypesPage extends ConsumerWidget {
  const RoomTypesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(roomTypeControllerProvider);
    final controller = ref.read(roomTypeControllerProvider.notifier);

    final amenities = ref.watch(amenitiesControllerProvider).amenities;
    final facilities = ref.watch(facilitiesControllerProvider).facilities;
    final bedTypes = ref.watch(bedTypesControllerProvider).bedTypes;

    return Scaffold(
      appBar: AppBar(title: const Text('Room Types')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(24),
              child: ListView(
                children: [
                  const Text('Amenities'),
                  Wrap(
                    spacing: 8,
                    children: amenities.map((a) {
                      final selected =
                          state.selectedAmenityIds.contains(a.id);
                      return FilterChip(
                        label: Text(a.name),
                        selected: selected,
                        onSelected: (_) => controller.toggleAmenity(a.id!),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),
                  const Text('Facilities'),
                  Wrap(
                    spacing: 8,
                    children: facilities.map((f) {
                      final selected =
                          state.selectedFacilityIds.contains(f.id);
                      return FilterChip(
                        label: Text(f.name),
                        selected: selected,
                        onSelected: (_) => controller.toggleFacility(f.id!),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),
                  const Text('Bed Types'),
                  Wrap(
                    spacing: 8,
                    children: bedTypes.map((b) {
                      final selected =
                          state.selectedBedTypeIds.contains(b.id);
                      return FilterChip(
                        label: Text(b.name),
                        selected: selected,
                        onSelected: (_) => controller.toggleBedType(b.id!),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
    );
  }
}
