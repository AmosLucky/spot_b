// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_dao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginUserDaoImpl _$$LoginUserDaoImplFromJson(Map<String, dynamic> json) =>
    _$LoginUserDaoImpl(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      company: json['company'] == null
          ? null
          : LoginCompanyDao.fromJson(json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LoginUserDaoImplToJson(_$LoginUserDaoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'company': instance.company,
    };
