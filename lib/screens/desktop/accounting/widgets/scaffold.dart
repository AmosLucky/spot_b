import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:flutter/material.dart';

import 'body.dart';

class Scaffolding extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final String? app;
  const Scaffolding(
      {super.key,
      required this.user,
      required this.systemProvider,
      required this.app});

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
          mediaQuery: MediaQuery.of(context).size,
          user: widget.user,
          app: widget.app,
          systemProvider: widget.systemProvider,
        ),
      ),
    );
  }
}
