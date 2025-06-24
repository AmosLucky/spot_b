import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GraphMobileScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> HomeKey;
  final UserDetails user;
  const GraphMobileScreen(
      {super.key, required this.HomeKey, required this.user});

  @override
  State<GraphMobileScreen> createState() => _GraphMobileScreenState();
}

class _GraphMobileScreenState extends State<GraphMobileScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SystemProvider>(
      create: (context) => SystemProvider(),
      child: Consumer<SystemProvider>(
        builder: (context, systemProvider, _) {
          return RefreshIndicator(
              onRefresh: () => systemProvider.refreshData,
              child: _productsList(context, systemProvider));
        },
      ),
    );
  }

  Widget _productsList(BuildContext context, SystemProvider systemProvider) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
          backgroundColor: primaryColor,
          centerTitle: true,
          title: const Text(
            'Stock Warehouse',
            style: TextStyle(color: whiteColor),
          ),
          actions: [],
        ),
        // drawer: SideNavigation(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(),
        ));
  }
}
