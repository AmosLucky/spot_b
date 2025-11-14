// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grouped_hold.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GroupedHold _$GroupedHoldFromJson(Map<String, dynamic> json) {
  return _GroupedHold.fromJson(json);
}

/// @nodoc
mixin _$GroupedHold {
  List<Hold> get holds => throw _privateConstructorUsedError;

  /// Serializes this GroupedHold to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupedHold
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupedHoldCopyWith<GroupedHold> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupedHoldCopyWith<$Res> {
  factory $GroupedHoldCopyWith(
          GroupedHold value, $Res Function(GroupedHold) then) =
      _$GroupedHoldCopyWithImpl<$Res, GroupedHold>;
  @useResult
  $Res call({List<Hold> holds});
}

/// @nodoc
class _$GroupedHoldCopyWithImpl<$Res, $Val extends GroupedHold>
    implements $GroupedHoldCopyWith<$Res> {
  _$GroupedHoldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupedHold
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? holds = null,
  }) {
    return _then(_value.copyWith(
      holds: null == holds
          ? _value.holds
          : holds // ignore: cast_nullable_to_non_nullable
              as List<Hold>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupedHoldImplCopyWith<$Res>
    implements $GroupedHoldCopyWith<$Res> {
  factory _$$GroupedHoldImplCopyWith(
          _$GroupedHoldImpl value, $Res Function(_$GroupedHoldImpl) then) =
      __$$GroupedHoldImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Hold> holds});
}

/// @nodoc
class __$$GroupedHoldImplCopyWithImpl<$Res>
    extends _$GroupedHoldCopyWithImpl<$Res, _$GroupedHoldImpl>
    implements _$$GroupedHoldImplCopyWith<$Res> {
  __$$GroupedHoldImplCopyWithImpl(
      _$GroupedHoldImpl _value, $Res Function(_$GroupedHoldImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupedHold
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? holds = null,
  }) {
    return _then(_$GroupedHoldImpl(
      holds: null == holds
          ? _value._holds
          : holds // ignore: cast_nullable_to_non_nullable
              as List<Hold>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupedHoldImpl extends _GroupedHold {
  const _$GroupedHoldImpl({required final List<Hold> holds})
      : _holds = holds,
        super._();

  factory _$GroupedHoldImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupedHoldImplFromJson(json);

  final List<Hold> _holds;
  @override
  List<Hold> get holds {
    if (_holds is EqualUnmodifiableListView) return _holds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_holds);
  }

  @override
  String toString() {
    return 'GroupedHold(holds: $holds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupedHoldImpl &&
            const DeepCollectionEquality().equals(other._holds, _holds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_holds));

  /// Create a copy of GroupedHold
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupedHoldImplCopyWith<_$GroupedHoldImpl> get copyWith =>
      __$$GroupedHoldImplCopyWithImpl<_$GroupedHoldImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupedHoldImplToJson(
      this,
    );
  }
}

abstract class _GroupedHold extends GroupedHold {
  const factory _GroupedHold({required final List<Hold> holds}) =
      _$GroupedHoldImpl;
  const _GroupedHold._() : super._();

  factory _GroupedHold.fromJson(Map<String, dynamic> json) =
      _$GroupedHoldImpl.fromJson;

  @override
  List<Hold> get holds;

  /// Create a copy of GroupedHold
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupedHoldImplCopyWith<_$GroupedHoldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
