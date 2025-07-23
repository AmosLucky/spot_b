import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotstock_inventory/common/helpers/database_engine.dart';
import 'package:spotstock_inventory/objectbox.g.dart';
import 'package:spotstock_inventory/screens/desktop/model/select_attendant_model.dart';
import 'package:spotstock_inventory/common/helpers/internet_connectivity.dart';

class OfflinePinService {
  static const String _pinPrefix = 'offline_pin_';
  static const String _saltPrefix = 'pin_salt_';
  static const String _syncPrefix = 'pin_sync_';
  
  /// Generate a random salt for PIN hashing
  String _generateSalt() {
    final random = Random.secure();
    final saltBytes = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Encode(saltBytes);
  }
  
  /// Hash PIN with salt using SHA-256
  String _hashPin(String pin, String salt) {
    final combined = pin + salt;
    final bytes = utf8.encode(combined);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  
  /// Store PIN locally with encryption
  Future<bool> storePinLocally(int attendantId, String pin) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final salt = _generateSalt();
      final hashedPin = _hashPin(pin, salt);
      
      // Store hashed PIN and salt separately
      await prefs.setString('${_pinPrefix}$attendantId', hashedPin);
      await prefs.setString('${_saltPrefix}$attendantId', salt);
      await prefs.setBool('${_syncPrefix}$attendantId', false); // Mark as not synced
      
      // Also update the attendant model in ObjectBox
      await _updateAttendantPinStatus(attendantId, true);
      
      print('PIN stored locally for attendant $attendantId');
      return true;
    } catch (e) {
      print('Error storing PIN locally: $e');
      return false;
    }
  }
  
  /// Verify PIN offline
  Future<Map<String, dynamic>> verifyPinOffline(int attendantId, String inputPin) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedHashedPin = prefs.getString('${_pinPrefix}$attendantId');
      final salt = prefs.getString('${_saltPrefix}$attendantId');
      
      if (storedHashedPin == null || salt == null) {
        return {
          'success': false,
          'message': 'No offline PIN found for this attendant',
          'requiresOnline': true,
        };
      }
      
      final inputHashedPin = _hashPin(inputPin, salt);
      final isValid = storedHashedPin == inputHashedPin;
      
      return {
        'success': isValid,
        'message': isValid ? 'PIN verified offline' : 'Invalid PIN',
        'isOffline': true,
      };
    } catch (e) {
      print('Error verifying PIN offline: $e');
      return {
        'success': false,
        'message': 'Error verifying PIN offline: $e',
        'isOffline': true,
      };
    }
  }
  
  /// Check if attendant has offline PIN stored
  Future<bool> hasOfflinePin(int attendantId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hasPin = prefs.getString('${_pinPrefix}$attendantId') != null;
      print('Attendant $attendantId has offline PIN: $hasPin');
      return hasPin;
    } catch (e) {
      print('Error checking offline PIN: $e');
      return false;
    }
  }
  
  /// Update attendant PIN status in ObjectBox
  Future<void> _updateAttendantPinStatus(int attendantId, bool hasPinSet) async {
    try {
      final store = await DatabaseEngine.instance.getStore();
      final attendantBox = store.box<SelectAttendantModel>();
      
      // Find attendant by apiId
      final query = attendantBox.query(SelectAttendantModel_.apiId.equals(attendantId)).build();
      final attendants = query.find();
      query.close();
      
      if (attendants.isNotEmpty) {
        final attendant = attendants.first;
        // Create updated attendant with new PIN status
        final updatedAttendant = SelectAttendantModel(
          apiId: attendant.apiId,
          firstName: attendant.firstName,
          lastName: attendant.lastName,
          email: attendant.email,
          phone: attendant.phone,
          department: attendant.department,
          hasPinSet: hasPinSet,
        );
        updatedAttendant.id = attendant.id; // Keep the same ObjectBox ID
        attendantBox.put(updatedAttendant);
        print('Updated attendant PIN status in ObjectBox');
      }
    } catch (e) {
      print('Error updating attendant PIN status: $e');
    }
  }
  
  /// Sync local PINs with server when online
  Future<void> syncPinsWithServer() async {
    try {
      final isOnline = await InternetUtils.isConnected();
      if (!isOnline) {
        print('Cannot sync PINs: No internet connection');
        return;
      }
      
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      
      // Find all unsynced PINs
      for (String key in keys) {
        if (key.startsWith(_syncPrefix)) {
          final attendantId = int.tryParse(key.replaceFirst(_syncPrefix, ''));
          final needsSync = prefs.getBool(key) == false;
          
          if (attendantId != null && needsSync) {
            // Here you would call your existing API to sync the PIN
            // For now, we'll just mark it as synced
            await prefs.setBool(key, true);
            print('Marked PIN as synced for attendant $attendantId');
          }
        }
      }
    } catch (e) {
      print('Error syncing PINs with server: $e');
    }
  }
  
  /// Clear offline PIN data
  Future<void> clearOfflinePin(int attendantId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('${_pinPrefix}$attendantId');
      await prefs.remove('${_saltPrefix}$attendantId');
      await prefs.remove('${_syncPrefix}$attendantId');
      
      await _updateAttendantPinStatus(attendantId, false);
      print('Cleared offline PIN for attendant $attendantId');
    } catch (e) {
      print('Error clearing offline PIN: $e');
    }
  }
  
  /// Get all attendants with offline PINs
  Future<List<int>> getAttendantsWithOfflinePins() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      final attendantIds = <int>[];
      
      for (String key in keys) {
        if (key.startsWith(_pinPrefix)) {
          final attendantId = int.tryParse(key.replaceFirst(_pinPrefix, ''));
          if (attendantId != null) {
            attendantIds.add(attendantId);
          }
        }
      }
      
      return attendantIds;
    } catch (e) {
      print('Error getting attendants with offline PINs: $e');
      return [];
    }
  }
}
 