// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../pos/data/models/sale_creation_response.dart';

part 'spotstock_user.freezed.dart';
part 'spotstock_user.g.dart';

@freezed
class SpotstockUser with _$SpotstockUser {
  const factory SpotstockUser({
    int? id,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    String? email,
    String? phone,
    @JsonKey(name: 'role_id') int? roleId,
    @JsonKey(name: 'role_name') String? roleName,
    @JsonKey(name: 'role_display_name') String? roleDisplayName,
    @JsonKey(name: 'is_admin') @IntOrBoolToBoolConverter() bool? isAdmin,
    List<String>? permissions,
    SpotstockCompany? company,
  }) = _SpotstockUser;

  factory SpotstockUser.fromJson(Map<String, dynamic> json) => _$SpotstockUserFromJson(json);
}

@freezed
class SpotstockCompany with _$SpotstockCompany {
  const factory SpotstockCompany({
    int? id,
    String? name,
    String? address,
    String? phone,
    String? email,
  }) = _SpotstockCompany;

  factory SpotstockCompany.fromJson(Map<String, dynamic> json) => _$SpotstockCompanyFromJson(json);
}
