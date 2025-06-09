import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotstock_inventory/common/helpers/database_engine.dart';
import 'package:spotstock_inventory/objectbox.g.dart';
import '../model/select_attendant_model.dart';

class SelectAttendantService {
  final String _baseUrl = 'https://app.spotstockinventory.com/api/staffs';

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
}



// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// import '../model/select_attendant_model.dart';
// // import 'package:spotstock_inventory/screens/desktop/providers/select_attendant_model.dart';

// class SelectAttendantService {
//   final String _baseUrl = 'https://app.spotstockinventory.com/api/staffs';

//   Future<List<SelectAttendantModel>> getAttendants() async {
//     try {
//       // Retrieve token from SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('token') ?? '';
//       print('Attempting to fetch attendants with token: $token'); // Debug log

//       if (token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       final response = await http.get(
//         Uri.parse(_baseUrl),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//         },
//       );

//       print('API response status: ${response.statusCode}'); // Debug log
//       print('API response body: ${response.body}'); // Debug log

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonResponse = json.decode(response.body);
//         final List<dynamic> data = jsonResponse['data'] ?? [];
//         return data.map((json) => SelectAttendantModel.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load attendants: ${response.statusCode} - ${response.body}');
//       }
//     } catch (e) {
//       print('Error fetching attendants: $e'); // Debug log
//       throw Exception('Error fetching attendants: $e');
//     }
//   }
// }