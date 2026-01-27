import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/dashboard_state.dart';
import '../controllers/hotel_dashboard_controller.dart';

final hotelDashboardControllerProvider =
    StateNotifierProvider<HotelDashboardController, HotelDashboardState>(
  (ref) => HotelDashboardController(),
);