import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/booking_entity.dart';

import '../../domain/usecases/create_booking_usecase.dart';

import '../../domain/usecases/get_available_rooms_use_case.dart';
import '../../domain/usecases/get_bookings_usecase.dart';
import '../../domain/usecases/update_booking_use_case.dart';
import '../state/booking_state.dart';

class BookingController extends StateNotifier<BookingState> {
  final CreateBookingUseCase createBookingUseCase;
  final GetBookingsUseCase getBookingsUseCase;
  final UpdateBookingUseCase updateBookingUseCase;
  final GetAvailableRoomsUseCase getAvailableRoomsUseCase;

  BookingController({
    required this.createBookingUseCase,
    required this.getBookingsUseCase,
    required this.updateBookingUseCase,
    required this.getAvailableRoomsUseCase,
  }) : super(const BookingState());

  // ==================== SETTERS ====================

  void setCheckInDate(DateTime date) {
    state = state.copyWith(
      checkInDate: date,
      hasSearched: false,
      selectedRooms: {},
      error: null,
    );
  }

  void setCheckOutDate(DateTime date) {
    state = state.copyWith(
      checkOutDate: date,
      hasSearched: false,
      selectedRooms: {},
      error: null,
    );
  }

  void setRoomType(String type) {
    state = state.copyWith(
      roomType: type,
      hasSearched: false,
      selectedRooms: {},
    );
  }

  void setNumberOfRooms(int count) {
    state = state.copyWith(
      numberOfRooms: count,
      hasSearched: false,
      selectedRooms: {},
    );
  }

  void setAdults(int count) {
    state = state.copyWith(adults: count);
  }

  void setChildren(int count) {
    state = state.copyWith(children: count);
  }

  void setCustomerId(int id) {
    state = state.copyWith(customerId: id);
  }

  void setAllRoomNumbers(List<String> rooms) {
    state = state.copyWith(allRoomNumbers: rooms);
  }

  // ==================== SEARCH ROOMS ====================

  Future<void> searchRooms() async {
    if (state.checkInDate == null || state.checkOutDate == null) {
      state =
          state.copyWith(error: 'Please select check-in and check-out dates');
      return;
    }

    if (state.checkOutDate!.isBefore(state.checkInDate!) ||
        state.checkOutDate!.isAtSameMomentAs(state.checkInDate!)) {
      state =
          state.copyWith(error: 'Check-out date must be after check-in date');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      // Get booked rooms for the date range
      final bookedRoomsMap = await getAvailableRoomsUseCase(
        checkIn: state.checkInDate!,
        checkOut: state.checkOutDate!,
        allRoomNumbers: state.allRoomNumbers,
      );

      // Calculate available rooms for each day
      final availableRoomsMap = <DateTime, List<String>>{};

      for (final entry in bookedRoomsMap.entries) {
        final date = entry.key;
        final bookedRooms = entry.value;

        // Available rooms = all rooms - booked rooms
        final available = state.allRoomNumbers
            .where((room) => !bookedRooms.contains(room))
            .toList();

        availableRoomsMap[date] = available;
      }

      state = state.copyWith(
        hasSearched: true,
        isLoading: false,
        availableRooms: availableRoomsMap,
        bookedRooms: bookedRoomsMap,
        selectedRooms: {},
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to search rooms: ${e.toString()}',
      );
    }
  }

  // ==================== ROOM SELECTION ====================

  void toggleRoom(DateTime day, String roomNumber) {
    // Check if room is booked
    if (state.bookedRooms[day]?.contains(roomNumber) ?? false) {
      state = state.copyWith(
          error: 'Room $roomNumber is already booked for this date');
      return;
    }

    final currentSelections =
        Map<DateTime, List<String>>.from(state.selectedRooms);
    final daySelections = List<String>.from(currentSelections[day] ?? []);

    if (daySelections.contains(roomNumber)) {
      // Deselect room
      daySelections.remove(roomNumber);
    } else {
      // Check if max rooms reached
      if (daySelections.length >= state.numberOfRooms) {
        state = state.copyWith(
          error:
              'Maximum ${state.numberOfRooms} room(s) can be selected per day',
        );
        return;
      }
      // Select room
      daySelections.add(roomNumber);
    }

    if (daySelections.isEmpty) {
      currentSelections.remove(day);
    } else {
      currentSelections[day] = daySelections;
    }

    state = state.copyWith(selectedRooms: currentSelections, error: null);
  }

  int getSelectionCount(DateTime day) {
    return state.selectedRooms[day]?.length ?? 0;
  }

  bool isRoomSelected(DateTime day, String roomNumber) {
    return state.selectedRooms[day]?.contains(roomNumber) ?? false;
  }

  bool isRoomBooked(DateTime day, String roomNumber) {
    return state.bookedRooms[day]?.contains(roomNumber) ?? false;
  }

  bool isRoomAvailable(DateTime day, String roomNumber) {
    return state.availableRooms[day]?.contains(roomNumber) ?? false;
  }

  // ==================== CREATE BOOKING ====================

  Future<void> createBooking() async {
    // Validation
    if (state.customerId == null) {
      state = state.copyWith(error: 'Please select a customer');
      return;
    }

    if (state.selectedRooms.isEmpty) {
      state = state.copyWith(error: 'Please select rooms for your stay');
      return;
    }

    // Check if all days have selections
    final missingDays = state.bookingDays.where((day) {
      return (state.selectedRooms[day]?.length ?? 0) == 0;
    }).toList();

    if (missingDays.isNotEmpty) {
      state = state.copyWith(
        error: 'Please select rooms for all days of your stay',
      );
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      // Generate booking number
      final bookingNumber = _generateBookingNumber();

      // Get all unique room numbers selected across all days
      final allSelectedRooms = <String>{};
      for (final rooms in state.selectedRooms.values) {
        allSelectedRooms.addAll(rooms);
      }

      // Create booking entity
      final booking = BookingEntity(
        bookingNumber: bookingNumber,
        customerId: state.customerId!,
        roomNumbers: allSelectedRooms.join(', '),
        dateFrom: state.checkInDate!,
        dateTo: state.checkOutDate!,
        status: 'Confirmed',
        paymentStatus: 'Pending',
        checkInStatus: 'Not Checked In',
        checkOutStatus: 'Not Checked Out',
        roomKeyStatus: 'Not Issued',
        totalAmount: state.totalPrice,
        createdAt: DateTime.now(),
      );

      // Save booking
      await createBookingUseCase(booking);

      state = state.copyWith(
        isLoading: false,
        successMessage:
            'Booking created successfully! Booking Number: $bookingNumber',
        selectedRooms: {},
        hasSearched: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to create booking: ${e.toString()}',
      );
    }
  }

  // ==================== HELPERS ====================

  String _generateBookingNumber() {
    final now = DateTime.now();
    final timestamp = now.millisecondsSinceEpoch.toString().substring(7);
    return 'BK${now.year}${now.month.toString().padLeft(2, '0')}$timestamp';
  }

  void resetSelections() {
    state = state.copyWith(selectedRooms: {});
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearSuccess() {
    state = state.copyWith(successMessage: null);
  }

  void reset() {
    state = const BookingState();
  }
}
