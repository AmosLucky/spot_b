import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:spotstock_inventory/data/repository/system_repo.dart';

import '../api/api_client.dart';

var box = GetStorage();


class AuthRepo extends ApiClient {
  // Login API
  Future<Map<String, dynamic>> loginAPI(String email, String password) async {
    try {
      // String deviceToken = await getDeviceToken();
      print(email);
      var jsonData;
      var data = await http.post(
        Uri.parse('${baseUrl}login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        //"platform":"mobile"
        body: jsonEncode(
          {
            "email": email,
            'password': password,
            'language_code': 'en',
            "platform": "mobile"
          },
        ),
      );
      print(data.body);
      jsonData = json.decode(data.body)['data'];
      if (data.statusCode == 200 && jsonData['token'] != null) {
        jsonData['user']['token'] = jsonData['token'];
        box.write("token", jsonData['token']);
        box.write("email", email.toString());
        box.write("password", password.toString());
        print(' thissssss issss jsonnnnnn dattttaaaa $jsonData');
        return {
          'status': true,
          'message': jsonData['message'],
          'token': jsonData['token'].toString(),
          'data': UserDetails.fromJson(jsonData['user']),
        };
        // UserDetails.fromJson(jsonData['user']);
      } else {
        return {'status': false, 'message': jsonData['message']};
        // UserDetails.fromJson({"status": 401, "message": jsonData['message']});
      }
    } on Exception catch (_) {
      return {
        'status': false,
        'message': 'Internet connection error! ${_.toString()}',
      };
      // UserDetails.fromJson({"status": 404, "message": "Internet connection error!"});
    }
  }
}
// var box = GetStorage();

// class AuthRepo extends ApiClient {
//   // Login API with refresh token support
//   Future<Map<String, dynamic>> loginAPI(String email, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse('${baseUrl}login'),
//         headers: {
//           'Accept': 'application/json',
//           'Content-Type': 'application/json'
//         },
//         body: jsonEncode({
//           "email": email,
//           'password': password,
//           'language_code': 'en',
//           "platform": "mobile"
//         }),
//       );

//       final jsonData = json.decode(response.body);
      
//       if (response.statusCode == 200 && jsonData['data']['token'] != null) {
//         final userData = jsonData['data']['user'];
//         final token = jsonData['data']['token'].toString();
//         final refreshToken = jsonData['data']['refresh_token']?.toString() ?? '';
        
//         // Store tokens and user data
//         userData['token'] = token;
//         box.write("token", token);
//         box.write("refresh_token", refreshToken);
//         box.write("email", email);
//         box.write("password", password);
        
//         return {
//           'status': true,
//           'message': jsonData['data']['message'],
//           'token': token,
//           'refresh_token': refreshToken,
//           'data': UserDetails.fromJson(userData),
//         };
//       } else {
//         return {
//           'status': false,
//           'message': jsonData['message'] ?? 'Login failed'
//         };
//       }
//     } catch (e) {
//       return {
//         'status': false,
//         'message': 'Internet connection error! ${e.toString()}',
//       };
//     }
//   }

//   // Refresh Token API
//   Future<Map<String, dynamic>> refreshTokenAPI(String refreshToken) async {
//     try {
//       final response = await dio.post(
//         '${baseUrl}refresh',
//         data: {
//           'refresh_token': refreshToken,
//         },
//       );
      
//       return response.data;
//     } catch (e) {
//       if (e is DioError) {
//         if (e.response != null) {
//           return e.response!.data;
//         }
//       }
      
//       return {
//         'status': false,
//         'message': 'Network error: ${e.toString()}'
//       };
//     }
//   }
//   // Logout API
//   Future<Map<String, dynamic>> logoutAPI() async {
//     try {
//       final token = box.read("token") ?? '';
//       final response = await http.post(
//         Uri.parse('${baseUrl}logout'),
//         headers: {
//           'Accept': 'application/json',
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token'
//         },
//       );

//       // Clear local storage regardless of API response
//       box.remove("token");
//       box.remove("refresh_token");
//       box.remove("email");
//       box.remove("password");

//       final jsonData = json.decode(response.body);
//       return {
//         'status': response.statusCode == 200,
//         'message': jsonData['message'] ?? 'Logged out successfully'
//       };
//     } catch (e) {
//       // Ensure we clear storage even if API call fails
//       box.remove("token");
//       box.remove("refresh_token");
//       box.remove("email");
//       box.remove("password");
      
//       return {
//         'status': false,
//         'message': 'Logout error: ${e.toString()}',
//       };
//     }
//   }

//   // Check if user is authenticated
//   bool isLoggedIn() {
//     return box.hasData("token") && box.hasData("refresh_token");
//   }

//   // Get current access token
//   String? getCurrentToken() {
//     return box.read("token");
//   }
// }
