import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'action_button.dart';


class PaymentToolbar extends ConsumerWidget {
  final Function(String) onSearch;
  final VoidCallback onExportExcel;
  final VoidCallback onExportPdf;
  final VoidCallback onPrintAll;
  final int rowsPerPage;
  final Function(int?) onRowsChanged;

  const PaymentToolbar({
    required this.onSearch,
    required this.onExportExcel,
    required this.onExportPdf,
    required this.onPrintAll,
    required this.rowsPerPage,
    required this.onRowsChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [

        /// SEARCH
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search booking, customer, amount...",
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: onSearch,
          ),
        ),

        const SizedBox(width: 20),

        /// ROWS PER PAGE
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<int>(
            value: rowsPerPage,
            underline: const SizedBox(),
            items: const [
              DropdownMenuItem(value: 5, child: Text("5 per page")),
              DropdownMenuItem(value: 10, child: Text("10 per page")),
              DropdownMenuItem(value: 20, child: Text("20 per page")),
            ],
            onChanged: onRowsChanged,
          ),
        ),

        const SizedBox(width: 16),

        ActionButton(icon: Icons.download, label: "Excel", onTap: onExportExcel),
        const SizedBox(width: 8),
        ActionButton(icon: Icons.picture_as_pdf, label: "PDF", onTap: onExportPdf),
        const SizedBox(width: 8),
        ActionButton(icon: Icons.print, label: "Print", onTap: onPrintAll),
      ],
    );
  }

 



}