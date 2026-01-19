// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'close_register_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CloseRegisterDto _$CloseRegisterDtoFromJson(Map<String, dynamic> json) {
  return _CloseRegisterDto.fromJson(json);
}

/// @nodoc
mixin _$CloseRegisterDto {
  @JsonKey(includeToJson: false)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'cash_in_hand_while_closing')
  double? get cashInHandWhileClosing => throw _privateConstructorUsedError;
  @JsonKey(name: 'notes')
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this CloseRegisterDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CloseRegisterDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CloseRegisterDtoCopyWith<CloseRegisterDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CloseRegisterDtoCopyWith<$Res> {
  factory $CloseRegisterDtoCopyWith(
          CloseRegisterDto value, $Res Function(CloseRegisterDto) then) =
      _$CloseRegisterDtoCopyWithImpl<$Res, CloseRegisterDto>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int? id,
      @JsonKey(name: 'cash_in_hand_while_closing')
      double? cashInHandWhileClosing,
      @JsonKey(name: 'notes') String? notes});
}

/// @nodoc
class _$CloseRegisterDtoCopyWithImpl<$Res, $Val extends CloseRegisterDto>
    implements $CloseRegisterDtoCopyWith<$Res> {
  _$CloseRegisterDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CloseRegisterDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? cashInHandWhileClosing = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      cashInHandWhileClosing: freezed == cashInHandWhileClosing
          ? _value.cashInHandWhileClosing
          : cashInHandWhileClosing // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CloseRegisterDtoImplCopyWith<$Res>
    implements $CloseRegisterDtoCopyWith<$Res> {
  factory _$$CloseRegisterDtoImplCopyWith(_$CloseRegisterDtoImpl value,
          $Res Function(_$CloseRegisterDtoImpl) then) =
      __$$CloseRegisterDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int? id,
      @JsonKey(name: 'cash_in_hand_while_closing')
      double? cashInHandWhileClosing,
      @JsonKey(name: 'notes') String? notes});
}

/// @nodoc
class __$$CloseRegisterDtoImplCopyWithImpl<$Res>
    extends _$CloseRegisterDtoCopyWithImpl<$Res, _$CloseRegisterDtoImpl>
    implements _$$CloseRegisterDtoImplCopyWith<$Res> {
  __$$CloseRegisterDtoImplCopyWithImpl(_$CloseRegisterDtoImpl _value,
      $Res Function(_$CloseRegisterDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of CloseRegisterDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? cashInHandWhileClosing = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$CloseRegisterDtoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      cashInHandWhileClosing: freezed == cashInHandWhileClosing
          ? _value.cashInHandWhileClosing
          : cashInHandWhileClosing // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CloseRegisterDtoImpl implements _CloseRegisterDto {
  const _$CloseRegisterDtoImpl(
      {@JsonKey(includeToJson: false) this.id,
      @JsonKey(name: 'cash_in_hand_while_closing') this.cashInHandWhileClosing,
      @JsonKey(name: 'notes') this.notes});

  factory _$CloseRegisterDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CloseRegisterDtoImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int? id;
  @override
  @JsonKey(name: 'cash_in_hand_while_closing')
  final double? cashInHandWhileClosing;
  @override
  @JsonKey(name: 'notes')
  final String? notes;

  @override
  String toString() {
    return 'CloseRegisterDto(id: $id, cashInHandWhileClosing: $cashInHandWhileClosing, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CloseRegisterDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.cashInHandWhileClosing, cashInHandWhileClosing) ||
                other.cashInHandWhileClosing == cashInHandWhileClosing) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, cashInHandWhileClosing, notes);

  /// Create a copy of CloseRegisterDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CloseRegisterDtoImplCopyWith<_$CloseRegisterDtoImpl> get copyWith =>
      __$$CloseRegisterDtoImplCopyWithImpl<_$CloseRegisterDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CloseRegisterDtoImplToJson(
      this,
    );
  }
}

abstract class _CloseRegisterDto implements CloseRegisterDto {
  const factory _CloseRegisterDto(
      {@JsonKey(includeToJson: false) final int? id,
      @JsonKey(name: 'cash_in_hand_while_closing')
      final double? cashInHandWhileClosing,
      @JsonKey(name: 'notes') final String? notes}) = _$CloseRegisterDtoImpl;

  factory _CloseRegisterDto.fromJson(Map<String, dynamic> json) =
      _$CloseRegisterDtoImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  int? get id;
  @override
  @JsonKey(name: 'cash_in_hand_while_closing')
  double? get cashInHandWhileClosing;
  @override
  @JsonKey(name: 'notes')
  String? get notes;

  /// Create a copy of CloseRegisterDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CloseRegisterDtoImplCopyWith<_$CloseRegisterDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
