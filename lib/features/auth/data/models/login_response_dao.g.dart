// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_dao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginResponseDaoImpl _$$LoginResponseDaoImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginResponseDaoImpl(
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : LoginUserDao.fromJson(json['user'] as Map<String, dynamic>),
      role: json['role'] == null
          ? null
          : LoginRoleDao.fromJson(json['role'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LoginResponseDaoImplToJson(
        _$LoginResponseDaoImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
      'role': instance.role,
    };
