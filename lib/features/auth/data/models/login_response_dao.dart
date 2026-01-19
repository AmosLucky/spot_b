import 'package:freezed_annotation/freezed_annotation.dart';

import 'login_role_dao.dart';
import 'login_user_dao.dart';

part 'login_response_dao.freezed.dart';
part 'login_response_dao.g.dart';

@freezed
class LoginResponseDao with _$LoginResponseDao {
  const factory LoginResponseDao({
    String? token,
    LoginUserDao? user,
    LoginRoleDao? role,
    List<String>? permissions,
  }) = _LoginResponseDao;

  factory LoginResponseDao.fromJson(Map<String, dynamic> json) => _$LoginResponseDaoFromJson(json);
}
