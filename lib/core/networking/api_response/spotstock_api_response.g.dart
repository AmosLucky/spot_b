// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spotstock_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpotstockApiResponseImpl<T> _$$SpotstockApiResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$SpotstockApiResponseImpl<T>(
      data: fromJsonT(json['data']),
      links: json['links'] == null
          ? null
          : ApiLinks.fromJson(json['links'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? null
          : ApiMeta.fromJson(json['meta'] as Map<String, dynamic>),
      message: json['message'] as String?,
      success: json['success'] as bool?,
      rawResponse: json['rawResponse'],
    );

Map<String, dynamic> _$$SpotstockApiResponseImplToJson<T>(
  _$SpotstockApiResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': toJsonT(instance.data),
      'links': instance.links,
      'meta': instance.meta,
      'message': instance.message,
      'success': instance.success,
      'rawResponse': instance.rawResponse,
    };

_$ApiLinksImpl _$$ApiLinksImplFromJson(Map<String, dynamic> json) =>
    _$ApiLinksImpl(
      first: json['first'] as String?,
      last: json['last'] as String?,
      prev: json['prev'] as String?,
      next: json['next'] as String?,
    );

Map<String, dynamic> _$$ApiLinksImplToJson(_$ApiLinksImpl instance) =>
    <String, dynamic>{
      'first': instance.first,
      'last': instance.last,
      'prev': instance.prev,
      'next': instance.next,
    };

_$ApiMetaImpl _$$ApiMetaImplFromJson(Map<String, dynamic> json) =>
    _$ApiMetaImpl(
      currentPage: (json['current_page'] as num?)?.toInt(),
      lastPage: (json['last_page'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ApiMetaImplToJson(_$ApiMetaImpl instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'per_page': instance.perPage,
      'total': instance.total,
    };
