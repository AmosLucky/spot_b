import '../../domain/entities/booking_entity.dart';

// class BookingState {
//   final bool isLoading;
//   final List<BookingEntity> bookings;
//   final String? error;

//   const BookingState({
//     this.isLoading = false,
//     this.bookings = const [],
//     this.error,
//   });

//   BookingState copyWith({
//     bool? isLoading,
//     List<BookingEntity>? bookings,
//     String? error,
//   }) {
//     return BookingState(
//       isLoading: isLoading ?? this.isLoading,
//       bookings: bookings ?? this.bookings,
//       error: error,
//     );
//   }
// }


// class BookingState {
//   final bool isLoading;

//   /// day → selected room numbers
//   final Map<DateTime, List<String>> selectedRooms;

//   final int maxRoomsPerDay;
//   final double pricePerRoom;

//   final String? error;

//   const BookingState({
//     this.isLoading = false,
//     this.selectedRooms = const {},
//     this.maxRoomsPerDay = 1,
//     this.pricePerRoom = 0,
//     this.error,
//   });

//   BookingState copyWith({
//     bool? isLoading,
//     Map<DateTime, List<String>>? selectedRooms,
//     String? error, required List<BookingEntity> bookings,
//   }) {
//     return BookingState(
//       isLoading: isLoading ?? this.isLoading,
//       selectedRooms: selectedRooms ?? this.selectedRooms,
//       maxRoomsPerDay: maxRoomsPerDay,
//       pricePerRoom: pricePerRoom,
//       error: error,
//     );
//   }
// }
class BookingState {
  final bool isLoading;
  final bool hasSearched;

  final DateTime? checkIn;
  final DateTime? checkOut;

  final int? roomTypeId;
  final String? roomTypeName;

  final int numberOfRooms;
  final int adults;
  final int children;

  /// day → available rooms
  final Map<DateTime, List<String>> availableRooms;

  /// day → selected rooms
  final Map<DateTime, List<String>> selectedRooms;

  final double pricePerRoom;
  final String? error;

  const BookingState({
    this.isLoading = false,
    this.hasSearched = false,
    this.checkIn,
    this.checkOut,
    this.roomTypeId,
    this.roomTypeName,
    this.numberOfRooms = 1,
    this.adults = 1,
    this.children = 0,
    this.availableRooms = const {},
    this.selectedRooms = const {},
    this.pricePerRoom = 0,
    this.error,
  });

  int get nights =>
      (checkIn != null && checkOut != null)
          ? checkOut!.difference(checkIn!).inDays
          : 0;

  double get totalPrice {
    double total = 0;
    selectedRooms.forEach((_, rooms) {
      total += rooms.length * pricePerRoom;
    });
    return total;
  }

  BookingState copyWith({
    bool? isLoading,
    bool? hasSearched,
    DateTime? checkIn,
    DateTime? checkOut,
    int? roomTypeId,
    String? roomTypeName,
    int? numberOfRooms,
    int? adults,
    int? children,
    Map<DateTime, List<String>>? availableRooms,
    Map<DateTime, List<String>>? selectedRooms,
    double? pricePerRoom,
    String? error,
  }) {
    return BookingState(
      isLoading: isLoading ?? this.isLoading,
      hasSearched: hasSearched ?? this.hasSearched,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      roomTypeId: roomTypeId ?? this.roomTypeId,
      roomTypeName: roomTypeName ?? this.roomTypeName,
      numberOfRooms: numberOfRooms ?? this.numberOfRooms,
      adults: adults ?? this.adults,
      children: children ?? this.children,
      availableRooms: availableRooms ?? this.availableRooms,
      selectedRooms: selectedRooms ?? this.selectedRooms,
      pricePerRoom: pricePerRoom ?? this.pricePerRoom,
      error: error,
    );
  }
}

