import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/constants/colors/spotstock_colors.dart';
import '../../../domain/entities/bed_type.dart';
import '../../providers/bed_types_provider.dart';

class BedTypesPage extends ConsumerStatefulWidget {
  const BedTypesPage({super.key});

  @override
  ConsumerState<BedTypesPage> createState() => _BedTypesPageState();
}

class _BedTypesPageState extends ConsumerState<BedTypesPage> {
  final searchController = TextEditingController();

  void showBedTypeDialog({BedType? bedType}) {
    final nameCtrl = TextEditingController(text: bedType?.name ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(bedType == null ? 'Add Bed Type' : 'Edit Bed Type'),
        content: SizedBox(
          width: 300,
          child: TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(labelText: 'Bed Type Name'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final controller = ref.read(bedTypesControllerProvider.notifier);
              print(nameCtrl.text);
              if (bedType == null) {
                await controller.addBedType(nameCtrl.text);
              } else {
                await controller.updateBedType(
                    id: bedType.id, name: nameCtrl.text);
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void showDeleteDialog(BedType bedType) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Bed Type'),
        content: const Text('Are you sure you want to delete this bed type?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: SpotstockColors.red),
            onPressed: () {
              ref
                  .read(bedTypesControllerProvider.notifier)
                  .deleteBedType(bedType.id!);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bedTypesControllerProvider);
    final bedTypes = state.bedTypes;

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
                const Text('Bed Types',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  onPressed: () => showBedTypeDialog(),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Bed Type'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /// SEARCH
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search bed types...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => ref
                  .read(bedTypesControllerProvider.notifier)
                  .searchByName(value),
            ),
            const SizedBox(height: 20),

            /// TABLE
            Expanded(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        itemCount: bedTypes.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final bedType = bedTypes[index];
                          return ListTile(
                            title: Text(bedType.name),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: SpotstockColors.blue),
                                  onPressed: () =>
                                      showBedTypeDialog(bedType: bedType),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: SpotstockColors.red),
                                  onPressed: () => showDeleteDialog(bedType),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
