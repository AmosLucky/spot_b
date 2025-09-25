// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_role_dao.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoginRoleDao _$LoginRoleDaoFromJson(Map<String, dynamic> json) {
  return _LoginRoleDao.fromJson(json);
}

/// @nodoc
mixin _$LoginRoleDao {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_name')
  String? get displayName => throw _privateConstructorUsedError;

  /// Serializes this LoginRoleDao to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginRoleDao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginRoleDaoCopyWith<LoginRoleDao> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginRoleDaoCopyWith<$Res> {
  factory $LoginRoleDaoCopyWith(
          LoginRoleDao value, $Res Function(LoginRoleDao) then) =
      _$LoginRoleDaoCopyWithImpl<$Res, LoginRoleDao>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      @JsonKey(name: 'display_name') String? displayName});
}

/// @nodoc
class _$LoginRoleDaoCopyWithImpl<$Res, $Val extends LoginRoleDao>
    implements $LoginRoleDaoCopyWith<$Res> {
  _$LoginRoleDaoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginRoleDao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? displayName = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginRoleDaoImplCopyWith<$Res>
    implements $LoginRoleDaoCopyWith<$Res> {
  factory _$$LoginRoleDaoImplCopyWith(
          _$LoginRoleDaoImpl value, $Res Function(_$LoginRoleDaoImpl) then) =
      __$$LoginRoleDaoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      @JsonKey(name: 'display_name') String? displayName});
}

/// @nodoc
class __$$LoginRoleDaoImplCopyWithImpl<$Res>
    extends _$LoginRoleDaoCopyWithImpl<$Res, _$LoginRoleDaoImpl>
    implements _$$LoginRoleDaoImplCopyWith<$Res> {
  __$$LoginRoleDaoImplCopyWithImpl(
      _$LoginRoleDaoImpl _value, $Res Function(_$LoginRoleDaoImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginRoleDao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? displayName = freezed,
  }) {
    return _then(_$LoginRoleDaoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginRoleDaoImpl implements _LoginRoleDao {
  const _$LoginRoleDaoImpl(
      {this.id, this.name, @JsonKey(name: 'display_name') this.displayName});

  factory _$LoginRoleDaoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginRoleDaoImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  @JsonKey(name: 'display_name')
  final String? displayName;

  @override
  String toString() {
    return 'LoginRoleDao(id: $id, name: $name, displayName: $displayName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginRoleDaoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, displayName);

  /// Create a copy of LoginRoleDao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginRoleDaoImplCopyWith<_$LoginRoleDaoImpl> get copyWith =>
      __$$LoginRoleDaoImplCopyWithImpl<_$LoginRoleDaoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginRoleDaoImplToJson(
      this,
    );
  }
}

abstract class _LoginRoleDao implements LoginRoleDao {
  const factory _LoginRoleDao(
          {final int? id,
          final String? name,
          @JsonKey(name: 'display_name') final String? displayName}) =
      _$LoginRoleDaoImpl;

  factory _LoginRoleDao.fromJson(Map<String, dynamic> json) =
      _$LoginRoleDaoImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  @JsonKey(name: 'display_name')
  String? get displayName;

  /// Create a copy of LoginRoleDao
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginRoleDaoImplCopyWith<_$LoginRoleDaoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
