import '../../../../core/error_handling/app_error.dart';

class LoginError extends AppError {
  final String title;
  final String subtitle;

  LoginError({
    required super.message,
    super.code,
    super.originalError,
    String? title,
    String? subtitle,
  })  : title = title ?? message,
        subtitle = subtitle ?? message;
}
