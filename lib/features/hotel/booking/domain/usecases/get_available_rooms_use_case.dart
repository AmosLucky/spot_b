import 'package:spotstock_inventory/features/hotel/room_types/domain/repositories/room_type_repository.dart';
import 'package:spotstock_inventory/features/hotel/rooms/domain/repositories/room_repository.dart';

import '../../../rooms/domain/entities/room_entity.dart';
import '../repositories/booking_repository.dart';

class GetAvailableRoomsUseCase {
  final BookingRepository repository;
  final RoomRepository roomRepository;

  GetAvailableRoomsUseCase(this.repository, this.roomRepository);

  Future<List<RoomEntity>> call({
    required int roomTypeId,
    required DateTime checkIn,
    required DateTime checkOut,
  }) async {
    final rooms = await roomRepository.getRoomsByRoomType(roomTypeId);
    final bookings = await repository.getBookings();

    final bookedRoomIds = bookings
        .where((b) => isOverlapping(
              checkIn,
              checkOut,
              b.dateFrom,
              b.dateTo,
            ))
        .map((b) => b.id)
        .toSet();

    return rooms.where((room) => !bookedRoomIds.contains(room.id)).toList();
  }

  bool isOverlapping(
    DateTime startA,
    DateTime endA,
    DateTime startB,
    DateTime endB,
  ) {
    return startA.isBefore(endB) && endA.isAfter(startB);
  }

  /// Get available rooms by checking existing bookings
  /// Returns a map of DateTime to list of booked room numbers
  // Future<Map<DateTime, List<String>>> call({
  //   required DateTime checkIn,
  //   required DateTime checkOut,
  //  // required List<String> allRoomNumbers,
  // }) async {
  //   // Get all bookings
  //   final bookings = await repository.getBookings();

  //   final bookedRooms = <DateTime, List<String>>{};

  //   // Calculate days in the requested range
  //   final days = checkOut.difference(checkIn).inDays;

  //   for (int i = 0; i < days; i++) {
  //     final currentDate = checkIn.add(Duration(days: i));
  //     bookedRooms[currentDate] = [];

  //     // Check each booking to see if it overlaps with current date
  //     for (final booking in bookings) {
  //       final bookingStart = DateTime(
  //         booking.dateFrom.year,
  //         booking.dateFrom.month,
  //         booking.dateFrom.day,
  //       );
  //       final bookingEnd = DateTime(
  //         booking.dateTo.year,
  //         booking.dateTo.month,
  //         booking.dateTo.day,
  //       );
  //       final checkDate = DateTime(
  //         currentDate.year,
  //         currentDate.month,
  //         currentDate.day,
  //       );

  //       // If the booking overlaps with this date
  //       if (checkDate.isAtSameMomentAs(bookingStart) ||
  //           checkDate.isAtSameMomentAs(bookingEnd) ||
  //           (checkDate.isAfter(bookingStart) && checkDate.isBefore(bookingEnd))) {
  //         // Add the booked rooms to this date
  //         final rooms = booking.roomNumbers.split(',').map((r) => r.trim()).toList();
  //         bookedRooms[currentDate]!.addAll(rooms);
  //       }
  //     }
  //   }

  //   return bookedRooms;
  // }
}
