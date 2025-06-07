import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotstock_inventory/common/provider/auth/auth_provider.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:spotstock_inventory/common/provider/user_provider.dart';
import 'package:spotstock_inventory/screens/desktop/login_desktop.dart';
// import 'package:spotstock_inventory/utils/toast_utils.dart';

import '../../common/helpers/user_preferences.dart';
import '../../common/utils/toast_utils.dart';
import 'home/home_screen_desktop.dart';

class SplashScreenDesktop extends StatefulWidget {
  const SplashScreenDesktop({super.key});

  @override
  _SplashScreenDesktopState createState() => _SplashScreenDesktopState();
}

class _SplashScreenDesktopState extends State<SplashScreenDesktop> {
  startTime() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, navigationPage);
  }

  void navigationPage() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('email'));
    print(prefs.getString('password'));
    print(prefs.getBool('isLoggedIn'));

    if (prefs.getBool('isLoggedIn') == true) {
      print("okkkkkk");
      AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
      UserPreferences userPreferences = UserPreferences();
      UserDetails? user = await userPreferences.getUser();

      if (user != null) {
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const HomeScreenDesktop();
        }));
        debugPrint("Logged in without api call");
      } else {
        await auth
            .userLogin(
          prefs.getString('email')!,
          prefs.getString('password')!,
          context,
        )
            .then((response) {
          if (response['status'] == true) {
            UserDetails user = response['data'];
            context.read<UserProvider>().setUser(user);
            ToastUtils.showSuccessToast(context, 'Login Successful', 'Welcome back!');
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const HomeScreenDesktop();
            }));
          } else {
            ToastUtils.showErrorToast(context, 'Failed Login', response['message']);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const LoginScreenDesktop();
            }));
          }
        }).catchError((error) {
          ToastUtils.showErrorToast(context, 'Error', 'An error occurred: $error');
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const LoginScreenDesktop();
          }));
        });
      }
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const LoginScreenDesktop();
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



// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:spotstock_inventory/common/provider/auth/auth_provider.dart';
// import 'package:spotstock_inventory/data/models/userdetails.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:provider/provider.dart';
// import 'package:spotstock_inventory/common/provider/user_provider.dart';
// import 'package:spotstock_inventory/screens/desktop/login_desktop.dart';

// import '../../common/helpers/user_preferences.dart';
// import '../mobile/home/home_screen_mobile.dart';
// import 'home/home_screen_desktop.dart';

// class SplashScreenDesktop extends StatefulWidget {
//   const SplashScreenDesktop({super.key});

//   @override
//   _SplashScreenDesktopState createState() => _SplashScreenDesktopState();
// }

// class _SplashScreenDesktopState extends State<SplashScreenDesktop> {
//   startTime() async {
//     var duration = const Duration(seconds: 5);
//     return Timer(duration, navigationPage);
//   }

//   @override
//   void initState() {
//     super.initState();
//     startTime();
//   }

//   void navigationPage() async {
//     final prefs = await SharedPreferences.getInstance();
//     print(prefs.getString('email'));
//     print(prefs.getString('password'));
//     print(prefs.getBool('isLoggedIn'));
//     // var user = await Provider.of<UserProvider>(context, listen: false).isLoggedIn();
//     // if (user == true) {
//     //   Navigator.push(context, MaterialPageRoute(builder: (context) {
//     //     return const HomeScreenDesktop();
//     //   }));
//     // } else {
//     //   Navigator.push(context, MaterialPageRoute(builder: (context) {
//     //     return const LoginScreenDesktop();
//     //   }));
//     // }
//     if (prefs.getBool('isLoggedIn') == true) {
//       print("okkkkkk");
//       AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
//       UserPreferences userPreferences = UserPreferences();
//       UserDetails? user = (await userPreferences.getUser());

//       if (user != null) {
//         Provider.of<UserProvider>(context, listen: false).setUser(user);
//         Navigator.push(context, MaterialPageRoute(builder: (context) {
//           return const HomeScreenDesktop();
//         }));
//         debugPrint("Logged in without api call");
//       } else {
//         await auth
//             .userLogin(
//           prefs.getString('email')!,
//           prefs.getString('password')!,
//         )
//             .then((response) {
//           if (response['status'] == true) {
//             UserDetails user = response['data'];
//             context.read<UserProvider>().setUser(user);
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return const HomeScreenDesktop();
//             }));
//           }
//         }).catchError((error) {
//           Navigator.push(context, MaterialPageRoute(builder: (context) {
//             return const LoginScreenDesktop();
//           }));
//         });
//       }
//     } else {
//       // ignore: use_build_context_synchronously
//       Navigator.push(context, MaterialPageRoute(builder: (context) {
//         return const LoginScreenDesktop();
//       }));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFFF2FCFE), // #F2FCFE
//               Color(0xFFFAF1FE), // #FAF1FE
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: Image.asset(
//             'assets/images/spot-stock-white.png',
//             width: 250,
//             height: 200,
//             color: const Color(0xFF473069), // Set the image color to #473069
//             colorBlendMode: BlendMode.srcIn,
//           ),
//         ),
//       ),
//     );
//   }
// }
