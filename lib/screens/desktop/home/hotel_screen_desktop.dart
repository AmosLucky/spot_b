import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/screens/desktop/home/hotel/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HotelScreenDesktop extends StatefulWidget {
  const HotelScreenDesktop({super.key});

  @override
  State<HotelScreenDesktop> createState() => _HotelScreenDesktopState();
}

class _HotelScreenDesktopState extends State<HotelScreenDesktop> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserDetails user = Provider.of<UserProvider>(context).user;
    return ChangeNotifierProvider<SystemProvider>(
      create: (context) => SystemProvider(),
      child: Consumer<SystemProvider>(
        builder: (context, systemProvider, _) {
          return RefreshIndicator(
              onRefresh: () => systemProvider.refreshData,
              child: Scaffolding(user: user, systemProvider: systemProvider));
        },
      ),
    );
  }
}
