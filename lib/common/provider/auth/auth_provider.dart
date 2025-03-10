import 'package:spotstock_inventory/data/repository/auth_repo.dart';
import 'package:flutter/material.dart';
import '../../../data/models/userdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // user Login
  Future<Map<String, dynamic>> userLogin(String email, String password) async {
    Map<String, dynamic> response = await AuthRepo().loginAPI(email, password);
    if (response['status'] == true) {
      UserPreferences().saveUser(response['data']);
      UserPreferences().isLoggedIn(email, password, response['token']);
      notifyListeners();
      return response;
    }
    return response;
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
    // notifyListeners();
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

  // for user authentication
  Future<String> get isLoggedInToken async {
    final prefs = await sharedPreferences;
    return prefs.getString(loggedInToken) ?? "";
  }

  void setLoggedIn(String value) async {
    final prefs = await sharedPreferences;
    prefs.setString(loggedInToken, value);
  }
}
