import '../../../../core/error_handling/app_error.dart';

class ComingSoonError extends AppError {
  final String title;
  final String subtitle;

  ComingSoonError({
    required super.message,
    super.code,
    super.originalError,
    String? title,
    String? subtitle,
  })  : title = title ?? message,
        subtitle = subtitle ?? message;
}
