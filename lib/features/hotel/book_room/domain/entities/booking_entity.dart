// class BookingEntity {
//   final int? id;
//   final String bookingNumber;
//   final int customerId;
//   final String roomNumber;
//   final DateTime dateFrom;
//   final DateTime dateTo;
//   final String status;
//   final String paymentStatus;
//   final String checkInStatus;
//   final String checkOutStatus;
//   final String roomKeyStatus;
//   final double totalAmount;
//   final DateTime createdAt;

//   BookingEntity({
//     this.id,
//     required this.bookingNumber,
//     required this.customerId,
//     required this.roomNumber,
//     required this.dateFrom,
//     required this.dateTo,
//     required this.status,
//     required this.paymentStatus,
//     required this.checkInStatus,
//     required this.checkOutStatus,
//     required this.roomKeyStatus,
//     required this.totalAmount,
//     required this.createdAt,
//   });

//   BookingEntity copyWith({
//     int? id,
//     int? customerId,
//     String? paymentStatus,
//     String? status,
//   }) {
//     return BookingEntity(
//       id: id ?? this.id,
//       bookingNumber: bookingNumber,
//       customerId: customerId ?? this.customerId,
//       roomNumber: roomNumber,
//       dateFrom: dateFrom,
//       dateTo: dateTo,
//       status: status ?? this.status,
//       paymentStatus: paymentStatus ?? this.paymentStatus,
//       checkInStatus: checkInStatus,
//       checkOutStatus: checkOutStatus,
//       roomKeyStatus: roomKeyStatus,
//       totalAmount: totalAmount,
//       createdAt: createdAt,
//     );
//   }
// }


// class BookingEntity {
//   final int? id;
//   final String bookingNumber;
//   final int customerId;
//   final DateTime dateFrom;
//   final DateTime dateTo;

//   /// active | canceled
//   final String status;

//   /// partial | fully_paid
//   final String paymentStatus;

//   /// not_checked_in | checked_in
//   final String checkInStatus;

//   /// not_checked_out | checked_out
//   final String checkOutStatus;

//   /// given | not_given
//   final String roomKeyStatus;

//   final double totalAmount;
//   final DateTime createdAt;

//   BookingEntity({
//     this.id,
//     required this.bookingNumber,
//     required this.customerId,
//     required this.dateFrom,
//     required this.dateTo,
//     required this.status,
//     required this.paymentStatus,
//     required this.checkInStatus,
//     required this.checkOutStatus,
//     required this.roomKeyStatus,
//     required this.totalAmount,
//     required this.createdAt,
//   });

//   BookingEntity copyWith({
//     String? status,
//     String? paymentStatus,
//     String? checkInStatus,
//     String? checkOutStatus,
//     String? roomKeyStatus,
//     double? totalAmount,
//   }) {
//     return BookingEntity(
//       id: id,
//       bookingNumber: bookingNumber,
//       customerId: customerId,
//       dateFrom: dateFrom,
//       dateTo: dateTo,
//       status: status ?? this.status,
//       paymentStatus: paymentStatus ?? this.paymentStatus,
//       checkInStatus: checkInStatus ?? this.checkInStatus,
//       checkOutStatus: checkOutStatus ?? this.checkOutStatus,
//       roomKeyStatus: roomKeyStatus ?? this.roomKeyStatus,
//       totalAmount: totalAmount ?? this.totalAmount,
//       createdAt: createdAt,
//     );
//   }
// }





class BookingEntity {
  final int? id;
  final String bookingNumber;
  final int customerId;

  /// comma-separated room numbers: "102,104,105"
  final String roomNumbers;

  final DateTime dateFrom;
  final DateTime dateTo;

  /// active | canceled
  final String status;

  /// partial | fully_paid
  final String paymentStatus;

  /// not_checked_in | checked_in
  final String checkInStatus;

  /// not_checked_out | checked_out
  final String checkOutStatus;

  /// given | not_given
  final String roomKeyStatus;

  final double totalAmount;
  final DateTime createdAt;

  BookingEntity({
    this.id,
    required this.bookingNumber,
    required this.customerId,
    required this.roomNumbers,
    required this.dateFrom,
    required this.dateTo,
    required this.status,
    required this.paymentStatus,
    required this.checkInStatus,
    required this.checkOutStatus,
    required this.roomKeyStatus,
    required this.totalAmount,
    required this.createdAt,
  });

  BookingEntity copyWith({
    String? status,
    String? paymentStatus,
    String? checkInStatus,
    String? checkOutStatus,
    String? roomKeyStatus,
    double? totalAmount,
  }) {
    return BookingEntity(
      id: id,
      bookingNumber: bookingNumber,
      customerId: customerId,
      roomNumbers: roomNumbers,
      dateFrom: dateFrom,
      dateTo: dateTo,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      checkInStatus: checkInStatus ?? this.checkInStatus,
      checkOutStatus: checkOutStatus ?? this.checkOutStatus,
      roomKeyStatus: roomKeyStatus ?? this.roomKeyStatus,
      totalAmount: totalAmount ?? this.totalAmount,
      createdAt: createdAt,
    );
  }
}
