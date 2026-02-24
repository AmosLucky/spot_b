import 'package:flutter/material.dart';

import '../repositories/theme_repository.dart';

class SetTheme {
  final ThemeRepository themeRepository;

  SetTheme(this.themeRepository);

  Future<void> call(ThemeMode themeMode) async {
    await themeRepository.setThemeMode(themeMode);
  }
}
