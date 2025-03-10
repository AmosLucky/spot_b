import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:flutter/material.dart';

import 'body.dart';

class Scaffolding extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  const Scaffolding(
      {super.key, required this.user, required this.systemProvider});

  @override
  State<Scaffolding> createState() => _ScaffoldingState();
}

class _ScaffoldingState extends State<Scaffolding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF2FCFE),
              Color(0xFFFAF1FE),
            ],
          ),
        ),
        child: Body(
          user: widget.user,
          systemProvider: widget.systemProvider,
          mediaQuery: MediaQuery.of(context).size,
        ),
      ),
    );
  }
}
