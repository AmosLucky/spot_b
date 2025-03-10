import 'package:spotstock_inventory/common/common.dart';
import 'package:flutter/material.dart';

class WelcomeMobileScreen extends StatelessWidget {
  const WelcomeMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .50,
            // decoration: BoxDecoration(
            //   image:
            // ),
          )
        ],
      ),
    );
  }
}
