// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_role_dao.freezed.dart';
part 'login_role_dao.g.dart';

@freezed
class LoginRoleDao with _$LoginRoleDao {
  const factory LoginRoleDao({
    int? id,
    String? name,
    @JsonKey(name: 'display_name') String? displayName,
  }) = _LoginRoleDao;

  factory LoginRoleDao.fromJson(Map<String, dynamic> json) => _$LoginRoleDaoFromJson(json);
}
