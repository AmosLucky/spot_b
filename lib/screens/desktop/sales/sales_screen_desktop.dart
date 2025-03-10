import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';

import 'widgets/scaffold.dart';

class SalesDesktop extends StatefulWidget {
  const SalesDesktop({super.key});

  @override
  State<SalesDesktop> createState() => _SalesDesktopState();
}

class _SalesDesktopState extends State<SalesDesktop> {
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
