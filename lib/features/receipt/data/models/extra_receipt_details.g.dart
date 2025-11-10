// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_receipt_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExtraReceiptDetailsImpl _$$ExtraReceiptDetailsImplFromJson(
        Map<String, dynamic> json) =>
    _$ExtraReceiptDetailsImpl(
      tableName: json['tableName'] as String?,
      companyName: json['companyName'] as String?,
      companyAddress: json['companyAddress'] as String?,
      companyPhone: json['companyPhone'] as String?,
      companyEmail: json['companyEmail'] as String?,
    );

Map<String, dynamic> _$$ExtraReceiptDetailsImplToJson(
        _$ExtraReceiptDetailsImpl instance) =>
    <String, dynamic>{
      'tableName': instance.tableName,
      'companyName': instance.companyName,
      'companyAddress': instance.companyAddress,
      'companyPhone': instance.companyPhone,
      'companyEmail': instance.companyEmail,
    };
