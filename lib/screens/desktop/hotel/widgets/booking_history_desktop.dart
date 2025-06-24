import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/screens/desktop/accounting/widgets/booking%20history.dart';

class BookingHistoryDesktop extends StatefulWidget {
  const BookingHistoryDesktop({super.key});

  @override
  State<BookingHistoryDesktop> createState() => _BookingHistoryDesktopState();
}

class _BookingHistoryDesktopState extends State<BookingHistoryDesktop> {
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
                child: BookingHistoryScreen(
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
