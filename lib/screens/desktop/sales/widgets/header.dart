import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';

class SalesHeader extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final Function(DateTime) onDateSelected; // Callback to pass selected date

  const SalesHeader({
    super.key,
    required this.user,
    required this.systemProvider,
    required this.onDateSelected, // Required callback function
  });

  @override
  _SalesHeaderState createState() => _SalesHeaderState();
}

class _SalesHeaderState extends State<SalesHeader> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
      widget.onDateSelected(pickedDate); // Pass the selected date to parent
    }
  }

  String getFormattedDate() {
    if (_selectedDate != null) {
      return DateFormat('MMM d, yyyy').format(_selectedDate!);
    }
    return 'Select Date';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sales',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        getFormattedDate(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
