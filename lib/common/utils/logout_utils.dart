import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/provider/auth/auth_provider.dart';
import 'package:spotstock_inventory/screens/desktop/login_desktop.dart';
// import 'package:spotstock_inventory/screens/desktop/login_screenDesktop.dart';
import 'package:spotstock_inventory/screens/mobile/login_mobile.dart';
import 'package:spotstock_inventory/widgets/responsive.dart';

class LogoutUtils {
  static void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Logout Confirmation",
            style: TextStyle(fontFamily: 'sofia', fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Are you sure you want to log out?",
            style: TextStyle(fontFamily: 'Regular'),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close dialog
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                await authProvider.logout(context); // Call AuthProvider logout
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Responsive.isMobile(context)
                        ? const LoginScreenMobile()
                        : const LoginScreenDesktop(),
                  ),
                );
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Color(0xFFE53935), fontFamily: 'Poppins'),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close dialog
              child: const Text(
                "Cancel",
                style: TextStyle(color: Color(0xFF333333), fontFamily: 'Poppins'),
              ),
            ),
          ],
        );
      },
    );
  }

  static void logout(BuildContext context) {
    showLogoutDialog(context); // Delegate to dialog for confirmation
  }
}