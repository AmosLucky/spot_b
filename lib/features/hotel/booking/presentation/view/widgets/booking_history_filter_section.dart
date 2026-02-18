import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/constants/colors/spotstock_colors.dart';
import '../../controllers/booking_history_controller.dart';
import '../../state/booking_history_state.dart';

class BookingHistoryFilterSection extends ConsumerWidget {
  final BookingHistoryState state;
  final BookingHistoryController controller;

  const BookingHistoryFilterSection({
    super.key,
    required this.state,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: SpotstockColors.c4D2B5B.withOpacity(.25),
        ),
      ),
      child: Column(
        children: [
          _searchField(),
          const SizedBox(height: 14),
          _dateFilters(context),
          const SizedBox(height: 14),
          _statusFilters(),
        ],
      ),
    );
  }

  // ---------------- SEARCH ----------------

  Widget _searchField() {
    return TextField(
      onChanged: controller.updateSearch,
      decoration: InputDecoration(
        hintText: "Search by booking #",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: SpotstockColors.c4D2B5B),
        ),
      ),
    );
  }

  // ---------------- DATE RANGE ----------------

  Widget _dateFilters(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _dateButton(
            context,
            label: "Date From",
            date: state.dateFrom,
            onPick: (date) =>
                controller.updateDateRange(date, state.dateTo),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _dateButton(
            context,
            label: "Date To",
            date: state.dateTo,
            onPick: (date) =>
                controller.updateDateRange(state.dateFrom, date),
          ),
        ),
      ],
    );
  }

  Widget _dateButton(
    BuildContext context, {
    required String label,
    required DateTime? date,
    required Function(DateTime) onPick,
  }) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime(2100),
          initialDate: date ?? DateTime.now(),
        );

        if (picked != null) onPick(picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          date == null
              ? label
              : "${date.year}-${date.month}-${date.day}",
          style: TextStyle(
            color: date == null ? Colors.grey : Colors.black,
          ),
        ),
      ),
    );
  }

  // ---------------- STATUS DROPDOWNS ----------------

  Widget _statusFilters() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _dropdown(
                label: "Status",
                value: state.status,
                items: const ['all', 'active', 'canceled'],
                onChanged: (v) => controller.updateStatus(status: v),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _dropdown(
                label: "Payment",
                value: state.paymentStatus,
                items: const ['all', 'partial', 'fully_paid'],
                onChanged: (v) =>
                    controller.updateStatus(paymentStatus: v),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _dropdown(
                label: "Check In",
                value: state.checkInStatus,
                items: const ['all', 'checked_in', 'not_checked_in'],
                onChanged: (v) =>
                    controller.updateStatus(checkInStatus: v),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _dropdown(
                label: "Check Out",
                value: state.checkOutStatus,
                items: const ['all', 'checked_out', 'not_checked_out'],
                onChanged: (v) =>
                    controller.updateStatus(checkOutStatus: v),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _dropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (v) => onChanged(v!),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: SpotstockColors.c4D2B5B),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
