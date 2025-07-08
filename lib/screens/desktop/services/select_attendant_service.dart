import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotstock_inventory/common/helpers/database_engine.dart';
import '../model/select_attendant_model.dart';

class SelectAttendantService {
  final String _baseUrl = 'https://app.spotstockinventory.com/api/attendants';
  final String _setPinUrl = 'https://app.spotstockinventory.com/api/set-pin';
  final String _verifyPinUrl = 'https://app.spotstockinventory.com/api/verify-pin';

  Future<List<SelectAttendantModel>> getAttendants() async {
    final store = await DatabaseEngine.instance.getStore();
    final attendantBox = store.box<SelectAttendantModel>();

    try {
      // Retrieve token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      print('Attempting to fetch attendants with token: $token');

      if (token.isEmpty) {
        // Try to load from cache if no token
        final cachedAttendants = attendantBox.getAll();
        if (cachedAttendants.isNotEmpty) {
          print('Loaded ${cachedAttendants.length} attendants from cache');
          return cachedAttendants;
        }
        throw Exception('No authentication token found and no cached data available');
      }

      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print('API response status: ${response.statusCode}');
      print('API response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'] ?? [];
        final attendants = data.map((json) => SelectAttendantModel.fromJson(json)).toList();

        // Cache the attendants
        attendantBox.removeAll(); // Clear old data
        attendantBox.putMany(attendants);
        print('Cached ${attendants.length} attendants');

        return attendants;
      } else {
        // Try to load from cache if API call fails
        final cachedAttendants = attendantBox.getAll();
        if (cachedAttendants.isNotEmpty) {
          print('API call failed, loaded ${cachedAttendants.length} attendants from cache');
          return cachedAttendants;
        }
        throw Exception('Failed to load attendants: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Try to load from cache on any error
      final cachedAttendants = attendantBox.getAll();
      if (cachedAttendants.isNotEmpty) {
        print('Error fetching attendants, loaded ${cachedAttendants.length} attendants from cache');
        return cachedAttendants;
      }
      print('Error fetching attendants: $e');
      throw Exception('Error fetching attendants: $e');
    }
  }

  Future<bool> createPin(int userId, String pin) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      
      if (token.isEmpty) {
        throw Exception('No authentication token found');
      }

      final response = await http.post(
        Uri.parse(_setPinUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'user_id': userId,
          'pin': pin,
        }),
      );

      print('Create PIN response status: ${response.statusCode}');
      print('Create PIN response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse['success'] == true;
      } else {
        throw Exception('Failed to create PIN: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error creating PIN: $e');
      throw Exception('Error creating PIN: $e');
    }
  }

  Future<Map<String, dynamic>> verifyPin(int userId, String pin) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      
      if (token.isEmpty) {
        throw Exception('No authentication token found');
      }

      final response = await http.post(
        Uri.parse(_verifyPinUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'user_id': userId,
          'pin': pin,
        }),
      );

      print('Verify PIN response status: ${response.statusCode}');
      print('Verify PIN response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return {
          'success': jsonResponse['success'] == true,
          'message': jsonResponse['message'] ?? 'PIN verified successfully'
        };
      } else {
        return {
          'success': false,
          'message': 'Invalid PIN: ${response.statusCode} - ${response.body}'
        };
      }
    } catch (e) {
      print('Error verifying PIN: $e');
      return {
        'success': false,
        'message': 'Error verifying PIN: $e'
      };
    }
  }
}




// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:spotstock_inventory/common/helpers/database_engine.dart';
// import '../model/select_attendant_model.dart';

// class SelectAttendantService {
//   final String _baseUrl = 'https://app.spotstockinventory.com/api/attendants';

//   Future<List<SelectAttendantModel>> getAttendants() async {
//     final store = await DatabaseEngine.instance.getStore();
//     final attendantBox = store.box<SelectAttendantModel>();

//     try {
//       // Retrieve token from SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('token') ?? '';
//       print('Attempting to fetch attendants with token: $token');

//       if (token.isEmpty) {
//         // Try to load from cache if no token
//         final cachedAttendants = attendantBox.getAll();
//         if (cachedAttendants.isNotEmpty) {
//           print('Loaded ${cachedAttendants.length} attendants from cache');
//           return cachedAttendants;
//         }
//         throw Exception('No authentication token found and no cached data available');
//       }

//       final response = await http.get(
//         Uri.parse(_baseUrl),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//         },
//       );

//       print('API response status: ${response.statusCode}');
//       print('API response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonResponse = json.decode(response.body);
//         final List<dynamic> data = jsonResponse['data'] ?? [];
//         final attendants = data.map((json) => SelectAttendantModel.fromJson(json)).toList();

//         // Cache the attendants
//         attendantBox.removeAll(); // Clear old data
//         attendantBox.putMany(attendants);
//         print('Cached ${attendants.length} attendants');

//         return attendants;
//       } else {
//         // Try to load from cache if API call fails
//         final cachedAttendants = attendantBox.getAll();
//         if (cachedAttendants.isNotEmpty) {
//           print('API call failed, loaded ${cachedAttendants.length} attendants from cache');
//           return cachedAttendants;
//         }
//         throw Exception('Failed to load attendants: ${response.statusCode} - ${response.body}');
//       }
//     } catch (e) {
//       // Try to load from cache on any error
//       final cachedAttendants = attendantBox.getAll();
//       if (cachedAttendants.isNotEmpty) {
//         print('Error fetching attendants, loaded ${cachedAttendants.length} attendants from cache');
//         return cachedAttendants;
//       }
//       print('Error fetching attendants: $e');
//       throw Exception('Error fetching attendants: $e');
//     }
//   }

//   Future<bool> createPin(int attendantId, String pin) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('token') ?? '';
      
//       if (token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       final response = await http.post(
//         Uri.parse('https://app.spotstockinventory.com/api/attendants/set-pin'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({
//           'attendant_id': attendantId,
//           'pin': pin,
//         }),
//       );

//       print('Create PIN response status: ${response.statusCode}');
//       print('Create PIN response body: ${response.body}');

//       return response.statusCode == 200;
//     } catch (e) {
//       print('Error creating PIN: $e');
//       throw Exception('Error creating PIN: $e');
//     }
//   }

//   Future<Map<String, dynamic>> verifyPin(int attendantId, String pin) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('token') ?? '';
      
//       if (token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       final response = await http.post(
//         Uri.parse('https://app.spotstockinventory.com/api/attendants/verify-pin'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({
//           'attendant_id': attendantId,
//           'pin': pin,
//         }),
//       );

//       print('Verify PIN response status: ${response.statusCode}');
//       print('Verify PIN response body: ${response.body}');

//       if (response.statusCode == 200) {
//         return {
//           'success': true,
//           'message': 'PIN verified successfully'
//         };
//       } else {
//         return {
//           'success': false,
//           'message': 'Invalid PIN'
//         };
//       }
//     } catch (e) {
//       print('Error verifying PIN: $e');
//       return {
//         'success': false,
//         'message': 'Error verifying PIN: $e'
//       };
//     }
//   }
// }