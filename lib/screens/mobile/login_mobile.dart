import 'package:spotstock_inventory/common/common.dart';
import 'package:spotstock_inventory/common/provider/auth/auth_provider.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/common/utils/logout_utils.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/screens/mobile/home/home_screen_mobile.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/widgets/button_widget.dart';
import 'package:spotstock_inventory/widgets/responsive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:toastification/toastification.dart';
import 'dart:io';

import '../../common/utils/toast_utils.dart';

final box = GetStorage();

class LoginScreenMobile extends StatefulWidget {
  const LoginScreenMobile({super.key});

  @override
  State<LoginScreenMobile> createState() => _LoginScreenMobileState();
}

class _LoginScreenMobileState extends State<LoginScreenMobile> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
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

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
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
            MaterialPageRoute(builder: (context) => HomeScreenMobile(
                  isMobile: Responsive.isMobile(context),
                )));
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
    double defaultFontSize = 14;
    double defaultIconSize = 17;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: Responsive.isMobile(context)
              ? const EdgeInsets.symmetric(horizontal: 20, vertical: 30)
              : const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 130,
                      height: 130,
                      alignment: Alignment.center,
                      child: Center(
                        child: Image.asset(
                          'assets/images/spot-stock-white.png',
                          width: 250,
                          height: 200,
                          color: const Color(0xFF473069),
                          colorBlendMode: BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const Text("Please, Login to continue!"),
                    const SizedBox(height: 15),
                    Form(
                      key: _formState,
                      child: Column(
                        children: [
                          TextField(
                            controller: _email,
                            showCursor: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Color(0xFF666666),
                                size: defaultIconSize,
                              ),
                              fillColor: Color(0xFFF2F3F5),
                              hintStyle: TextStyle(
                                  color: Color(0xFF666666),
                                  fontSize: defaultFontSize),
                              hintText: "Email address",
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: _password,
                            showCursor: true,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Color(0xFF666666),
                                size: defaultIconSize,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Color(0xFF666666),
                                  size: defaultIconSize,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              fillColor: Color(0xFFF2F3F5),
                              hintStyle: TextStyle(
                                color: Color(0xFF666666),
                                fontSize: defaultFontSize,
                              ),
                              hintText: "Password",
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Responsive.isMobile(context) ? 15 : 20),
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
                    const SizedBox(height: 10),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}




// import 'package:spotstock_inventory/common/common.dart';
// import 'package:spotstock_inventory/common/provider/auth/auth_provider.dart';
// import 'package:spotstock_inventory/common/provider/user_provider.dart';
// import 'package:spotstock_inventory/data/models/userdetails.dart';
// import 'package:spotstock_inventory/screens/mobile/home/home_screen_mobile.dart';
// import 'package:spotstock_inventory/widgets/button_widget.dart';
// // import 'package:spotstock_inventory/utils/toast_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:provider/provider.dart';
// import 'package:spotstock_inventory/widgets/responsive.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:toastification/toastification.dart';

// import '../../common/utils/toast_utils.dart';

// final box = GetStorage();

// class LoginScreenMobile extends StatefulWidget {
//   const LoginScreenMobile({super.key});

//   @override
//   State<LoginScreenMobile> createState() => _LoginScreenMobileState();
// }

// class _LoginScreenMobileState extends State<LoginScreenMobile> {
//   final GlobalKey<FormState> _formState = GlobalKey<FormState>();
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

//   @override
//   void dispose() {
//     _email.dispose();
//     _password.dispose();
//     super.dispose();
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
//               MaterialPageRoute(builder: (context) => HomeScreenMobile(
//                     isMobile: Responsive.isMobile(context),
//                   )));
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
//               MaterialPageRoute(builder: (context) => HomeScreenMobile(
//                     isMobile: Responsive.isMobile(context),
//                   )));
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
//     double defaultFontSize = 14;
//     double defaultIconSize = 17;

//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         color: Colors.white,
//         child: Padding(
//           padding: Responsive.isMobile(context)
//               ? const EdgeInsets.symmetric(horizontal: 20, vertical: 30)
//               : const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
//           child: Column(
//             children: <Widget>[
//               Flexible(
//                 flex: 5,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Container(
//                       width: 130,
//                       height: 130,
//                       alignment: Alignment.center,
//                       child: Center(
//                         child: Image.asset(
//                           'assets/images/spot-stock-white.png',
//                           width: 250,
//                           height: 200,
//                           color: const Color(0xFF473069),
//                           colorBlendMode: BlendMode.srcIn,
//                         ),
//                       ),
//                     ),
//                     const Text("Please, Login to continue!"),
//                     const SizedBox(height: 15),
//                     Form(
//                       key: _formState,
//                       child: Column(
//                         children: [
//                           TextField(
//                             controller: _email,
//                             showCursor: true,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                                 borderSide: BorderSide(
//                                   width: 0,
//                                   style: BorderStyle.none,
//                                 ),
//                               ),
//                               filled: true,
//                               prefixIcon: Icon(
//                                 Icons.mail,
//                                 color: Color(0xFF666666),
//                                 size: defaultIconSize,
//                               ),
//                               fillColor: Color(0xFFF2F3F5),
//                               hintStyle: TextStyle(
//                                   color: Color(0xFF666666),
//                                   fontSize: defaultFontSize),
//                               hintText: "Email address",
//                             ),
//                           ),
//                           const SizedBox(height: 15),
//                           TextField(
//                             controller: _password,
//                             showCursor: true,
//                             obscureText: _obscurePassword,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                                 borderSide: BorderSide(
//                                   width: 0,
//                                   style: BorderStyle.none,
//                                 ),
//                               ),
//                               filled: true,
//                               prefixIcon: Icon(
//                                 Icons.lock_outline,
//                                 color: Color(0xFF666666),
//                                 size: defaultIconSize,
//                               ),
//                               suffixIcon: IconButton(
//                                 icon: Icon(
//                                   _obscurePassword
//                                       ? Icons.visibility_off
//                                       : Icons.visibility,
//                                   color: Color(0xFF666666),
//                                   size: defaultIconSize,
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     _obscurePassword = !_obscurePassword;
//                                   });
//                                 },
//                               ),
//                               fillColor: Color(0xFFF2F3F5),
//                               hintStyle: TextStyle(
//                                 color: Color(0xFF666666),
//                                 fontSize: defaultFontSize,
//                               ),
//                               hintText: "Password",
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: Responsive.isMobile(context) ? 15 : 20),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ButtonGradWidget(
//                         onPress: _handleLogin,
//                         title: 'Submit',
//                         isLoading: _isLoading,
//                         buttonColor: primaryColor,
//                         titleColor: whiteColor,
//                         borderColor: primaryColor,
//                         paddingHorizontal: 15.0,
//                         paddingVertical: 15.0,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }