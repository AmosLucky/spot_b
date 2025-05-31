import 'package:flutter/material.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/screens/desktop/home/home_screen_desktop.dart';

import 'home/hotel_screen_desktop.dart';

class ChooseModuleDesktop extends StatefulWidget {
  const ChooseModuleDesktop({super.key});

  @override
  _ChooseModuleDesktopState createState() => _ChooseModuleDesktopState();
}

class _ChooseModuleDesktopState extends State<ChooseModuleDesktop> {
  @override
  void initState() {
    super.initState();
  }

  void navigateToModule(String module) async {
    if (module == "HOTEL") {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const HotelScreenDesktop(); // Replace with your HotelScreen widget
      }));
    } else if (module == "INVENTORY") {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const HomeScreenDesktop(); // Replace with your InventoryScreen widget
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF2FCFE), // #F2FCFE
              Color(0xFFFAF1FE), // #FAF1FE
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // HOTEL module card
              GestureDetector(
                onTap: () => navigateToModule("HOTEL"),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 2,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: 200,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.hotel, size: 40, color: secondaryColor),
                        const SizedBox(height: 10),
                        Text(
                          "HOTEL",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 30),
              // INVENTORY module card
              GestureDetector(
                onTap: () => navigateToModule("INVENTORY"),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 2,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: 200,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inventory, size: 40, color: Colors.purple),
                        const SizedBox(height: 10),
                        Text(
                          "INVENTORY",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
