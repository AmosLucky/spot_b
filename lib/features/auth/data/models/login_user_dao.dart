// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'login_company_dao.dart';

part 'login_user_dao.freezed.dart';
part 'login_user_dao.g.dart';

@freezed
class LoginUserDao with _$LoginUserDao {
  const factory LoginUserDao({
    required int? id,
    @JsonKey(name: 'first_name') required String? firstName,
    @JsonKey(name: 'last_name') required String? lastName,
    required String? email,
    required String? phone,
    required LoginCompanyDao? company,
  }) = _LoginUserDao;

  factory LoginUserDao.fromJson(Map<String, dynamic> json) => _$LoginUserDaoFromJson(json);
}
