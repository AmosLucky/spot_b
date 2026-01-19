// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_response_dao.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoginResponseDao _$LoginResponseDaoFromJson(Map<String, dynamic> json) {
  return _LoginResponseDao.fromJson(json);
}

/// @nodoc
mixin _$LoginResponseDao {
  String? get token => throw _privateConstructorUsedError;
  LoginUserDao? get user => throw _privateConstructorUsedError;
  LoginRoleDao? get role => throw _privateConstructorUsedError;
  List<String>? get permissions => throw _privateConstructorUsedError;

  /// Serializes this LoginResponseDao to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginResponseDao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginResponseDaoCopyWith<LoginResponseDao> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginResponseDaoCopyWith<$Res> {
  factory $LoginResponseDaoCopyWith(
          LoginResponseDao value, $Res Function(LoginResponseDao) then) =
      _$LoginResponseDaoCopyWithImpl<$Res, LoginResponseDao>;
  @useResult
  $Res call(
      {String? token,
      LoginUserDao? user,
      LoginRoleDao? role,
      List<String>? permissions});

  $LoginUserDaoCopyWith<$Res>? get user;
  $LoginRoleDaoCopyWith<$Res>? get role;
}

/// @nodoc
class _$LoginResponseDaoCopyWithImpl<$Res, $Val extends LoginResponseDao>
    implements $LoginResponseDaoCopyWith<$Res> {
  _$LoginResponseDaoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginResponseDao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? user = freezed,
    Object? role = freezed,
    Object? permissions = freezed,
  }) {
    return _then(_value.copyWith(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as LoginUserDao?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as LoginRoleDao?,
      permissions: freezed == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }

  /// Create a copy of LoginResponseDao
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoginUserDaoCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $LoginUserDaoCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of LoginResponseDao
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoginRoleDaoCopyWith<$Res>? get role {
    if (_value.role == null) {
      return null;
    }

    return $LoginRoleDaoCopyWith<$Res>(_value.role!, (value) {
      return _then(_value.copyWith(role: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoginResponseDaoImplCopyWith<$Res>
    implements $LoginResponseDaoCopyWith<$Res> {
  factory _$$LoginResponseDaoImplCopyWith(_$LoginResponseDaoImpl value,
          $Res Function(_$LoginResponseDaoImpl) then) =
      __$$LoginResponseDaoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? token,
      LoginUserDao? user,
      LoginRoleDao? role,
      List<String>? permissions});

  @override
  $LoginUserDaoCopyWith<$Res>? get user;
  @override
  $LoginRoleDaoCopyWith<$Res>? get role;
}

/// @nodoc
class __$$LoginResponseDaoImplCopyWithImpl<$Res>
    extends _$LoginResponseDaoCopyWithImpl<$Res, _$LoginResponseDaoImpl>
    implements _$$LoginResponseDaoImplCopyWith<$Res> {
  __$$LoginResponseDaoImplCopyWithImpl(_$LoginResponseDaoImpl _value,
      $Res Function(_$LoginResponseDaoImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginResponseDao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? user = freezed,
    Object? role = freezed,
    Object? permissions = freezed,
  }) {
    return _then(_$LoginResponseDaoImpl(
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as LoginUserDao?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as LoginRoleDao?,
      permissions: freezed == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginResponseDaoImpl implements _LoginResponseDao {
  const _$LoginResponseDaoImpl(
      {this.token, this.user, this.role, final List<String>? permissions})
      : _permissions = permissions;

  factory _$LoginResponseDaoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginResponseDaoImplFromJson(json);

  @override
  final String? token;
  @override
  final LoginUserDao? user;
  @override
  final LoginRoleDao? role;
  final List<String>? _permissions;
  @override
  List<String>? get permissions {
    final value = _permissions;
    if (value == null) return null;
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'LoginResponseDao(token: $token, user: $user, role: $role, permissions: $permissions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginResponseDaoImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token, user, role,
      const DeepCollectionEquality().hash(_permissions));

  /// Create a copy of LoginResponseDao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginResponseDaoImplCopyWith<_$LoginResponseDaoImpl> get copyWith =>
      __$$LoginResponseDaoImplCopyWithImpl<_$LoginResponseDaoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginResponseDaoImplToJson(
      this,
    );
  }
}

abstract class _LoginResponseDao implements LoginResponseDao {
  const factory _LoginResponseDao(
      {final String? token,
      final LoginUserDao? user,
      final LoginRoleDao? role,
      final List<String>? permissions}) = _$LoginResponseDaoImpl;

  factory _LoginResponseDao.fromJson(Map<String, dynamic> json) =
      _$LoginResponseDaoImpl.fromJson;

  @override
  String? get token;
  @override
  LoginUserDao? get user;
  @override
  LoginRoleDao? get role;
  @override
  List<String>? get permissions;

  /// Create a copy of LoginResponseDao
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginResponseDaoImplCopyWith<_$LoginResponseDaoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
