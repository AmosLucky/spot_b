class SpotstockApiResponse<T> {
  final T? data;
  final String? message;
  final bool? success;
  final dynamic rawResponse;

  SpotstockApiResponse({this.data, this.message, this.success, this.rawResponse});
}
