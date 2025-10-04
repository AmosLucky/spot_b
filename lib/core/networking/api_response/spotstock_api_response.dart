// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'spotstock_api_response.freezed.dart';
part 'spotstock_api_response.g.dart';

@Freezed(genericArgumentFactories: true)
class SpotstockApiResponse<T> with _$SpotstockApiResponse<T> {
  const factory SpotstockApiResponse({
    required T data,
    ApiLinks? links,
    ApiMeta? meta,
    String? message,
    bool? success,
    dynamic rawResponse,
  }) = _SpotstockApiResponse<T>;

  factory SpotstockApiResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) =>
      _$SpotstockApiResponseFromJson(json, fromJsonT);
}

@freezed
class ApiLinks with _$ApiLinks {
  const factory ApiLinks({
    String? first,
    String? last,
    String? prev,
    String? next,
  }) = _ApiLinks;

  factory ApiLinks.fromJson(Map<String, dynamic> json) => _$ApiLinksFromJson(json);
}

@freezed
class ApiMeta with _$ApiMeta {
  const factory ApiMeta({
    @JsonKey(name: 'current_page') int? currentPage,
    @JsonKey(name: 'last_page') int? lastPage,
    @JsonKey(name: 'per_page') int? perPage,
    int? total,
  }) = _ApiMeta;

  factory ApiMeta.fromJson(Map<String, dynamic> json) => _$ApiMetaFromJson(json);
}
