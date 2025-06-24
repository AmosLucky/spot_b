import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';

import 'widgets/scaffold.dart';

class AccountingDesktop extends StatefulWidget {
  final String? app;

  const AccountingDesktop({super.key, this.app = "INVENTORY"});

  @override
  State<AccountingDesktop> createState() => _AccountingDesktopState();
}

class _AccountingDesktopState extends State<AccountingDesktop> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserDetails user = Provider.of<UserProvider>(context, listen: false).user;
    return ChangeNotifierProvider<SystemProvider>(
      create: (context) => SystemProvider(),
      child: Consumer<SystemProvider>(
        builder: (context, systemProvider, _) {
          return RefreshIndicator(
            onRefresh: () => systemProvider.refreshData(),
            child: Scaffolding(
              user: user,
              app: widget.app,
              systemProvider: systemProvider,
            ),
          );
        },
      ),
    );
  }
}
