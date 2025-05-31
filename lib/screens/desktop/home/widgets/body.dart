import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/desktop/home/widgets/card.dart';
import 'package:spotstock_inventory/screens/desktop/home/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:spotstock_inventory/widgets/sidebar_inventory.dart';

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

SystemProvider systemProvider = SystemProvider();
Future<List<dynamic>> getTables() async {
  print("Down Bar Table");
  return await systemProvider.getTables();
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
                    child: SideBarInventory(
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
                                  title: "Total Sales",
                                  value: Money.format(widget.systemProvider
                                          .dashboardStats['overallAmount'] ??
                                      0)),
                              HomeCard(
                                  title: "Today Sales",
                                  value: Money.format(widget.systemProvider
                                          .dashboardStats['salesToday'] ??
                                      0)),
                              HomeCard(
                                  title: "Yesterday",
                                  value: Money.format(widget.systemProvider
                                          .dashboardStats['yesterdayAmount'] ??
                                      0)),
                              HomeCard(
                                  title: "Last Week",
                                  value: Money.format(widget.systemProvider
                                          .dashboardStats['lastweekAmount'] ??
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

  @override
  void initState() {
    // TODO: implement initState
    //getTables();
    SystemProvider systemProvider = SystemProvider();
    systemProvider.fetchTables(true, true);
    super.initState();
  }
}
