import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_company_dao.freezed.dart';
part 'login_company_dao.g.dart';

@freezed
class LoginCompanyDao with _$LoginCompanyDao {
  const factory LoginCompanyDao({
    required int? id,
    required String? name,
    required String? address,
    required String? phone,
    required String? email,
  }) = _LoginCompanyDao;

  factory LoginCompanyDao.fromJson(Map<String, dynamic> json) => _$LoginCompanyDaoFromJson(json);
}
