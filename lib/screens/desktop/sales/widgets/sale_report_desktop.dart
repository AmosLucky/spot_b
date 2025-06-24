import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/screens/desktop/sales/widgets/sales_report.dart';

class SalesReportDesktop extends StatefulWidget {
  const SalesReportDesktop({super.key});

  @override
  State<SalesReportDesktop> createState() => _SalesReportDesktopState();
}

class _SalesReportDesktopState extends State<SalesReportDesktop> {
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
                child: DesktopSalesReportScreen(
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
