import 'package:flutter/material.dart';
import 'package:spotstock_inventory/features/hotel/dashboard/presentation/view/hotel_dashboard.dart'
    show HotelDashboardPage;

import '../../../amenities/presentation/views/amenities_page.dart';

final List<Widget> hotelPages = [
  HotelDashboardPage(),
  AmenitiesPage(),
  // FacilitiesPage(),
  // BedTypesPage(),
  // RoomTypesPage(),
  // PremiumServicesPage(),
  // RoomsPage(),
];
