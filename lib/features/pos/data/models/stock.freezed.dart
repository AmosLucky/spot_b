// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Stock _$StockFromJson(Map<String, dynamic> json) {
  return _Stock.fromJson(json);
}

/// @nodoc
mixin _$Stock {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'warehouse_id')
  int? get warehouseId => throw _privateConstructorUsedError;

  /// Serializes this Stock to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Stock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StockCopyWith<Stock> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockCopyWith<$Res> {
  factory $StockCopyWith(Stock value, $Res Function(Stock) then) =
      _$StockCopyWithImpl<$Res, Stock>;
  @useResult
  $Res call({int? id, @JsonKey(name: 'warehouse_id') int? warehouseId});
}

/// @nodoc
class _$StockCopyWithImpl<$Res, $Val extends Stock>
    implements $StockCopyWith<$Res> {
  _$StockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Stock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? warehouseId = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      warehouseId: freezed == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StockImplCopyWith<$Res> implements $StockCopyWith<$Res> {
  factory _$$StockImplCopyWith(
          _$StockImpl value, $Res Function(_$StockImpl) then) =
      __$$StockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, @JsonKey(name: 'warehouse_id') int? warehouseId});
}

/// @nodoc
class __$$StockImplCopyWithImpl<$Res>
    extends _$StockCopyWithImpl<$Res, _$StockImpl>
    implements _$$StockImplCopyWith<$Res> {
  __$$StockImplCopyWithImpl(
      _$StockImpl _value, $Res Function(_$StockImpl) _then)
      : super(_value, _then);

  /// Create a copy of Stock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? warehouseId = freezed,
  }) {
    return _then(_$StockImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      warehouseId: freezed == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StockImpl implements _Stock {
  const _$StockImpl({this.id, @JsonKey(name: 'warehouse_id') this.warehouseId});

  factory _$StockImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'warehouse_id')
  final int? warehouseId;

  @override
  String toString() {
    return 'Stock(id: $id, warehouseId: $warehouseId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, warehouseId);

  /// Create a copy of Stock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StockImplCopyWith<_$StockImpl> get copyWith =>
      __$$StockImplCopyWithImpl<_$StockImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StockImplToJson(
      this,
    );
  }
}

abstract class _Stock implements Stock {
  const factory _Stock(
      {final int? id,
      @JsonKey(name: 'warehouse_id') final int? warehouseId}) = _$StockImpl;

  factory _Stock.fromJson(Map<String, dynamic> json) = _$StockImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'warehouse_id')
  int? get warehouseId;

  /// Create a copy of Stock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockImplCopyWith<_$StockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
