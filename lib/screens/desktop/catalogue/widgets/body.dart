import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:flutter/material.dart';
import 'package:spotstock_inventory/widgets/sidebar_inventory.dart';
import 'package:spotstock_inventory/widgets/sidebar_pos.dart';
import 'card.dart';
import 'header.dart';
import '../../../../widgets/sidebar.dart';

class Body extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final String app;
  const Body(
      {super.key,
      required this.user,
      required this.systemProvider,
      required this.app});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
                    child: widget.app == "HOTEL"
                        ? SideBarHotel(
                            vertical: 20,
                            user: widget.user,
                            systemProvider: widget.systemProvider,
                          )
                        : SideBarInventory(
                            vertical: 20,
                            user: widget.user,
                            systemProvider: widget.systemProvider),
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
                                  title: "Products",
                                  value:
                                      "${widget.systemProvider.dashboardStats['productCount'] ?? '0'}"),
                              HomeCard(
                                  title: "In Stock",
                                  value:
                                      "${widget.systemProvider.dashboardStats['productStockOut'] ?? '0'}"),
                              // Test dommy data
                              HomeCard(
                                  title: "Out of stock",
                                  value:
                                      "${widget.systemProvider.dashboardStats['productsOutOfStock'] ?? '0'}"),
                              // HomeCard(
                              //     title: "Out of Stock",
                              //     value:
                              //         "${widget.systemProvider.dashboardStats['warehouseCount'] ?? '0'}"),
                              HomeCard(
                                  title: "Categories",
                                  value:
                                      "${widget.systemProvider.dashboardStats['categoryCount'] ?? '0'}"),
                              HomeCard(
                                  title: "Customers",
                                  value:
                                      "${widget.systemProvider.dashboardStats['customerCount'] ?? '0'}"),
                              HomeCard(
                                  title: "Hotel Categories",
                                  value:
                                      "${widget.systemProvider.dashboardStats['hotelCategoryCount'] ?? '0'}"),
                              HomeCard(
                                  title: "Hotel Amenities",
                                  value:
                                      "${widget.systemProvider.dashboardStats['hotelAmenityCount'] ?? '0'}"),
                              HomeCard(
                                  title: "Hotel Rooms",
                                  value:
                                      "${widget.systemProvider.dashboardStats['hotelRoomCount'] ?? '0'}"),
                            ],
                          ),
                        ),
                      ),
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
