import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/screens/desktop/home/hotel/card.dart';
import 'package:spotstock_inventory/screens/desktop/home/hotel/header.dart';
import 'package:spotstock_inventory/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final Size mediaQuery;
  const Body(
      {super.key,
      required this.user,
      required this.systemProvider,
      required this.mediaQuery});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  List _rooms = [];
  List _hotelCategories = [];
  final List _filterRooms = [];
  List _dataRooms = [];
  List? _foundProducts = [];
  List? stations = [];
  List? checkedInRooms = [];
  List? reservedRooms = [];

  Future<void> readRooms() async {
    final data = await widget.systemProvider.getHotelRooms();
    final hotelCategory = await widget.systemProvider.getHotelCategories();
    final hotel =
        await widget.systemProvider.fetchHotelReservations(true, true);
    print("---------------- rooms -------------");
    print(data);
    print("Total number of hotel rooms ==>> ${data.length}");
    print("hotel Reservation ===>> $hotel");
    setState(() {
      _rooms = data;
      _foundProducts = data;
      _dataRooms = data;
      _hotelCategories = hotelCategory;
    });
    getAvailable();
    getBooked();
    getReserved();
  }

  void getAvailable() {
    setState(() {
      if (_rooms.isNotEmpty) {
        stations = _rooms.where((room) {
          return room['attributes']['is_booked'] == 0;
        }).toList();
      }
    });
  }

  void getBooked() {
    setState(() {
      if (_rooms.isNotEmpty) {
        checkedInRooms = _rooms.where((room) {
          return room['attributes']['is_booked'] == 1;
        }).toList();
      }
    });
  }

  void getReserved() {
    setState(() {
      if (_rooms.isNotEmpty) {
        reservedRooms = _rooms.where((room) {
          return room['attributes']['is_reserved'] == 1;
        }).toList();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    readRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: SingleChildScrollView(
        // Use SingleChildScrollView to handle overflow
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Align to the top
              children: [
                // Sidebar Navigation with fixed width
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight:
                        MediaQuery.of(context).size.height, // Set max height
                  ),
                  child: SizedBox(
                    width: 200, // Fixed width for sidebar
                    child: SideBarHotel(
                      vertical: 20,
                      user: widget.user,
                      systemProvider: widget.systemProvider,
                    ),
                  ),
                ),

                // Dashboard Content Area
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dashboard Header
                      Header(
                        user: widget.user,
                        systemProvider: widget.systemProvider,
                      ),

                      // Dashboard Content Area
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          height: MediaQuery.of(context)
                              .size
                              .height, // Use MediaQuery to define height
                          child: GridView(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  4, // Adjust the number of columns based on design
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio:
                                  1.5, // Adjust to get the card proportions right
                            ),
                            children: [
                              HomeCard(
                                title: "Total No Of Rooms",
                                value: _rooms.length.toString(),
                                onPressed: readRooms,
                              ),
                              HomeCard(
                                title: "Available Rooms",
                                value: stations!.length.toString(),
                                onPressed: getAvailable,
                              ),
                              HomeCard(
                                title: "Booked Rooms",
                                value: checkedInRooms!.length.toString(),
                                onPressed: getBooked,
                              ),
                              HomeCard(
                                title: "Reserved Rooms",
                                value: widget.systemProvider
                                      .dashboardStats['totalReserved']
                                      .toString(),
                                onPressed: getReserved,
                              ),
                              HomeCard(
                                  title: "Total Checked-in",
                                  value: widget.systemProvider
                                      .dashboardStats['totalCheckedIn']
                                      .toString()),
                              HomeCard(
                                  title: "Total Checked-out",
                                  value: widget.systemProvider
                                      .dashboardStats['totalCheckedOut']
                                      .toString()),
                              HomeCard(
                                  title: "Today Sales",
                                  value: Money.format(widget.systemProvider
                                          .dashboardStats['todayHotelSales'] ??
                                      0)),
                              HomeCard(
                                  title: "Yesterday",
                                  value: Money.format(
                                      widget.systemProvider.dashboardStats[
                                              'yesterdayHotelSales'] ??
                                          0)),
                              HomeCard(
                                  title: "This Week Sales",
                                  value: Money.format(widget.systemProvider
                                          .dashboardStats['weeklyHotelSales'] ??
                                      0)),
                              HomeCard(
                                  title: "Last Week Sales",
                                  value: Money.format(
                                      widget.systemProvider.dashboardStats[
                                              'lastweekHotelSales'] ??
                                          0)),
                              HomeCard(
                                  title: "Monthly Sales",
                                  value: Money.format(
                                      widget.systemProvider.dashboardStats[
                                              'monthlyHotelSales'] ??
                                          0)),
                              HomeCard(
                                  title: "All Sales",
                                  value: Money.format(
                                      widget.systemProvider.dashboardStats[
                                              'lifetimeHotelSales'] ??
                                          0)),
                            ],
                          ),
                        ),
                      ),

                      // sales summary
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     // Sales Summary
                      //     Expanded(
                      //       flex: 3,
                      //       child: Container(
                      //         constraints: BoxConstraints(
                      //           maxHeight: widget.mediaQuery.height *
                      //               0.96, // Set a sensible max height
                      //         ),
                      //         padding: const EdgeInsets.all(16.0),
                      //         decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //               'Sales Summary',
                      //               style: TextStyle(
                      //                 fontSize: 15,
                      //                 fontWeight: FontWeight.bold,
                      //               ),
                      //             ),
                      //             SizedBox(height: 10), // Add spacing
                      //             Text('Total: \$1234'), // Example summary data
                      //             // Add more detailed summary data or a ListView for larger data
                      //           ],
                      //         ),
                      //       ),
                      //     ),

                      //     // Placeholder for another column or content
                      //     Expanded(
                      //       flex: 2,
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           // Add content here or remove if not needed
                      //           Text('Another section here'),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
