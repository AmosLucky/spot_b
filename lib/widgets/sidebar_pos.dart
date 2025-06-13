import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/common/utils/logout_utils.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/data/repository/system_repo.dart';
import 'package:spotstock_inventory/screens/desktop/catalogue/catalogue_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/home/home_screen_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/pos/ecosystem_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/sales/widgets/sale_report_desktop.dart';
// import 'package:spotstock_inventory/screens/desktop/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../screens/desktop/pos/screens/products_desktop_screen.dart';

class SideBarPos extends StatelessWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final Size mediaQuery;
  final double vertical;
  final double horizontal;
  final VoidCallback? openInvoice;
  final ValueNotifier<String> activeItem;

  const SideBarPos({
    super.key,
    required this.user,
    required this.systemProvider,
    this.vertical = 20.0,
    this.horizontal = 15.0,
    required this.mediaQuery,
    this.openInvoice,
    required this.activeItem,
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
              width: 200,
              height: mediaQuery.height,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView(
                children: [
                  SidebarItem(
                    title: "Dashboard",
                    onTap: () => _navigateToPage(
                      context,
                      const HomeScreenDesktop(),
                      "Dashboard",
                    ),
                    icon: Icons.dashboard,
                    activeItem: activeItem,
                  ),
                  SidebarItem(
                    title: "Invoices",
                    onTap: () {
                      openInvoice!();
                      activeItem.value = "Invoices";
                    },
                    icon: MdiIcons.handBackLeft,
                    activeItem: activeItem,
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
                      "Catalogues",
                    ),
                    icon: MdiIcons.database,
                    activeItem: activeItem,
                  ),
                  SidebarItem(
                    title: "Calculator",
                    onTap: () => activeItem.value = "Calculator",
                    icon: MdiIcons.calculator,
                    activeItem: activeItem,
                  ),
                  SidebarItem(
                    title: "Sales Report",
                    onTap: () => _navigateToPage(
                      context,
                      const SalesReportDesktop(),
                      "Sales Report",
                    ),
                    icon: MdiIcons.information,
                    activeItem: activeItem,
                  ),
                  SidebarItem(
                    title: "Products",
                    onTap: () => _navigateToPage(
                      context,
                      ProductsDesktopScreen(
                        user: user,
                        systemProvider: systemProvider,
                        mediaQuery: mediaQuery,
                      ),
                      "Products",
                    ),
                    icon: MdiIcons.packageVariant,
                    activeItem: activeItem,
                  ),
                  SidebarItem(
                    title: "Close POS",
                    onTap: () => _showPOSDialog(context, isClosing: true),
                    icon: MdiIcons.close,
                    activeItem: activeItem,
                  ),
                  SidebarItem(
                    title: "Logout",
                    onTap: () => LogoutUtils.showLogoutDialog(context),
                    icon: MdiIcons.logout,
                    activeItem: activeItem,
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
                  Navigator.of(context).pop();
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
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _navigateToPage(BuildContext context, Widget page, String title) {
    activeItem.value = title;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final IconData icon;
  final ValueNotifier<String> activeItem;

  const SidebarItem({
    super.key,
    required this.title,
    this.onTap,
    required this.icon,
    required this.activeItem,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: activeItem,
      builder: (context, activeTitle, child) {
        bool isActive = activeTitle == title;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: isActive ? Colors.white.withOpacity(0.2) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  icon,
                  color: secondaryColor,
                ),
                onTap: onTap,
                hoverColor: Colors.white.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}




// import 'package:spotstock_inventory/common/common.dart';
// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:spotstock_inventory/common/utils/logout_utils.dart';
// import 'package:spotstock_inventory/data/models/userdetails.dart';
// import 'package:spotstock_inventory/data/repository/system_repo.dart';
// import 'package:spotstock_inventory/screens/desktop/catalogue/catalogue_desktop.dart';
// import 'package:spotstock_inventory/screens/desktop/home/home_screen_desktop.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/ecosystem_desktop.dart';
// import 'package:spotstock_inventory/screens/desktop/sales/widgets/sale_report_desktop.dart';
// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// class SideBarPos extends StatelessWidget {
//   final UserDetails user;
//   final SystemProvider systemProvider;
//   final Size mediaQuery;
//   final double vertical;
//   final double horizontal;
//   final VoidCallback? openInvoice;
//   final ValueNotifier<String> activeItem;

//   const SideBarPos({
//     super.key,
//     required this.user,
//     required this.systemProvider,
//     this.vertical = 20.0,
//     this.horizontal = 15.0,
//     required this.mediaQuery,
//     this.openInvoice,
//     required this.activeItem,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
//       child: Column(
//         children: [
//           // Sidebar Logo
//           Image.asset(
//             'assets/images/spot-stock-logo.png',
//             width: 200,
//             height: 90,
//           ),
//           const SizedBox(height: 10),
//           // Sidebar Items
//           Expanded(
//             child: Container(
//               width: 200,
//               height: mediaQuery.height,
//               decoration: BoxDecoration(
//                 color: primaryColor,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               child: ListView(
//                 children: [
//                   SidebarItem(
//                     title: "Dashboard",
//                     onTap: () => _navigateToPage(
//                       context,
//                       const HomeScreenDesktop(),
//                       "Dashboard",
//                     ),
//                     icon: Icons.dashboard,
//                     activeItem: activeItem,
//                   ),
//                   SidebarItem(
//                     title: "Invoices",
//                     onTap: () {
//                       openInvoice!();
//                       activeItem.value = "Invoices";
//                     },
//                     icon: MdiIcons.handBackLeft,
//                     activeItem: activeItem,
//                   ),
//                   SidebarItem(
//                     title: "Catalogues",
//                     onTap: () => _navigateToPage(
//                       context,
//                       CatalogueDesktop(
//                         user: user,
//                         systemProvider: systemProvider,
//                         app: 'INVENTORY',
//                       ),
//                       "Catalogues",
//                     ),
//                     icon: MdiIcons.database,
//                     activeItem: activeItem,
//                   ),
//                   SidebarItem(
//                     title: "Calculator",
//                     onTap: () => activeItem.value = "Calculator",
//                     icon: MdiIcons.calculator,
//                     activeItem: activeItem,
//                   ),
//                   SidebarItem(
//                     title: "Sales Report",
//                     onTap: () => _navigateToPage(
//                       context,
//                       const SalesReportDesktop(),
//                       "Sales Report",
//                     ),
//                     icon: MdiIcons.information,
//                     activeItem: activeItem,
//                   ),
//                   SidebarItem(
//                     title: "Close POS",
//                     onTap: () => _showPOSDialog(context, isClosing: true),
//                     icon: MdiIcons.close,
//                     activeItem: activeItem,
//                   ),
//                   SidebarItem(
//                     title: "Logout",
//                     onTap: () => LogoutUtils.showLogoutDialog(context),
//                     icon: MdiIcons.logout,
//                     activeItem: activeItem,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<bool> _isOpenRegister(String text) async {
//     var response =
//         await SystemRepo(refresh: false, online: false).isRegisterOpen(text);
//     if (response['total'] == 0) {
//       return false;
//     }
//     return true;
//   }

//   Future<Map<String, dynamic>> _registerInfo() async {
//     var response =
//         await SystemRepo(refresh: false, online: false).getRegisterInfo();
//     return response;
//   }

//   void _showPOSDialog(BuildContext context, {required bool isClosing}) {
//     final TextEditingController amountController = TextEditingController();
//     final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(isClosing ? "Close POS Register" : "Open POS Register"),
//           content: Form(
//             key: formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   isClosing
//                       ? "Enter the closing cash amount to close the register."
//                       : "Open register to start your daily sales!",
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: amountController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     labelText: isClosing
//                         ? "Cash at Hand (Closing)"
//                         : "Cash at Hand (Opening)",
//                     border: const OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the cash amount at hand';
//                     }
//                     if (double.tryParse(value) == null ||
//                         double.parse(value) < 0) {
//                       return 'Please enter a valid amount greater than or equal to 0';
//                     }
//                     return null;
//                   },
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () async {
//                 if (formKey.currentState?.validate() ?? false) {
//                   Navigator.of(context).pop();
//                   if (isClosing) {
//                     var response =
//                         await SystemRepo(refresh: false, online: false)
//                             .closeRegister("INVENTORY", amountController.text);
//                     if (response['status'] == true) {
//                       Navigator.pushReplacement(context,
//                           MaterialPageRoute(builder: (context) {
//                         return const HomeScreenDesktop();
//                       }));
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                             content: Text('Register closed successfully!')),
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                             content: Text(
//                                 'Failed to close register. Please try again.')),
//                       );
//                     }
//                   } else {
//                     var response =
//                         await SystemRepo(refresh: false, online: false)
//                             .openRegister(
//                                 module: 'INVENTORY',
//                                 amount: amountController.text);
//                     if (response['status'] == true) {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return EcosystemDesktop(
//                           systemProvider: systemProvider,
//                           user: user,
//                         );
//                       }));
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                             content: Text(
//                                 'Failed to open register. Please try again.')),
//                       );
//                     }
//                   }
//                 }
//               },
//               child: Text(isClosing ? "Close" : "Open"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text("Cancel"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _navigateToPage(BuildContext context, Widget page, String title) {
//     activeItem.value = title;
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => page),
//     );
//   }
// }

// class SidebarItem extends StatelessWidget {
//   final String title;
//   final VoidCallback? onTap;
//   final IconData icon;
//   final ValueNotifier<String> activeItem;

//   const SidebarItem({
//     super.key,
//     required this.title,
//     this.onTap,
//     required this.icon,
//     required this.activeItem,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<String>(
//       valueListenable: activeItem,
//       builder: (context, activeTitle, child) {
//         bool isActive = activeTitle == title;
//         return MouseRegion(
//           cursor: SystemMouseCursors.click,
//           child: GestureDetector(
//             onTap: onTap,
//             child: Container(
//               margin: const EdgeInsets.symmetric(vertical: 4),
//               decoration: BoxDecoration(
//                 color: isActive ? Colors.white.withOpacity(0.2) : Colors.transparent,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: ListTile(
//                 title: Text(
//                   title,
//                   style: const TextStyle(color: Colors.white),
//                 ),
//                 leading: Icon(
//                   icon,
//                   color: secondaryColor,
//                 ),
//                 onTap: onTap,
//                 hoverColor: Colors.white.withOpacity(0.1),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }