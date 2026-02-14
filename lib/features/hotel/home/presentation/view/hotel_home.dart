import 'package:flutter/material.dart';

import '../../../../../core/presentation/appbars/spotstock_desktop_top_toolbar.dart';
import '../view_model/hotel_home_viewmodel.dart';
import 'hotel_pages.dart';

class HotelHome extends StatelessWidget {
  final HotelHomeViewmodel homeViewmodel;

  const HotelHome({super.key, required this.homeViewmodel});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: hotelPages.length, // total tabs
      child: Scaffold(
        appBar: AppBar(
          title: const SpotstockDesktopTopToolbar(),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Dashboard"),
              Tab(text: "Amenities"),
              Tab(text: "Facilities"),
              Tab(text: "Bed Types"),
              Tab(text: "Room Types"),
              Tab(text: "Premium"),
              Tab(text: "Rooms"),
              Tab(text: "Bookings"),
              Tab(text: "Booking History"),
            ],
          ),
        ),
        body: TabBarView(
          children: hotelPages,
        ),
      ),
    );
  }
}
