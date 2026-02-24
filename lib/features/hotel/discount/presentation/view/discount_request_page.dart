import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/discount_entity.dart';
import '../providers/discount_providers.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// ---------------------------------------------------------------------------
// Additional providers for UI state (no setState needed)
// ---------------------------------------------------------------------------

/// Tracks which discount IDs are selected via checkboxes
final selectedDiscountIdsProvider =
    StateNotifierProvider<SelectedIdsNotifier, Set<int>>((ref) {
  return SelectedIdsNotifier();
});

class SelectedIdsNotifier extends StateNotifier<Set<int>> {
  SelectedIdsNotifier() : super({});

  void toggle(int id) {
    if (state.contains(id)) {
      state = {...state}..remove(id);
    } else {
      state = {...state, id};
    }
  }

  void toggleAll(List<DiscountEntity> discounts) {
    final ids = discounts.map((d) => d.id!).toSet();
    if (state.containsAll(ids)) {
      state = {};
    } else {
      state = ids;
    }
  }

  void clear() => state = {};
}

// ---------------------------------------------------------------------------
// Page
// ---------------------------------------------------------------------------

class DiscountRequestPage extends ConsumerStatefulWidget {
  const DiscountRequestPage({super.key});

  @override
  ConsumerState<DiscountRequestPage> createState() =>
      _DiscountRequestPageState();
}

class _DiscountRequestPageState extends ConsumerState<DiscountRequestPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        ref.read(discountRequestProvider.notifier).loadAllDiscountRequests());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(discountRequestProvider);
    final controller = ref.read(discountRequestProvider.notifier);
    final selectedIds = ref.watch(selectedDiscountIdsProvider);
    final selectedNotifier = ref.read(selectedDiscountIdsProvider.notifier);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Paginated rows
    final visibleDiscounts =
        state.filteredDiscounts.take(state.rowsPerPage).toList();
    final allSelected = visibleDiscounts.isNotEmpty &&
        visibleDiscounts.every((d) => selectedIds.contains(d.id));

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ────────────────────────────────────────────────────
              _Header(
                onExcelTap: () => _exportToExcel(state.allDiscounts),
                onPdfTap: () => _exportToPDF(state.allDiscounts),
                onPrintTap: () => _exportToPDF(state.allDiscounts),
              ),

              const SizedBox(height: 24),

              // ── Toolbar: search + rows per page ───────────────────────────
              _Toolbar(controller: controller, state: state),

              const SizedBox(height: 16),

              // ── Table ─────────────────────────────────────────────────────
              Expanded(
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          _DiscountTable(
                            discounts: visibleDiscounts,
                            selectedIds: selectedIds,
                            allSelected: allSelected,
                            onToggleAll: () =>
                                selectedNotifier.toggleAll(visibleDiscounts),
                            onToggleOne: selectedNotifier.toggle,
                            ref: ref,
                            controller: controller,
                          ),
                        ],
                      ),
              ),

              const SizedBox(height: 12),

              // ── Footer: pagination info ────────────────────────────────────
              _Footer(state: state),
            ],
          ),
        ),
      ),
    );
  }

  // ── Export helpers ──────────────────────────────────────────────────────

  Future<void> _exportToExcel(List<DiscountEntity> discounts) async {
    final excel = Excel.createExcel();
    final sheet = excel['Discounts'];

    sheet.appendRow([
      "ID",
      "Booking",
      "Customer",
      "Amount",
      "Status",
      "Date",
      "Requested By"
    ]);
    for (var d in discounts) {
      sheet.appendRow([
        d.id,
        d.bookingId,
        " d.customerName" ?? '',
        d.amount,
        d.status ?? '',
        d.dateCreated.toString(),
        "d.requestedBy" ?? '',
      ]);
    }

    final fileBytes = excel.save();
    if (fileBytes == null) return;
    // On mobile/desktop: save to file; on web: trigger download
    // File("discounts.xlsx")..createSync(recursive: true)..writeAsBytesSync(fileBytes);
  }

  Future<void> _exportToPDF(List<DiscountEntity> discounts) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Table.fromTextArray(
          headers: [
            "ID",
            "Booking",
            "Customer",
            "Amount",
            "Status",
            "Date",
            "Requested By"
          ],
          data: discounts
              .map((d) => [
                    d.id.toString(),
                    d.bookingId.toString(),
                    "d.customerName" ?? '',
                    d.amount.toString(),
                    d.status ?? '',
                    d.dateCreated.toString(),
                    " d.requestedBy" ?? '',
                  ])
              .toList(),
        ),
      ),
    );
    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }
}

// ---------------------------------------------------------------------------
// Header
// ---------------------------------------------------------------------------

class _Header extends StatelessWidget {
  const _Header({
    required this.onExcelTap,
    required this.onPdfTap,
    required this.onPrintTap,
  });

  final VoidCallback onExcelTap;
  final VoidCallback onPdfTap;
  final VoidCallback onPrintTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Title
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Discount Requests',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1D23),
                    letterSpacing: -0.5,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              'Manage and review all discount requests',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF6B7280),
                  ),
            ),
          ],
        ),

        const Spacer(),

        // Action buttons
        _ExportButton(
          icon: Icons.table_chart_outlined,
          label: 'Excel',
          color: const Color(0xFF1D6F42),
          onTap: onExcelTap,
        ),
        const SizedBox(width: 8),
        _ExportButton(
          icon: Icons.picture_as_pdf_outlined,
          label: 'PDF',
          color: const Color(0xFFD93025),
          onTap: onPdfTap,
        ),
        const SizedBox(width: 8),
        _ExportButton(
          icon: Icons.print_outlined,
          label: 'Print',
          color: const Color(0xFF1A73E8),
          onTap: onPrintTap,
        ),
      ],
    );
  }
}

class _ExportButton extends StatelessWidget {
  const _ExportButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          child: Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Toolbar
// ---------------------------------------------------------------------------

class _Toolbar extends ConsumerWidget {
  const _Toolbar({required this.controller, required this.state});

  final dynamic controller; // DiscountRequestNotifier
  final dynamic state; // DiscountRequestState

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        // Search
        Expanded(
          child: Container(
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              onChanged: controller.search,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Search by booking, customer, amount…',
                hintStyle: TextStyle(fontSize: 13, color: Colors.grey[400]),
                prefixIcon:
                    Icon(Icons.search, size: 18, color: Colors.grey[400]),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Rows per page
        _RowsPerPageDropdown(state: state, controller: controller),
      ],
    );
  }
}

class _RowsPerPageDropdown extends StatelessWidget {
  const _RowsPerPageDropdown({required this.state, required this.controller});

  final dynamic state;
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    const options = [5, 10, 20, 50];
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: (options.contains(state.rowsPerPage as int)
              ? state.rowsPerPage as int
              : 10),
          items: options
              .map((n) => DropdownMenuItem(
                    value: n,
                    child: Text('$n per page',
                        style: const TextStyle(fontSize: 13)),
                  ))
              .toList(),
          onChanged: (val) {
            if (val != null) controller.setRowsPerPage(val);
          },
          style: const TextStyle(fontSize: 13, color: Color(0xFF1A1D23)),
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Table
// ---------------------------------------------------------------------------

class _DiscountTable extends StatelessWidget {
  const _DiscountTable({
    required this.discounts,
    required this.selectedIds,
    required this.allSelected,
    required this.onToggleAll,
    required this.onToggleOne,
    required this.ref,
    required this.controller,
  });

  final List<DiscountEntity> discounts;
  final Set<int> selectedIds;
  final bool allSelected;
  final VoidCallback onToggleAll;
  final void Function(int id) onToggleOne;
  final WidgetRef ref;
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: discounts.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(48),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.inbox_outlined,
                        size: 48, color: Color(0xFFD1D5DB)),
                    SizedBox(height: 12),
                    Text('No discount requests found',
                        style: TextStyle(color: Color(0xFF9CA3AF))),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: DataTable(
                  headingRowColor:
                      WidgetStateProperty.all(const Color(0xFFF9FAFB)),
                  headingTextStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                    letterSpacing: 0.5,
                  ),
                  dataRowMinHeight: 52,
                  dataRowMaxHeight: 64,
                  dividerThickness: 0.5,
                  columns: [
                    DataColumn(
                      label: Checkbox(
                        value: allSelected,
                        onChanged: (_) => onToggleAll(),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    const DataColumn(label: Text('ID')),
                    const DataColumn(label: Text('BOOKING')),
                    const DataColumn(label: Text('CUSTOMER')),
                    const DataColumn(label: Text('AMOUNT')),
                    const DataColumn(label: Text('STATUS')),
                    const DataColumn(label: Text('DATE')),
                    const DataColumn(label: Text('REQUESTED BY')),
                    const DataColumn(label: Text('ACTIONS')),
                  ],
                  rows: discounts.map((d) {
                    final isSelected = selectedIds.contains(d.id);
                    return DataRow(
                      selected: isSelected,
                      color: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return const Color(0xFFEFF6FF);
                        }
                        return null;
                      }),
                      cells: [
                        // Checkbox
                        DataCell(
                          Checkbox(
                            value: isSelected,
                            onChanged: (_) => onToggleOne(d.id!),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),

                        // ID
                        DataCell(Text(
                          '#${d.id}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Color(0xFF374151),
                          ),
                        )),

                        // Booking
                        DataCell(Text(
                          d.bookingId.toString(),
                          style: const TextStyle(
                              fontSize: 13, color: Color(0xFF374151)),
                        )),

                        // Customer
                        DataCell(_AvatarCell(name: "d.customerName" ?? '—')),

                        // Amount
                        DataCell(Text(
                          '\$${d.amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Color(0xFF111827),
                          ),
                        )),

                        // Status
                        DataCell(_StatusBadge(status: d.status ?? 'unknown')),

                        // Date
                        DataCell(Text(
                          _formatDate(d.dateCreated),
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xFF6B7280)),
                        )),

                        // Requested By
                        DataCell(Text(
                          "d.requestedBy" ?? '—',
                          style: const TextStyle(
                              fontSize: 13, color: Color(0xFF374151)),
                        )),

                        // Actions
                        DataCell(_ActionButtons(
                          discount: d,
                          controller: controller,
                        )),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
    );
  }

  String _formatDate(DateTime? dt) {
    if (dt == null) return '—';
    return '${_month(dt.month)} ${dt.day}, ${dt.year}';
  }

  String _month(int m) => const [
        '',
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ][m];
}

// ---------------------------------------------------------------------------
// Cells
// ---------------------------------------------------------------------------

class _AvatarCell extends StatelessWidget {
  const _AvatarCell({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    final initials = name.isNotEmpty
        ? name.trim().split(' ').map((w) => w[0]).take(2).join().toUpperCase()
        : '?';
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: const Color(0xFFDDD6FE),
          child: Text(
            initials,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xFF6D28D9),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(name,
            style: const TextStyle(fontSize: 13, color: Color(0xFF374151))),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    final (bg, fg, label) = switch (status.toLowerCase()) {
      'approved' => (
          const Color(0xFFD1FAE5),
          const Color(0xFF065F46),
          'Approved'
        ),
      'pending' => (
          const Color(0xFFFEF3C7),
          const Color(0xFF92400E),
          'Pending'
        ),
      'rejected' => (
          const Color(0xFFFEE2E2),
          const Color(0xFF991B1B),
          'Rejected'
        ),
      _ => (const Color(0xFFF3F4F6), const Color(0xFF6B7280), status),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: fg,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({required this.discount, required this.controller});
  final DiscountEntity discount;
  final dynamic controller;

  @override
  Widget build(BuildContext context) {
    final isPending = (discount.status ?? '').toLowerCase() == 'pending';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // View
        _IconAction(
          icon: Icons.visibility_outlined,
          tooltip: 'View',
          color: const Color(0xFF6B7280),
          onTap: () => _showDetailDialog(context, discount),
        ),

        if (isPending) ...[
          const SizedBox(width: 4),
          // Approve
          _IconAction(
            icon: Icons.check_circle_outline,
            tooltip: 'Approve',
            color: const Color(0xFF059669),
            onTap: () => controller.approveDiscount(discount.id),
          ),
          const SizedBox(width: 4),
          // Reject
          _IconAction(
            icon: Icons.cancel_outlined,
            tooltip: 'Reject',
            color: const Color(0xFFDC2626),
            onTap: () => controller.rejectDiscount(discount.id),
          ),
        ],
      ],
    );
  }

  void _showDetailDialog(BuildContext context, DiscountEntity d) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Discount #${d.id}',
            style: const TextStyle(fontWeight: FontWeight.w700)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DetailRow('Booking', d.bookingId.toString()),
            _DetailRow('Customer', "d.customerName" ?? '—'),
            _DetailRow('Amount', '\$${d.amount.toStringAsFixed(2)}'),
            _DetailRow('Status', d.status ?? '—'),
            _DetailRow('Requested By', "d.requestedBy" ?? '—'),
            _DetailRow('Date', d.dateCreated.toString()),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7280))),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 13, color: Color(0xFF111827))),
          ),
        ],
      ),
    );
  }
}

class _IconAction extends StatelessWidget {
  const _IconAction({
    required this.icon,
    required this.tooltip,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Icon(icon, size: 16, color: color),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Footer
// ---------------------------------------------------------------------------

class _Footer extends StatelessWidget {
  const _Footer({required this.state});
  final dynamic state;

  @override
  Widget build(BuildContext context) {
    final total = (state.filteredDiscounts as List).length;
    final showing = total.clamp(0, state.rowsPerPage as int);

    return Row(
      children: [
        Text(
          'Showing $showing of $total results',
          style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
        ),
      ],
    );
  }
}
