import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchWithDateFilter extends StatefulWidget {
  final String title;
  final TextEditingController searchController;
  final Function(String?) onChanged;
  final VoidCallback onClear;
  final Function(DateTimeRange) onDateRangeSelected;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final DateTimeRange? initialDateRange;

  const SearchWithDateFilter({
    super.key,
    required this.title,
    required this.searchController,
    required this.onChanged,
    required this.onClear,
    required this.onDateRangeSelected,
    this.hintText = 'Search...',
    this.prefixIcon = Icons.search,
    this.suffixIcon = Icons.cancel,
    this.backgroundColor,
    this.textStyle,
    this.initialDateRange,
  });

  @override
  _SearchWithDateFilterState createState() => _SearchWithDateFilterState();
}

class _SearchWithDateFilterState extends State<SearchWithDateFilter> {
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _selectedDateRange = widget.initialDateRange ??
        DateTimeRange(
          start: DateTime.now().subtract(const Duration(days: 7)),
          end: DateTime.now(),
        );
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? pickedDateRange = await showDateRangePicker(
      context: context,
      saveText: 'Apply',
      initialDateRange: _selectedDateRange,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (pickedDateRange != null) {
      setState(() {
        _selectedDateRange = pickedDateRange;
      });
      widget.onDateRangeSelected(pickedDateRange);
    }
  }

  String getFormattedDateRange() {
    final formatter = DateFormat('MMM d, yyyy');
    return _selectedDateRange != null
        ? '${formatter.format(_selectedDateRange!.start)} - ${formatter.format(_selectedDateRange!.end)}'
        : 'Select Date Range';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: widget.searchController,
                  onChanged: widget.onChanged,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    prefixIcon: widget.prefixIcon != null
                        ? Icon(widget.prefixIcon)
                        : null,
                    suffixIcon: widget.suffixIcon != null
                        ? GestureDetector(
                            onTap: widget.onClear,
                            child: Icon(widget.suffixIcon,
                                color: Colors.deepPurple),
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300), // Updated color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 2), // Active focus color
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300), // Default border color
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () => _selectDateRange(context),
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        widget.backgroundColor ?? Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        "Filter",
                        style:
                            widget.textStyle ?? const TextStyle(fontSize: 16),
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
