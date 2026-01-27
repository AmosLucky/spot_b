import 'package:flutter/material.dart';

import '../../../../../core/presentation/appbars/spotstock_desktop_top_toolbar.dart';
import '../../../../../core/presentation/appbars/spotstock_hotel_sidebar.dart';

import '../view_model/hotel_home_viewmodel.dart';
import 'hotel_pages.dart';

class HotelHome extends StatefulWidget {
  HotelHomeViewmodel homeViewmodel;
  HotelHome({super.key, required this.homeViewmodel});

  @override
  State<HotelHome> createState() => _HotelHomeState();
}

class _HotelHomeState extends State<HotelHome> {
  //bool hotelOpen = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: SpotstockDesktopTopToolbar(),
      ),
      body: Row(
        children: [
          // LEFT SIDEBAR
          Container(
            width: 260,
            color: Theme.of(context).colorScheme.primary,
            child: SpotstockHotelSidebar(viewModel: widget.homeViewmodel),
          ),

          // RIGHT CONTENT AREA
          Expanded(
            child: AnimatedBuilder(
              animation: widget.homeViewmodel,
              builder: (_, __) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: IndexedStack(
                    index: widget.homeViewmodel.selectedIndex,
                    children: hotelPages,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
