import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotstock_inventory/common/helpers/user_preferences.dart';
import 'package:spotstock_inventory/common/provider/auth/auth_provider.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/screens/mobile/home/home_screen_mobile.dart';
import 'package:spotstock_inventory/screens/mobile/login_mobile.dart';
import 'package:spotstock_inventory/widgets/responsive.dart';

import '../../common/utils/toast_utils.dart';

class SplashScreenMobile extends StatefulWidget {
  const SplashScreenMobile({super.key});

  @override
  _SplashScreenMobileState createState() => _SplashScreenMobileState();
}

class _SplashScreenMobileState extends State<SplashScreenMobile> {
  final GetStorage _storage = GetStorage();

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, navigationPage);
  }

  Future<bool> _checkInternetConnection() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        print('No internet connection detected in splash screen.');
        return false;
      }
      final result = await InternetAddress.lookup('google.com').timeout(const Duration(seconds: 3));
      final isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      print('Internet connection check in splash screen: $isConnected');
      return isConnected;
    } catch (e) {
      print('Connectivity check failed in splash screen: $e');
      return false;
    }
  }

  void navigationPage() async {
    final prefs = await SharedPreferences.getInstance();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final hasLoggedIn = _storage.read('hasLoggedIn') ?? false;

    print('Splash navigation: isLoggedIn=$isLoggedIn, hasLoggedIn=$hasLoggedIn');
    print('cached_email: ${_storage.read('cached_email')}');
    print('cached_user: ${_storage.read('cached_user') != null}');

    try {
      if (isLoggedIn && hasLoggedIn) {
        bool hasInternet = await _checkInternetConnection();
        String? cachedEmail = _storage.read('cached_email');
        String? cachedPassword = _storage.read('cached_password');
        String? cachedUserJson = _storage.read('cached_user');

        print('Splash navigation: hasInternet=$hasInternet, cached_email=$cachedEmail');

        if (cachedEmail != null && cachedPassword != null && cachedUserJson != null) {
          Map<String, dynamic> response;
          if (hasInternet) {
            print('Proceeding with online login from splash screen.');
            response = await authProvider.userLogin(cachedEmail, cachedPassword, context);
          } else {
            print('Proceeding with offline login from splash screen.');
            response = await authProvider.offlineLogin(cachedEmail, cachedPassword, context);
          }

          if (response['status']) {
            UserDetails user = response['data'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            ToastUtils.showSuccessToast(context, 'Success', 'Welcome back!');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreenMobile(
                  isMobile: Responsive.isMobile(context),
                ),
              ),
            );
          } else {
            print('Splash login failed: ${response['message']}');
            ToastUtils.showErrorToast(context, 'Failed Login', response['message']);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreenMobile()),
            );
          }
        } else {
          print('No cached credentials available in splash screen.');
          ToastUtils.showErrorToast(
              context, 'Error', 'No cached credentials available. Please log in.');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreenMobile()),
          );
        }
      } else {
        print('Not logged in, navigating to login screen.');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreenMobile()),
        );
      }
    } catch (e) {
      print('Navigation error in splash screen: $e');
      ToastUtils.showErrorToast(context, 'Error', 'An error occurred: $e');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreenMobile()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF2FCFE),
              Color(0xFFFAF1FE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
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
    );
  }
}