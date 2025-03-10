import 'dart:convert';
import 'dart:developer';

import 'package:spotstock_inventory/common/provider/auth/auth_provider.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:spotstock_inventory/screens/mobile/home/home_screen_mobile.dart';
import 'package:spotstock_inventory/screens/mobile/login_mobile.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotstock_inventory/widgets/responsive.dart';

import '../../common/helpers/user_preferences.dart';

class SplashScreenMobile extends StatefulWidget {
  @override
  _SplashScreenMobileState createState() => _SplashScreenMobileState();
}

class _SplashScreenMobileState extends State<SplashScreenMobile> {
  startTime() async {
    var _duration = const Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('email'));
    print(prefs.getString('password'));
    print(prefs.getBool('isLoggedIn'));
    // try {
    //   //UserDetails
    //   UserPreferences userPreferences = UserPreferences();
    //   UserDetails? userDetails = (await userPreferences.getUser());
    //
    //   print("UserData = ${userDetails?.token}");
    // } catch(e) {
    //   log(e.toString());
    // }

    if (prefs.getBool('isLoggedIn') == true) {
      //UserDetails
      UserPreferences userPreferences = UserPreferences();
      UserDetails? user = (await userPreferences.getUser());
      AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);

      if(user != null) {
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomeScreenMobile(
            isMobile: Responsive.isMobile(context),
          );
        }));
        debugPrint("Logged in without api call");
      } else {
        await auth.userLogin(
          prefs.getString('email')!,
          prefs.getString('password')!,
        ).then((response) {
          if (response['status'] == true) {
            UserDetails user = response['data'];
            context.read<UserProvider>().setUser(user);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomeScreenMobile(
                isMobile: Responsive.isMobile(context),
              );
            }));
            debugPrint("Logged in with api call");
          }
        }).catchError((error) {
          debugPrint("User is not logged in");
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const LoginScreenMobile();
          }));
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const LoginScreenMobile();
      }));
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF2FCFE), // #F2FCFE
              Color(0xFFFAF1FE), // #FAF1FE
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
            color: const Color(0xFF473069), // Set the image color to #473069
            colorBlendMode: BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
