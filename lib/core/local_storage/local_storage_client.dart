import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageClient {
  final SharedPreferences _sharedPreferences;
  final FlutterSecureStorage _secureStorage;

  LocalStorageClient({
    required SharedPreferences sharedPreferences,
    required FlutterSecureStorage secureStorage,
  })  : _sharedPreferences = sharedPreferences,
        _secureStorage = secureStorage;

  Future<void> write(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  String? read(String key) {
    return _sharedPreferences.getString(key);
  }

  Future<void> delete(String key) async {
    await _sharedPreferences.remove(key);
  }

  Future<void> writeBool(String key, bool value) async {
    await _sharedPreferences.setBool(key, value);
  }

  bool? readBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  Future<void> privateWrite(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> privateRead(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> privateDelete(String key) async {
    await _secureStorage.delete(key: key);
  }
}
