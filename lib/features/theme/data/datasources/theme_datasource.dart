import 'package:flutter/material.dart';

import '../../../../core/local_storage/local_storage_client.dart';
import '../../../../core/local_storage/local_storage_keys.dart';

class ThemeDatasource {
  final LocalStorageClient localStorageClient;

  ThemeDatasource(this.localStorageClient);

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await localStorageClient.write(LocalStorageKeys.themeMode, themeMode.name);
  }

  ThemeMode getThemeMode() {
    final themeModeString = localStorageClient.read(LocalStorageKeys.themeMode);
    return ThemeMode.values.firstWhere((mode) => mode.name == themeModeString, orElse: () => ThemeMode.system);
  }
}
