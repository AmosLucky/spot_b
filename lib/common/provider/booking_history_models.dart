// booking_model.dart
class BookingHistoryResponse {
  final int currentPage;
  final List<Booking> bookings;
  final int totalPages;
  final int totalItems;
  final int? perPage;
  final String? firstPageUrl;
  final String? lastPageUrl;

  BookingHistoryResponse({
    required this.currentPage,
    required this.bookings,
    required this.totalPages,
    required this.totalItems,
    this.perPage,
    this.firstPageUrl,
    this.lastPageUrl,
  });

  factory BookingHistoryResponse.fromJson(Map<String, dynamic> json) {
    return BookingHistoryResponse(
      currentPage: json['current_page'] ?? 1,
      bookings: (json['data'] as List)
          .map((bookingJson) => Booking.fromJson(bookingJson))
          .toList(),
      totalPages: json['last_page'] ?? 1,
      totalItems: json['total'] ?? 0,
      perPage: json['per_page'],
      firstPageUrl: json['first_page_url'],
      lastPageUrl: json['last_page_url'],
    );
  }
}

class Booking {
  final int id;
  final String bookingNumber;
  final Customer customer;
  final DateTime checkIn;
  final DateTime checkOut;
  final String status;
  final String paymentStatus;
  final double bookingFare;
  final double serviceCost;
  final double taxCharge;
  final double paidAmount;
  final double pendingAmount;
  final int nights;
  final DateTime createdAt;
  final DateTime? checkedInAt;
  final DateTime? checkedOutAt;
  final List<BookedRoom> bookedRooms;
  final List<Payment> payments;
  final List<PremiumService> premiumServices;
  final double totalServiceAmount;

  Booking({
    required this.id,
    required this.bookingNumber,
    required this.customer,
    required this.checkIn,
    required this.checkOut,
    required this.status,
    required this.paymentStatus,
    required this.bookingFare,
    required this.serviceCost,
    required this.taxCharge,
    required this.paidAmount,
    required this.pendingAmount,
    required this.nights,
    required this.createdAt,
    this.checkedInAt,
    this.checkedOutAt,
    required this.bookedRooms,
    required this.payments,
    required this.premiumServices,
    required this.totalServiceAmount,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      bookingNumber: json['booking_number'],
      customer: Customer.fromJson(json['customer']),
      checkIn: DateTime.parse(json['check_in']),
      checkOut: DateTime.parse(json['check_out']),
      status: json['status'],
      paymentStatus: json['payment_status'],
      bookingFare: double.parse(json['booking_fare']),
      serviceCost: double.parse(json['service_cost']),
      taxCharge: double.parse(json['tax_charge']),
      paidAmount: double.parse(json['paid_amount']),
      pendingAmount: double.parse(json['pending_amount'].toString()),
      nights: json['nights'],
      createdAt: DateTime.parse(json['created_at']),
      checkedInAt: json['checked_in_at'] != null
          ? DateTime.parse(json['checked_in_at'])
          : null,
      checkedOutAt: json['checked_out_at'] != null
          ? DateTime.parse(json['checked_out_at'])
          : null,
      bookedRooms: (json['booked_rooms'] as List)
          .map((roomJson) => BookedRoom.fromJson(roomJson))
          .toList(),
      payments: (json['payments'] as List)
          .map((paymentJson) => Payment.fromJson(paymentJson))
          .toList(),
      premiumServices: (json['used_premium_service'] as List)
          .map((serviceJson) => PremiumService.fromJson(serviceJson))
          .toList(),
      totalServiceAmount: json['total_service_amount']?.toDouble() ?? 0.0,
    );
  }

  double get totalAmount => bookingFare + serviceCost + taxCharge;
}

class Customer {
  final int id;
  final String name;
  final String email;
  final String phone;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}

class BookedRoom {
  final int id;
  final String roomNumber;
  final String roomType;
  final double fare;

  BookedRoom({
    required this.id,
    required this.roomNumber,
    required this.roomType,
    required this.fare,
  });

  factory BookedRoom.fromJson(Map<String, dynamic> json) {
    return BookedRoom(
      id: json['id'],
      roomNumber: json['room']['room_number'],
      roomType: json['room_type']['name'],
      fare: double.parse(json['fare']),
    );
  }
}

class Payment {
  final int id;
  final double amount;
  final String method;
  final DateTime? date;
  final String description;

  Payment({
    required this.id,
    required this.amount,
    required this.method,
    this.date,
    required this.description,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      amount: double.parse(json['amount']),
      method: json['payment_method'],
      date: json['payment_date'] != null
          ? DateTime.parse(json['payment_date'])
          : null,
      description: json['description'] ?? 'Payment',
    );
  }
}

class PremiumService {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final DateTime serviceDate;
  final String roomNumber;

  PremiumService({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.serviceDate,
    required this.roomNumber,
  });

  factory PremiumService.fromJson(Map<String, dynamic> json) {
    return PremiumService(
      id: json['id'],
      name: json['premium_service']?['name'] ?? 'Unknown Service',
      price: double.parse(json['unit_price']),
      quantity: json['qty'],
      serviceDate: DateTime.parse(json['service_date']),
      roomNumber: json['room']['room_number'],
    );
  }
}
