import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final String Function(T) getItemLabel;
  final void Function(T?) onChanged;
  final Color? dropdownColor;
  final String? hintText;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.getItemLabel,
    required this.onChanged,
    this.selectedItem,
    this.dropdownColor,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      isExpanded: true,
      value: selectedItem,
      dropdownColor: dropdownColor,
      hint: hintText != null ? Text(hintText!) : null,
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(getItemLabel(item)),
        );
      }).toList(),
      onChanged: onChanged,
      icon: const Icon(Icons.arrow_drop_down),
    );
  }
}
