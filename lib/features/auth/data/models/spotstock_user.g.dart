// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spotstock_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpotstockUserImpl _$$SpotstockUserImplFromJson(Map<String, dynamic> json) =>
    _$SpotstockUserImpl(
      id: (json['id'] as num).toInt(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      roleId: (json['roleId'] as num).toInt(),
      roleName: json['roleName'] as String,
      roleDisplayName: json['roleDisplayName'] as String,
      company:
          SpotstockCompany.fromJson(json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SpotstockUserImplToJson(_$SpotstockUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'roleId': instance.roleId,
      'roleName': instance.roleName,
      'roleDisplayName': instance.roleDisplayName,
      'company': instance.company,
    };

_$SpotstockCompanyImpl _$$SpotstockCompanyImplFromJson(
        Map<String, dynamic> json) =>
    _$SpotstockCompanyImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$$SpotstockCompanyImplToJson(
        _$SpotstockCompanyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'email': instance.email,
    };
