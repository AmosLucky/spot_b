import 'package:dio/dio.dart';

import '../constants/strings/spotstock_strings.dart';
import 'spotstock_api_error.dart';
import 'spotstock_status_code.dart';

SpotstockApiError handleSpotstockApiError(Object e) {
  if (e is DioException) {
    return SpotstockApiError(
      message: e.response?.data['message'].toString() ?? SpotstockStrings.somethingWentWrong,
      code: e.response?.statusCode.toString() ?? SpotstockStatusCode.internalServerError.toString(),
      originalError: e.response?.data,
    );
  }
  return SpotstockApiError(
    message: SpotstockStrings.anUnexpectedErrorOccurred,
    code: SpotstockStatusCode.unknown.toString(),
    originalError: e,
  );
}
