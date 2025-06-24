import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/screens/desktop/accounting/widgets/scaffold.dart';
import 'package:spotstock_inventory/screens/desktop/maintenance.dart';
import 'package:spotstock_inventory/screens/desktop/sales/folio_screen_desktop.dart';

class MaintenanceDesktop extends StatefulWidget {
  const MaintenanceDesktop({super.key});

  @override
  State<MaintenanceDesktop> createState() => _MaintenanceDesktopState();
}

class _MaintenanceDesktopState extends State<MaintenanceDesktop> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserDetails user = Provider.of<UserProvider>(context).user;
    
    return Scaffold(
      body: ChangeNotifierProvider<SystemProvider>(
        create: (context) => SystemProvider(),
        child: Consumer<SystemProvider>(
          builder: (context, systemProvider, _) {
            return RefreshIndicator(
                onRefresh: () => systemProvider.refreshData,
                child: RoomMaintenanceScreen(
                  user: user,
                  systemProvider: systemProvider,
                  mediaQuery: MediaQuery.of(context).size,
                ));
          },
        ),
      ),
    );
  }
}
