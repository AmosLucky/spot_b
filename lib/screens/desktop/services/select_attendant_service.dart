import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotstock_inventory/common/helpers/database_engine.dart';
import 'package:spotstock_inventory/common/helpers/internet_connectivity.dart';
import '../model/select_attendant_model.dart';
import 'offline_pin_service.dart';

class SelectAttendantService {
  final String _baseUrl = 'https://app.spotstockinventory.com/api/attendants';
  final String _setPinUrl = 'https://app.spotstockinventory.com/api/set-pin';
  final String _verifyPinUrl = 'https://app.spotstockinventory.com/api/verify-pin';
  final OfflinePinService _offlinePinService = OfflinePinService();

  Future<List<SelectAttendantModel>> getAttendants() async {
    final store = await DatabaseEngine.instance.getStore();
    final attendantBox = store.box<SelectAttendantModel>();
        
    try {
      final isOnline = await InternetUtils.isConnected();
            
      if (isOnline) {
        // Try to fetch from API
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token') ?? '';
                
        if (token.isNotEmpty) {
          final response = await http.get(
            Uri.parse(_baseUrl),
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
          ).timeout(Duration(seconds: 10));
          
          if (response.statusCode == 200) {
            final Map<String, dynamic> jsonResponse = json.decode(response.body);
            final List<dynamic> data = jsonResponse['data'] ?? [];
            final attendants = data.map((json) => SelectAttendantModel.fromJson(json)).toList();
            
            // Update local cache
            attendantBox.removeAll();
            attendantBox.putMany(attendants);
                        
            // Update PIN status based on offline storage
            await _updateAttendantsWithOfflinePinStatus(attendants);
                        
            print('Fetched ${attendants.length} attendants from API and cached locally');
            return attendants;
          }
        }
      }
            
      // Fallback to cached data
      final cachedAttendants = attendantBox.getAll();
      if (cachedAttendants.isNotEmpty) {
        // Update PIN status based on offline storage
        await _updateAttendantsWithOfflinePinStatus(cachedAttendants);
        print('Loaded ${cachedAttendants.length} attendants from cache');
        return cachedAttendants;
      }
            
      throw Exception('No attendants available offline and unable to fetch from server');
    } catch (e) {
      // Try cache on any error
      final cachedAttendants = attendantBox.getAll();
      if (cachedAttendants.isNotEmpty) {
        await _updateAttendantsWithOfflinePinStatus(cachedAttendants);
        print('Error fetching attendants, loaded ${cachedAttendants.length} from cache');
        return cachedAttendants;
      }
            
      print('Error fetching attendants: $e');
      throw Exception('Error fetching attendants: $e');
    }
  }

  /// Update attendants list with offline PIN status
  Future<void> _updateAttendantsWithOfflinePinStatus(List<SelectAttendantModel> attendants) async {
    for (var attendant in attendants) {
      final hasOfflinePin = await _offlinePinService.hasOfflinePin(attendant.apiId);
      if (hasOfflinePin && !attendant.hasPinSet) {
        // Update the attendant to reflect offline PIN availability
        attendant = SelectAttendantModel(
          apiId: attendant.apiId,
          firstName: attendant.firstName,
          lastName: attendant.lastName,
          email: attendant.email,
          phone: attendant.phone,
          department: attendant.department,
          hasPinSet: true, // Update to reflect offline PIN
        );
      }
    }
  }

  Future<bool> createPin(int userId, String pin) async {
    try {
      final isOnline = await InternetUtils.isConnected();
            
      if (isOnline) {
        // Try online first
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token') ?? '';
                
        if (token.isNotEmpty) {
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
          ).timeout(Duration(seconds: 10));
          
          if (response.statusCode == 200) {
            final jsonResponse = json.decode(response.body);
            final success = jsonResponse['success'] == true;
                        
            if (success) {
              // Also store offline for future use
              await _offlinePinService.storePinLocally(userId, pin);
              print('PIN created online and stored offline for user $userId');
              return true;
            }
          }
        }
      }
            
      // Fallback to offline storage
      final success = await _offlinePinService.storePinLocally(userId, pin);
      if (success) {
        print('PIN created offline for user $userId');
        return true;
      }
            
      throw Exception('Failed to create PIN both online and offline');
    } catch (e) {
      // Try offline as last resort
      final success = await _offlinePinService.storePinLocally(userId, pin);
      if (success) {
        print('PIN created offline due to error: $e');
        return true;
      }
            
      print('Error creating PIN: $e');
      throw Exception('Error creating PIN: $e');
    }
  }

  Future<Map<String, dynamic>> verifyPin(int userId, String pin) async {
    print('Starting PIN verification for user $userId');
    
    // Input validation
    if (pin.trim().isEmpty) {
      return {
        'success': false,
        'message': 'PIN cannot be empty',
        'errorType': 'INVALID_INPUT',
      };
    }
    
    if (pin.trim().length != 6) {
      return {
        'success': false,
        'message': 'PIN must be exactly 6 digits',
        'errorType': 'INVALID_FORMAT',
      };
    }
    
    if (!RegExp(r'^\d+$').hasMatch(pin.trim())) {
      return {
        'success': false,
        'message': 'PIN must contain only numbers',
        'errorType': 'INVALID_FORMAT',
      };
    }

    try {
      final isOnline = await InternetUtils.isConnected();
      final hasOfflinePin = await _offlinePinService.hasOfflinePin(userId);
      
      print('Connection status: ${isOnline ? "Online" : "Offline"}');
      print('Has offline PIN: $hasOfflinePin');

      // Strategy 1: Try offline verification first (if available)
      if (hasOfflinePin) {
        print('Attempting offline PIN verification for user $userId');
        final offlineResult = await _offlinePinService.verifyPinOffline(userId, pin);
        
        if (offlineResult['success'] == true) {
          print('PIN verified offline successfully');
          return {
            'success': true,
            'message': 'PIN verified successfully (offline)',
            'isOffline': true,
            'errorType': null,
          };
        } else {
          print('Offline PIN verification failed');
          // If we're offline and offline verification failed, return specific error
          if (!isOnline) {
            return {
              'success': false,
              'message': 'Invalid PIN entered',
              'errorType': 'INVALID_PIN_OFFLINE',
              'isOffline': true,
            };
          }
          // If online, continue to try online verification
        }
      }

      // Strategy 2: Try online verification
      if (isOnline) {
        print('Attempting online PIN verification for user $userId');
        
        try {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token') ?? '';
          
          if (token.isEmpty) {
            return {
              'success': false,
              'message': 'Authentication token not found. Please login again.',
              'errorType': 'AUTH_ERROR',
            };
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
          ).timeout(Duration(seconds: 15));

          print('Online verification response status: ${response.statusCode}');

          if (response.statusCode == 200) {
            final jsonResponse = json.decode(response.body);
            final success = jsonResponse['success'] == true;
            
            if (success) {
              // Store PIN offline for future use if not already stored
              if (!hasOfflinePin) {
                await _offlinePinService.storePinLocally(userId, pin);
                print('PIN verified online and stored offline for future use');
              }
              
              return {
                'success': true,
                'message': 'PIN verified successfully (online)',
                'isOffline': false,
                'errorType': null,
              };
            } else {
              // Online verification failed - invalid PIN
              return {
                'success': false,
                'message': 'Invalid PIN entered',
                'errorType': 'INVALID_PIN_ONLINE',
                'isOffline': false,
              };
            }
          } else if (response.statusCode == 401) {
            return {
              'success': false,
              'message': 'Authentication failed. Please login again.',
              'errorType': 'AUTH_ERROR',
            };
          } else if (response.statusCode == 404) {
            return {
              'success': false,
              'message': 'Attendant not found on server',
              'errorType': 'USER_NOT_FOUND',
            };
          } else {
            return {
              'success': false,
              'message': 'Server error occurred. Please try again.',
              'errorType': 'SERVER_ERROR',
            };
          }
        } catch (e) {
          print('Online verification error: $e');
          
          // If we have offline PIN and online failed due to network issues
          if (hasOfflinePin) {
            final offlineResult = await _offlinePinService.verifyPinOffline(userId, pin);
            return {
              'success': offlineResult['success'],
              'message': offlineResult['success'] 
                ? 'PIN verified successfully (offline fallback)'
                : 'Invalid PIN entered',
              'errorType': offlineResult['success'] ? null : 'INVALID_PIN_OFFLINE',
              'isOffline': true,
            };
          }
          
          return {
            'success': false,
            'message': 'Network error occurred. Please check your connection.',
            'errorType': 'NETWORK_ERROR',
          };
        }
      }

      // Strategy 3: No online connection and no offline PIN
      if (!hasOfflinePin) {
        return {
          'success': false,
          'message': 'No internet connection and no offline PIN available. Please connect to internet to verify PIN.',
          'errorType': 'NO_OFFLINE_PIN_NO_INTERNET',
          'requiresOnline': true,
        };
      }

      // Fallback case (shouldn't reach here normally)
      return {
        'success': false,
        'message': 'Unable to verify PIN. Please try again.',
        'errorType': 'UNKNOWN_ERROR',
      };

    } catch (e) {
      print('Unexpected error during PIN verification: $e');
      
      // Last resort: try offline if available
      final hasOfflinePin = await _offlinePinService.hasOfflinePin(userId);
      if (hasOfflinePin) {
        try {
          final offlineResult = await _offlinePinService.verifyPinOffline(userId, pin);
          return {
            'success': offlineResult['success'],
            'message': offlineResult['success'] 
              ? 'PIN verified successfully (offline emergency fallback)'
              : 'Invalid PIN entered',
            'errorType': offlineResult['success'] ? null : 'INVALID_PIN_OFFLINE',
            'isOffline': true,
          };
        } catch (offlineError) {
          print('Offline fallback also failed: $offlineError');
        }
      }
      
      return {
        'success': false,
        'message': 'System error occurred during PIN verification. Please try again.',
        'errorType': 'SYSTEM_ERROR',
      };
    }
  }

  /// Sync offline data when connection is available
  Future<void> syncOfflineData() async {
    try {
      await _offlinePinService.syncPinsWithServer();
    } catch (e) {
      print('Error syncing offline data: $e');
    }
  }
}





// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:spotstock_inventory/common/helpers/database_engine.dart';
// import 'package:spotstock_inventory/common/helpers/internet_connectivity.dart';
// // import 'package:spotstock_inventory/services/offline_pin_service.dart';
// import '../model/select_attendant_model.dart';
// import 'offline_pin_service.dart';

// class SelectAttendantService {
//   final String _baseUrl = 'https://app.spotstockinventory.com/api/attendants';
//   final String _setPinUrl = 'https://app.spotstockinventory.com/api/set-pin';
//   final String _verifyPinUrl = 'https://app.spotstockinventory.com/api/verify-pin';
//   final OfflinePinService _offlinePinService = OfflinePinService();

//   Future<List<SelectAttendantModel>> getAttendants() async {
//     final store = await DatabaseEngine.instance.getStore();
//     final attendantBox = store.box<SelectAttendantModel>();
    
//     try {
//       final isOnline = await InternetUtils.isConnected();
      
//       if (isOnline) {
//         // Try to fetch from API
//         final prefs = await SharedPreferences.getInstance();
//         final token = prefs.getString('token') ?? '';
        
//         if (token.isNotEmpty) {
//           final response = await http.get(
//             Uri.parse(_baseUrl),
//             headers: {
//               'Authorization': 'Bearer $token',
//               'Accept': 'application/json',
//             },
//           ).timeout(Duration(seconds: 10));

//           if (response.statusCode == 200) {
//             final Map<String, dynamic> jsonResponse = json.decode(response.body);
//             final List<dynamic> data = jsonResponse['data'] ?? [];
//             final attendants = data.map((json) => SelectAttendantModel.fromJson(json)).toList();

//             // Update local cache
//             attendantBox.removeAll();
//             attendantBox.putMany(attendants);
            
//             // Update PIN status based on offline storage
//             await _updateAttendantsWithOfflinePinStatus(attendants);
            
//             print('Fetched ${attendants.length} attendants from API and cached locally');
//             return attendants;
//           }
//         }
//       }
      
//       // Fallback to cached data
//       final cachedAttendants = attendantBox.getAll();
//       if (cachedAttendants.isNotEmpty) {
//         // Update PIN status based on offline storage
//         await _updateAttendantsWithOfflinePinStatus(cachedAttendants);
//         print('Loaded ${cachedAttendants.length} attendants from cache');
//         return cachedAttendants;
//       }
      
//       throw Exception('No attendants available offline and unable to fetch from server');
//     } catch (e) {
//       // Try cache on any error
//       final cachedAttendants = attendantBox.getAll();
//       if (cachedAttendants.isNotEmpty) {
//         await _updateAttendantsWithOfflinePinStatus(cachedAttendants);
//         print('Error fetching attendants, loaded ${cachedAttendants.length} from cache');
//         return cachedAttendants;
//       }
      
//       print('Error fetching attendants: $e');
//       throw Exception('Error fetching attendants: $e');
//     }
//   }

//   /// Update attendants list with offline PIN status
//   Future<void> _updateAttendantsWithOfflinePinStatus(List<SelectAttendantModel> attendants) async {
//     for (var attendant in attendants) {
//       final hasOfflinePin = await _offlinePinService.hasOfflinePin(attendant.apiId);
//       if (hasOfflinePin && !attendant.hasPinSet) {
//         // Update the attendant to reflect offline PIN availability
//         attendant = SelectAttendantModel(
//           apiId: attendant.apiId,
//           firstName: attendant.firstName,
//           lastName: attendant.lastName,
//           email: attendant.email,
//           phone: attendant.phone,
//           department: attendant.department,
//           hasPinSet: true, // Update to reflect offline PIN
//         );
//       }
//     }
//   }

//   Future<bool> createPin(int userId, String pin) async {
//     try {
//       final isOnline = await InternetUtils.isConnected();
      
//       if (isOnline) {
//         // Try online first
//         final prefs = await SharedPreferences.getInstance();
//         final token = prefs.getString('token') ?? '';
        
//         if (token.isNotEmpty) {
//           final response = await http.post(
//             Uri.parse(_setPinUrl),
//             headers: {
//               'Authorization': 'Bearer $token',
//               'Accept': 'application/json',
//               'Content-Type': 'application/json',
//             },
//             body: json.encode({
//               'user_id': userId,
//               'pin': pin,
//             }),
//           ).timeout(Duration(seconds: 10));

//           if (response.statusCode == 200) {
//             final jsonResponse = json.decode(response.body);
//             final success = jsonResponse['success'] == true;
            
//             if (success) {
//               // Also store offline for future use
//               await _offlinePinService.storePinLocally(userId, pin);
//               print('PIN created online and stored offline for user $userId');
//               return true;
//             }
//           }
//         }
//       }
      
//       // Fallback to offline storage
//       final success = await _offlinePinService.storePinLocally(userId, pin);
//       if (success) {
//         print('PIN created offline for user $userId');
//         return true;
//       }
      
//       throw Exception('Failed to create PIN both online and offline');
//     } catch (e) {
//       // Try offline as last resort
//       final success = await _offlinePinService.storePinLocally(userId, pin);
//       if (success) {
//         print('PIN created offline due to error: $e');
//         return true;
//       }
      
//       print('Error creating PIN: $e');
//       throw Exception('Error creating PIN: $e');
//     }
//   }

//   Future<Map<String, dynamic>> verifyPin(int userId, String pin) async {
//     try {
//       final isOnline = await InternetUtils.isConnected();
      
//       // Always try offline first for faster response
//       final hasOfflinePin = await _offlinePinService.hasOfflinePin(userId);
      
//       if (hasOfflinePin) {
//         print('Attempting offline PIN verification for user $userId');
//         final offlineResult = await _offlinePinService.verifyPinOffline(userId, pin);
        
//         if (offlineResult['success'] == true) {
//           print('PIN verified offline successfully');
//           return offlineResult;
//         } else if (!isOnline) {
//           // If offline verification failed and no internet, return the offline result
//           print('Offline PIN verification failed and no internet connection');
//           return offlineResult;
//         }
//       }
      
//       // Try online verification if offline failed or no offline PIN exists
//       if (isOnline) {
//         print('Attempting online PIN verification for user $userId');
//         final prefs = await SharedPreferences.getInstance();
//         final token = prefs.getString('token') ?? '';
        
//         if (token.isNotEmpty) {
//           final response = await http.post(
//             Uri.parse(_verifyPinUrl),
//             headers: {
//               'Authorization': 'Bearer $token',
//               'Accept': 'application/json',
//               'Content-Type': 'application/json',
//             },
//             body: json.encode({
//               'user_id': userId,
//               'pin': pin,
//             }),
//           ).timeout(Duration(seconds: 10));

//           if (response.statusCode == 200) {
//             final jsonResponse = json.decode(response.body);
//             final success = jsonResponse['success'] == true;
            
//             if (success && !hasOfflinePin) {
//               // Store PIN offline for future use
//               await _offlinePinService.storePinLocally(userId, pin);
//               print('PIN verified online and stored offline for future use');
//             }
            
//             return {
//               'success': success,
//               'message': jsonResponse['message'] ?? (success ? 'PIN verified online' : 'Invalid PIN'),
//               'isOffline': false,
//             };
//           }
//         }
//       }
      
//       // If we reach here, both offline and online verification failed
//       return {
//         'success': false,
//         'message': hasOfflinePin 
//             ? 'Invalid PIN (verified offline)' 
//             : 'Unable to verify PIN - no internet connection and no offline PIN available',
//         'requiresOnline': !hasOfflinePin,
//       };
      
//     } catch (e) {
//       print('Error verifying PIN: $e');
      
//       // Last resort: try offline if we haven't already
//       final hasOfflinePin = await _offlinePinService.hasOfflinePin(userId);
//       if (hasOfflinePin) {
//         final offlineResult = await _offlinePinService.verifyPinOffline(userId, pin);
//         return {
//           ...offlineResult,
//           'message': '${offlineResult['message']} (fallback due to error)',
//         };
//       }
      
//       return {
//         'success': false,
//         'message': 'Error verifying PIN: $e',
//       };
//     }
//   }

//   /// Sync offline data when connection is available
//   Future<void> syncOfflineData() async {
//     try {
//       await _offlinePinService.syncPinsWithServer();
//     } catch (e) {
//       print('Error syncing offline data: $e');
//     }
//   }
// }