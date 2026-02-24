// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_pin_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VerifyPinDtoImpl _$$VerifyPinDtoImplFromJson(Map<String, dynamic> json) =>
    _$VerifyPinDtoImpl(
      pin: json['pin'] as String,
      userId: (json['user_id'] as num).toInt(),
    );

Map<String, dynamic> _$$VerifyPinDtoImplToJson(_$VerifyPinDtoImpl instance) =>
    <String, dynamic>{
      'pin': instance.pin,
      'user_id': instance.userId,
    };
