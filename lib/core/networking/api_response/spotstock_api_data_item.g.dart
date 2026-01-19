// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spotstock_api_data_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpotstockApiDataItemImpl _$$SpotstockApiDataItemImplFromJson(
        Map<String, dynamic> json) =>
    _$SpotstockApiDataItemImpl(
      id: (json['id'] as num?)?.toInt(),
      type: json['type'] as String?,
      attributes: json['attributes'] as Map<String, dynamic>?,
      links: const FlexibleLinksConverter().fromJson(json['links']),
    );

Map<String, dynamic> _$$SpotstockApiDataItemImplToJson(
        _$SpotstockApiDataItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributes': instance.attributes,
      'links': const FlexibleLinksConverter().toJson(instance.links),
    };
