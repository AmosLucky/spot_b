import 'package:flutter/material.dart';

class HotelDashboardPage extends StatefulWidget {
  const HotelDashboardPage({super.key});

  @override
  State<HotelDashboardPage> createState() => _HotelDashboardPageState();
}

class _HotelDashboardPageState extends State<HotelDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        body: Container(
          
          child: Text("Dashboard"),
        ));
  }
}
