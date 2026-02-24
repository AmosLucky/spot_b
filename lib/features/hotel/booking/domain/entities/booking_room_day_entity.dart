class BookingRoomDayEntity {
  final int? id;
  final int bookingId;
  final DateTime date;
  final String roomNumber;

  BookingRoomDayEntity({
    this.id,
    required this.bookingId,
    required this.date,
    required this.roomNumber,
  });
}
