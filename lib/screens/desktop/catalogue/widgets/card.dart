import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/widgets/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String value;

  const HomeCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    Size hquery = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: primaryColor, // Background color of the card
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              SizedBox(
                  height: 38,
                  width: 38,
                  child: Material(
                      elevation: 10,
                      shadowColor: Colors.black45,
                      borderRadius: BorderRadius.circular(30.0),
                      child: CircleAvatar(
                          radius: 30,
                          backgroundColor: secondaryColor,
                          child: Center(
                            child: IconButton(
                              icon: Icon(
                                MdiIcons.syncCircle,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          )))),
              const SizedBox(
                width: 10,
              ),
              Text(title,
                  style: const TextStyle(color: Colors.grey, fontSize: 16))
            ]),
            SizedBox(height: hquery.height * 0.05),
            DottedLine(
              height: 2.0, // Thickness of the dotted line
              color: secondaryColor, // Color of the dotted line
            ),
            SizedBox(height: hquery.height * 0.02),
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
