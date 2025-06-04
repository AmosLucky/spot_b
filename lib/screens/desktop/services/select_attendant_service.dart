import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/select_attendant_model.dart';
// import 'package:spotstock_inventory/screens/desktop/providers/select_attendant_model.dart';

class SelectAttendantService {
  final String _baseUrl = 'https://app.spotstockinventory.com/api/staffs';

  Future<List<SelectAttendantModel>> getAttendants() async {
    try {
      // Retrieve token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      print('Attempting to fetch attendants with token: $token'); // Debug log

      if (token.isEmpty) {
        throw Exception('No authentication token found');
      }

      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print('API response status: ${response.statusCode}'); // Debug log
      print('API response body: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'] ?? [];
        return data.map((json) => SelectAttendantModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load attendants: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error fetching attendants: $e'); // Debug log
      throw Exception('Error fetching attendants: $e');
    }
  }
}