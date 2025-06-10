import 'package:spotstock_inventory/common/money.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/desktop/home/widgets/card.dart';
import 'package:spotstock_inventory/screens/desktop/home/widgets/header.dart';
import 'package:spotstock_inventory/widgets/sidebar_inventory.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final Size mediaQuery;
  const Body({
    super.key,
    required this.user,
    required this.systemProvider,
    required this.mediaQuery,
  });

  @override
  State<Body> createState() => _BodyState();
}

SystemProvider systemProvider = SystemProvider();
Future<List<dynamic>> getTables() async {
  print("Down Bar Table");
  return await systemProvider.getTables();
}

class _BodyState extends State<Body> {
  final ValueNotifier<String> _activeItem = ValueNotifier<String>("Dashboard");

  @override
  void initState() {
    SystemProvider systemProvider = SystemProvider();
    systemProvider.fetchTables(true, true);
    super.initState();
  }

  @override
  void dispose() {
    _activeItem.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                  ),
                  child: SizedBox(
                    width: 250,
                    child: SideBarInventory(
                      vertical: 20,
                      user: widget.user,
                      systemProvider: widget.systemProvider,
                      activeItem: _activeItem,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(
                        user: widget.user,
                        systemProvider: widget.systemProvider,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: GridView(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 1.5,
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




// import 'package:spotstock_inventory/common/money.dart';
// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:spotstock_inventory/data/models/userdetails.dart';
// import 'package:spotstock_inventory/screens/desktop/home/widgets/card.dart';
// import 'package:spotstock_inventory/screens/desktop/home/widgets/header.dart';
// import 'package:spotstock_inventory/widgets/sidebar_inventory.dart';
// import 'package:flutter/material.dart';

// class Body extends StatefulWidget {
//   final UserDetails user;
//   final SystemProvider systemProvider;
//   final Size mediaQuery;
//   const Body({
//     super.key,
//     required this.user,
//     required this.systemProvider,
//     required this.mediaQuery,
//   });

//   @override
//   State<Body> createState() => _BodyState();
// }

// SystemProvider systemProvider = SystemProvider();
// Future<List<dynamic>> getTables() async {
//   print("Down Bar Table");
//   return await systemProvider.getTables();
// }

// class _BodyState extends State<Body> {
//   final ValueNotifier<String> _activeItem = ValueNotifier<String>("Dashboard");

//   @override
//   void initState() {
//     SystemProvider systemProvider = SystemProvider();
//     systemProvider.fetchTables(true, true);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _activeItem.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ConstrainedBox(
//                   constraints: BoxConstraints(
//                     maxHeight: MediaQuery.of(context).size.height,
//                   ),
//                   child: SizedBox(
//                     width: 200,
//                     child: SideBarInventory(
//                       vertical: 20,
//                       user: widget.user,
//                       systemProvider: widget.systemProvider,
//                       activeItem: _activeItem,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Header(
//                         user: widget.user,
//                         systemProvider: widget.systemProvider,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: SizedBox(
//                           height: MediaQuery.of(context).size.height,
//                           child: GridView(
//                             gridDelegate:
//                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 4,
//                               crossAxisSpacing: 16,
//                               mainAxisSpacing: 16,
//                               childAspectRatio: 1.5,
//                             ),
//                             children: [
//                               HomeCard(
//                                   title: "Total Sales",
//                                   value: Money.format(widget.systemProvider
//                                           .dashboardStats['overallAmount'] ??
//                                       0)),
//                               HomeCard(
//                                   title: "Today Sales",
//                                   value: Money.format(widget.systemProvider
//                                           .dashboardStats['salesToday'] ??
//                                       0)),
//                               HomeCard(
//                                   title: "Yesterday",
//                                   value: Money.format(widget.systemProvider
//                                           .dashboardStats['yesterdayAmount'] ??
//                                       0)),
//                               HomeCard(
//                                   title: "Last Week",
//                                   value: Money.format(widget.systemProvider
//                                           .dashboardStats['lastweekAmount'] ??
//                                       0)),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }