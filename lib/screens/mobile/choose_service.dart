import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/screens/mobile/pos/ecosystem_mobile_2.dart';
import 'package:spotstock_inventory/screens/mobile/pos/pos_mobile.dart';
import 'package:spotstock_inventory/widgets/dialogs.dart';
// import 'package:spotstock_inventory/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChooseServiceScreen extends StatefulWidget {
  final SystemProvider systemProvider;
  final bool isMobile;
  const ChooseServiceScreen(
      {super.key, required this.systemProvider, required this.isMobile});

  @override
  State<ChooseServiceScreen> createState() => _ChooseServiceScreenState();
}

class _ChooseServiceScreenState extends State<ChooseServiceScreen> {
  final List<ServiceModel> services = [
    ServiceModel('POS', 'assets/images/pos.png', '/pos'),
    ServiceModel('Hotel', 'assets/images/hotel.png', '/hotel'),
    // ServiceModel('Hotel', 'assets/service2.png', '/service2'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          'Choose Service',
          style: TextStyle(color: whiteColor),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(10.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Set the number of columns you want
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: services.length,
            itemBuilder: (BuildContext context, int index) {
              return ServiceBox(
                service: services[index],
                systemProvider: widget.systemProvider,
                isMobile: widget.isMobile,
              );
            },
          )),
    );
  }
}

class ServiceBox extends StatelessWidget {
  final ServiceModel service;
  final SystemProvider systemProvider;
  final bool isMobile;
  const ServiceBox(
      {Key? key,
      required this.service,
      required this.systemProvider,
      required this.isMobile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle onTap logic
        if (service.url == '/pos') {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EcosystemMobile2Screen(
              systemProvider: systemProvider,
              category: const {"id": 0, "name": "Products"},
            );
          }));
        }
        if (service.url == '/hotel') {
          Dialogs.alertDialog(
              context,
              "Warning",
              "Hotel service is still under maintenance!",
              "cancel",
              "save", []);
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return ChooseServiceScreen(systemProvider: systemProvider);
          // }));
        }
      },
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(12.0), // Adjust the radius as needed
        child: Material(
          elevation: 4.0, // Adjust the elevation as needed
          color: Colors.white, // Replace with your box color
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    service.imagePath,
                    height: 80.0, // Adjust the height as needed
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    service.name,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ServiceModel {
  final String name;
  final String imagePath;
  final String url;

  ServiceModel(this.name, this.imagePath, this.url);
}
