// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Register _$RegisterFromJson(Map<String, dynamic> json) {
  return _Register.fromJson(json);
}

/// @nodoc
mixin _$Register {
  int? get id => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  bool? get isOpen => throw _privateConstructorUsedError;
  bool? get isValid => throw _privateConstructorUsedError;
  double? get openingCashAtHand => throw _privateConstructorUsedError;
  double? get closingCashAtHand => throw _privateConstructorUsedError;

  /// Serializes this Register to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Register
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterCopyWith<Register> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterCopyWith<$Res> {
  factory $RegisterCopyWith(Register value, $Res Function(Register) then) =
      _$RegisterCopyWithImpl<$Res, Register>;
  @useResult
  $Res call(
      {int? id,
      DateTime? createdAt,
      bool? isOpen,
      bool? isValid,
      double? openingCashAtHand,
      double? closingCashAtHand});
}

/// @nodoc
class _$RegisterCopyWithImpl<$Res, $Val extends Register>
    implements $RegisterCopyWith<$Res> {
  _$RegisterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Register
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? isOpen = freezed,
    Object? isValid = freezed,
    Object? openingCashAtHand = freezed,
    Object? closingCashAtHand = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isOpen: freezed == isOpen
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool?,
      isValid: freezed == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool?,
      openingCashAtHand: freezed == openingCashAtHand
          ? _value.openingCashAtHand
          : openingCashAtHand // ignore: cast_nullable_to_non_nullable
              as double?,
      closingCashAtHand: freezed == closingCashAtHand
          ? _value.closingCashAtHand
          : closingCashAtHand // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterImplCopyWith<$Res>
    implements $RegisterCopyWith<$Res> {
  factory _$$RegisterImplCopyWith(
          _$RegisterImpl value, $Res Function(_$RegisterImpl) then) =
      __$$RegisterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      DateTime? createdAt,
      bool? isOpen,
      bool? isValid,
      double? openingCashAtHand,
      double? closingCashAtHand});
}

/// @nodoc
class __$$RegisterImplCopyWithImpl<$Res>
    extends _$RegisterCopyWithImpl<$Res, _$RegisterImpl>
    implements _$$RegisterImplCopyWith<$Res> {
  __$$RegisterImplCopyWithImpl(
      _$RegisterImpl _value, $Res Function(_$RegisterImpl) _then)
      : super(_value, _then);

  /// Create a copy of Register
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? isOpen = freezed,
    Object? isValid = freezed,
    Object? openingCashAtHand = freezed,
    Object? closingCashAtHand = freezed,
  }) {
    return _then(_$RegisterImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isOpen: freezed == isOpen
          ? _value.isOpen
          : isOpen // ignore: cast_nullable_to_non_nullable
              as bool?,
      isValid: freezed == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool?,
      openingCashAtHand: freezed == openingCashAtHand
          ? _value.openingCashAtHand
          : openingCashAtHand // ignore: cast_nullable_to_non_nullable
              as double?,
      closingCashAtHand: freezed == closingCashAtHand
          ? _value.closingCashAtHand
          : closingCashAtHand // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterImpl implements _Register {
  const _$RegisterImpl(
      {this.id,
      this.createdAt,
      this.isOpen,
      this.isValid,
      this.openingCashAtHand,
      this.closingCashAtHand});

  factory _$RegisterImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterImplFromJson(json);

  @override
  final int? id;
  @override
  final DateTime? createdAt;
  @override
  final bool? isOpen;
  @override
  final bool? isValid;
  @override
  final double? openingCashAtHand;
  @override
  final double? closingCashAtHand;

  @override
  String toString() {
    return 'Register(id: $id, createdAt: $createdAt, isOpen: $isOpen, isValid: $isValid, openingCashAtHand: $openingCashAtHand, closingCashAtHand: $closingCashAtHand)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isOpen, isOpen) || other.isOpen == isOpen) &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            (identical(other.openingCashAtHand, openingCashAtHand) ||
                other.openingCashAtHand == openingCashAtHand) &&
            (identical(other.closingCashAtHand, closingCashAtHand) ||
                other.closingCashAtHand == closingCashAtHand));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, isOpen, isValid,
      openingCashAtHand, closingCashAtHand);

  /// Create a copy of Register
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterImplCopyWith<_$RegisterImpl> get copyWith =>
      __$$RegisterImplCopyWithImpl<_$RegisterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterImplToJson(
      this,
    );
  }
}

abstract class _Register implements Register {
  const factory _Register(
      {final int? id,
      final DateTime? createdAt,
      final bool? isOpen,
      final bool? isValid,
      final double? openingCashAtHand,
      final double? closingCashAtHand}) = _$RegisterImpl;

  factory _Register.fromJson(Map<String, dynamic> json) =
      _$RegisterImpl.fromJson;

  @override
  int? get id;
  @override
  DateTime? get createdAt;
  @override
  bool? get isOpen;
  @override
  bool? get isValid;
  @override
  double? get openingCashAtHand;
  @override
  double? get closingCashAtHand;

  /// Create a copy of Register
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterImplCopyWith<_$RegisterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
