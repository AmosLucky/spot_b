// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_warehouse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductWarehouse _$ProductWarehouseFromJson(Map<String, dynamic> json) {
  return _ProductWarehouse.fromJson(json);
}

/// @nodoc
mixin _$ProductWarehouse {
  @JsonKey(name: 'total_quantity')
  int? get totalQuantity => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this ProductWarehouse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductWarehouse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductWarehouseCopyWith<ProductWarehouse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductWarehouseCopyWith<$Res> {
  factory $ProductWarehouseCopyWith(
          ProductWarehouse value, $Res Function(ProductWarehouse) then) =
      _$ProductWarehouseCopyWithImpl<$Res, ProductWarehouse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_quantity') int? totalQuantity, String? name});
}

/// @nodoc
class _$ProductWarehouseCopyWithImpl<$Res, $Val extends ProductWarehouse>
    implements $ProductWarehouseCopyWith<$Res> {
  _$ProductWarehouseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductWarehouse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalQuantity = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      totalQuantity: freezed == totalQuantity
          ? _value.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductWarehouseImplCopyWith<$Res>
    implements $ProductWarehouseCopyWith<$Res> {
  factory _$$ProductWarehouseImplCopyWith(_$ProductWarehouseImpl value,
          $Res Function(_$ProductWarehouseImpl) then) =
      __$$ProductWarehouseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_quantity') int? totalQuantity, String? name});
}

/// @nodoc
class __$$ProductWarehouseImplCopyWithImpl<$Res>
    extends _$ProductWarehouseCopyWithImpl<$Res, _$ProductWarehouseImpl>
    implements _$$ProductWarehouseImplCopyWith<$Res> {
  __$$ProductWarehouseImplCopyWithImpl(_$ProductWarehouseImpl _value,
      $Res Function(_$ProductWarehouseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductWarehouse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalQuantity = freezed,
    Object? name = freezed,
  }) {
    return _then(_$ProductWarehouseImpl(
      totalQuantity: freezed == totalQuantity
          ? _value.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductWarehouseImpl implements _ProductWarehouse {
  const _$ProductWarehouseImpl(
      {@JsonKey(name: 'total_quantity') this.totalQuantity, this.name});

  factory _$ProductWarehouseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductWarehouseImplFromJson(json);

  @override
  @JsonKey(name: 'total_quantity')
  final int? totalQuantity;
  @override
  final String? name;

  @override
  String toString() {
    return 'ProductWarehouse(totalQuantity: $totalQuantity, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductWarehouseImpl &&
            (identical(other.totalQuantity, totalQuantity) ||
                other.totalQuantity == totalQuantity) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalQuantity, name);

  /// Create a copy of ProductWarehouse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductWarehouseImplCopyWith<_$ProductWarehouseImpl> get copyWith =>
      __$$ProductWarehouseImplCopyWithImpl<_$ProductWarehouseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductWarehouseImplToJson(
      this,
    );
  }
}

abstract class _ProductWarehouse implements ProductWarehouse {
  const factory _ProductWarehouse(
      {@JsonKey(name: 'total_quantity') final int? totalQuantity,
      final String? name}) = _$ProductWarehouseImpl;

  factory _ProductWarehouse.fromJson(Map<String, dynamic> json) =
      _$ProductWarehouseImpl.fromJson;

  @override
  @JsonKey(name: 'total_quantity')
  int? get totalQuantity;
  @override
  String? get name;

  /// Create a copy of ProductWarehouse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductWarehouseImplCopyWith<_$ProductWarehouseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
