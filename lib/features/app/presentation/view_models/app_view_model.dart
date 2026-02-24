import 'package:flutter/material.dart';

import '../../../../core/presentation/view_models/spotstock_view_model.dart';
import '../../../../features/theme/domain/usecases/get_theme.dart';
import '../../../../features/theme/domain/usecases/set_theme.dart';
import '../../../platform/domain/usecases/check_if_is_mobile.dart';

class AppViewModel extends SpotstockViewModel {
  final GetTheme getTheme;
  final SetTheme setTheme;
  final CheckIfIsMobile checkIfIsMobile;

  AppViewModel(this.getTheme, this.setTheme, this.checkIfIsMobile);

  ThemeMode get themeMode => getTheme();

  bool get isMobile => checkIfIsMobile();

  @override
  void bind(BuildContext context) {}

  Future<void> onThemeChanged(ThemeMode themeMode) async {
    await setTheme(themeMode);
    notifyListeners();
  }
}
