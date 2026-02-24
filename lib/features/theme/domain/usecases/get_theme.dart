import 'package:flutter/material.dart';

import '../repositories/theme_repository.dart';

class GetTheme {
  final ThemeRepository themeRepository;

  GetTheme(this.themeRepository);

  ThemeMode call() {
    return themeRepository.themeMode;
  }
}
