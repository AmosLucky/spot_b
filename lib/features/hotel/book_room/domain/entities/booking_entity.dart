import '../../domain/repositories/enums/guest_type.dart';

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

  /// 💰 total before discount
  final double totalAmount;

  /// 💸 discount applied
  final double discount;

  /// 👤 guest | walkin | existing
  final String guestType;

  final DateTime createdAt;
  final DateTime updatedAt;

  const BookingEntity({
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
    required this.discount,
    required this.guestType,
    required this.createdAt,
    required this.updatedAt,
  });

  /// 🧮 derived value (VERY useful)
  double get payableAmount => totalAmount - discount;

  BookingEntity copyWith({
    String? status,
    String? paymentStatus,
    String? checkInStatus,
    String? checkOutStatus,
    String? roomKeyStatus,
    double? totalAmount,
    double? discount,
    String? guestType,
    DateTime? updatedAt,
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
      discount: discount ?? this.discount,
      guestType: guestType ?? this.guestType,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
