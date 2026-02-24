import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/presentation/appbars/spotstock_desktop_top_toolbar.dart';
import '../../../dashboard/presentation/providers/dashboard_provider.dart';
import '../provider/provider.dart';
import '../view_model/hotel_home_viewmodel.dart';
import 'hotel_pages.dart';

class HotelHome extends ConsumerStatefulWidget {
  final HotelHomeViewmodel homeViewmodel;

  const HotelHome({super.key, required this.homeViewmodel});

  @override
  ConsumerState<HotelHome> createState() => _HotelHomeState();
}

class _HotelHomeState extends ConsumerState<HotelHome>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Listen to provider changes
    // ref.listen<int>(hotelTabIndexProvider, (previous, next) {
    //   _tabController.animateTo(next);
    // });

    _tabController = TabController(length: hotelPages.length, vsync: this);

    // Example: call some provider on init
    // ✅ Load room and room type data on init
    Future.microtask(() {
      ref.read(hotelDashboardControllerProvider.notifier).loadAllModule();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // You can now use `ref` to watch any provider
    // final someState = ref.watch(someProvider);

    return DefaultTabController(
      length: hotelPages.length,
      child: Scaffold(
        appBar: AppBar(
          title: const SpotstockDesktopTopToolbar(),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            onTap: (index) {
              ref.read(hotelTabIndexProvider.notifier).state = index;
            },
            tabs: const [
              Tab(text: "Dashboard"),
              Tab(text: "Amenities"),
              Tab(text: "Facilities"),
              Tab(text: "Bed Types"),
              Tab(text: "Room Types"),
              Tab(text: "Premium"),
              Tab(text: "Rooms"),
              Tab(text: "Bookings"),
              Tab(text: "Booking History"),
              Tab(text: "Maintenance Page"),
              Tab(text: "Folio Booking"),
              Tab(text: "Discount Request Page"),
              Tab(text: "Credit Request Page"),
              Tab(text: "Payments Page"),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: hotelPages,
        ),
      ),
    );
  }
}
