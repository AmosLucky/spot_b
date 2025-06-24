import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:flutter/material.dart';

import 'widgets/scaffold.dart';

class FrontDeskDesktop extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  const FrontDeskDesktop(
      {super.key, required this.systemProvider, required this.user});

  @override
  State<FrontDeskDesktop> createState() => _FrontDeskDesktopState();
}

class _FrontDeskDesktopState extends State<FrontDeskDesktop> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => widget.systemProvider.forcefulRefresh(true),
        child: Scaffolding(
            user: widget.user, systemProvider: widget.systemProvider));
  }
}
