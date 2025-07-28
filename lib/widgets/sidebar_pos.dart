import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/common/utils/logout_utils.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/data/repository/system_repo.dart';
import 'package:spotstock_inventory/screens/desktop/catalogue/catalogue_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/home/home_screen_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/pos/ecosystem_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/pos/screens/desktop_pos_hold_sales_record.dart';
import 'package:spotstock_inventory/screens/desktop/sales/widgets/sale_report_desktop.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../screens/desktop/pos/screens/products_desktop_screen.dart';
import '../screens/desktop/pos/widgets/paid_invoice_list.dart';

class SideBarPos extends StatefulWidget {
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
  State<SideBarPos> createState() => _SideBarPosState();
}

class _SideBarPosState extends State<SideBarPos> {
  bool _isPaidInvoicesOpen = false;

  @override
  Widget build(BuildContext context) {
    // Check if user is admin or super admin
    bool canAccessPaidInvoices = widget.user.isAnyAdmin;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: widget.vertical, horizontal: widget.horizontal),
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
                  height: widget.mediaQuery.height,
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
                        activeItem: widget.activeItem,
                      ),
                      SidebarItem(
                        title: "Hold List",
                        onTap: () {
                          widget.openInvoice!();
                          widget.activeItem.value = "Hold List";
                        },
                        icon: MdiIcons.handBackLeft,
                        activeItem: widget.activeItem,
                      ),
                      // **NEW: Hold List Record sidebar item**
                      SidebarItem(
                        title: "Hold List Record",
                        onTap: () => _navigateToPage(
                          context,
                          DesktopPosHoldSalesRecord(
                            user: widget.user,
                            systemProvider: widget.systemProvider,
                            mediaQuery: widget.mediaQuery,
                            activeItem: widget.activeItem,
                          ),
                          "Hold List Record",
                        ),
                        icon: MdiIcons.formatListBulleted,
                        activeItem: widget.activeItem,
                      ),
                      SidebarItem(
                        title: "Catalogues",
                        onTap: () => _navigateToPage(
                          context,
                          CatalogueDesktop(
                            user: widget.user,
                            systemProvider: widget.systemProvider,
                            app: 'INVENTORY',
                          ),
                          "Catalogues",
                        ),
                        icon: MdiIcons.database,
                        activeItem: widget.activeItem,
                      ),
                      SidebarItem(
                        title: "Calculator",
                        onTap: () => widget.activeItem.value = "Calculator",
                        icon: MdiIcons.calculator,
                        activeItem: widget.activeItem,
                      ),
                      SidebarItem(
                        title: "Sales Report",
                        onTap: () => _navigateToPage(
                          context,
                          const SalesReportDesktop(),
                          "Sales Report",
                        ),
                        icon: MdiIcons.information,
                        activeItem: widget.activeItem,
                      ),
                      SidebarItem(
                        title: "Products",
                        onTap: () => _navigateToPage(
                          context,
                          ProductsDesktopScreen(
                            user: widget.user,
                            systemProvider: widget.systemProvider,
                            mediaQuery: widget.mediaQuery,
                          ),
                          "Products",
                        ),
                        icon: MdiIcons.packageVariant,
                        activeItem: widget.activeItem,
                      ),
                      SidebarItem(
                        title: "Table",
                        onTap: () => widget.activeItem.value = "Table",
                        icon: MdiIcons.table,
                        activeItem: widget.activeItem,
                      ),
                      SidebarItem(
                        title: "Close POS",
                        onTap: () => _showPOSDialog(context, isClosing: true),
                        icon: MdiIcons.close,
                        activeItem: widget.activeItem,
                      ),
                      SidebarItem(
                        title: "Logout",
                        onTap: () => LogoutUtils.showLogoutDialog(context),
                        icon: MdiIcons.logout,
                        activeItem: widget.activeItem,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Paid Invoices Overlay
        if (_isPaidInvoicesOpen && canAccessPaidInvoices)
          Positioned(
            right: 20,
            top: 100,
            child: PaidInvoicesList(
              systemProvider: widget.systemProvider,
              user: widget.user,
              mediaQuery: widget.mediaQuery,
            ),
          ),
      ],
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
                          systemProvider: widget.systemProvider,
                          user: widget.user,
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
    widget.activeItem.value = title;
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
                color: isActive
                    ? Colors.white.withOpacity(0.2)
                    : Colors.transparent,
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
// import 'package:spotstock_inventory/data/models/user_details.dart';
// import 'package:spotstock_inventory/data/repository/system_repo.dart';
// import 'package:spotstock_inventory/screens/desktop/catalogue/catalogue_desktop.dart';
// import 'package:spotstock_inventory/screens/desktop/home/home_screen_desktop.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/ecosystem_desktop.dart';
// import 'package:spotstock_inventory/screens/desktop/sales/widgets/sale_report_desktop.dart';
// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import '../screens/desktop/pos/screens/products_desktop_screen.dart';
// import '../screens/desktop/pos/widgets/paid_invoice_list.dart';
// // import '../screens/desktop/pos/widgets/paid_invoices_list.dart';

// class SideBarPos extends StatefulWidget {
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
//   State<SideBarPos> createState() => _SideBarPosState();
// }

// class _SideBarPosState extends State<SideBarPos> {
//   bool _isPaidInvoicesOpen = false;

//   @override
//   Widget build(BuildContext context) {
//     // Check if user is admin or super admin
//     bool canAccessPaidInvoices = widget.user.isAnyAdmin;

//     return Stack(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(vertical: widget.vertical, horizontal: widget.horizontal),
//           child: Column(
//             children: [
//               // Sidebar Logo
//               Image.asset(
//                 'assets/images/spot-stock-logo.png',
//                 width: 200,
//                 height: 90,
//               ),
//               const SizedBox(height: 10),
//               // Sidebar Items
//               Expanded(
//                 child: Container(
//                   width: 200,
//                   height: widget.mediaQuery.height,
//                   decoration: BoxDecoration(
//                     color: primaryColor,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   child: ListView(
//                     children: [
//                       SidebarItem(
//                         title: "Dashboard",
//                         onTap: () => _navigateToPage(
//                           context,
//                           const HomeScreenDesktop(),
//                           "Dashboard",
//                         ),
//                         icon: Icons.dashboard,
//                         activeItem: widget.activeItem,
//                       ),
//                       SidebarItem(
//                         title: "Hold List",
//                         onTap: () {
//                           widget.openInvoice!();
//                           widget.activeItem.value = "Hold List";
//                         },
//                         icon: MdiIcons.handBackLeft,
//                         activeItem: widget.activeItem,
//                       ),
//                       SidebarItem(
//                         title: "Catalogues",
//                         onTap: () => _navigateToPage(
//                           context,
//                           CatalogueDesktop(
//                             user: widget.user,
//                             systemProvider: widget.systemProvider,
//                             app: 'INVENTORY',
//                           ),
//                           "Catalogues",
//                         ),
//                         icon: MdiIcons.database,
//                         activeItem: widget.activeItem,
//                       ),
//                       SidebarItem(
//                         title: "Calculator",
//                         onTap: () => widget.activeItem.value = "Calculator",
//                         icon: MdiIcons.calculator,
//                         activeItem: widget.activeItem,
//                       ),
//                       SidebarItem(
//                         title: "Sales Report",
//                         onTap: () => _navigateToPage(
//                           context,
//                           const SalesReportDesktop(),
//                           "Sales Report",
//                         ),
//                         icon: MdiIcons.information,
//                         activeItem: widget.activeItem,
//                       ),
//                       SidebarItem(
//                         title: "Products",
//                         onTap: () => _navigateToPage(
//                           context,
//                           ProductsDesktopScreen(
//                             user: widget.user,
//                             systemProvider: widget.systemProvider,
//                             mediaQuery: widget.mediaQuery,
//                           ),
//                           "Products",
//                         ),
//                         icon: MdiIcons.packageVariant,
//                         activeItem: widget.activeItem,
//                       ),
//                       SidebarItem(
//                         title: "Table",
//                         onTap: () => widget.activeItem.value = "Table",
//                         icon: MdiIcons.table,
//                         activeItem: widget.activeItem,
//                       ),
//                       SidebarItem(
//                         title: "Close POS",
//                         onTap: () => _showPOSDialog(context, isClosing: true),
//                         icon: MdiIcons.close,
//                         activeItem: widget.activeItem,
//                       ),
//                       SidebarItem(
//                         title: "Logout",
//                         onTap: () => LogoutUtils.showLogoutDialog(context),
//                         icon: MdiIcons.logout,
//                         activeItem: widget.activeItem,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // Paid Invoices Overlay
//         if (_isPaidInvoicesOpen && canAccessPaidInvoices)
//           Positioned(
//             right: 20,
//             top: 100,
//             child: PaidInvoicesList(
//               systemProvider: widget.systemProvider,
//               user: widget.user,
//               mediaQuery: widget.mediaQuery,
//               // onClose: () {
//               //   setState(() {
//               //     _isPaidInvoicesOpen = false;
//               //   });
//               // },
//             ),
//           ),
//       ],
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
//                           systemProvider: widget.systemProvider,
//                           user: widget.user,
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
//     widget.activeItem.value = title;
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
//                 color: isActive
//                     ? Colors.white.withOpacity(0.2)
//                     : Colors.transparent,
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