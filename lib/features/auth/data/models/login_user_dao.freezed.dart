// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_user_dao.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoginUserDao _$LoginUserDaoFromJson(Map<String, dynamic> json) {
  return _LoginUserDao.fromJson(json);
}

/// @nodoc
mixin _$LoginUserDao {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String? get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_admin', fromJson: _toBool, toJson: _fromBool)
  bool get isAdmin => throw _privateConstructorUsedError;
  LoginCompanyDao? get company => throw _privateConstructorUsedError;

  /// Serializes this LoginUserDao to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginUserDao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginUserDaoCopyWith<LoginUserDao> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginUserDaoCopyWith<$Res> {
  factory $LoginUserDaoCopyWith(
          LoginUserDao value, $Res Function(LoginUserDao) then) =
      _$LoginUserDaoCopyWithImpl<$Res, LoginUserDao>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'first_name') String? firstName,
      @JsonKey(name: 'last_name') String? lastName,
      String? email,
      String? phone,
      @JsonKey(name: 'is_admin', fromJson: _toBool, toJson: _fromBool)
      bool isAdmin,
      LoginCompanyDao? company});

  $LoginCompanyDaoCopyWith<$Res>? get company;
}

/// @nodoc
class _$LoginUserDaoCopyWithImpl<$Res, $Val extends LoginUserDao>
    implements $LoginUserDaoCopyWith<$Res> {
  _$LoginUserDaoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginUserDao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? isAdmin = null,
    Object? company = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as LoginCompanyDao?,
    ) as $Val);
  }

  /// Create a copy of LoginUserDao
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoginCompanyDaoCopyWith<$Res>? get company {
    if (_value.company == null) {
      return null;
    }

    return $LoginCompanyDaoCopyWith<$Res>(_value.company!, (value) {
      return _then(_value.copyWith(company: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoginUserDaoImplCopyWith<$Res>
    implements $LoginUserDaoCopyWith<$Res> {
  factory _$$LoginUserDaoImplCopyWith(
          _$LoginUserDaoImpl value, $Res Function(_$LoginUserDaoImpl) then) =
      __$$LoginUserDaoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'first_name') String? firstName,
      @JsonKey(name: 'last_name') String? lastName,
      String? email,
      String? phone,
      @JsonKey(name: 'is_admin', fromJson: _toBool, toJson: _fromBool)
      bool isAdmin,
      LoginCompanyDao? company});

  @override
  $LoginCompanyDaoCopyWith<$Res>? get company;
}

/// @nodoc
class __$$LoginUserDaoImplCopyWithImpl<$Res>
    extends _$LoginUserDaoCopyWithImpl<$Res, _$LoginUserDaoImpl>
    implements _$$LoginUserDaoImplCopyWith<$Res> {
  __$$LoginUserDaoImplCopyWithImpl(
      _$LoginUserDaoImpl _value, $Res Function(_$LoginUserDaoImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginUserDao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? isAdmin = null,
    Object? company = freezed,
  }) {
    return _then(_$LoginUserDaoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as LoginCompanyDao?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginUserDaoImpl implements _LoginUserDao {
  const _$LoginUserDaoImpl(
      {required this.id,
      @JsonKey(name: 'first_name') required this.firstName,
      @JsonKey(name: 'last_name') required this.lastName,
      required this.email,
      required this.phone,
      @JsonKey(name: 'is_admin', fromJson: _toBool, toJson: _fromBool)
      required this.isAdmin,
      required this.company});

  factory _$LoginUserDaoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginUserDaoImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'first_name')
  final String? firstName;
  @override
  @JsonKey(name: 'last_name')
  final String? lastName;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  @JsonKey(name: 'is_admin', fromJson: _toBool, toJson: _fromBool)
  final bool isAdmin;
  @override
  final LoginCompanyDao? company;

  @override
  String toString() {
    return 'LoginUserDao(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, isAdmin: $isAdmin, company: $company)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginUserDaoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.company, company) || other.company == company));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, firstName, lastName, email, phone, isAdmin, company);

  /// Create a copy of LoginUserDao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginUserDaoImplCopyWith<_$LoginUserDaoImpl> get copyWith =>
      __$$LoginUserDaoImplCopyWithImpl<_$LoginUserDaoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginUserDaoImplToJson(
      this,
    );
  }
}

abstract class _LoginUserDao implements LoginUserDao {
  const factory _LoginUserDao(
      {required final int? id,
      @JsonKey(name: 'first_name') required final String? firstName,
      @JsonKey(name: 'last_name') required final String? lastName,
      required final String? email,
      required final String? phone,
      @JsonKey(name: 'is_admin', fromJson: _toBool, toJson: _fromBool)
      required final bool isAdmin,
      required final LoginCompanyDao? company}) = _$LoginUserDaoImpl;

  factory _LoginUserDao.fromJson(Map<String, dynamic> json) =
      _$LoginUserDaoImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'first_name')
  String? get firstName;
  @override
  @JsonKey(name: 'last_name')
  String? get lastName;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  @JsonKey(name: 'is_admin', fromJson: _toBool, toJson: _fromBool)
  bool get isAdmin;
  @override
  LoginCompanyDao? get company;

  /// Create a copy of LoginUserDao
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginUserDaoImplCopyWith<_$LoginUserDaoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
