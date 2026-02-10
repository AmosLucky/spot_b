import '../../../room_types/domain/entities/room_type_entities.dart';
import '../../../rooms/domain/entities/room_entity.dart';
import '../../domain/repositories/enums/guest_type.dart';
import '../../domain/repositories/enums/payment_method.dart';

class BookingState {
  final int? selectedRoomTypeId;
  final PaymentMethod paymentMethod;
  final GuestType guestType ;
  final double discount ;
  final double paidAmount ;
   

  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final RoomTypeEntity? roomType;
  final int numberOfRooms;
  final int adults;
  final int children;
  final int? customerId;
  final bool hasSearched;
  final bool isLoading;
  final Map<DateTime, List<String>> selectedRooms;
  final Map<DateTime, List<RoomEntity>> availableRooms;
  final Map<DateTime, List<String>> bookedRooms;
  final List<String> allRoomNumbers; // All room numbers in the system
  final List<RoomTypeEntity> availableRoomTypes; // All room types
  final List<RoomEntity> allRooms; // All rooms from database
  final double pricePerRoom;
  final String? error;
  final String? successMessage;

   BookingState({
    this.selectedRoomTypeId,
    this.paymentMethod = PaymentMethod.cash,
    this.guestType = GuestType.guest,
    this.discount = 0.0,
    this.paidAmount = 0,
    this.checkInDate,
    this.checkOutDate,
    this.roomType,
    this.numberOfRooms = 1,
    this.adults = 1,
    this.children = 0,
    this.customerId,
    this.hasSearched = false,
    this.isLoading = false,
    this.selectedRooms = const {},
    this.availableRooms = const {},
    this.bookedRooms = const {},
    this.allRoomNumbers = const [],
    //const ['102', '104', '105'], // Default rooms
    this.availableRoomTypes = const [],
    this.allRooms = const [],
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
     int? selectedRoomTypeId,
    PaymentMethod? paymentMethod,
    GuestType? guestType,
    double? discount,
    double? paidAmount,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    RoomTypeEntity? roomType,
    int? numberOfRooms,
    int? adults,
    int? children,
    int? customerId,
    bool? hasSearched,
    bool? isLoading,
    Map<DateTime, List<String>>? selectedRooms,
    Map<DateTime, List<RoomEntity>>? availableRooms,
    Map<DateTime, List<String>>? bookedRooms,
    List<RoomTypeEntity>? availableRoomTypes,
    List<RoomEntity>? allRooms,
    List<String>? allRoomNumbers,
    double? pricePerRoom,
    String? error,
    String? successMessage,
  }) {
    return BookingState(
      selectedRoomTypeId: selectedRoomTypeId ?? this.selectedRoomTypeId,
    paymentMethod: paymentMethod?? this.paymentMethod,
    guestType: guestType ?? this.guestType,
    discount: discount ?? this.discount,
    paidAmount: paidAmount ?? this.paidAmount,
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
      availableRoomTypes: availableRoomTypes ?? this.availableRoomTypes,
      allRooms: allRooms ?? this.allRooms,
      pricePerRoom: pricePerRoom ?? this.pricePerRoom,
      error: error,
      successMessage: successMessage,
    );
  }
}
