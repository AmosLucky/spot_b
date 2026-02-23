import 'package:flutter/material.dart';
import 'package:spotstock_inventory/features/hotel/booking/presentation/view/folio_bookings_page.dart';

import '../../../amenities/presentation/views/amenities_page.dart';
import '../../../bed_type/presentation/view/desktop/bed_types_page.dart';
import '../../../booking/presentation/view/booking_history_page.dart';
import '../../../booking/presentation/view/booking_page.dart';
import '../../../dashboard/presentation/view/hotel_dashboard.dart';
import '../../../discount/presentation/view/discount_request_page.dart';
import '../../../facilities/presentation/views/desktop/facilities_page.dart';
import '../../../premium_type/presentation/views/premium_types_page.dart';
import '../../../room_types/presentation/pages/room_types_page.dart';
import '../../../rooms/presentation/view/hotel_rooms_page.dart';
import '../../../rooms/presentation/view/maintenance_page.dart';

final List<Widget> hotelPages = [
  HotelDashboardPage(),
  AmenitiesPage(),
  FacilitiesPage(),
  BedTypesPage(),
  RoomTypesPage(),
  PremiumTypesPage(),
  HotelRoomsPage(),
  BookingPage(),
  BookingHistoryPage(),
  MaintenancePage(),
  FolioBookingsPage(),
  DiscountRequestPage()
];
