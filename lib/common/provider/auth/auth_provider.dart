import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotstock_inventory/data/repository/auth_repo.dart';
// import 'package:spotstock_inventory/utils/toast_utils.dart';
import '../../../data/models/userdetails.dart';
import '../../helpers/user_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

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

  // Online user login
  Future<Map<String, dynamic>> userLogin(
      String email, String password, BuildContext context) async {
    Map<String, dynamic> response = await AuthRepo().loginAPI(email, password);
    if (response['status'] == true) {
      UserPreferences().saveUser(response['data']);
      UserPreferences().isLoggedIn(email, password, response['token']);
      await sharedPreferences.setString('offline_email', email);
      await sharedPreferences.setString('offline_password', password);
      notifyListeners();
      return response;
    }
    return response;
  }

  // Offline user login
  Future<Map<String, dynamic>> offlineLogin(
      String email, String password, BuildContext context) async {
    try {
      String? storedEmail = sharedPreferences.getString('offline_email');
      String? storedPassword = sharedPreferences.getString('offline_password');
      
      if (storedEmail == email && storedPassword == password) {
        UserDetails? user = await UserPreferences().getUser();
        if (user != null) {
          return {
            'status': true,
            'message': 'Offline login successful',
            'data': user,
          };
        }
      }
      return {
        'status': false,
        'message': 'Invalid credentials or no offline data available'
      };
    } catch (e) {
      return {
        'status': false,
        'message': 'Offline login error: $e'
      };
    }
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
    prefs.setString(loggedInToken, value);
  }
}




// ===========================================================
// =================original auth_provider ====================
// import 'package:spotstock_inventory/data/repository/auth_repo.dart';
// import 'package:flutter/material.dart';
// import '../../../data/models/userdetails.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../helpers/user_preferences.dart';

// class AuthProvider extends ChangeNotifier {
//   final SharedPreferences sharedPreferences;

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

//   // user Login
//   Future<Map<String, dynamic>> userLogin(String email, String password) async {
//     Map<String, dynamic> response = await AuthRepo().loginAPI(email, password);
//     if (response['status'] == true) {
//       UserPreferences().saveUser(response['data']);
//       UserPreferences().isLoggedIn(email, password, response['token']);
//       notifyListeners();
//       return response;
//     }
//     return response;
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
//     // notifyListeners();
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

//   // for user authentication
//   Future<String> get isLoggedInToken async {
//     final prefs = sharedPreferences;
//     return prefs.getString(loggedInToken) ?? "";
//   }

//   void setLoggedIn(String value) async {
//     final prefs = sharedPreferences;
//     prefs.setString(loggedInToken, value);
//   }
// }

// ===========================================================
// ================= end original auth_provider ====================



// class AuthProvider extends ChangeNotifier {
//   final SharedPreferences sharedPreferences;
  
//   // Token keys
//   static const String _accessTokenKey = 'access_token';
//   static const String _refreshTokenKey = 'refresh_token';
//   static const String _tokenExpiryKey = 'token_expiry';
//   static const String _isLoggedInKey = 'isLoggedIn';
//   static const String _userEmailKey = 'email';
//   static const String _userPasswordKey = 'password';
  
//   UserDetails? userDetails;
//   bool _isRegisterDone = false;
//   bool get isRegisterDone => _isRegisterDone;
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//   int _current_step = 1;
//   int get currentStep => _current_step;
  
//   String _accessToken = "";
//   String _refreshToken = "";
//   DateTime? _tokenExpiry;
  
//   String get accessToken => _accessToken;
//   bool get isTokenExpired => _tokenExpiry?.isBefore(DateTime.now()) ?? true;
//   bool get isAuthenticated => !isTokenExpired && _accessToken.isNotEmpty;
  
//   AuthProvider({required this.sharedPreferences}) {
//     _loadTokens();
//   }
  
//   // Load tokens from shared preferences
//   Future<void> _loadTokens() async {
//     _accessToken = sharedPreferences.getString(_accessTokenKey) ?? "";
//     _refreshToken = sharedPreferences.getString(_refreshTokenKey) ?? "";
//     final expiryString = sharedPreferences.getString(_tokenExpiryKey);
    
//     if (expiryString != null) {
//       _tokenExpiry = DateTime.parse(expiryString);
//     }
    
//     notifyListeners();
//   }
  
//   // Save tokens to shared preferences
//   Future<void> _saveTokens({
//     required String accessToken,
//     required String refreshToken,
//     DateTime? expiry,
//   }) async {
//     await sharedPreferences.setString(_accessTokenKey, accessToken);
//     await sharedPreferences.setString(_refreshTokenKey, refreshToken);
    
//     if (expiry != null) {
//       await sharedPreferences.setString(_tokenExpiryKey, expiry.toIso8601String());
//       _tokenExpiry = expiry;
//     }
    
//     _accessToken = accessToken;
//     _refreshToken = refreshToken;
    
//     notifyListeners();
//   }
  
//   // User login method
//   Future<Map<String, dynamic>> userLogin(String email, String password) async {
//     startLoading();
    
//     try {
//       Map<String, dynamic> response = await AuthRepo().loginAPI(email, password);
      
//       if (response['status'] == true) {
//         // Save user data
//         UserPreferences().saveUser(response['data']);
        
//         // Save credentials
//         await sharedPreferences.setString(_userEmailKey, email);
//         await sharedPreferences.setString(_userPasswordKey, password);
//         await sharedPreferences.setBool(_isLoggedInKey, true);
        
//         // Extract tokens - adjust keys based on your API response
//         final accessToken = response['token'];
//         final refreshToken = response['refresh_token'] ?? ""; // Update based on your API
        
//         // Calculate expiry (typically 1 hour, adjust as needed)
//         final expiry = DateTime.now().add(Duration(hours: 1));
        
//         // Save tokens
//         await _saveTokens(
//           accessToken: accessToken,
//           refreshToken: refreshToken,
//           expiry: expiry,
//         );
//       }
      
//       doneLoading();
//       return response;
//     } catch (e) {
//       doneLoading();
//       return {
//         'status': false,
//         'message': 'Login failed: ${e.toString()}'
//       };
//     }
//   }
  
//   // Refresh token method
//   Future<Map<String, dynamic>> refreshToken() async {
//     try {
//       if (_refreshToken.isEmpty) {
//         return {
//           'status': false,
//           'message': 'No refresh token available'
//         };
//       }
      
//       Map<String, dynamic> response = await AuthRepo().refreshTokenAPI(_refreshToken);
      
//       if (response['status'] == true) {
//         // Extract tokens - adjust based on your API response
//         final accessToken = response['token'];
//         final refreshToken = response['refresh_token'] ?? _refreshToken;
        
//         // Calculate expiry (typically 1 hour, adjust as needed)
//         final expiry = DateTime.now().add(Duration(hours: 1));
        
//         // Save tokens
//         await _saveTokens(
//           accessToken: accessToken, 
//           refreshToken: refreshToken,
//           expiry: expiry,
//         );
        
//         return {
//           'status': true,
//           'message': 'Token refreshed successfully'
//         };
//       }
      
//       return response;
//     } catch (e) {
//       return {
//         'status': false,
//         'message': 'Failed to refresh token: ${e.toString()}'
//       };
//     }
//   }
  
//   // Check and refresh token if needed
//   Future<String> getValidToken() async {
//     if (isTokenExpired && _refreshToken.isNotEmpty) {
//       final result = await refreshToken();
      
//       if (result['status'] != true) {
//         // If refresh failed, try to perform a silent login
//         return await _performSilentLogin();
//       }
//     }
    
//     return _accessToken;
//   }
  
//   // Silent login with saved credentials
//   Future<String> _performSilentLogin() async {
//     final email = sharedPreferences.getString(_userEmailKey);
//     final password = sharedPreferences.getString(_userPasswordKey);
    
//     if (email != null && password != null) {
//       final response = await userLogin(email, password);
      
//       if (response['status'] == true) {
//         return _accessToken;
//       }
//     }
    
//     // If silent login fails, clear auth state
//     await logout();
//     return "";
//   }
  
//   // Logout method
//   Future<void> logout() async {
//     await sharedPreferences.remove(_accessTokenKey);
//     await sharedPreferences.remove(_refreshTokenKey);
//     await sharedPreferences.remove(_tokenExpiryKey);
//     await sharedPreferences.setBool(_isLoggedInKey, false);
    
//     _accessToken = "";
//     _refreshToken = "";
//     _tokenExpiry = null;
    
//     notifyListeners();
//   }
  
//   // Existing methods
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
//     notifyListeners();
//   }
  
//   void startLoading() {
//     _isLoading = true;
//     notifyListeners();
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
// }