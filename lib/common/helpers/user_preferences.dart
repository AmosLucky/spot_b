import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import '../../data/models/userdetails.dart';

final box = GetStorage();

class UserPreferences {
  Future<bool> saveUser(UserDetails user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("id", user.id);
    prefs.setString("first_name", user.firstName);
    prefs.setString("last_name", user.lastName);
    prefs.setString("email", user.email);
    prefs.setString("phone", user.phone);
    prefs.setString("default_password", user.defaultPassword);
    prefs.setString("created_at", user.createdAt);
    prefs.setString("updated_at", user.updatedAt);
    prefs.setInt("status", user.status);
    prefs.setString("language", user.language);
    prefs.setString("token", user.token);

    // Save company and role information if they are not null
    if (user.company != null) {
      prefs.setString("company", jsonEncode(user.company!.toJson()));
    }
    if (user.role != null) {
      prefs.setString("role", jsonEncode(user.role!.toJson()));
    }

    // Save to storage
    box.write('token', user.token);
    box.write('id', user.id);
    box.write('email', user.email);
    box.write('first_name', user.firstName);
    box.write('last_name', user.lastName);

    return prefs.commit();
  }

  Future<UserDetails?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? id = prefs.getInt("id");
    String? firstName = prefs.getString("first_name");
    String? lastName = prefs.getString("last_name");
    String? email = prefs.getString("email");
    String? phone = prefs.getString("phone");
    String? defaultPassword = prefs.getString("default_password");
    String? createdAt = prefs.getString("created_at");
    String? updatedAt = prefs.getString("updated_at");
    int? status = prefs.getInt("status");
    String? language = prefs.getString("language");
    String? token = prefs.getString("token");

    print(id);
    print(firstName);

    print("--- company ---");
    print(prefs.getString("company"));

    //Retrieve company and role information
    Company? company;
    String? companyString = prefs.getString("company");
    if (companyString != null) {
      // company = Company.fromJson(json.decode(companyString));
      try {
        company = Company.fromJson(json.decode(companyString));
      } catch (e) {
        print("Error decoding company JSON: $e");
      }
    }

    Role? role;
    String? roleString = prefs.getString("role");
    if (roleString != null) {
      try {
        role = Role.fromJson(json.decode(roleString));
      } catch (e) {
        print("Error decoding role JSON: $e");
      }
    }

    print("$id");
    print(firstName);
    return UserDetails(
      id: id ?? 0,
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      email: email ?? '',
      phone: phone ?? '',
      defaultPassword: defaultPassword ?? '',
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
      status: status ?? 0,
      token: token ?? '',
      language: language ?? '',
      company: company,
      role: role,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("id");
    prefs.remove("first_name");
    prefs.remove("last_name");
    prefs.remove("email");
    prefs.remove("phone");
    prefs.remove("default_password");
    prefs.remove("created_at");
    prefs.remove("updated_at");
    prefs.remove("status");
    prefs.remove("language");
    prefs.remove("token");
    prefs.remove("company");
    prefs.remove("role");

    box.remove('token');
    box.remove('id');
    box.remove('email');
    box.remove('first_name');
    box.remove('last_name');
  }

  Future<bool> isLoggedIn(
      String username, String password, String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token.isNotEmpty) {
      prefs.setBool("isLoggedIn", true);
      prefs.setString('email', username);
      prefs.setString('password', password);
    } else {
      prefs.setBool("isLoggedIn", false);
    }
    return true;
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }
}
