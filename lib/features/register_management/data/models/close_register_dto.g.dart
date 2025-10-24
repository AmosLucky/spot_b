// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_register_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CloseRegisterDtoImpl _$$CloseRegisterDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$CloseRegisterDtoImpl(
      id: (json['id'] as num).toInt(),
      closingCashAtHand: (json['closingCashAtHand'] as num).toDouble(),
      closeCurrentRegister: json['closeCurrentRegister'] as bool?,
    );

Map<String, dynamic> _$$CloseRegisterDtoImplToJson(
        _$CloseRegisterDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'closingCashAtHand': instance.closingCashAtHand,
      'closeCurrentRegister': instance.closeCurrentRegister,
    };
