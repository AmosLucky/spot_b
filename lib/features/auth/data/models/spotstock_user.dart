import 'package:freezed_annotation/freezed_annotation.dart';

part 'spotstock_user.freezed.dart';
part 'spotstock_user.g.dart';

@freezed
class SpotstockUser with _$SpotstockUser {
  const factory SpotstockUser({
    required int id,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required int roleId,
    required String roleName,
    required String roleDisplayName,
    required SpotstockCompany company,
  }) = _SpotstockUser;

  factory SpotstockUser.fromJson(Map<String, dynamic> json) => _$SpotstockUserFromJson(json);
}

@freezed
class SpotstockCompany with _$SpotstockCompany {
  const factory SpotstockCompany({
    required int id,
    required String name,
    required String address,
    required String phone,
    required String email,
  }) = _SpotstockCompany;

  factory SpotstockCompany.fromJson(Map<String, dynamic> json) => _$SpotstockCompanyFromJson(json);
}
