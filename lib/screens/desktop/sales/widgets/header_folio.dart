import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/primary_text_field.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';

class HeaderFolio extends StatefulWidget {
  final UserDetails user;
  final String title;
  final SystemProvider systemProvider;
  final Function(DateTimeRange)
      onDateRangeSelected; // Callback to pass selected date range
  final TextEditingController searchController;
  final Function(String?) onChanged;
  final VoidCallback onTap;

  const HeaderFolio({
    super.key,
    required this.title,
    required this.user,
    required this.systemProvider,
    required this.onDateRangeSelected, // Required callback function
    required this.searchController,
    required this.onChanged,
    required this.onTap,
  });

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<HeaderFolio> {
  DateTimeRange? _selectedDateRange;

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? pickedDateRange = await showDateRangePicker(
        context: context,
        helpText: 'Select Date',
        saveText: 'Fetch Report',
        initialDateRange: _selectedDateRange ??
            DateTimeRange(
              start: DateTime.now().subtract(const Duration(days: 7)),
              end: DateTime.now(),
            ),
        firstDate: DateTime(2020),
        lastDate: DateTime(2101),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.only(
                      right: 150,
                    ), // Adjust spacing
                  ),
                ),
              ),
              child: child!);
        });
    if (pickedDateRange != null && pickedDateRange != _selectedDateRange) {
      setState(() {
        _selectedDateRange = pickedDateRange;
      });
      widget.onDateRangeSelected(
          pickedDateRange); // Pass the selected date range to parent
    }
  }

  String getFormattedDateRange() {
    if (_selectedDateRange != null) {
      final DateFormat formatter = DateFormat('MMM d, yyyy');
      return '${formatter.format(_selectedDateRange!.start)} - ${formatter.format(_selectedDateRange!.end)}';
    }
    return 'Select Date Range';
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
              Text(
                widget.title,
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: PrimaryTextField(
                  controller: widget.searchController,
                  hintText: 'Search folio by booking ID',
                  title: '',
                  onChanged: widget.onChanged,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    onTap: widget.onTap,
                    child: const Icon(
                      Icons.cancel,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  _selectDateRange(context);
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
                        getFormattedDateRange(),
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
