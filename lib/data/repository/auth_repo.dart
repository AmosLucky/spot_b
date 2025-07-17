import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:spotstock_inventory/data/models/user_details.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:spotstock_inventory/data/repository/system_repo.dart';
import '../api/api_client.dart';

var box = GetStorage();

class AuthRepo extends ApiClient {
  Future<Map<String, dynamic>> loginAPI(String email, String password) async {
    try {
      print('Login attempt for email: $email');
      
      var data = await http.post(
        Uri.parse('${baseUrl}login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "email": email,
          'password': password,
          'language_code': 'en',
          "platform": "mobile"
        }),
      );

      print('Response status code: ${data.statusCode}');
      print('Response body: ${data.body}');

      if (data.statusCode == 200) {
        var responseBody = json.decode(data.body);
        
        // Check if response has the expected structure
        if (responseBody['data'] == null) {
          return {
            'status': false,
            'message': 'Invalid response format from server',
          };
        }

        var jsonData = responseBody['data'];
        
        // Ensure token exists
        if (jsonData['token'] == null) {
          return {
            'status': false,
            'message': 'No authentication token received',
          };
        }

        // Ensure user data exists
        if (jsonData['user'] == null) {
          return {
            'status': false,
            'message': 'No user data received',
          };
        }

        // Add token to user data for UserDetails creation
        jsonData['user']['token'] = jsonData['token'];
        
        // Store credentials
        box.write("token", jsonData['token']);
        box.write("email", email.toString());
        box.write("password", password.toString());

        print('Login successful, creating UserDetails object');
        
        try {
          UserDetails user = UserDetails.fromJson(jsonData['user']);
          
          return {
            'status': true,
            'message': responseBody['message'] ?? 'Login successful',
            'token': jsonData['token'].toString(),
            'data': user,
          };
        } catch (e) {
          print('Error creating UserDetails: $e');
          print('User data: ${jsonData['user']}');
          return {
            'status': false,
            'message': 'Error processing user data: $e',
          };
        }
      } else {
        // Handle non-200 status codes
        var errorResponse = json.decode(data.body);
        return {
          'status': false,
          'message': errorResponse['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      print('Login API exception: $e');
      return {
        'status': false,
        'message': 'Internet connection error! ${e.toString()}',
      };
    }
  }
}




// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:spotstock_inventory/data/models/user_details.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:spotstock_inventory/data/repository/system_repo.dart';

// import '../api/api_client.dart';

// var box = GetStorage();


// class AuthRepo extends ApiClient {
//   // Login API
//   Future<Map<String, dynamic>> loginAPI(String email, String password) async {
//     try {
//       // String deviceToken = await getDeviceToken();
//       print(email);
//       var jsonData;
//       var data = await http.post(
//         Uri.parse('${baseUrl}login'),
//         headers: {
//           'Accept': 'application/json',
//           'Content-Type': 'application/json'
//         },
//         //"platform":"mobile"
//         body: jsonEncode(
//           {
//             "email": email,
//             'password': password,
//             'language_code': 'en',
//             "platform": "mobile"
//           },
//         ),
//       );
//       print(data.body);
//       jsonData = json.decode(data.body)['data'];
//       if (data.statusCode == 200 && jsonData['token'] != null) {
//         jsonData['user']['token'] = jsonData['token'];
//         box.write("token", jsonData['token']);
//         box.write("email", email.toString());
//         box.write("password", password.toString());
//         print(' thissssss issss jsonnnnnn dattttaaaa $jsonData');
//         return {
//           'status': true,
//           'message': jsonData['message'],
//           'token': jsonData['token'].toString(),
//           'data': UserDetails.fromJson(jsonData['user']),
//         };
//         // UserDetails.fromJson(jsonData['user']);
//       } else {
//         return {'status': false, 'message': jsonData['message']};
//         // UserDetails.fromJson({"status": 401, "message": jsonData['message']});
//       }
//     } on Exception catch (_) {
//       return {
//         'status': false,
//         'message': 'Internet connection error! ${_.toString()}',
//       };
//       // UserDetails.fromJson({"status": 404, "message": "Internet connection error!"});
//     }
//   }
// }