class RoomEntity {
  final int? id;
  final String roomNumber;
  final int roomTypeId;

  /// active | inactive | dirty | maintenance
  final String status;

  /// available | booked | checked_in
  final String bookingStatus;

  RoomEntity({
    this.id,
    required this.roomNumber,
    required this.roomTypeId,
    required this.status,
    String? bookingStatus,
  }) : bookingStatus = bookingStatus ?? 'available';

  RoomEntity copyWith({
    int? id,
    String? roomNumber,
    int? roomTypeId,
    String? status,
    String? bookingStatus,
  }) {
    return RoomEntity(
      id: id ?? this.id,
      roomNumber: roomNumber ?? this.roomNumber,
      roomTypeId: roomTypeId ?? this.roomTypeId,
      status: status ?? this.status,
      bookingStatus: bookingStatus ?? this.bookingStatus,
    );
  }
}
