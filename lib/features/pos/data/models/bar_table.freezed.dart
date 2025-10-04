// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bar_table.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BarTable {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'company_id')
  int? get companyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'chairs_no')
  int? get chairsNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;

  /// Create a copy of BarTable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BarTableCopyWith<BarTable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BarTableCopyWith<$Res> {
  factory $BarTableCopyWith(BarTable value, $Res Function(BarTable) then) =
      _$BarTableCopyWithImpl<$Res, BarTable>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      @JsonKey(name: 'company_id') int? companyId,
      @JsonKey(name: 'chairs_no') int? chairsNo,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      String? link});
}

/// @nodoc
class _$BarTableCopyWithImpl<$Res, $Val extends BarTable>
    implements $BarTableCopyWith<$Res> {
  _$BarTableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BarTable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? companyId = freezed,
    Object? chairsNo = freezed,
    Object? createdAt = freezed,
    Object? link = freezed,
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
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as int?,
      chairsNo: freezed == chairsNo
          ? _value.chairsNo
          : chairsNo // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BarTableImplCopyWith<$Res>
    implements $BarTableCopyWith<$Res> {
  factory _$$BarTableImplCopyWith(
          _$BarTableImpl value, $Res Function(_$BarTableImpl) then) =
      __$$BarTableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      @JsonKey(name: 'company_id') int? companyId,
      @JsonKey(name: 'chairs_no') int? chairsNo,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      String? link});
}

/// @nodoc
class __$$BarTableImplCopyWithImpl<$Res>
    extends _$BarTableCopyWithImpl<$Res, _$BarTableImpl>
    implements _$$BarTableImplCopyWith<$Res> {
  __$$BarTableImplCopyWithImpl(
      _$BarTableImpl _value, $Res Function(_$BarTableImpl) _then)
      : super(_value, _then);

  /// Create a copy of BarTable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? companyId = freezed,
    Object? chairsNo = freezed,
    Object? createdAt = freezed,
    Object? link = freezed,
  }) {
    return _then(_$BarTableImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as int?,
      chairsNo: freezed == chairsNo
          ? _value.chairsNo
          : chairsNo // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$BarTableImpl implements _BarTable {
  const _$BarTableImpl(
      {this.id,
      this.name,
      @JsonKey(name: 'company_id') this.companyId,
      @JsonKey(name: 'chairs_no') this.chairsNo,
      @JsonKey(name: 'created_at') this.createdAt,
      this.link});

  @override
  final int? id;
  @override
  final String? name;
  @override
  @JsonKey(name: 'company_id')
  final int? companyId;
  @override
  @JsonKey(name: 'chairs_no')
  final int? chairsNo;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  final String? link;

  @override
  String toString() {
    return 'BarTable(id: $id, name: $name, companyId: $companyId, chairsNo: $chairsNo, createdAt: $createdAt, link: $link)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BarTableImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.chairsNo, chairsNo) ||
                other.chairsNo == chairsNo) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.link, link) || other.link == link));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, companyId, chairsNo, createdAt, link);

  /// Create a copy of BarTable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BarTableImplCopyWith<_$BarTableImpl> get copyWith =>
      __$$BarTableImplCopyWithImpl<_$BarTableImpl>(this, _$identity);
}

abstract class _BarTable implements BarTable {
  const factory _BarTable(
      {final int? id,
      final String? name,
      @JsonKey(name: 'company_id') final int? companyId,
      @JsonKey(name: 'chairs_no') final int? chairsNo,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      final String? link}) = _$BarTableImpl;

  @override
  int? get id;
  @override
  String? get name;
  @override
  @JsonKey(name: 'company_id')
  int? get companyId;
  @override
  @JsonKey(name: 'chairs_no')
  int? get chairsNo;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  String? get link;

  /// Create a copy of BarTable
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BarTableImplCopyWith<_$BarTableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
