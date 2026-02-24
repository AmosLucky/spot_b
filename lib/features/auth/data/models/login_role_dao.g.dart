// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_role_dao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRoleDaoImpl _$$LoginRoleDaoImplFromJson(Map<String, dynamic> json) =>
    _$LoginRoleDaoImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      displayName: json['display_name'] as String?,
    );

Map<String, dynamic> _$$LoginRoleDaoImplToJson(_$LoginRoleDaoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'display_name': instance.displayName,
    };
