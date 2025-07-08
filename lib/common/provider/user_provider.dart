import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import '../../data/models/user_details.dart';

final box = GetStorage();

class UserProvider with ChangeNotifier {
  UserDetails _user = UserDetails(
    id: 0,
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    defaultPassword: '',
    createdAt: '',
    updatedAt: '',
    status: 0,
    token: '',
    language: '',
    isAdmin: 0, // Add this line
    isSuper: 0, // Add this line
    company: null,
    role: null,
  );

  UserDetails get user => _user;

  void setUser(UserDetails user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> isLoggedIn() async {
    String? token = box.read("token");
    return token != null ? true : false;
  }
}




// import 'package:flutter/foundation.dart';
// import 'package:get_storage/get_storage.dart';

// import '../../data/models/user_details.dart';

// final box = GetStorage();

// class UserProvider with ChangeNotifier {
//   UserDetails _user = UserDetails(
//       id: 0,
//       firstName: '',
//       lastName: '',
//       email: '',
//       phone: '',
//       defaultPassword: '',
//       createdAt: '',
//       updatedAt: '',
//       status: 0,
//       token: '',
//       language: '',
//       company: null,
//       role: null);

//   UserDetails get user => _user;

//   void setUser(UserDetails user) {
//     _user = user;
//     notifyListeners();
//   }

//   Future<bool> isLoggedIn() async {
//     String? token = box.read("token");
//     return token != null ? true : false;
//   }
// }