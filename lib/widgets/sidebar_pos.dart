import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/data/repository/system_repo.dart';
import 'package:spotstock_inventory/screens/desktop/catalogue/catalogue_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/home/home_screen_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/login_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/pos/ecosystem_desktop.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:spotstock_inventory/screens/desktop/sales/sales_screen_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/sales/widgets/sale_report_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/sales/widgets/sales_report.dart';

class SideBarPos extends StatelessWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final Size mediaQuery;
  final double vertical;
  final double horizontal;
  final VoidCallback? openInvoice;

  const SideBarPos({
    super.key,
    required this.user,
    required this.systemProvider,
    this.vertical = 20.0,
    this.horizontal = 15.0,
    required this.mediaQuery,
    this.openInvoice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: Column(
        children: [
          // Sidebar Items
          Expanded(
            child: Container(
              width: 200, // Fixed width for sidebar
              height: mediaQuery.height,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius:
                    BorderRadius.circular(10), // Set the border radius
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView(
                children: [
                  SidebarItem(
                      title: "Dashboard",
                      onTap: () => _navigateToPage(
                            context,
                            const HomeScreenDesktop(),
                          ),
                      icon: Icons.dashboard),
                  SidebarItem(
                    title: "Invoices",
                    onTap: () {
                      openInvoice!();
                    },
                    icon: MdiIcons.handBackLeft,
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
                    icon: MdiIcons.database,
                  ),
                  SidebarItem(
                    title: "Calculator",
                    icon: MdiIcons.calculator,
                  ),
                  // SidebarItem(
                  //   title: "Sales",
                  //   icon: MdiIcons.information,
                  //   onTap: () => _navigateToPage(
                  //     context,
                  //     const SalesDesktop(),
                  //   ),
                  // ),
                  SidebarItem(
                    title: "Sales Report",
                    icon: MdiIcons.information,
                    onTap: () => _navigateToPage(
                      context,
                      const SalesReportDesktop(),
                    ),
                  ),
                  SidebarItem(
                    title: "Close POS",
                    icon: MdiIcons.close,
                    onTap: () => _showPOSDialog(context, isClosing: true),
                  ),
                  SidebarItem(
                    title: "Logout",
                    icon: MdiIcons.logout,
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

  Future<bool> _isOpenRegister(String text) async {
    var response =
        await SystemRepo(refresh: false, online: false).isRegisterOpen(text);
    if (response['total'] == 0) {
      return false;
    }
    return true;
  }

  Future<Map<String, dynamic>> _registerInfo() async {
    var response =
        await SystemRepo(refresh: false, online: false).getRegisterInfo();
    return response;
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

  // Method to show the POS dialog with validation
  void _showPOSDialog(BuildContext context, {required bool isClosing}) {
    final TextEditingController amountController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isClosing ? "Close POS Register" : "Open POS Register"),
          content: Form(
            key: formKey,
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
                if (formKey.currentState?.validate() ?? false) {
                  Navigator.of(context).pop(); // Close dialog

                  if (isClosing) {
                    var response =
                        await SystemRepo(refresh: false, online: false)
                            .closeRegister("INVENTORY", amountController.text);

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
                                module: 'INVENTORY',
                                amount: amountController.text);

                    if (response['status'] == true) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return EcosystemDesktop(
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

  // Method to navigate to the CatalogueDesktop page
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
  final IconData icon; // Add an icon property
  final Color tileColor; // Add a tile color property
  const SidebarItem({super.key, 
    required this.title,
    this.onTap,
    required this.icon,
    this.tileColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
      leading: Icon(
        icon,
        color: secondaryColor,
      ),
    );
  }
}
