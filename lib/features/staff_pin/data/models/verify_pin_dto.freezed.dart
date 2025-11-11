// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_pin_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VerifyPinDto _$VerifyPinDtoFromJson(Map<String, dynamic> json) {
  return _VerifyPinDto.fromJson(json);
}

/// @nodoc
mixin _$VerifyPinDto {
  String get pin => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;

  /// Serializes this VerifyPinDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VerifyPinDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerifyPinDtoCopyWith<VerifyPinDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyPinDtoCopyWith<$Res> {
  factory $VerifyPinDtoCopyWith(
          VerifyPinDto value, $Res Function(VerifyPinDto) then) =
      _$VerifyPinDtoCopyWithImpl<$Res, VerifyPinDto>;
  @useResult
  $Res call({String pin, @JsonKey(name: 'user_id') int userId});
}

/// @nodoc
class _$VerifyPinDtoCopyWithImpl<$Res, $Val extends VerifyPinDto>
    implements $VerifyPinDtoCopyWith<$Res> {
  _$VerifyPinDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerifyPinDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pin = null,
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      pin: null == pin
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerifyPinDtoImplCopyWith<$Res>
    implements $VerifyPinDtoCopyWith<$Res> {
  factory _$$VerifyPinDtoImplCopyWith(
          _$VerifyPinDtoImpl value, $Res Function(_$VerifyPinDtoImpl) then) =
      __$$VerifyPinDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String pin, @JsonKey(name: 'user_id') int userId});
}

/// @nodoc
class __$$VerifyPinDtoImplCopyWithImpl<$Res>
    extends _$VerifyPinDtoCopyWithImpl<$Res, _$VerifyPinDtoImpl>
    implements _$$VerifyPinDtoImplCopyWith<$Res> {
  __$$VerifyPinDtoImplCopyWithImpl(
      _$VerifyPinDtoImpl _value, $Res Function(_$VerifyPinDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerifyPinDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pin = null,
    Object? userId = null,
  }) {
    return _then(_$VerifyPinDtoImpl(
      pin: null == pin
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyPinDtoImpl implements _VerifyPinDto {
  const _$VerifyPinDtoImpl(
      {required this.pin, @JsonKey(name: 'user_id') required this.userId});

  factory _$VerifyPinDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifyPinDtoImplFromJson(json);

  @override
  final String pin;
  @override
  @JsonKey(name: 'user_id')
  final int userId;

  @override
  String toString() {
    return 'VerifyPinDto(pin: $pin, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyPinDtoImpl &&
            (identical(other.pin, pin) || other.pin == pin) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, pin, userId);

  /// Create a copy of VerifyPinDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyPinDtoImplCopyWith<_$VerifyPinDtoImpl> get copyWith =>
      __$$VerifyPinDtoImplCopyWithImpl<_$VerifyPinDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyPinDtoImplToJson(
      this,
    );
  }
}

abstract class _VerifyPinDto implements VerifyPinDto {
  const factory _VerifyPinDto(
          {required final String pin,
          @JsonKey(name: 'user_id') required final int userId}) =
      _$VerifyPinDtoImpl;

  factory _VerifyPinDto.fromJson(Map<String, dynamic> json) =
      _$VerifyPinDtoImpl.fromJson;

  @override
  String get pin;
  @override
  @JsonKey(name: 'user_id')
  int get userId;

  /// Create a copy of VerifyPinDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerifyPinDtoImplCopyWith<_$VerifyPinDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
