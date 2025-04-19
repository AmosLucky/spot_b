import 'dart:convert';
import 'package:spotstock_inventory/data/models/userdetails.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

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
            {"email": email, 'password': password, 'language_code': 'en', "platform":"mobile"}, ),
      );
      print(data.body);
      jsonData = json.decode(data.body)['data'];
      if (data.statusCode == 200 && jsonData['token'] != null) {
        jsonData['user']['token'] = jsonData['token'];
        box.write("token", jsonData['token']);
        box.write("email", email.toString());
        box.write("password", password.toString());
        return {
          'status': true,
          'message': jsonData['message'],
          'token': jsonData['token'].toString(),
          'data': UserDetails.fromJson(jsonData['user'])
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
