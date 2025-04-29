import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/desktop/accounting/accounting_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/accounting/widgets/booking%20history.dart';
import 'package:spotstock_inventory/screens/desktop/catalogue/catalogue_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/home/home_screen_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/home/hotel_screen_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/hotel/frontdesk_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/hotel/widgets/booking_history_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/login_desktop.dart';
import 'package:flutter/material.dart';
import 'package:spotstock_inventory/screens/desktop/maintenance.dart';
import 'package:spotstock_inventory/screens/desktop/maintenance_desktop_screen.dart';
import 'package:spotstock_inventory/screens/desktop/sales/folio_screen_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/sales/sales_screen_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/sales/widgets/folio_desktop.dart';

import '../data/repository/system_repo.dart';

class SideBarHotel extends StatelessWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final double vertical;
  final double horizontal;

  const SideBarHotel({
    super.key,
    required this.user,
    required this.systemProvider,
    this.vertical = 20.0,
    this.horizontal = 15.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: Column(
        children: [
          // Sidebar Logo
          Image.asset(
            'assets/images/spot-stock-logo.png',
            width: 200,
            height: 90,
          ),
          const SizedBox(height: 10),

          // Sidebar Items
          Expanded(
            child: Container(
              width: 300, // Fixed width for sidebar
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(16), // Set the border radius
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ListView(
                children: [
                  SidebarItem(
                    title: "Dashboard",
                    onTap: () => _navigateToPage(
                      context,
                      const HotelScreenDesktop(),
                    ),
                  ),
                  SidebarItem(
                    title: "Booking History",
                    onTap:
                        // () {}
                        () => _navigateToPage(
                      context,
                      const BookingHistoryDesktop(),
                    ),
                  ),
                  SidebarItem(
                    title: "Maintenance",
                    onTap:
                        //  () {}
                        () => _navigateToPage(
                      context,
                      MaintenanceDesktop(),
                    ),
                  ),
                  SidebarItem(
                    title: "Folio",
                    onTap: () => _navigateToPage(
                      context,
                      const FolioDesktop(),
                    ),
                  ),
                  SidebarItem(
                    title: "Catalogues",
                    onTap: () => _navigateToPage(
                      context,
                      CatalogueDesktop(
                        user: user,
                        systemProvider: systemProvider,
                        app: 'HOTEL',
                      ),
                    ),
                  ),
                  SidebarItem(
                    title: "Reports",
                    onTap: () => _navigateToPage(
                      context,
                      const AccountingDesktop(app: "HOTEL"),
                    ),
                  ),
                  SidebarItem(
                    title: "Close Hotel",
                    onTap: () => _showHotelDialog(context, isClosing: true),
                  ),
                  SidebarItem(
                    title: "Logout",
                    onTap: () => _showLogoutDialog(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to show the logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout Confirmation"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () async {
                // Proceed with logout logic here
                // You can call a method to handle logout (e.g., clearing session or tokens)
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('You have logged out successfully')),
                );
                // Navigate to login screen or perform other necessary actions
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();

                Navigator.of(context).popUntil((route) => route.isFirst);

                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const LoginScreenDesktop();
                    },
                  ),
                  (_) => false,
                );
              },
              child: const Text("Logout"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _showHotelDialog(BuildContext context, {required bool isClosing}) {
    final TextEditingController amountController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(isClosing ? "Close HOTEL Register" : "Open HOTEL Register"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isClosing
                      ? "Enter the closing cash amount to close the register."
                      : "Open register to start your daily sales!",
                ),
                const SizedBox(height: 16),
                // TextField for cash amount (opening or closing) with validation
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: isClosing
                        ? "Cash at Hand (Closing)"
                        : "Cash at Hand (Opening)",
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the cash amount at hand';
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) < 0) {
                      // Allow zero, block negatives
                      return 'Please enter a valid amount greater than or equal to 0';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  Navigator.of(context).pop(); // Close dialog

                  if (isClosing) {
                    var response =
                        await SystemRepo(refresh: false, online: false)
                            .closeRegister("HOTEL", amountController.text);

                    if (response['status'] == true) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const HomeScreenDesktop();
                      }));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Register closed successfully!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Failed to close register. Please try again.')),
                      );
                    }
                  } else {
                    var response =
                        await SystemRepo(refresh: false, online: false)
                            .openRegister(
                                module: 'HOTEL', amount: amountController.text);

                    if (response['status'] == true) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FrontDeskDesktop(
                          systemProvider: systemProvider,
                          user: user,
                        );
                      }));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Failed to open register. Please try again.')),
                      );
                    }
                  }
                }
              },
              child: Text(isClosing ? "Close" : "Open"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  // Method to navigate to a specified page
  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const SidebarItem({required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(color: Colors.black, fontSize: 15)),
      onTap: onTap,
    );
  }
}
