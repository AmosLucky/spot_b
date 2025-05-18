import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/provider/attendant_model.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';

class SelectAttendantDialog extends StatefulWidget {
  final SystemProvider systemProvider;
  final Function(AttendantModel) onAttendantSelected;

  const SelectAttendantDialog({
    super.key,
    required this.systemProvider,
    required this.onAttendantSelected,
  });

  @override
  State<SelectAttendantDialog> createState() => _SelectAttendantDialogState();
}

class _SelectAttendantDialogState extends State<SelectAttendantDialog> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load attendants when dialog opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AttendantProvider>().loadAttendants(widget.systemProvider);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Attendant',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Search field
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search attendant...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
              onChanged: (value) {
                context.read<AttendantProvider>().searchAttendants(value);
              },
            ),
            const SizedBox(height: 20),

            // Attendants list
            Expanded(
              child: Consumer<AttendantProvider>(
                builder: (context, attendantProvider, child) {
                  if (attendantProvider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (attendantProvider.attendants.isEmpty) {
                    return const Center(
                      child: Text(
                        'No attendants found',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: attendantProvider.attendants.length,
                    itemBuilder: (context, index) {
                      final attendant = attendantProvider.attendants[index];
                      return _buildAttendantItem(context, attendant);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendantItem(BuildContext context, AttendantModel attendant) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          // Select the attendant and close this dialog
          Navigator.of(context).pop();
          widget.onAttendantSelected(attendant);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              attendant.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              attendant.department,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              attendant.hasPinSet ? 'PIN set' : 'No PIN set',
              style: TextStyle(
                fontSize: 12,
                color: attendant.hasPinSet ? Colors.green : Colors.orange,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}