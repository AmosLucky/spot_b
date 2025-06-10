import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:spotstock_inventory/common/utils/logout_utils.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/desktop/accounting/accounting_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/catalogue/catalogue_desktop.dart';
// import 'package:spotstock_inventory/screens desktop/home/home_screen_desktop.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../screens/desktop/home/home_screen_desktop.dart';

class SideBarInventory extends StatelessWidget {
  final UserDetails user;
  final SystemProvider systemProvider;
  final double vertical;
  final double horizontal;
  final ValueNotifier<String> activeItem;

  const SideBarInventory({
    super.key,
    required this.user,
    required this.systemProvider,
    this.vertical = 20.0,
    this.horizontal = 15.0,
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
                    title: "Reports",
                    onTap: () => _navigateToPage(
                      context,
                      const AccountingDesktop(app: "INVENTORY"),
                      "Reports",
                    ),
                    icon: MdiIcons.chartBar,
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




// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:spotstock_inventory/common/utils/logout_utils.dart';
// import 'package:spotstock_inventory/data/models/userdetails.dart';
// import 'package:spotstock_inventory/screens/desktop/accounting/accounting_desktop.dart';
// import 'package:spotstock_inventory/screens/desktop/catalogue/catalogue_desktop.dart';
// import 'package:spotstock_inventory/screens/desktop/home/home_screen_desktop.dart';
// // import 'package:spotstock_inventory/utils/logout_utils.dart';
// import 'package:flutter/material.dart';

// class SideBarInventory extends StatelessWidget {
//   final UserDetails user;
//   final SystemProvider systemProvider;
//   final double vertical;
//   final double horizontal;

//   const SideBarInventory({
//     super.key,
//     required this.user,
//     required this.systemProvider,
//     this.vertical = 20.0,
//     this.horizontal = 15.0,
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
//               width: 200, // Fixed width for sidebar
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16), // Set the border radius
//               ),
//               padding: const EdgeInsets.all(20),
//               child: ListView(
//                 children: [
//                   SidebarItem(
//                     title: "Dashboard",
//                     onTap: () => _navigateToPage(
//                       context,
//                       const HomeScreenDesktop(),
//                     ),
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
//                     ),
//                   ),
//                   SidebarItem(
//                     title: "Reports",
//                     onTap: () => _navigateToPage(
//                       context,
//                       const AccountingDesktop(app: "INVENTORY"),
//                     ),
//                   ),
//                   SidebarItem(
//                     title: "Logout",
//                     onTap: () => LogoutUtils.showLogoutDialog(context),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Method to navigate to a specified page
//   void _navigateToPage(BuildContext context, Widget page) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => page),
//     );
//   }
// }

// class SidebarItem extends StatelessWidget {
//   final String title;
//   final VoidCallback? onTap;
//   const SidebarItem({super.key, required this.title, this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(title, style: const TextStyle(color: Colors.black)),
//       onTap: onTap,
//     );
//   }
// }