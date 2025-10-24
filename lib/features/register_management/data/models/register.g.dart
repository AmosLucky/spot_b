// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegisterImpl _$$RegisterImplFromJson(Map<String, dynamic> json) =>
    _$RegisterImpl(
      id: (json['id'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      isOpen: json['isOpen'] as bool?,
      isValid: json['isValid'] as bool?,
      openingCashAtHand: (json['openingCashAtHand'] as num?)?.toDouble(),
      closingCashAtHand: (json['closingCashAtHand'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$RegisterImplToJson(_$RegisterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'isOpen': instance.isOpen,
      'isValid': instance.isValid,
      'openingCashAtHand': instance.openingCashAtHand,
      'closingCashAtHand': instance.closingCashAtHand,
    };
