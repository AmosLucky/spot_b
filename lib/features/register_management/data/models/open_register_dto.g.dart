// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_register_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OpenRegisterDtoImpl _$$OpenRegisterDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$OpenRegisterDtoImpl(
      openingCashAtHand: (json['openingCashAtHand'] as num?)?.toDouble(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$OpenRegisterDtoImplToJson(
        _$OpenRegisterDtoImpl instance) =>
    <String, dynamic>{
      'openingCashAtHand': instance.openingCashAtHand,
      'note': instance.note,
    };
