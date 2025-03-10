import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/mobile/home/pages/products.dart';
import 'package:spotstock_inventory/screens/mobile/home/pages/transactions.dart';
import 'package:spotstock_inventory/screens/mobile/home/pages/waiting_sync.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/dashboard.dart';

class HomeScreenMobile extends StatefulWidget {
  final bool? isMobile;
  const HomeScreenMobile({super.key, this.isMobile = true});

  @override
  State<HomeScreenMobile> createState() => _HomeScreenMobileState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    UserDetails user = Provider.of<UserProvider>(context).user;

    final screens = [
      DashboardMobileScreen(
        HomeKey: _scaffoldKey,
        user: user,
        isMobile: widget.isMobile,
      ),
      TransactionsMobileScreen(
        HomeKey: _scaffoldKey,
        user: user,
      ),
      WaitingMobileScreen(
        HomeKey: _scaffoldKey,
        user: user,
      ),
      ProductsMobileScreen(
        HomeKey: _scaffoldKey,
        user: user,
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: backgroundColor,
        color: primaryColor,
        animationDuration: Duration(milliseconds: 300),
        items: <Widget>[
          Icon(
            Icons.home,
            color: Colors.white,
            size: 25,
          ), //Icon
          Icon(
            Icons.history,
            color: Colors.white,
            size: 25,
          ), //Icon
          Icon(
            Icons.sync_alt,
            color: Colors.white,
            size: 25,
          ), //Icon
          Icon(
            Icons.production_quantity_limits,
            color: Colors.white,
            size: 25,
          ), //Icon
        ],
        index: index,
        onTap: (index) => setState(() => this.index = index),
      ),
    );
  }
}
