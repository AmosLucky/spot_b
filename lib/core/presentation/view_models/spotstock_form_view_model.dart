import 'dart:async';

import 'package:flutter/material.dart';

import '../../error_handling/app_error.dart';

abstract class SpotstockFormViewModel extends ChangeNotifier {
  SpotstockFormViewModel();

  final StreamController<AppError> _errorController = StreamController<AppError>.broadcast();
  Stream<AppError> get errorStream => _errorController.stream;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  void bind(BuildContext context);

  bool validateForm() {
    final result = formKey.currentState?.validate();
    return result ?? false;
  }

  void addError(AppError error) {
    _errorController.add(error);
  }

  @override
  void dispose() {
    _errorController.close();
    super.dispose();
  }
}
