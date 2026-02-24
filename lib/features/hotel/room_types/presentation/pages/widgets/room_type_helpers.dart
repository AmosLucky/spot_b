import 'package:flutter/material.dart';

/// ---------------- HELPERS ----------------

Widget input(TextEditingController c, String label, {bool enabled = true}) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: c,
        enabled: enabled,
        decoration: InputDecoration(labelText: label),
      ),
    );

Widget number(TextEditingController c, String label,
        {bool enabled = true, Function(String)? onChanged}) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: c,
        enabled: enabled,
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        decoration: InputDecoration(labelText: label),
      ),
    );

Widget textarea(TextEditingController c, String label) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: c,
        maxLines: 3,
        decoration: InputDecoration(labelText: label),
      ),
    );

Widget chipGroup(
  List items,
  List<int> selected,
  Function(int, bool) onToggle,
) =>
    Wrap(
      spacing: 8,
      children: items.map<Widget>((e) {
        final isSelected = selected.contains(e.id);
        return FilterChip(
          label: Text(e.name),
          selected: isSelected,
          onSelected: (val) => onToggle(e.id!, val),
        );
      }).toList(),
    );
