import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/desktop/accounting/accounting_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/catalogue/catalogue_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/home/home_screen_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/login_desktop.dart';
import 'package:flutter/material.dart';

class SideBarInventory extends StatelessWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final double vertical;
  final double horizontal;

  const SideBarInventory({
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
              width: 200, // Fixed width for sidebar
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(16), // Set the border radius
              ),
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  SidebarItem(
                    title: "Dashboard",
                    onTap: () => _navigateToPage(
                      context,
                      const HomeScreenDesktop(),
                    ),
                  ),
                  SidebarItem(
                    title: "Catalogues",
                    onTap: () => _navigateToPage(
                      context,
                      CatalogueDesktop(
                        user: user,
                        systemProvider: systemProvider,
                        app: 'INVENTORY',
                      ),
                    ),
                  ),
                  SidebarItem(
                    title: "Reports",
                    onTap: () => _navigateToPage(
                      context,
                      const AccountingDesktop(app: "INVENTORY"),
                    ),
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
  const SidebarItem({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.black)),
      onTap: onTap,
    );
  }
}
