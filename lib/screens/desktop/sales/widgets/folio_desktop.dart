import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/desktop/sales/folio_screen_desktop.dart';


class FolioDesktop extends StatefulWidget {
  const FolioDesktop({super.key});

  @override
  State<FolioDesktop> createState() => _FolioDesktopState();
}

class _FolioDesktopState extends State<FolioDesktop> {
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
                child: FolioScreenDesktop(user: user, systemProvider: systemProvider, mediaQuery: MediaQuery.of(context).size,));
          },
        ),
      ),
    );
  }
}
