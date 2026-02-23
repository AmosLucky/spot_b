import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/credit_request_entity.dart';
import '../providers/credit_providers.dart';

/// ===============================
/// SELECTED IDS PROVIDER
/// ===============================

final selectedCreditIdsProvider =
    StateNotifierProvider<SelectedCreditIdsNotifier, Set<int>>(
        (ref) => SelectedCreditIdsNotifier());

class SelectedCreditIdsNotifier extends StateNotifier<Set<int>> {
  SelectedCreditIdsNotifier() : super({});

  void toggle(int id) {
    if (state.contains(id)) {
      state = {...state}..remove(id);
    } else {
      state = {...state, id};
    }
  }

  void toggleAll(List<CreditRequestEntity> credits) {
    final ids = credits.map((c) => c.id).whereType<int>().toSet();

    if (state.containsAll(ids)) {
      state = {};
    } else {
      state = ids;
    }
  }

  void clear() => state = {};
}

/// ===============================
/// MAIN PAGE
/// ===============================




  class CreditRequestPage extends ConsumerStatefulWidget {
  const CreditRequestPage({super.key});

  @override
  ConsumerState<CreditRequestPage> createState() =>
      _CreditRequestPage();
}

class _CreditRequestPage extends ConsumerState<CreditRequestPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        ref.read(creditControllerProvider.notifier).loadAllCredits());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(creditControllerProvider);
    final controller = ref.read(creditControllerProvider.notifier);

    final selectedIds = ref.watch(selectedCreditIdsProvider);
    final selectedNotifier = ref.read(selectedCreditIdsProvider.notifier);

    final visibleCredits =
        state.filteredCredits.take(state.rowsPerPage).toList();

    final allSelected = visibleCredits.isNotEmpty &&
        visibleCredits.every((c) => selectedIds.contains(c.id));

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                onExcelTap: () => _exportToExcel(state.credits),
                onPdfTap: () => _exportToPDF(state.credits),
              ),
              const SizedBox(height: 20),
              _Toolbar(controller: controller, state: state),
              const SizedBox(height: 16),
              Expanded(
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _CreditTable(
                        credits: visibleCredits,
                        selectedIds: selectedIds,
                        allSelected: allSelected,
                        onToggleAll: () =>
                            selectedNotifier.toggleAll(visibleCredits),
                        onToggleOne: selectedNotifier.toggle,
                        controller: controller,
                      ),
              ),
              const SizedBox(height: 12),
              _Footer(state: state),
            ],
          ),
        ),
      ),
    );
  }
}

/// ===============================
/// HEADER
/// ===============================

class _Header extends StatelessWidget {
  final VoidCallback onExcelTap;
  final VoidCallback onPdfTap;

  const _Header({
    required this.onExcelTap,
    required this.onPdfTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Credit Requests",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Manage and review credit applications",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        Row(
          children: [
            _ActionButton(
              label: "Excel",
              icon: Icons.table_chart_outlined,
              color: Colors.green,
              onTap: onExcelTap,
            ),
            const SizedBox(width: 12),
            _ActionButton(
              label: "PDF",
              icon: Icons.picture_as_pdf_outlined,
              color: Colors.red,
              onTap: onPdfTap,
            ),
          ],
        )
      ],
    );
  }
}

/// ===============================
/// TOOLBAR
/// ===============================

class _Toolbar extends StatelessWidget {
  final dynamic controller;
  final dynamic state;

  const _Toolbar({
    required this.controller,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: controller.search,
            decoration: InputDecoration(
              hintText: "Search credits...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        DropdownButton<int>(
          value: state.rowsPerPage,
          items: const [
            DropdownMenuItem(value: 5, child: Text("5")),
            DropdownMenuItem(value: 10, child: Text("10")),
            DropdownMenuItem(value: 20, child: Text("20")),
          ],
          onChanged: (value) {
            if (value != null) {
              controller.setRowsPerPage(value);
            }
          },
        )
      ],
    );
  }
}

/// ===============================
/// CREDIT TABLE
/// ===============================

class _CreditTable extends StatelessWidget {
  final List<CreditRequestEntity> credits;
  final Set<int> selectedIds;
  final bool allSelected;
  final VoidCallback onToggleAll;
  final Function(int) onToggleOne;
  final dynamic controller;

  const _CreditTable({
    required this.credits,
    required this.selectedIds,
    required this.allSelected,
    required this.onToggleAll,
    required this.onToggleOne,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 2,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Checkbox(
                    value: allSelected,
                    onChanged: (_) => onToggleAll(),
                  ),
                ),
                const DataColumn(label: Text("ID")),
                const DataColumn(label: Text("Booking")),
                const DataColumn(label: Text("Amount")),
                const DataColumn(label: Text("Status")),
                const DataColumn(label: Text("Date")),
                const DataColumn(label: Text("Actions")),
              ],
              rows: credits.map((c) {
                return DataRow(
                  selected: selectedIds.contains(c.id),
                  cells: [
                    DataCell(
                      Checkbox(
                        value: selectedIds.contains(c.id),
                        onChanged: (_) => onToggleOne(c.id!),
                      ),
                    ),
                    DataCell(Text('#${c.id}')),
                    DataCell(Text(c.bookingId.toString())),
                    DataCell(Text('\$${c.amount.toStringAsFixed(2)}')),
                    DataCell(_StatusBadge(status: c.status)),
                    DataCell(Text(c.dateCreated.toString())),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check, color: Colors.green),
                            onPressed: () => controller.approveCredit(c),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () => controller.rejectCredit(c),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

/// ===============================
/// FOOTER
/// ===============================

class _Footer extends StatelessWidget {
  final dynamic state;

  const _Footer({required this.state});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Showing ${state.filteredCredits.length} results",
      style: const TextStyle(color: Colors.grey),
    );
  }
}

/// ===============================
/// STATUS BADGE
/// ===============================

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;

    switch (status.toLowerCase()) {
      case "approved":
        color = Colors.green;
        break;
      case "rejected":
        color = Colors.red;
        break;
      default:
        color = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(color: color),
      ),
    );
  }
}

/// ===============================
/// ACTION BUTTON
/// ===============================

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}

/// ===============================
/// EXPORT STUBS
/// ===============================

Future<void> _exportToExcel(List<CreditRequestEntity> credits) async {
  debugPrint("Exporting ${credits.length} credits to Excel");
}

Future<void> _exportToPDF(List<CreditRequestEntity> credits) async {
  debugPrint("Exporting ${credits.length} credits to PDF");
}
