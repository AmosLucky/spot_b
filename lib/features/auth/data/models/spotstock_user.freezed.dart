// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spotstock_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SpotstockUser _$SpotstockUserFromJson(Map<String, dynamic> json) {
  return _SpotstockUser.fromJson(json);
}

/// @nodoc
mixin _$SpotstockUser {
  int get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  int get roleId => throw _privateConstructorUsedError;
  String get roleName => throw _privateConstructorUsedError;
  String get roleDisplayName => throw _privateConstructorUsedError;
  SpotstockCompany get company => throw _privateConstructorUsedError;

  /// Serializes this SpotstockUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpotstockUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpotstockUserCopyWith<SpotstockUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpotstockUserCopyWith<$Res> {
  factory $SpotstockUserCopyWith(
          SpotstockUser value, $Res Function(SpotstockUser) then) =
      _$SpotstockUserCopyWithImpl<$Res, SpotstockUser>;
  @useResult
  $Res call(
      {int id,
      String firstName,
      String lastName,
      String email,
      String phone,
      int roleId,
      String roleName,
      String roleDisplayName,
      SpotstockCompany company});

  $SpotstockCompanyCopyWith<$Res> get company;
}

/// @nodoc
class _$SpotstockUserCopyWithImpl<$Res, $Val extends SpotstockUser>
    implements $SpotstockUserCopyWith<$Res> {
  _$SpotstockUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpotstockUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phone = null,
    Object? roleId = null,
    Object? roleName = null,
    Object? roleDisplayName = null,
    Object? company = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      roleId: null == roleId
          ? _value.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as int,
      roleName: null == roleName
          ? _value.roleName
          : roleName // ignore: cast_nullable_to_non_nullable
              as String,
      roleDisplayName: null == roleDisplayName
          ? _value.roleDisplayName
          : roleDisplayName // ignore: cast_nullable_to_non_nullable
              as String,
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as SpotstockCompany,
    ) as $Val);
  }

  /// Create a copy of SpotstockUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SpotstockCompanyCopyWith<$Res> get company {
    return $SpotstockCompanyCopyWith<$Res>(_value.company, (value) {
      return _then(_value.copyWith(company: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SpotstockUserImplCopyWith<$Res>
    implements $SpotstockUserCopyWith<$Res> {
  factory _$$SpotstockUserImplCopyWith(
          _$SpotstockUserImpl value, $Res Function(_$SpotstockUserImpl) then) =
      __$$SpotstockUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String firstName,
      String lastName,
      String email,
      String phone,
      int roleId,
      String roleName,
      String roleDisplayName,
      SpotstockCompany company});

  @override
  $SpotstockCompanyCopyWith<$Res> get company;
}

/// @nodoc
class __$$SpotstockUserImplCopyWithImpl<$Res>
    extends _$SpotstockUserCopyWithImpl<$Res, _$SpotstockUserImpl>
    implements _$$SpotstockUserImplCopyWith<$Res> {
  __$$SpotstockUserImplCopyWithImpl(
      _$SpotstockUserImpl _value, $Res Function(_$SpotstockUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpotstockUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = null,
    Object? phone = null,
    Object? roleId = null,
    Object? roleName = null,
    Object? roleDisplayName = null,
    Object? company = null,
  }) {
    return _then(_$SpotstockUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      roleId: null == roleId
          ? _value.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as int,
      roleName: null == roleName
          ? _value.roleName
          : roleName // ignore: cast_nullable_to_non_nullable
              as String,
      roleDisplayName: null == roleDisplayName
          ? _value.roleDisplayName
          : roleDisplayName // ignore: cast_nullable_to_non_nullable
              as String,
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as SpotstockCompany,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpotstockUserImpl implements _SpotstockUser {
  const _$SpotstockUserImpl(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.roleId,
      required this.roleName,
      required this.roleDisplayName,
      required this.company});

  factory _$SpotstockUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpotstockUserImplFromJson(json);

  @override
  final int id;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String email;
  @override
  final String phone;
  @override
  final int roleId;
  @override
  final String roleName;
  @override
  final String roleDisplayName;
  @override
  final SpotstockCompany company;

  @override
  String toString() {
    return 'SpotstockUser(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, roleId: $roleId, roleName: $roleName, roleDisplayName: $roleDisplayName, company: $company)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpotstockUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.roleId, roleId) || other.roleId == roleId) &&
            (identical(other.roleName, roleName) ||
                other.roleName == roleName) &&
            (identical(other.roleDisplayName, roleDisplayName) ||
                other.roleDisplayName == roleDisplayName) &&
            (identical(other.company, company) || other.company == company));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, firstName, lastName, email,
      phone, roleId, roleName, roleDisplayName, company);

  /// Create a copy of SpotstockUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpotstockUserImplCopyWith<_$SpotstockUserImpl> get copyWith =>
      __$$SpotstockUserImplCopyWithImpl<_$SpotstockUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpotstockUserImplToJson(
      this,
    );
  }
}

abstract class _SpotstockUser implements SpotstockUser {
  const factory _SpotstockUser(
      {required final int id,
      required final String firstName,
      required final String lastName,
      required final String email,
      required final String phone,
      required final int roleId,
      required final String roleName,
      required final String roleDisplayName,
      required final SpotstockCompany company}) = _$SpotstockUserImpl;

  factory _SpotstockUser.fromJson(Map<String, dynamic> json) =
      _$SpotstockUserImpl.fromJson;

  @override
  int get id;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get email;
  @override
  String get phone;
  @override
  int get roleId;
  @override
  String get roleName;
  @override
  String get roleDisplayName;
  @override
  SpotstockCompany get company;

  /// Create a copy of SpotstockUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpotstockUserImplCopyWith<_$SpotstockUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SpotstockCompany _$SpotstockCompanyFromJson(Map<String, dynamic> json) {
  return _SpotstockCompany.fromJson(json);
}

/// @nodoc
mixin _$SpotstockCompany {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;

  /// Serializes this SpotstockCompany to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpotstockCompany
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpotstockCompanyCopyWith<SpotstockCompany> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpotstockCompanyCopyWith<$Res> {
  factory $SpotstockCompanyCopyWith(
          SpotstockCompany value, $Res Function(SpotstockCompany) then) =
      _$SpotstockCompanyCopyWithImpl<$Res, SpotstockCompany>;
  @useResult
  $Res call({int id, String name, String address, String phone, String email});
}

/// @nodoc
class _$SpotstockCompanyCopyWithImpl<$Res, $Val extends SpotstockCompany>
    implements $SpotstockCompanyCopyWith<$Res> {
  _$SpotstockCompanyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpotstockCompany
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? phone = null,
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpotstockCompanyImplCopyWith<$Res>
    implements $SpotstockCompanyCopyWith<$Res> {
  factory _$$SpotstockCompanyImplCopyWith(_$SpotstockCompanyImpl value,
          $Res Function(_$SpotstockCompanyImpl) then) =
      __$$SpotstockCompanyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String address, String phone, String email});
}

/// @nodoc
class __$$SpotstockCompanyImplCopyWithImpl<$Res>
    extends _$SpotstockCompanyCopyWithImpl<$Res, _$SpotstockCompanyImpl>
    implements _$$SpotstockCompanyImplCopyWith<$Res> {
  __$$SpotstockCompanyImplCopyWithImpl(_$SpotstockCompanyImpl _value,
      $Res Function(_$SpotstockCompanyImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpotstockCompany
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? phone = null,
    Object? email = null,
  }) {
    return _then(_$SpotstockCompanyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpotstockCompanyImpl implements _SpotstockCompany {
  const _$SpotstockCompanyImpl(
      {required this.id,
      required this.name,
      required this.address,
      required this.phone,
      required this.email});

  factory _$SpotstockCompanyImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpotstockCompanyImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String address;
  @override
  final String phone;
  @override
  final String email;

  @override
  String toString() {
    return 'SpotstockCompany(id: $id, name: $name, address: $address, phone: $phone, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpotstockCompanyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, address, phone, email);

  /// Create a copy of SpotstockCompany
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpotstockCompanyImplCopyWith<_$SpotstockCompanyImpl> get copyWith =>
      __$$SpotstockCompanyImplCopyWithImpl<_$SpotstockCompanyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpotstockCompanyImplToJson(
      this,
    );
  }
}

abstract class _SpotstockCompany implements SpotstockCompany {
  const factory _SpotstockCompany(
      {required final int id,
      required final String name,
      required final String address,
      required final String phone,
      required final String email}) = _$SpotstockCompanyImpl;

  factory _SpotstockCompany.fromJson(Map<String, dynamic> json) =
      _$SpotstockCompanyImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get address;
  @override
  String get phone;
  @override
  String get email;

  /// Create a copy of SpotstockCompany
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpotstockCompanyImplCopyWith<_$SpotstockCompanyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
