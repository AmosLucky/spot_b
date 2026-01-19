import 'package:flutter/material.dart';

import '../../domain/repositories/theme_repository.dart';
import '../datasources/theme_datasource.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeDatasource themeDatasource;

  ThemeRepositoryImpl(this.themeDatasource);

  @override
  ThemeMode get themeMode => themeDatasource.getThemeMode();

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await themeDatasource.setThemeMode(themeMode);
  }
}
