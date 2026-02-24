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

/// @nodoc
mixin _$Register {
  int? get id => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get closedAt => throw _privateConstructorUsedError;
  bool? get isClosed => throw _privateConstructorUsedError;
  double? get openingCashAtHand => throw _privateConstructorUsedError;
  double? get closingCashAtHand => throw _privateConstructorUsedError;
  SpotstockUser? get user => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  bool? get isSynced => throw _privateConstructorUsedError;

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
      DateTime? closedAt,
      bool? isClosed,
      double? openingCashAtHand,
      double? closingCashAtHand,
      SpotstockUser? user,
      String? note,
      bool? isSynced});

  $SpotstockUserCopyWith<$Res>? get user;
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
    Object? closedAt = freezed,
    Object? isClosed = freezed,
    Object? openingCashAtHand = freezed,
    Object? closingCashAtHand = freezed,
    Object? user = freezed,
    Object? note = freezed,
    Object? isSynced = freezed,
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
      closedAt: freezed == closedAt
          ? _value.closedAt
          : closedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isClosed: freezed == isClosed
          ? _value.isClosed
          : isClosed // ignore: cast_nullable_to_non_nullable
              as bool?,
      openingCashAtHand: freezed == openingCashAtHand
          ? _value.openingCashAtHand
          : openingCashAtHand // ignore: cast_nullable_to_non_nullable
              as double?,
      closingCashAtHand: freezed == closingCashAtHand
          ? _value.closingCashAtHand
          : closingCashAtHand // ignore: cast_nullable_to_non_nullable
              as double?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as SpotstockUser?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      isSynced: freezed == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  /// Create a copy of Register
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SpotstockUserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $SpotstockUserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
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
      DateTime? closedAt,
      bool? isClosed,
      double? openingCashAtHand,
      double? closingCashAtHand,
      SpotstockUser? user,
      String? note,
      bool? isSynced});

  @override
  $SpotstockUserCopyWith<$Res>? get user;
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
    Object? closedAt = freezed,
    Object? isClosed = freezed,
    Object? openingCashAtHand = freezed,
    Object? closingCashAtHand = freezed,
    Object? user = freezed,
    Object? note = freezed,
    Object? isSynced = freezed,
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
      closedAt: freezed == closedAt
          ? _value.closedAt
          : closedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isClosed: freezed == isClosed
          ? _value.isClosed
          : isClosed // ignore: cast_nullable_to_non_nullable
              as bool?,
      openingCashAtHand: freezed == openingCashAtHand
          ? _value.openingCashAtHand
          : openingCashAtHand // ignore: cast_nullable_to_non_nullable
              as double?,
      closingCashAtHand: freezed == closingCashAtHand
          ? _value.closingCashAtHand
          : closingCashAtHand // ignore: cast_nullable_to_non_nullable
              as double?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as SpotstockUser?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      isSynced: freezed == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$RegisterImpl implements _Register {
  const _$RegisterImpl(
      {this.id,
      this.createdAt,
      this.closedAt,
      this.isClosed,
      this.openingCashAtHand,
      this.closingCashAtHand,
      this.user,
      this.note,
      this.isSynced});

  @override
  final int? id;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? closedAt;
  @override
  final bool? isClosed;
  @override
  final double? openingCashAtHand;
  @override
  final double? closingCashAtHand;
  @override
  final SpotstockUser? user;
  @override
  final String? note;
  @override
  final bool? isSynced;

  @override
  String toString() {
    return 'Register(id: $id, createdAt: $createdAt, closedAt: $closedAt, isClosed: $isClosed, openingCashAtHand: $openingCashAtHand, closingCashAtHand: $closingCashAtHand, user: $user, note: $note, isSynced: $isSynced)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.closedAt, closedAt) ||
                other.closedAt == closedAt) &&
            (identical(other.isClosed, isClosed) ||
                other.isClosed == isClosed) &&
            (identical(other.openingCashAtHand, openingCashAtHand) ||
                other.openingCashAtHand == openingCashAtHand) &&
            (identical(other.closingCashAtHand, closingCashAtHand) ||
                other.closingCashAtHand == closingCashAtHand) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, closedAt,
      isClosed, openingCashAtHand, closingCashAtHand, user, note, isSynced);

  /// Create a copy of Register
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterImplCopyWith<_$RegisterImpl> get copyWith =>
      __$$RegisterImplCopyWithImpl<_$RegisterImpl>(this, _$identity);
}

abstract class _Register implements Register {
  const factory _Register(
      {final int? id,
      final DateTime? createdAt,
      final DateTime? closedAt,
      final bool? isClosed,
      final double? openingCashAtHand,
      final double? closingCashAtHand,
      final SpotstockUser? user,
      final String? note,
      final bool? isSynced}) = _$RegisterImpl;

  @override
  int? get id;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get closedAt;
  @override
  bool? get isClosed;
  @override
  double? get openingCashAtHand;
  @override
  double? get closingCashAtHand;
  @override
  SpotstockUser? get user;
  @override
  String? get note;
  @override
  bool? get isSynced;

  /// Create a copy of Register
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterImplCopyWith<_$RegisterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
