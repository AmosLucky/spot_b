// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'open_register_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OpenRegisterDto _$OpenRegisterDtoFromJson(Map<String, dynamic> json) {
  return _OpenRegisterDto.fromJson(json);
}

/// @nodoc
mixin _$OpenRegisterDto {
  double? get openingCashAtHand => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this OpenRegisterDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OpenRegisterDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OpenRegisterDtoCopyWith<OpenRegisterDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OpenRegisterDtoCopyWith<$Res> {
  factory $OpenRegisterDtoCopyWith(
          OpenRegisterDto value, $Res Function(OpenRegisterDto) then) =
      _$OpenRegisterDtoCopyWithImpl<$Res, OpenRegisterDto>;
  @useResult
  $Res call({double? openingCashAtHand, String? note});
}

/// @nodoc
class _$OpenRegisterDtoCopyWithImpl<$Res, $Val extends OpenRegisterDto>
    implements $OpenRegisterDtoCopyWith<$Res> {
  _$OpenRegisterDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OpenRegisterDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? openingCashAtHand = freezed,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      openingCashAtHand: freezed == openingCashAtHand
          ? _value.openingCashAtHand
          : openingCashAtHand // ignore: cast_nullable_to_non_nullable
              as double?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OpenRegisterDtoImplCopyWith<$Res>
    implements $OpenRegisterDtoCopyWith<$Res> {
  factory _$$OpenRegisterDtoImplCopyWith(_$OpenRegisterDtoImpl value,
          $Res Function(_$OpenRegisterDtoImpl) then) =
      __$$OpenRegisterDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? openingCashAtHand, String? note});
}

/// @nodoc
class __$$OpenRegisterDtoImplCopyWithImpl<$Res>
    extends _$OpenRegisterDtoCopyWithImpl<$Res, _$OpenRegisterDtoImpl>
    implements _$$OpenRegisterDtoImplCopyWith<$Res> {
  __$$OpenRegisterDtoImplCopyWithImpl(
      _$OpenRegisterDtoImpl _value, $Res Function(_$OpenRegisterDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of OpenRegisterDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? openingCashAtHand = freezed,
    Object? note = freezed,
  }) {
    return _then(_$OpenRegisterDtoImpl(
      openingCashAtHand: freezed == openingCashAtHand
          ? _value.openingCashAtHand
          : openingCashAtHand // ignore: cast_nullable_to_non_nullable
              as double?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OpenRegisterDtoImpl implements _OpenRegisterDto {
  const _$OpenRegisterDtoImpl({this.openingCashAtHand, this.note});

  factory _$OpenRegisterDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OpenRegisterDtoImplFromJson(json);

  @override
  final double? openingCashAtHand;
  @override
  final String? note;

  @override
  String toString() {
    return 'OpenRegisterDto(openingCashAtHand: $openingCashAtHand, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpenRegisterDtoImpl &&
            (identical(other.openingCashAtHand, openingCashAtHand) ||
                other.openingCashAtHand == openingCashAtHand) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, openingCashAtHand, note);

  /// Create a copy of OpenRegisterDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OpenRegisterDtoImplCopyWith<_$OpenRegisterDtoImpl> get copyWith =>
      __$$OpenRegisterDtoImplCopyWithImpl<_$OpenRegisterDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OpenRegisterDtoImplToJson(
      this,
    );
  }
}

abstract class _OpenRegisterDto implements OpenRegisterDto {
  const factory _OpenRegisterDto(
      {final double? openingCashAtHand,
      final String? note}) = _$OpenRegisterDtoImpl;

  factory _OpenRegisterDto.fromJson(Map<String, dynamic> json) =
      _$OpenRegisterDtoImpl.fromJson;

  @override
  double? get openingCashAtHand;
  @override
  String? get note;

  /// Create a copy of OpenRegisterDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OpenRegisterDtoImplCopyWith<_$OpenRegisterDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
