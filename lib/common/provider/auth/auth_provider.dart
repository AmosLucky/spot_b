import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotstock_inventory/common/utils/toast_utils.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:spotstock_inventory/data/repository/auth_repo.dart';
import '../../helpers/user_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:convert';
import 'dart:io';

class AuthProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;
  final GetStorage _storage = GetStorage();

  AuthProvider({required this.sharedPreferences}) {
    _getToken();
  }

  UserDetails? userDetails;
  bool _isRegisterDone = false;
  bool get isRegisterDone => _isRegisterDone;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int _current_step = 1;
  int get currentStep => _current_step;
  String _loggedInToken = "";
  String get loggedInToken => _loggedInToken;

  Future<bool> _checkInternetConnection() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        print('No internet connection detected.');
        return false;
      }
      
      final result = await InternetAddress.lookup('google.com').timeout(Duration(seconds: 3));
      final isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      print('Internet connection check: $isConnected');
      return isConnected;
    } catch (e) {
      print('Connectivity check failed: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> userLogin(
      String email, String password, BuildContext context) async {
    bool hasInternet = await _checkInternetConnection();
    if (!hasInternet) {
      print('No internet for userLogin, should use offlineLogin instead.');
      ToastUtils.showErrorToast(context, 'Error', 'No internet connection. Try offline login.');
      return {
        'status': false,
        'message': 'No internet connection for online login',
      };
    }

    try {
      print('Attempting online login with email: $email');
      Map<String, dynamic> response = await AuthRepo().loginAPI(email, password);
      
      if (response['status'] == true) {
        UserDetails user = response['data'];
        
        // Cache credentials and user details with better error handling
        try {
          await _storage.write('cached_email', email);
          await _storage.write('cached_password', password);
          await _storage.write('cached_user', jsonEncode(user.toJson()));
          print('Cached credentials successfully');
        } catch (e) {
          print('Error caching credentials: $e');
          // Continue with login even if caching fails
        }

        UserPreferences().saveUser(user);
        UserPreferences().isLoggedIn(email, password, response['token']);
        
        await sharedPreferences.setString('offline_email', email);
        await sharedPreferences.setString('offline_password', password);
        
        notifyListeners();
        return response;
      }
      
      print('Online login failed: ${response['message']}');
      return response;
    } catch (e) {
      print('Online login error: $e');
      ToastUtils.showErrorToast(context, 'Error', 'Login failed: $e');
      return {
        'status': false,
        'message': 'Login failed: $e',
      };
    }
  }

  Future<Map<String, dynamic>> offlineLogin(
      String email, String password, BuildContext context) async {
    print('Attempting offline login with email: $email');
    try {
      String? cachedEmail = _storage.read('cached_email');
      String? cachedPassword = _storage.read('cached_password');
      String? cachedUserJson = _storage.read('cached_user');
      
      print('Cached credentials: email=$cachedEmail, has_user=${cachedUserJson != null}');

      if (cachedEmail == null || cachedPassword == null || cachedUserJson == null) {
        print('No cached credentials found.');
        return {
          'status': false,
          'message': 'No cached credentials available. Please log in online first.',
        };
      }

      if (cachedEmail == email && cachedPassword == password) {
        try {
          UserDetails user = UserDetails.fromJson(jsonDecode(cachedUserJson));
          print('Offline login successful for email: $email');
          return {
            'status': true,
            'message': 'Offline login successful',
            'data': user,
          };
        } catch (e) {
          print('Error parsing cached user data: $e');
          return {
            'status': false,
            'message': 'Error loading cached user data: $e',
          };
        }
      } else {
        print('Offline login failed: Invalid credentials');
        return {
          'status': false,
          'message': 'Invalid credentials',
        };
      }
    } catch (e) {
      print('Offline login error: $e');
      return {
        'status': false,
        'message': 'Offline login error: $e',
      };
    }
  }

  Future<void> logout(BuildContext context) async {
    print('Logging out user.');
    await sharedPreferences.remove('isLoggedIn');
    await sharedPreferences.remove('loggedInToken');
    notifyListeners();
    ToastUtils.showSuccessToast(context, 'Logout Successful', 'You have been logged out.');
  }

  void _getToken() async {
    _loggedInToken = await isLoggedInToken;
    notifyListeners();
  }

  void doneRegister(int value) {
    if (value == 4) {
      _isRegisterDone = true;
    } else {
      _isRegisterDone = false;
    }
    notifyListeners();
  }

  void doneLoading() {
    _isLoading = false;
  }

  void startLoading() {
    _isLoading = true;
  }

  void nextStep(int value) {
    if (_current_step < 4) {
      _current_step++;
    }
    print("######### next step registration ###############");
    print(_current_step);
    notifyListeners();
  }

  void prevStep() {
    if (_current_step > 1) {
      _current_step--;
    }
    print("######### previous step registration ###############");
    print(_current_step);
    notifyListeners();
  }

  Future<String> get isLoggedInToken async {
    final prefs = sharedPreferences;
    return prefs.getString(loggedInToken) ?? "";
  }

  void setLoggedIn(String value) async {
    final prefs = sharedPreferences;
    await prefs.setString(loggedInToken, value);
  }
}




// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:spotstock_inventory/common/utils/toast_utils.dart';
// import 'package:spotstock_inventory/data/models/user_details.dart';
// import 'package:spotstock_inventory/data/repository/auth_repo.dart';
// // import 'package:spotstock_inventory/utils/toast_utils.dart';
// // import '../../../data/models/user_details.dart';
// import '../../helpers/user_preferences.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'dart:convert';
// import 'dart:io';

// class AuthProvider extends ChangeNotifier {
//   final SharedPreferences sharedPreferences;
//   final GetStorage _storage = GetStorage();

//   AuthProvider({required this.sharedPreferences}) {
//     _getToken();
//   }

//   UserDetails? userDetails;

//   bool _isRegisterDone = false;
//   bool get isRegisterDone => _isRegisterDone;

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   int _current_step = 1;
//   int get currentStep => _current_step;

//   String _loggedInToken = "";
//   String get loggedInToken => _loggedInToken;

//   Future<bool> _checkInternetConnection() async {
//     try {
//       var connectivityResult = await Connectivity().checkConnectivity();
//       if (connectivityResult == ConnectivityResult.none) {
//         print('No internet connection detected.');
//         return false;
//       }
//       // Verify actual connectivity by pinging a reliable server
//       final result = await InternetAddress.lookup('google.com').timeout(Duration(seconds: 3));
//       final isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//       print('Internet connection check: $isConnected');
//       return isConnected;
//     } catch (e) {
//       print('Connectivity check failed: $e');
//       return false;
//     }
//   }

//   // Online user login
//   Future<Map<String, dynamic>> userLogin(
//       String email, String password, BuildContext context) async {
//     bool hasInternet = await _checkInternetConnection();
//     if (!hasInternet) {
//       print('No internet for userLogin, should use offlineLogin instead.');
//       ToastUtils.showErrorToast(context, 'Error', 'No internet connection. Try offline login.');
//       return {
//         'status': false,
//         'message': 'No internet connection for online login',
//       };
//     }

//     try {
//       print('Attempting online login with email: $email');
//       Map<String, dynamic> response = await AuthRepo().loginAPI(email, password);
//       if (response['status'] == true) {
//         UserDetails user = response['data'];
//         // Cache credentials and user details
//         await _storage.write('cached_email', email);
//         await _storage.write('cached_password', password);
//         await _storage.write('cached_user', jsonEncode(user.toJson()));
//         print('Cached credentials: email=$email, user=${user.toJson()}');
//         UserPreferences().saveUser(user);
//         UserPreferences().isLoggedIn(email, password, response['token']);
//         await sharedPreferences.setString('offline_email', email);
//         await sharedPreferences.setString('offline_password', password);
//         notifyListeners();
//         return response;
//       }
//       print('Online login failed: ${response['message']}');
//       return response;
//     } catch (e) {
//       print('Online login error: $e');
//       ToastUtils.showErrorToast(context, 'Error', 'Login failed: $e');
//       return {
//         'status': false,
//         'message': 'Login failed: $e',
//       };
//     }
//   }

//   // Offline user login
//   Future<Map<String, dynamic>> offlineLogin(
//       String email, String password, BuildContext context) async {
//     print('Attempting offline login with email: $email');
//     try {
//       String? cachedEmail = _storage.read('cached_email');
//       String? cachedPassword = _storage.read('cached_password');
//       String? cachedUserJson = _storage.read('cached_user');

//       print('Cached credentials: email=$cachedEmail, has_user=${cachedUserJson != null}');

//       if (cachedEmail == null || cachedPassword == null || cachedUserJson == null) {
//         print('No cached credentials found.');
//         return {
//           'status': false,
//           'message': 'No cached credentials available. Please log in online first.',
//         };
//       }

//       if (cachedEmail == email && cachedPassword == password) {
//         UserDetails user = UserDetails.fromJson(jsonDecode(cachedUserJson));
//         print('Offline login successful for email: $email');
//         return {
//           'status': true,
//           'message': 'Offline login successful',
//           'data': user,
//         };
//       } else {
//         print('Offline login failed: Invalid credentials');
//         return {
//           'status': false,
//           'message': 'Invalid credentials',
//         };
//       }
//     } catch (e) {
//       print('Offline login error: $e');
//       return {
//         'status': false,
//         'message': 'Offline login error: $e',
//       };
//     }
//   }

//   // Logout
//   Future<void> logout(BuildContext context) async {
//     print('Logging out user.');
//     await sharedPreferences.remove('isLoggedIn');
//     await sharedPreferences.remove('loggedInToken');
//     // Cached credentials in GetStorage are not removed
//     notifyListeners();
//     ToastUtils.showSuccessToast(context, 'Logout Successful', 'You have been logged out.');
//   }

//   void _getToken() async {
//     _loggedInToken = await isLoggedInToken;
//     notifyListeners();
//   }

//   void doneRegister(int value) {
//     if (value == 4) {
//       _isRegisterDone = true;
//     } else {
//       _isRegisterDone = false;
//     }
//     notifyListeners();
//   }

//   void doneLoading() {
//     _isLoading = false;
//   }

//   void startLoading() {
//     _isLoading = true;
//   }

//   void nextStep(int value) {
//     if (_current_step < 4) {
//       _current_step++;
//     }
//     print("######### next step registration ###############");
//     print(_current_step);
//     notifyListeners();
//   }

//   void prevStep() {
//     if (_current_step > 1) {
//       _current_step--;
//     }
//     print("######### previous step registration ###############");
//     print(_current_step);
//     notifyListeners();
//   }

//   Future<String> get isLoggedInToken async {
//     final prefs = sharedPreferences;
//     return prefs.getString(loggedInToken) ?? "";
//   }

//   void setLoggedIn(String value) async {
//     final prefs = sharedPreferences;
//     await prefs.setString(loggedInToken, value);
//   }
// }