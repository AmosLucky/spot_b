import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/desktop/catalogue/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class CatalogueDesktop extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final String? app;
  const CatalogueDesktop(
      {super.key,
      required this.user,
      required this.systemProvider,
      required this.app});

  @override
  State<CatalogueDesktop> createState() => _CatalogueDesktopState();
}

class _CatalogueDesktopState extends State<CatalogueDesktop> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => widget.systemProvider.refreshData,
        child: Scaffolding(
          user: widget.user,
          systemProvider: widget.systemProvider,
          app: widget.app ?? "INVENTORY",
        ));
  }
}
