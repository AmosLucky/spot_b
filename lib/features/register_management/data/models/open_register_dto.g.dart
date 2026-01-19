// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_register_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OpenRegisterDtoImpl _$$OpenRegisterDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$OpenRegisterDtoImpl(
      openingCashAtHand: (json['cash_in_hand'] as num?)?.toDouble(),
      note: json['notes'] as String?,
    );

Map<String, dynamic> _$$OpenRegisterDtoImplToJson(
        _$OpenRegisterDtoImpl instance) =>
    <String, dynamic>{
      'cash_in_hand': instance.openingCashAtHand,
      'notes': instance.note,
    };
