import '../error_handling/app_error.dart';

class SpotstockApiError extends AppError {
  final bool? success;
  final dynamic rawResponse;
  SpotstockApiError(
      {required super.message, super.code, super.originalError, this.success, this.rawResponse});
}
