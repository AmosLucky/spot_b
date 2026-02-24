// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_register_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CloseRegisterDtoImpl _$$CloseRegisterDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$CloseRegisterDtoImpl(
      id: (json['id'] as num?)?.toInt(),
      cashInHandWhileClosing:
          (json['cash_in_hand_while_closing'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$CloseRegisterDtoImplToJson(
        _$CloseRegisterDtoImpl instance) =>
    <String, dynamic>{
      'cash_in_hand_while_closing': instance.cashInHandWhileClosing,
      'notes': instance.notes,
    };
