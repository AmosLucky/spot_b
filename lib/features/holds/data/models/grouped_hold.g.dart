// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grouped_hold.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupedHoldImpl _$$GroupedHoldImplFromJson(Map<String, dynamic> json) =>
    _$GroupedHoldImpl(
      holds: (json['holds'] as List<dynamic>)
          .map((e) => Hold.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GroupedHoldImplToJson(_$GroupedHoldImpl instance) =>
    <String, dynamic>{
      'holds': instance.holds,
    };
