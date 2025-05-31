import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';

import '../../../../widgets/custom_dropdown.dart';

class Header extends StatefulWidget {
  final UserDetails user;
  final String title;
  final SystemProvider systemProvider;
  final Function(DateTimeRange)
      onDateRangeSelected; // Callback to pass selected date range

  const Header({
    super.key,
    required this.title,
    required this.user,
    required this.systemProvider,
    required this.onDateRangeSelected, // Required callback function
  });

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  DateTimeRange? _selectedDateRange;
  Map? selectedRange;
  String hintValue = '';
  DateTimeRange? pickedDateRange;

  List ranges = [

    {'date' : DateTimeRange(
      start: DateUtils.dateOnly(DateTime.now().subtract(Duration(days: 1))),
      end: DateTime.now()
    ), 'label': 'Today'},
    {
      "date" : DateTimeRange(
      start: DateUtils.dateOnly(DateTime.now().subtract(const Duration(days: 2))),
    end: DateUtils.dateOnly(DateTime.now().subtract(Duration(days: 1)))), "label": "Yesterday",
    },
    {
      "date" : DateTimeRange(
        start: DateUtils.dateOnly(DateTime.now().subtract(const Duration(days: 7))),
        end: DateUtils.dateOnly(DateTime.now()),
      ), "label": "7 days ago"
    },

    {
      "date" : DateTimeRange(
        start: DateUtils.dateOnly(DateTime.now().subtract(const Duration(days: 30))),
        end: DateUtils.dateOnly(DateTime.now()),), "label" : "30 days ago"
    }

  ];

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? pickedDateRange = await showDateRangePicker(
      context: context,
      saveText: 'Fetch Report',
      initialDateRange: _selectedDateRange ??
          DateTimeRange(
            start: DateTime.now().subtract(const Duration(days: 7)),
            end: DateTime.now(),
          ),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
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
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),

              SizedBox(width: 5.w,),

              Expanded(
                child: CustomDropdown(
                  items: ranges,
                  selectedItem: selectedRange,
                  getItemLabel: (item) => item['label'],
                  onChanged: (value) {
                    setState(() {
                      hintValue = value['label'];
                      print("hint value ==>> $hintValue");
                    });
                    if (value['date'] != null) {
                      setState(() {
                        _selectedDateRange = value['date'];
                      });
                      print("date range ==>> $_selectedDateRange");
                      widget.onDateRangeSelected(
                          _selectedDateRange!); // Pass the selected date range to parent
                    }
                  },
                  hintText: hintValue == '' ? "Selected a date range" : hintValue,
                  dropdownColor: Colors.white,
                ),),

              SizedBox(width: 5.w,),

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
