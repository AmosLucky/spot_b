import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/provider/system_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/data/repository/system_repo.dart';
import 'package:spotstock_inventory/screens/desktop/hotel/frontdesk_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/login_desktop.dart';
import 'package:spotstock_inventory/screens/desktop/pos/ecosystem_desktop.dart';
// import 'package:spotstock_inventory/utils/role_detector.dart';

class Header extends StatefulWidget {
  final UserDetails user;
  final SystemProvider systemProvider;

  const Header({super.key, required this.user, required this.systemProvider});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
      // Debug role detection
      _debugRoleDetection();
    });
  }

  void _debugRoleDetection() {
    print('=== HEADER ROLE DEBUG ===');
    print('User Role: ${widget.user.userRole}');
    print('Is Hotel Admin: ${widget.user.isHotelAdmin}');
    print('Is Store Admin: ${widget.user.isStoreAdmin}');
    print('Is Super Admin: ${widget.user.isSuperAdmin}');
    print('========================');
  }

  Future<void> getData() async {
    await Provider.of<SystemProvider>(context, listen: false)
        .forcefulRefresh(true);
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        DateFormat('MMM d, yyyy').format(DateTime.now());

    // Debug the user role in build method
    final userRole = widget.user.userRole;
    final isHotelAdmin = widget.user.isHotelAdmin;
    final isStoreAdmin = widget.user.isStoreAdmin;
    final isSuperAdmin = widget.user.isSuperAdmin;

    print('BUILD - User Role: $userRole, Hotel: $isHotelAdmin, Store: $isStoreAdmin, Super: $isSuperAdmin');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            // Search Bar
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
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                    prefixIcon: Icon(Icons.search, color: primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: const Color(0xFFF5F5F5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Conditional Button Rendering
            Row(
              children: [
                // POS Button - Only show for Store Admins and Super Admins
                if (isStoreAdmin || isSuperAdmin) ...[
                  OutlinedButton(
                    onPressed: () async {
                      bool isOpen = await _isOpenRegister("INVENTORY");
                      if (isOpen) {
                        _navigateToPage(
                          context,
                          EcosystemDesktop(
                            systemProvider: widget.systemProvider,
                            user: widget.user,
                          ),
                        );
                      } else {
                        _showPOSDialog(context, "INVENTORY");
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: primaryColor, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                    child: Text(
                      "POS",
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                  // Add spacing if both buttons will be shown
                  if (isHotelAdmin || isSuperAdmin) const SizedBox(width: 10),
                ],
                
                // HOTEL Button - Only show for Hotel Admins and Super Admins
                if (isHotelAdmin || isSuperAdmin)
                  OutlinedButton(
                    onPressed: () async {
                      bool isOpen = await _isOpenRegister("HOTEL");
                      if (isOpen) {
                        _navigateToPage(
                          context,
                          FrontDeskDesktop(
                            systemProvider: widget.systemProvider,
                            user: widget.user,
                          ),
                        );
                      } else {
                        _showPOSDialog(context, "HOTEL");
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: primaryColor, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                    child: Text(
                      "HOTEL",
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
              ],
            ),
          ]),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, ${widget.user.firstName}',
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  // Debug info - remove this in production
                  Text(
                    'Role: $userRole',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 8),
                      Text(formattedDate),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> _isOpenRegister(String text) async {
    var response =
        await SystemRepo(refresh: false, online: false).isRegisterOpen(text);
    print("----------register open ------------");
    print(response);
    return response['total'] != 0;
  }

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
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('You have logged out successfully')),
                );
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
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _showPOSDialog(BuildContext context, String module) {
    final TextEditingController amountController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$module Register"),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Open register to start your daily sales!"),
                const SizedBox(height: 16),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Cash at Hand",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the cash amount at hand';
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) < 0) {
                      return 'Please enter a valid amount greater than 0';
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
                  var response = await SystemRepo(refresh: false, online: false)
                      .openRegister(
                          module: module, amount: amountController.text);
                  if (response['status'] == true) {
                    if (module == 'INVENTORY') {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return EcosystemDesktop(
                          systemProvider: widget.systemProvider,
                          user: widget.user,
                        );
                      }));
                    } else if (module == 'HOTEL') {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FrontDeskDesktop(
                          systemProvider: widget.systemProvider,
                          user: widget.user,
                        );
                      }));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Failed to open register. Please try again.'),
                      ),
                    );
                  }
                }
              },
              child: const Text("Open"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Register closed!')),
                );
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}






// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:spotstock_inventory/common/common.dart';
// import 'package:spotstock_inventory/common/provider/system_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:spotstock_inventory/data/models/user_details.dart';
// import 'package:spotstock_inventory/data/repository/system_repo.dart';
// import 'package:spotstock_inventory/screens/desktop/hotel/frontdesk_desktop.dart';
// import 'package:spotstock_inventory/screens/desktop/login_desktop.dart';
// import 'package:spotstock_inventory/screens/desktop/pos/ecosystem_desktop.dart';

// // import 'package:spotstock_inventory/data/models/userdetails.dart';
// // import '../../choose_module_desktop.dart';
// // import 'package:spotstock_inventory/screens/desktop/home/hotel_screen_desktop.dart';

// class Header extends StatefulWidget {
//   final UserDetails user;
//   final SystemProvider systemProvider;
//   const Header({super.key, required this.user, required this.systemProvider});

//   @override
//   State<Header> createState() => _HeaderState();
// }

// class _HeaderState extends State<Header> {
//   // @override
//   // void initState() {
//   //   getData();
//   //   // TODO: implement initState
//   //   super.initState();
//   // }

//   void initState() {
//     super.initState();
//     // Delay the data fetch until after the first frame is rendered
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       getData();
//     });
//   }

//   Future<void> getData() async {
//     await Provider.of<SystemProvider>(context, listen: false)
//         .forcefulRefresh(true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Format today's date
//     final String formattedDate =
//         DateFormat('MMM d, yyyy').format(DateTime.now());

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             // Search Bar
//             SizedBox(
//               width: 250,
//               child: Material(
//                 elevation: 10,
//                 shadowColor: Colors.black45,
//                 borderRadius: BorderRadius.circular(25.0),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search',
//                     filled: true,
//                     fillColor: const Color(0xFFF5F5F5),
//                     contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
//                     prefixIcon: Icon(Icons.search, color: primaryColor),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25.0),
//                       borderSide: BorderSide(
//                         color: const Color(0xFFF5F5F5),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             // FRD and POS Buttons
//             Row(
//               children: [
//                 OutlinedButton(
//                   onPressed: () async {
//                     // Check if the register is open before navigating
//                     bool isOpen = await _isOpenRegister("INVENTORY");

//                     if (isOpen) {
//                       _navigateToPage(
//                         context,
//                         EcosystemDesktop(
//                           systemProvider: widget.systemProvider,
//                           user: widget.user,
//                         ),
//                       );
//                     } else {
//                       // Show POS dialog if register is not open
//                       _showPOSDialog(context, "INVENTORY");
//                     }
//                   },
//                   style: OutlinedButton.styleFrom(
//                     side: BorderSide(
//                         color: primaryColor,
//                         width: 1), // Outline color and width
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8), // Rounded corners
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 24, // Horizontal padding
//                       vertical: 16, // Vertical padding
//                     ),
//                   ),
//                   child: Text(
//                     "POS",
//                     style: TextStyle(color: primaryColor),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),

//                 OutlinedButton(
//                   onPressed: () async {
//                     // Check if the register is open before navigating
//                     bool isOpen = await _isOpenRegister("HOTEL");

//                     if (isOpen) {
//                       _navigateToPage(
//                         context,
//                         FrontDeskDesktop(
//                           systemProvider: widget.systemProvider,
//                           user: widget.user,
//                         ),
//                       );
//                     } else {
//                       // Show POS dialog if register is not open
//                       _showPOSDialog(context, "HOTEL");
//                     }
//                   },
//                   style: OutlinedButton.styleFrom(
//                     side: BorderSide(
//                         color: primaryColor,
//                         width: 1), // Outline color and width
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8), // Rounded corners
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 24, // Horizontal padding
//                       vertical: 16, // Vertical padding
//                     ),
//                   ),
//                   child: Text(
//                     "HOTEL",
//                     style: TextStyle(color: primaryColor),
//                   ),
//                 ),
//               ],
//             ),
//           ]),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Welcome, ${widget.user.firstName}',
//                 style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//               ),
//               InkWell(
//                 onTap: () {},
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 10.0, horizontal: 25.0),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.calendar_today, size: 16),
//                       const SizedBox(width: 8),
//                       Text(formattedDate),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // Method to check if the register is open
//   Future<bool> _isOpenRegister(String text) async {
//     var response =
//         await SystemRepo(refresh: false, online: false).isRegisterOpen(text);
//     print("----------register open ------------");
//     print(response);
//     return response['total'] != 0; // Return true if register is open
//   }

//   // Method to show the logout confirmation dialog
//   void _showLogoutDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Logout Confirmation"),
//           content: const Text("Are you sure you want to log out?"),
//           actions: [
//             TextButton(
//               onPressed: () async {
//                 // Proceed with logout logic here
//                 // You can call a method to handle logout (e.g., clearing session or tokens)
//                 Navigator.of(context).pop(); // Close the dialog
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                       content: Text('You have logged out successfully')),
//                 );
//                 // Navigate to login screen or perform other necessary actions
//                 SharedPreferences preferences =
//                     await SharedPreferences.getInstance();
//                 await preferences.clear();

//                 Navigator.of(context).popUntil((route) => route.isFirst);

//                 Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
//                   MaterialPageRoute(
//                     builder: (BuildContext context) {
//                       return const LoginScreenDesktop();
//                     },
//                   ),
//                   (_) => false,
//                 );
//               },
//               child: const Text("Logout"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text("Cancel"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Method to show the POS dialog with validation
//   void _showPOSDialog(BuildContext context, String module) {
//     final TextEditingController amountController = TextEditingController();
//     final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("$module Register"),
//           content: Form(
//             key: formKey,
//             child: Column(
//               mainAxisSize:
//                   MainAxisSize.min, // Set column height based on content
//               children: [
//                 const Text("Open register to start your daily sales!"),
//                 const SizedBox(height: 16), // Add spacing
//                 // TextField for cash at hand with validation
//                 TextFormField(
//                   controller: amountController,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     labelText: "Cash at Hand",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the cash amount at hand';
//                     }
//                     if (double.tryParse(value) == null ||
//                         double.parse(value) < 0) {
//                       return 'Please enter a valid amount greater than 0';
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
//                 // Validate the form before proceeding
//                 if (formKey.currentState?.validate() ?? false) {
//                   Navigator.of(context).pop(); // Close the dialog

//                   // Open register with the entered cash amount
//                   var response = await SystemRepo(refresh: false, online: false)
//                       .openRegister(
//                           module: module, amount: amountController.text);

//                   if (response['status'] == true) {
//                     if (module == 'INVENTORY') {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return EcosystemDesktop(
//                           systemProvider: widget.systemProvider,
//                           user: widget.user,
                          
//                         );
//                       }));
//                     } else if (module == 'HOTEL') {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return FrontDeskDesktop(
//                           systemProvider: widget.systemProvider,
//                           user: widget.user,
//                         );
//                       }));
//                     }
//                     ;
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content:
//                             Text('Failed to open register. Please try again.'),
//                       ),
//                     );
//                   }
//                 }
//               },
//               child: const Text("Open"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Register closed!')),
//                 );
//               },
//               child: const Text("Close"),
//             ),
//           ],
//         );
//       },
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