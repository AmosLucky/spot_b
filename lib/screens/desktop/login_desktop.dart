import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/provider/auth/auth_provider.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/desktop/home/home_screen_desktop.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:simple_text_field/simple_text_field.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:spotstock_inventory/widgets/button_widget.dart';
import 'package:toastification/toastification.dart';
import 'dart:io';

import '../../common/utils/logout_utils.dart';
import '../../common/utils/toast_utils.dart';

final box = GetStorage();

class LoginScreenDesktop extends StatefulWidget {
  const LoginScreenDesktop({super.key});

  @override
  State<LoginScreenDesktop> createState() => _LoginScreenDesktopState();
}

final GlobalKey<FormState> _formState = GlobalKey<FormState>();

class _LoginScreenDesktopState extends State<LoginScreenDesktop> {
  late TextEditingController _email;
  late TextEditingController _password;
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: box.read('email') ?? '');
    _password = TextEditingController(text: box.read('password') ?? '');
  }

  Future<bool> _checkInternetConnection() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        print('No internet connection detected in login screen.');
        return false;
      }
      final result = await InternetAddress.lookup('google.com').timeout(Duration(seconds: 3));
      final isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      print('Internet connection check in login screen: $isConnected');
      return isConnected;
    } catch (e) {
      print('Connectivity check failed in login screen: $e');
      return false;
    }
  }

  Future<bool> _hasCachedCredentials() async {
    final hasCredentials = box.read('cached_email') != null &&
        box.read('cached_password') != null &&
        box.read('cached_user') != null;
    print('Has cached credentials: $hasCredentials');
    return hasCredentials;
  }

  Future<void> _handleLogin() async {
    if (_formState.currentState?.validate() != true) return;

    setState(() => _isLoading = true);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      bool hasInternet = await _checkInternetConnection();
      bool hasCachedCredentials = await _hasCachedCredentials();

      print('Login attempt: hasInternet=$hasInternet, hasCachedCredentials=$hasCachedCredentials');

      if (!hasInternet && !hasCachedCredentials) {
        setState(() => _isLoading = false);
        ToastUtils.showErrorToast(
            context, 'Error', 'No cached credentials available. Please log in online first.');
        return;
      }

      Map<String, dynamic> response;
      if (hasInternet) {
        // Online login
        print('Proceeding with online login.');
        response = await authProvider.userLogin(_email.text, _password.text, context);
      } else {
        // Offline login
        print('Proceeding with offline login.');
        response = await authProvider.offlineLogin(_email.text, _password.text, context);
      }

      setState(() => _isLoading = false);

      if (response['status']) {
        UserDetails user = response['data'];
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        await box.write('hasLoggedIn', true);
        ToastUtils.showSuccessToast(context, 'Login Successful', 'Welcome back!');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomeScreenDesktop()));
      } else {
        ToastUtils.showErrorToast(context, 'Failed Login', response['message']);
      }
    } catch (e) {
      print('Login error: $e');
      setState(() => _isLoading = false);
      ToastUtils.showErrorToast(context, 'Error', 'An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF2FCFE),
                  Color(0xFFFAF1FE),
                ],
                stops: [0, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 500,
              height: 380,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const Text(
                    "Sign In",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontFamily: sofia,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Form(
                    key: _formState,
                    child: Column(
                      children: [
                        const SizedBox(height: 30.0),
                        SimpleTextField(
                          controller: _email,
                          decoration: SimpleInputDecoration(
                            hintText: "Email address",
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                            ),
                            fillColor: const Color(0xFFF5F5F5),
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 18.0,
                              horizontal: 20.0,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        SimpleTextField(
                          controller: _password,
                          obscureText: _obscurePassword,
                          decoration: SimpleInputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                            ),
                            fillColor: const Color(0xFFF5F5F5),
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 18.0,
                              horizontal: 20.0,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        SizedBox(
                          width: double.infinity,
                          child: ButtonGradWidget(
                            onPress: _handleLogin,
                            title: 'Submit',
                            isLoading: _isLoading,
                            buttonColor: primaryColor,
                            titleColor: whiteColor,
                            borderColor: primaryColor,
                            paddingHorizontal: 15.0,
                            paddingVertical: 15.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextButton(
                          onPressed: () => LogoutUtils.logout(context),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              color: Color(0xFFE53935),
                              fontSize: 16,
                              fontFamily: sofia,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



// import 'package:spotstock_inventory/common/common.dart';
// import 'package:spotstock_inventory/common/provider/auth/auth_provider.dart';
// import 'package:spotstock_inventory/common/provider/user_provider.dart';
// import 'package:spotstock_inventory/data/models/userdetails.dart';
// import 'package:spotstock_inventory/screens/desktop/home/home_screen_desktop.dart';
// import 'package:spotstock_inventory/widgets/button_widget.dart';
// // import 'package:spotstock_inventory/utils/toast_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:provider/provider.dart';
// import 'package:simple_text_field/simple_text_field.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:toastification/toastification.dart';

// import '../../common/utils/toast_utils.dart';

// final box = GetStorage();

// class LoginScreenDesktop extends StatefulWidget {
//   const LoginScreenDesktop({super.key});

//   @override
//   State<LoginScreenDesktop> createState() => _LoginScreenDesktopState();
// }

// final GlobalKey<FormState> _formState = GlobalKey<FormState>();

// class _LoginScreenDesktopState extends State<LoginScreenDesktop> {
//   late TextEditingController _email;
//   late TextEditingController _password;
//   bool _isLoading = false;
//   bool _obscurePassword = true;

//   @override
//   void initState() {
//     super.initState();
//     _email = TextEditingController(text: box.read('email') ?? '');
//     _password = TextEditingController(text: box.read('password') ?? '');
//   }

//   Future<bool> _checkInternetConnection() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     return connectivityResult != ConnectivityResult.none;
//   }

//   Future<bool> _isFirstLogin() async {
//     return box.read('hasLoggedIn') != true;
//   }

//   Future<void> _handleLogin() async {
//     if (_formState.currentState?.validate() != true) return;

//     setState(() => _isLoading = true);
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);

//     try {
//       bool hasInternet = await _checkInternetConnection();
//       bool isFirstLogin = await _isFirstLogin();

//       if (isFirstLogin && !hasInternet) {
//         setState(() => _isLoading = false);
//         ToastUtils.showErrorToast(
//             context, 'Error', 'Internet connection required for first login');
//         return;
//       }

//       if (hasInternet) {
//         // Online login
//         var response = await authProvider.userLogin(_email.text, _password.text, context);
//         setState(() => _isLoading = false);

//         if (response['status']) {
//           UserDetails user = response['data'];
//           Provider.of<UserProvider>(context, listen: false).setUser(user);
//           await box.write('hasLoggedIn', true);
//           ToastUtils.showSuccessToast(context, 'Login Successful', 'Welcome back!');
//           Navigator.pushReplacement(context,
//               MaterialPageRoute(builder: (context) => HomeScreenDesktop()));
//         } else {
//           ToastUtils.showErrorToast(context, 'Failed Login', response['message']);
//         }
//       } else {
//         // Offline login
//         var response = await authProvider.offlineLogin(_email.text, _password.text, context);
//         setState(() => _isLoading = false);

//         if (response['status']) {
//           UserDetails user = response['data'];
//           Provider.of<UserProvider>(context, listen: false).setUser(user);
//           ToastUtils.showSuccessToast(context, 'Offline Login Successful', 'Welcome back!');
//           Navigator.pushReplacement(context,
//               MaterialPageRoute(builder: (context) => HomeScreenDesktop()));
//         } else {
//           ToastUtils.showErrorToast(context, 'Failed Login', response['message']);
//         }
//       }
//     } catch (e) {
//       setState(() => _isLoading = false);
//       ToastUtils.showErrorToast(context, 'Error', 'An error occurred: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color(0xFFF2FCFE),
//                   Color(0xFFFAF1FE),
//                 ],
//                 stops: [0, 1],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: Container(
//               width: 500,
//               height: 350,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: Colors.white,
//               ),
//               child: Column(
//                 children: [
//                   const Text(
//                     "Sign In",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 25,
//                       fontFamily: sofia,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Form(
//                     key: _formState,
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 30.0),
//                         SimpleTextField(
//                           controller: _email,
//                           decoration: SimpleInputDecoration(
//                             hintText: "Email address",
//                             hintStyle: TextStyle(
//                               color: Colors.grey[500],
//                             ),
//                             fillColor: const Color(0xFFF5F5F5),
//                             filled: true,
//                             contentPadding: const EdgeInsets.symmetric(
//                               vertical: 18.0,
//                               horizontal: 20.0,
//                             ),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide.none,
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide.none,
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20.0),
//                         SimpleTextField(
//                           controller: _password,
//                           obscureText: _obscurePassword,
//                           decoration: SimpleInputDecoration(
//                             hintText: "Password",
//                             hintStyle: TextStyle(
//                               color: Colors.grey[500],
//                             ),
//                             fillColor: const Color(0xFFF5F5F5),
//                             filled: true,
//                             contentPadding: const EdgeInsets.symmetric(
//                               vertical: 18.0,
//                               horizontal: 20.0,
//                             ),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide.none,
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide.none,
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _obscurePassword
//                                     ? Icons.visibility_off
//                                     : Icons.visibility,
//                                 color: Colors.grey,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _obscurePassword = !_obscurePassword;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 30.0),
//                         SizedBox(
//                           width: double.infinity,
//                           child: ButtonGradWidget(
//                             onPress: _handleLogin,
//                             title: 'Submit',
//                             isLoading: _isLoading,
//                             buttonColor: primaryColor,
//                             titleColor: whiteColor,
//                             borderColor: primaryColor,
//                             paddingHorizontal: 15.0,
//                             paddingVertical: 15.0,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//       );
//   }
// }