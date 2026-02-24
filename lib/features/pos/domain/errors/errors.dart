import '../../../../core/error_handling/app_error.dart';
import '../../../../core/networking/spotstock_status_code.dart';

class LocalDatabaseError extends AppError {
  final String title;
  final String subtitle;

  LocalDatabaseError({
    required super.message,
    super.originalError,
    String? code,
    String? title,
    String? subtitle,
  })  : title = title ?? message,
        subtitle = subtitle ?? message,
        super(code: code ?? SpotstockStatusCode.internalAppDatabaseError.toString());
}

class OutOfStockError extends AppError {
  final String title;
  final String subtitle;

  OutOfStockError({
    required super.message,
    super.originalError,
    String? code,
    String? title,
    String? subtitle,
  })  : title = title ?? message,
        subtitle = subtitle ?? message,
        super(code: code ?? SpotstockStatusCode.internalAppDatabaseError.toString());
}
