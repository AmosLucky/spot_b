import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../room_types/presentation/providers/room_type_provider.dart';
import '../providers/booking_provider.dart';
import '../state/booking_state.dart';
import 'widgets/bookin_ confirmation_dialog.dart';

class BookingPage extends ConsumerWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bookingControllerProvider);

    ref.listen(bookingControllerProvider, (previous, next) {
      if (next.error != null && next.error != previous?.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
        ref.read(bookingControllerProvider.notifier).clearError();
      }

      if (next.successMessage != null &&
          next.successMessage != previous?.successMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.successMessage!),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 4),
          ),
        );
        ref.read(bookingControllerProvider.notifier).clearSuccess();
        // Optionally navigate back or to a confirmation page
      }
    });

    return Scaffold(
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchCard(context, ref, state),
                  if (state.hasSearched) ...[
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: _buildDaySelectionCard(ref, state),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: _buildSummaryCard(ref, state, context),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
    );
  }

  Widget _buildSearchCard(
      BuildContext context, WidgetRef ref, BookingState state) {
    final controller = ref.read(bookingControllerProvider.notifier);
    final roomTypeState = ref.watch(roomTypeControllerProvider);
    final bookingState = ref.watch(bookingControllerProvider);
    // Ensure default is set once data loads
    ref.listen(roomTypeControllerProvider, (_, next) {
      if (next.roomTypes.isNotEmpty) {
        controller.setDefaultRoomTypeIfNeeded();
      }
    });

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Room Search',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Check-in & Check-out Dates
            Row(
              children: [
                Expanded(
                  child: _buildDateField(
                    context: context,
                    label: 'Check-in Date',
                    selectedDate: state.checkInDate,
                    onDateSelected: (date) => controller.setCheckInDate(date),
                    firstDate: DateTime.now(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDateField(
                    context: context,
                    label: 'Check-out Date',
                    selectedDate: state.checkOutDate,
                    onDateSelected: (date) => controller.setCheckOutDate(date),
                    firstDate: state.checkInDate ?? DateTime.now(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: // Room Type
                      _buildDropdownField(
                    label: 'Room Type',
                    value: bookingState.roomType,
                    items: roomTypeState.roomTypes,
                    itemLabel: (item) => item.name,
                    onChanged: (value) {
                      if (value != null) {
                        controller.setRoomType(value);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildNumberField(
                    label: 'Number of Rooms',
                    value: state.numberOfRooms,
                    onChanged: (value) => controller.setNumberOfRooms(value),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Customer ID (for now, using a number field - can be replaced with customer dropdown)
            // _buildCustomerField(
            //   label: 'Customer ID',
            //   value: state.customerId,
            //   onChanged: (value) => controller.setCustomerId(value),
            // ),
            // const SizedBox(height: 16),

            // Number of Rooms

            // const SizedBox(height: 16),

            // Adults and Children
            Row(
              children: [
                Expanded(
                  child: _buildNumberField(
                    label: 'Adults',
                    value: state.adults,
                    onChanged: (value) => controller.setAdults(value),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildNumberField(
                    label: 'Children',
                    value: state.children,
                    onChanged: (value) => controller.setChildren(value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Search Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => controller.searchRooms(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Search Rooms',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField({
    required BuildContext context,
    required String label,
    required DateTime? selectedDate,
    required Function(DateTime) onDateSelected,
    required DateTime firstDate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? firstDate,
              firstDate: firstDate,
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) {
              onDateSelected(date);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate != null
                      ? DateFormat('MM/dd/yyyy').format(selectedDate)
                      : 'Select date',
                  style: TextStyle(
                    color: selectedDate != null ? Colors.black : Colors.grey,
                  ),
                ),
                const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField<T>({
    required String label,
    required T? value,
    required List<T> items,
    required String Function(T) itemLabel,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonFormField<T>(
      //value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<T>(
              value: item,
              child: Text(itemLabel(item)),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildNumberField({
    required String label,
    required int value,
    required Function(int) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: value > 0 ? () => onChanged(value - 1) : null,
                icon: const Icon(Icons.remove),
              ),
              Expanded(
                child: Text(
                  value.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              IconButton(
                onPressed: () => onChanged(value + 1),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerField({
    required String label,
    required int? value,
    required Function(int) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: value?.toString() ?? '',
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            hintText: 'Enter customer ID',
          ),
          onChanged: (val) {
            final parsed = int.tryParse(val);
            if (parsed != null) {
              onChanged(parsed);
            }
          },
        ),
      ],
    );
  }

  Widget _buildDaySelectionCard(WidgetRef ref, BookingState state) {
    final controller = ref.read(bookingControllerProvider.notifier);

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Day Selection',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Click on available rooms to select them for each day of your stay.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 16),

            // Legend
            _buildLegend(),
            const SizedBox(height: 16),

            // Day list
            ...state.bookingDays.map((day) {
              final nextDay = day.add(const Duration(days: 1));
              final selectedCount = controller.getSelectionCount(day);
              final availableRooms = state.availableRooms[day] ?? [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${DateFormat('EEE, MMM d, yyyy').format(day)} - ${DateFormat('EEE, MMM d, yyyy').format(nextDay)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Selected: $selectedCount/${state.numberOfRooms}',
                    style: TextStyle(
                      color: selectedCount == state.numberOfRooms
                          ? Colors.green
                          : Colors.orange,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: availableRooms.map((room) {
                      final isBooked =
                          controller.isRoomBooked(day, room.roomNumber);
                      final isSelected =
                          controller.isRoomSelected(day, room.roomNumber);

                      Color chipColor;
                      Color textColor;

                      if (isBooked) {
                        chipColor = Colors.red;
                        textColor = Colors.white;
                      } else if (isSelected) {
                        chipColor = Colors.green;
                        textColor = Colors.white;
                      } else {
                        chipColor = Colors.blue;
                        textColor = Colors.white;
                      }

                      return InkWell(
                        onTap: isBooked
                            ? null
                            : () => controller.toggleRoom(day, room.roomNumber),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: chipColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            room.roomNumber,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const Divider(height: 24),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      children: [
        _buildLegendItem(Colors.red, 'Booked'),
        const SizedBox(width: 16),
        _buildLegendItem(Colors.green, 'Selected'),
        const SizedBox(width: 16),
        _buildLegendItem(Colors.blue, 'Available'),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
      WidgetRef ref, BookingState state, BuildContext context) {
    final controller = ref.read(bookingControllerProvider.notifier);
    final formatter = NumberFormat('#,##0.00', 'en_US');

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Booking Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 24),
            _buildSummaryRow(
              'Check-in:',
              state.checkInDate != null
                  ? DateFormat('MM/dd/yyyy').format(state.checkInDate!)
                  : '-',
            ),
            const SizedBox(height: 8),
            _buildSummaryRow(
              'Check-out:',
              state.checkOutDate != null
                  ? DateFormat('MM/dd/yyyy').format(state.checkOutDate!)
                  : '-',
            ),
            const SizedBox(height: 8),
            _buildSummaryRow('Nights:', '${state.numberOfNights}'),
            const SizedBox(height: 8),
            _buildSummaryRow('Room Type:', state.roomType!.name),
            const Divider(height: 24),
            const Text(
              'Selected Rooms by Day',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...state.bookingDays.map((day) {
              final rooms = state.selectedRooms[day] ?? [];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${DateFormat('EEE, MMM d, yyyy').format(day)}:',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        rooms.isEmpty ? '0 rooms' : rooms.join(', '),
                        style: TextStyle(
                          fontSize: 12,
                          color: rooms.isEmpty ? Colors.red : Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const Divider(height: 24),
            _buildSummaryRow(
              'Price per Room:',
              '₦${formatter.format(state.pricePerRoom)}',
            ),
            const SizedBox(height: 12),
            _buildSummaryRow(
              'Total Price:',
              '₦${formatter.format(state.totalPrice)}',
              isBold: true,
              fontSize: 18,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: state.selectedRooms.isEmpty
                    ? null
                    : () {
                        controller.resetDiscountCalculator();
                        showDialog(
                          context: context,
                          builder: (_) => BookingConfirmationDialog(
                              //bookingState: state,
                              ),
                        );
                      },
                //controller.createBooking(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Book Now',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isBold = false,
    double fontSize = 14,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
