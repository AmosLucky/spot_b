// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_customer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateCustomerDtoImpl _$$CreateCustomerDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateCustomerDtoImpl(
      address: json['address'] as String?,
      city: json['city'] as String?,
      email: json['email'] as String?,
      country: json['country'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$$CreateCustomerDtoImplToJson(
        _$CreateCustomerDtoImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'city': instance.city,
      'email': instance.email,
      'country': instance.country,
      'name': instance.name,
      'phone': instance.phone,
    };
