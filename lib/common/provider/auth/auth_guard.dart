import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/provider/auth/auth_provider.dart';



// class AuthGuard extends StatelessWidget {
//   final Widget child;
//   final Widget loginScreen;
  
//   const AuthGuard({
//     Key? key,
//     required this.child,
//     required this.loginScreen,
//   }) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
    
//     // First, check if we have a valid token
//     if (authProvider.isAuthenticated) {
//       return child;
//     }
    
//     // If not authenticated, show login screen
//     return loginScreen;
//   }
// }