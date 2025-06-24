import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Header extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  const Header({super.key, required this.user, required this.systemProvider});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 250,
              child: Material(
                  elevation: 10,
                  shadowColor: Colors.black45,
                  borderRadius: BorderRadius.circular(25.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10.0),
                      prefixIcon: Icon(Icons.search, color: primaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color(0xFFF5F5F5),
                        ),
                      ),
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<SystemProvider>(
              builder: (context, systemProvider, child) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  systemProvider.dataFetched
                      ? Row(
                        children: [
                          const Text("Downloading Info..."),
                          SizedBox(width: 3.w,),
                          SizedBox(
                            height: 3.h,
                              width: 2.w,
                              child: CircularProgressIndicator()),
                        ],
                      )
                      : const Text('Catalogue',
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold)),
                  InkWell(
                    onTap: () async {
                      print("Loading catalogue ==>>> $loading");
                        await Provider.of<SystemProvider>(context, listen: false)
                            .forcefulRefresh(true);
                        },
                    child: Container(
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: const Row(
                          children: [
                            Icon(Icons.sync, size: 16),
                            SizedBox(width: 8),
                            Text('Refresh Data'),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
