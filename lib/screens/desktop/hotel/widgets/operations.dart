import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/helpers/colors_res.dart';
import 'package:spotstock_inventory/screens/desktop/hotel/widgets/operations_provider.dart';
import 'package:spotstock_inventory/screens/desktop/hotel/widgets/room_transfer.dart';

class OperationsScreen extends StatelessWidget {
  Future<void> _selectDate(BuildContext context) async {
    final provider = Provider.of<OperationsProvider>(context, listen: false);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: provider.selectedDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      provider.setDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            _buildExpandableTile(context, 'Extend Booking', 'extendBooking',
                Icons.calendar_today),
            // _buildExpandableTile(
            //     context, 'Room Transfer', 'roomTransfer', Icons.sync_alt),
            RoomTransferScreen(),
            _buildExpandableTile(context, 'Add Room', 'addRoom', Icons.add),
            _buildCheckout(context, 'Checkout', 'checkout', Icons.logout),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableTile(
      BuildContext context, String title, String key, IconData icon) {
    final provider = Provider.of<OperationsProvider>(context);
    final isExpanded = provider.expandedStates[key]!;

    return Card(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
          initiallyExpanded: isExpanded,
          onExpansionChanged: (_) => provider.toggleExpanded(key),
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDateSelector(
                          context, 'Start Date', provider.startDate, (date) {
                        provider.setStartDate(date);
                      }),
                      // const SizedBox(width: 10),
                      _buildDateSelector(context, 'End Date', provider.endDate,
                          (date) {
                        provider.setEndDate(date);
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: const RoomTypeSelector(label: 'Choose Room Type'),
                ),
                Gap(10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 200,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: ColorsRes.cardpurple,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          size: 13,
                          color: Colors.white,
                        ),
                        Text(
                          'Search Available Rooms',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(10)
              ],
            ),
            // const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckout(
      BuildContext context, String title, String key, IconData icon) {
    final provider = Provider.of<OperationsProvider>(context);
    final isExpanded = provider.expandedStates[key]!;
    // DateTime? selectedDate;
    final selectedDate = provider.selectedDate;

    return Card(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
          initiallyExpanded: isExpanded,
          onExpansionChanged: (_) => provider.toggleExpanded(key),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: ColorsRes.cardyellow,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Important: Checking out will mark the booking as completed and set all rooms to maintenance status. Any\noutstanding balance must be collected before checkout.',
                        style: TextStyle(
                          fontSize: 10,
                          // fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(10),
                Text(
                  'Checkout Date',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                ),
                Gap(5),
                Text(
                  'Actual Checkout Date',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                ),
                Gap(5),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorsRes.grey),
                      borderRadius: BorderRadius.circular(5)),
                  child: GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        decoration: InputDecoration(
                          constraints: BoxConstraints(maxHeight: 15),
                          hintText: 'Select Checkout Date',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            size: 10,
                          ),
                        ),
                        controller: TextEditingController(
                          text: selectedDate != null
                              ? "${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.year}"
                              : '',
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(1),
                Text(
                  'Default is today. Select a different date for early checkout.',
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  'Billing Summary',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                ),
                Gap(10),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorsRes.grey),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Booking Total:',
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            'N64500.00',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Premium Services:',
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            'N15000.00',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tax Charges:',
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            'N0.00',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                      Divider(
                        color: ColorsRes.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount:',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'N64500.00',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Paid Amount:',
                            style: TextStyle(
                              fontSize: 10,
                              // fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'N64500.00',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: ColorsRes.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Refund Amount:',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'N0.00',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: ColorsRes.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Gap(10),
                Text(
                  'Checkout Notes',
                  style: TextStyle(fontSize: 10),
                ),
                Gap(10),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: ColorsRes.grey,
                      )),
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Enter any note about the checkout',
                      hintStyle: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
                Gap(10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 200,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.indeterminate_check_box,
                          size: 13,
                          color: Colors.white,
                        ),
                        Gap(10),
                        Text(
                          'Complete Checkout',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(10)
              ],
            ),
            // const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context, String label,
      DateTime? selectedDate, Function(DateTime?) onDateSelected) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 4),
          Container(
            height: 25,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              onTap: () async {
                final pickedDate = await showDialog(
                  context: context,
                  builder: (context) => DatePickerDialog(
                    initialDate: selectedDate ?? DateTime.now(),
                  ),
                );
                if (pickedDate != null) {
                  onDateSelected(pickedDate);
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate != null
                          ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
                          : 'Select Date',
                      style: TextStyle(
                        color:
                            selectedDate != null ? Colors.black : Colors.grey,
                      ),
                    ),
                    const Icon(Icons.calendar_today, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Stateless widget using Provider
class RoomTypeSelector extends StatelessWidget {
  final String? label;

  const RoomTypeSelector({super.key, this.label = 'Room Type'});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OperationsProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!),
          const SizedBox(height: 4),
        ],
        Container(
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButton<String>(
            value: provider.selectedRoomType,
            isExpanded: true,
            underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down),
            hint: const Text('Select Room Type'),
            items: provider.roomTypes.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              provider.setRoomType(newValue);
            },
          ),
        ),
      ],
    );
  }
}

class DatePickerDialog extends StatelessWidget {
  final DateTime initialDate;

  const DatePickerDialog({super.key, required this.initialDate});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Date',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildMonthHeader(context),
            const SizedBox(height: 8),
            _buildWeekdaysHeader(),
            const SizedBox(height: 8),
            _buildCalendarGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthHeader(BuildContext context) {
    final provider = Provider.of<OperationsProvider>(context);
    final monthYear =
        '${_getMonthName(provider.currentMonth.month)} ${provider.currentMonth.year}';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            provider.setCurrentMonth(
              DateTime(
                  provider.currentMonth.year, provider.currentMonth.month - 1),
            );
          },
        ),
        Text(
          monthYear,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            provider.setCurrentMonth(
              DateTime(
                  provider.currentMonth.year, provider.currentMonth.month + 1),
            );
          },
        ),
      ],
    );
  }

  Widget _buildWeekdaysHeader() {
    const weekdays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

    return Row(
      children: weekdays.map((day) {
        return Expanded(
          child: Center(
            child: Text(
              day,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCalendarGrid(BuildContext context) {
    final provider = Provider.of<OperationsProvider>(context);
    final firstDayOfMonth =
        DateTime(provider.currentMonth.year, provider.currentMonth.month, 1);
    final daysInMonth =
        DateTime(provider.currentMonth.year, provider.currentMonth.month + 1, 0)
            .day;
    final weekdayOfFirstDay = firstDayOfMonth.weekday % 7; // Sunday = 0

    final days = <Widget>[];
    // Add empty cells for days before the first day of the month
    for (var i = 0; i < weekdayOfFirstDay; i++) {
      days.add(const Expanded(child: SizedBox()));
    }

    // Add cells for each day of the month
    for (var day = 1; day <= daysInMonth; day++) {
      final date = DateTime(
          provider.currentMonth.year, provider.currentMonth.month, day);
      final isSelected = (provider.startDate != null &&
              _isSameDate(provider.startDate!, date)) ||
          (provider.endDate != null && _isSameDate(provider.endDate!, date));

      days.add(
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context, date);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    day.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Create rows of 7 days each
    final rows = <Widget>[];
    for (var i = 0; i < days.length; i += 7) {
      final rowChildren =
          days.sublist(i, i + 7 > days.length ? days.length : i + 7);
      rows.add(Row(children: rowChildren));
    }

    return Column(children: rows);
  }

  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  String _getMonthName(int month) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[month - 1];
  }
}
