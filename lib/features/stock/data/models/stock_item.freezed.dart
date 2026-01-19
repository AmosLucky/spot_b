// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StockItem _$StockItemFromJson(Map<String, dynamic> json) {
  return _StockItem.fromJson(json);
}

/// @nodoc
mixin _$StockItem {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int? get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'main_product_id')
  int? get mainProductId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String? get productName => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_code')
  String? get productCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  int? get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'brand_name')
  String? get brandName => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'stock_alert')
  String? get stockAlert => throw _privateConstructorUsedError;
  @JsonKey(name: 'value_by_cost')
  double? get valueByCost => throw _privateConstructorUsedError;
  @JsonKey(name: 'value_by_price')
  double? get valueByPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_cost')
  double? get productCost => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_price')
  double? get productPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_unit')
  String? get productUnit => throw _privateConstructorUsedError;
  @JsonKey(name: 'warehouse_id')
  int? get warehouseId => throw _privateConstructorUsedError;
  @JsonKey(name: 'warehouse_name')
  String? get warehouseName => throw _privateConstructorUsedError;
  @JsonKey(name: 'company_id')
  int? get companyId => throw _privateConstructorUsedError;

  /// Serializes this StockItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StockItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StockItemCopyWith<StockItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockItemCopyWith<$Res> {
  factory $StockItemCopyWith(StockItem value, $Res Function(StockItem) then) =
      _$StockItemCopyWithImpl<$Res, StockItem>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'product_id') int? productId,
      @JsonKey(name: 'main_product_id') int? mainProductId,
      @JsonKey(name: 'product_name') String? productName,
      @JsonKey(name: 'product_code') String? productCode,
      @JsonKey(name: 'category_id') int? categoryId,
      @JsonKey(name: 'category_name') String? categoryName,
      @JsonKey(name: 'brand_name') String? brandName,
      int? quantity,
      @JsonKey(name: 'stock_alert') String? stockAlert,
      @JsonKey(name: 'value_by_cost') double? valueByCost,
      @JsonKey(name: 'value_by_price') double? valueByPrice,
      @JsonKey(name: 'product_cost') double? productCost,
      @JsonKey(name: 'product_price') double? productPrice,
      @JsonKey(name: 'product_unit') String? productUnit,
      @JsonKey(name: 'warehouse_id') int? warehouseId,
      @JsonKey(name: 'warehouse_name') String? warehouseName,
      @JsonKey(name: 'company_id') int? companyId});
}

/// @nodoc
class _$StockItemCopyWithImpl<$Res, $Val extends StockItem>
    implements $StockItemCopyWith<$Res> {
  _$StockItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StockItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? productId = freezed,
    Object? mainProductId = freezed,
    Object? productName = freezed,
    Object? productCode = freezed,
    Object? categoryId = freezed,
    Object? categoryName = freezed,
    Object? brandName = freezed,
    Object? quantity = freezed,
    Object? stockAlert = freezed,
    Object? valueByCost = freezed,
    Object? valueByPrice = freezed,
    Object? productCost = freezed,
    Object? productPrice = freezed,
    Object? productUnit = freezed,
    Object? warehouseId = freezed,
    Object? warehouseName = freezed,
    Object? companyId = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      mainProductId: freezed == mainProductId
          ? _value.mainProductId
          : mainProductId // ignore: cast_nullable_to_non_nullable
              as int?,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      productCode: freezed == productCode
          ? _value.productCode
          : productCode // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      brandName: freezed == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      stockAlert: freezed == stockAlert
          ? _value.stockAlert
          : stockAlert // ignore: cast_nullable_to_non_nullable
              as String?,
      valueByCost: freezed == valueByCost
          ? _value.valueByCost
          : valueByCost // ignore: cast_nullable_to_non_nullable
              as double?,
      valueByPrice: freezed == valueByPrice
          ? _value.valueByPrice
          : valueByPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      productCost: freezed == productCost
          ? _value.productCost
          : productCost // ignore: cast_nullable_to_non_nullable
              as double?,
      productPrice: freezed == productPrice
          ? _value.productPrice
          : productPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      productUnit: freezed == productUnit
          ? _value.productUnit
          : productUnit // ignore: cast_nullable_to_non_nullable
              as String?,
      warehouseId: freezed == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as int?,
      warehouseName: freezed == warehouseName
          ? _value.warehouseName
          : warehouseName // ignore: cast_nullable_to_non_nullable
              as String?,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StockItemImplCopyWith<$Res>
    implements $StockItemCopyWith<$Res> {
  factory _$$StockItemImplCopyWith(
          _$StockItemImpl value, $Res Function(_$StockItemImpl) then) =
      __$$StockItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'product_id') int? productId,
      @JsonKey(name: 'main_product_id') int? mainProductId,
      @JsonKey(name: 'product_name') String? productName,
      @JsonKey(name: 'product_code') String? productCode,
      @JsonKey(name: 'category_id') int? categoryId,
      @JsonKey(name: 'category_name') String? categoryName,
      @JsonKey(name: 'brand_name') String? brandName,
      int? quantity,
      @JsonKey(name: 'stock_alert') String? stockAlert,
      @JsonKey(name: 'value_by_cost') double? valueByCost,
      @JsonKey(name: 'value_by_price') double? valueByPrice,
      @JsonKey(name: 'product_cost') double? productCost,
      @JsonKey(name: 'product_price') double? productPrice,
      @JsonKey(name: 'product_unit') String? productUnit,
      @JsonKey(name: 'warehouse_id') int? warehouseId,
      @JsonKey(name: 'warehouse_name') String? warehouseName,
      @JsonKey(name: 'company_id') int? companyId});
}

/// @nodoc
class __$$StockItemImplCopyWithImpl<$Res>
    extends _$StockItemCopyWithImpl<$Res, _$StockItemImpl>
    implements _$$StockItemImplCopyWith<$Res> {
  __$$StockItemImplCopyWithImpl(
      _$StockItemImpl _value, $Res Function(_$StockItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of StockItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? productId = freezed,
    Object? mainProductId = freezed,
    Object? productName = freezed,
    Object? productCode = freezed,
    Object? categoryId = freezed,
    Object? categoryName = freezed,
    Object? brandName = freezed,
    Object? quantity = freezed,
    Object? stockAlert = freezed,
    Object? valueByCost = freezed,
    Object? valueByPrice = freezed,
    Object? productCost = freezed,
    Object? productPrice = freezed,
    Object? productUnit = freezed,
    Object? warehouseId = freezed,
    Object? warehouseName = freezed,
    Object? companyId = freezed,
  }) {
    return _then(_$StockItemImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      mainProductId: freezed == mainProductId
          ? _value.mainProductId
          : mainProductId // ignore: cast_nullable_to_non_nullable
              as int?,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      productCode: freezed == productCode
          ? _value.productCode
          : productCode // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      brandName: freezed == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      stockAlert: freezed == stockAlert
          ? _value.stockAlert
          : stockAlert // ignore: cast_nullable_to_non_nullable
              as String?,
      valueByCost: freezed == valueByCost
          ? _value.valueByCost
          : valueByCost // ignore: cast_nullable_to_non_nullable
              as double?,
      valueByPrice: freezed == valueByPrice
          ? _value.valueByPrice
          : valueByPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      productCost: freezed == productCost
          ? _value.productCost
          : productCost // ignore: cast_nullable_to_non_nullable
              as double?,
      productPrice: freezed == productPrice
          ? _value.productPrice
          : productPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      productUnit: freezed == productUnit
          ? _value.productUnit
          : productUnit // ignore: cast_nullable_to_non_nullable
              as String?,
      warehouseId: freezed == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as int?,
      warehouseName: freezed == warehouseName
          ? _value.warehouseName
          : warehouseName // ignore: cast_nullable_to_non_nullable
              as String?,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StockItemImpl implements _StockItem {
  const _$StockItemImpl(
      {this.id,
      @JsonKey(name: 'product_id') this.productId,
      @JsonKey(name: 'main_product_id') this.mainProductId,
      @JsonKey(name: 'product_name') this.productName,
      @JsonKey(name: 'product_code') this.productCode,
      @JsonKey(name: 'category_id') this.categoryId,
      @JsonKey(name: 'category_name') this.categoryName,
      @JsonKey(name: 'brand_name') this.brandName,
      this.quantity,
      @JsonKey(name: 'stock_alert') this.stockAlert,
      @JsonKey(name: 'value_by_cost') this.valueByCost,
      @JsonKey(name: 'value_by_price') this.valueByPrice,
      @JsonKey(name: 'product_cost') this.productCost,
      @JsonKey(name: 'product_price') this.productPrice,
      @JsonKey(name: 'product_unit') this.productUnit,
      @JsonKey(name: 'warehouse_id') this.warehouseId,
      @JsonKey(name: 'warehouse_name') this.warehouseName,
      @JsonKey(name: 'company_id') this.companyId});

  factory _$StockItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockItemImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'product_id')
  final int? productId;
  @override
  @JsonKey(name: 'main_product_id')
  final int? mainProductId;
  @override
  @JsonKey(name: 'product_name')
  final String? productName;
  @override
  @JsonKey(name: 'product_code')
  final String? productCode;
  @override
  @JsonKey(name: 'category_id')
  final int? categoryId;
  @override
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @override
  @JsonKey(name: 'brand_name')
  final String? brandName;
  @override
  final int? quantity;
  @override
  @JsonKey(name: 'stock_alert')
  final String? stockAlert;
  @override
  @JsonKey(name: 'value_by_cost')
  final double? valueByCost;
  @override
  @JsonKey(name: 'value_by_price')
  final double? valueByPrice;
  @override
  @JsonKey(name: 'product_cost')
  final double? productCost;
  @override
  @JsonKey(name: 'product_price')
  final double? productPrice;
  @override
  @JsonKey(name: 'product_unit')
  final String? productUnit;
  @override
  @JsonKey(name: 'warehouse_id')
  final int? warehouseId;
  @override
  @JsonKey(name: 'warehouse_name')
  final String? warehouseName;
  @override
  @JsonKey(name: 'company_id')
  final int? companyId;

  @override
  String toString() {
    return 'StockItem(id: $id, productId: $productId, mainProductId: $mainProductId, productName: $productName, productCode: $productCode, categoryId: $categoryId, categoryName: $categoryName, brandName: $brandName, quantity: $quantity, stockAlert: $stockAlert, valueByCost: $valueByCost, valueByPrice: $valueByPrice, productCost: $productCost, productPrice: $productPrice, productUnit: $productUnit, warehouseId: $warehouseId, warehouseName: $warehouseName, companyId: $companyId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.mainProductId, mainProductId) ||
                other.mainProductId == mainProductId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productCode, productCode) ||
                other.productCode == productCode) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.stockAlert, stockAlert) ||
                other.stockAlert == stockAlert) &&
            (identical(other.valueByCost, valueByCost) ||
                other.valueByCost == valueByCost) &&
            (identical(other.valueByPrice, valueByPrice) ||
                other.valueByPrice == valueByPrice) &&
            (identical(other.productCost, productCost) ||
                other.productCost == productCost) &&
            (identical(other.productPrice, productPrice) ||
                other.productPrice == productPrice) &&
            (identical(other.productUnit, productUnit) ||
                other.productUnit == productUnit) &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId) &&
            (identical(other.warehouseName, warehouseName) ||
                other.warehouseName == warehouseName) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      productId,
      mainProductId,
      productName,
      productCode,
      categoryId,
      categoryName,
      brandName,
      quantity,
      stockAlert,
      valueByCost,
      valueByPrice,
      productCost,
      productPrice,
      productUnit,
      warehouseId,
      warehouseName,
      companyId);

  /// Create a copy of StockItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StockItemImplCopyWith<_$StockItemImpl> get copyWith =>
      __$$StockItemImplCopyWithImpl<_$StockItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StockItemImplToJson(
      this,
    );
  }
}

abstract class _StockItem implements StockItem {
  const factory _StockItem(
      {final int? id,
      @JsonKey(name: 'product_id') final int? productId,
      @JsonKey(name: 'main_product_id') final int? mainProductId,
      @JsonKey(name: 'product_name') final String? productName,
      @JsonKey(name: 'product_code') final String? productCode,
      @JsonKey(name: 'category_id') final int? categoryId,
      @JsonKey(name: 'category_name') final String? categoryName,
      @JsonKey(name: 'brand_name') final String? brandName,
      final int? quantity,
      @JsonKey(name: 'stock_alert') final String? stockAlert,
      @JsonKey(name: 'value_by_cost') final double? valueByCost,
      @JsonKey(name: 'value_by_price') final double? valueByPrice,
      @JsonKey(name: 'product_cost') final double? productCost,
      @JsonKey(name: 'product_price') final double? productPrice,
      @JsonKey(name: 'product_unit') final String? productUnit,
      @JsonKey(name: 'warehouse_id') final int? warehouseId,
      @JsonKey(name: 'warehouse_name') final String? warehouseName,
      @JsonKey(name: 'company_id') final int? companyId}) = _$StockItemImpl;

  factory _StockItem.fromJson(Map<String, dynamic> json) =
      _$StockItemImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'product_id')
  int? get productId;
  @override
  @JsonKey(name: 'main_product_id')
  int? get mainProductId;
  @override
  @JsonKey(name: 'product_name')
  String? get productName;
  @override
  @JsonKey(name: 'product_code')
  String? get productCode;
  @override
  @JsonKey(name: 'category_id')
  int? get categoryId;
  @override
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @override
  @JsonKey(name: 'brand_name')
  String? get brandName;
  @override
  int? get quantity;
  @override
  @JsonKey(name: 'stock_alert')
  String? get stockAlert;
  @override
  @JsonKey(name: 'value_by_cost')
  double? get valueByCost;
  @override
  @JsonKey(name: 'value_by_price')
  double? get valueByPrice;
  @override
  @JsonKey(name: 'product_cost')
  double? get productCost;
  @override
  @JsonKey(name: 'product_price')
  double? get productPrice;
  @override
  @JsonKey(name: 'product_unit')
  String? get productUnit;
  @override
  @JsonKey(name: 'warehouse_id')
  int? get warehouseId;
  @override
  @JsonKey(name: 'warehouse_name')
  String? get warehouseName;
  @override
  @JsonKey(name: 'company_id')
  int? get companyId;

  /// Create a copy of StockItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockItemImplCopyWith<_$StockItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
