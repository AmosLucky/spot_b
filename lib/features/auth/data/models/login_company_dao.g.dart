// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_company_dao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginCompanyDaoImpl _$$LoginCompanyDaoImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginCompanyDaoImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$LoginCompanyDaoImplToJson(
        _$LoginCompanyDaoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'email': instance.email,
    };
