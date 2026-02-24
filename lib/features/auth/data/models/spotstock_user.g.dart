// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spotstock_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpotstockUserImpl _$$SpotstockUserImplFromJson(Map<String, dynamic> json) =>
    _$SpotstockUserImpl(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      roleId: (json['role_id'] as num?)?.toInt(),
      roleName: json['role_name'] as String?,
      roleDisplayName: json['role_display_name'] as String?,
      isAdmin: const IntOrBoolToBoolConverter().fromJson(json['is_admin']),
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      company: json['company'] == null
          ? null
          : SpotstockCompany.fromJson(json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SpotstockUserImplToJson(_$SpotstockUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'role_id': instance.roleId,
      'role_name': instance.roleName,
      'role_display_name': instance.roleDisplayName,
      'is_admin': _$JsonConverterToJson<dynamic, bool>(
          instance.isAdmin, const IntOrBoolToBoolConverter().toJson),
      'permissions': instance.permissions,
      'company': instance.company,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$SpotstockCompanyImpl _$$SpotstockCompanyImplFromJson(
        Map<String, dynamic> json) =>
    _$SpotstockCompanyImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
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
