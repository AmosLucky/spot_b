import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spotstock_inventory/core/presentation/dates/datetime_extension.dart';

import 'spotstock_textfield.dart';

class SpotstockDatePickerConstants {
  static DateTime firstDate = DateTime(2000);
  static DateTime lastDate = DateTime(2100);
}

class SpotstockDatePickerField extends StatefulWidget {
  final String? hintText;
  final DateTime? initialDate;
  final Function(DateTime) onDateSelected;

  const SpotstockDatePickerField({
    super.key,
    required this.onDateSelected,
    this.hintText,
    this.initialDate,
  });

  @override
  State<SpotstockDatePickerField> createState() => _SpotstockDatePickerFieldState();
}

class _SpotstockDatePickerFieldState extends State<SpotstockDatePickerField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialDate?.toFormattedDate() ?? '';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? DateTime.now(),
      firstDate: SpotstockDatePickerConstants.firstDate,
      lastDate: SpotstockDatePickerConstants.lastDate,
    );

    if (picked != null) {
      _controller.text = picked.toFormattedDate();
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SpotstockTextField(
      readOnly: true,
      controller: _controller,
      hintText: widget.hintText,
      onTap: () => _selectDate(context),
    );
  }
}
