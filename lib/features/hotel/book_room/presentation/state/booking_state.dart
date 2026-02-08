import 'package:flutter/foundation.dart';

class BookingState {
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final String roomType;
  final int numberOfRooms;
  final int adults;
  final int children;
  final int? customerId;
  final bool hasSearched;
  final bool isLoading;
  final Map<DateTime, List<String>> selectedRooms;
  final Map<DateTime, List<String>> availableRooms;
  final Map<DateTime, List<String>> bookedRooms;
  final List<String> allRoomNumbers; // All room numbers in the system
  final double pricePerRoom;
  final String? error;
  final String? successMessage;

  const BookingState({
    this.checkInDate,
    this.checkOutDate,
    this.roomType = 'Standard',
    this.numberOfRooms = 1,
    this.adults = 1,
    this.children = 0,
    this.customerId,
    this.hasSearched = false,
    this.isLoading = false,
    this.selectedRooms = const {},
    this.availableRooms = const {},
    this.bookedRooms = const {},
    this.allRoomNumbers = const ['102', '104', '105'], // Default rooms
    this.pricePerRoom = 25000.00,
    this.error,
    this.successMessage,
  });

  int get numberOfNights {
    if (checkInDate == null || checkOutDate == null) return 0;
    return checkOutDate!.difference(checkInDate!).inDays;
  }

  double get totalPrice {
    double total = 0;
    for (var rooms in selectedRooms.values) {
      total += rooms.length * pricePerRoom;
    }
    return total;
  }

  List<DateTime> get bookingDays {
    if (checkInDate == null || checkOutDate == null) return [];
    final days = <DateTime>[];
    for (int i = 0; i < numberOfNights; i++) {
      days.add(checkInDate!.add(Duration(days: i)));
    }
    return days;
  }

  BookingState copyWith({
    DateTime? checkInDate,
    DateTime? checkOutDate,
    String? roomType,
    int? numberOfRooms,
    int? adults,
    int? children,
    int? customerId,
    bool? hasSearched,
    bool? isLoading,
    Map<DateTime, List<String>>? selectedRooms,
    Map<DateTime, List<String>>? availableRooms,
    Map<DateTime, List<String>>? bookedRooms,
    List<String>? allRoomNumbers,
    double? pricePerRoom,
    String? error,
    String? successMessage,
  }) {
    return BookingState(
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      roomType: roomType ?? this.roomType,
      numberOfRooms: numberOfRooms ?? this.numberOfRooms,
      adults: adults ?? this.adults,
      children: children ?? this.children,
      customerId: customerId ?? this.customerId,
      hasSearched: hasSearched ?? this.hasSearched,
      isLoading: isLoading ?? this.isLoading,
      selectedRooms: selectedRooms ?? this.selectedRooms,
      availableRooms: availableRooms ?? this.availableRooms,
      bookedRooms: bookedRooms ?? this.bookedRooms,
      allRoomNumbers: allRoomNumbers ?? this.allRoomNumbers,
      pricePerRoom: pricePerRoom ?? this.pricePerRoom,
      error: error,
      successMessage: successMessage,
    );
  }
}