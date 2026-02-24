// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Product {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  int? get companyId => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  DateTime? get expiryDate => throw _privateConstructorUsedError;
  int? get mainProductId => throw _privateConstructorUsedError;
  int? get productCategoryId => throw _privateConstructorUsedError;
  double? get productCost => throw _privateConstructorUsedError;
  double? get productPrice => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  Stock? get stock => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  int? get inStock => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;
  double? get customCost => throw _privateConstructorUsedError;
  String? get customDescription => throw _privateConstructorUsedError;
  String? get customName => throw _privateConstructorUsedError;
  double? get customPrice => throw _privateConstructorUsedError;
  String? get brandName => throw _privateConstructorUsedError;
  String? get productCategoryName => throw _privateConstructorUsedError;
  String? get stockAlert => throw _privateConstructorUsedError;
  ProductUnitName? get productUnitName => throw _privateConstructorUsedError;
  List<ProductWarehouse>? get warehouse => throw _privateConstructorUsedError;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      int? companyId,
      String? code,
      DateTime? expiryDate,
      int? mainProductId,
      int? productCategoryId,
      double? productCost,
      double? productPrice,
      bool? isActive,
      Stock? stock,
      DateTime? createdAt,
      int? inStock,
      String? link,
      double? customCost,
      String? customDescription,
      String? customName,
      double? customPrice,
      String? brandName,
      String? productCategoryName,
      String? stockAlert,
      ProductUnitName? productUnitName,
      List<ProductWarehouse>? warehouse});

  $StockCopyWith<$Res>? get stock;
  $ProductUnitNameCopyWith<$Res>? get productUnitName;
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? companyId = freezed,
    Object? code = freezed,
    Object? expiryDate = freezed,
    Object? mainProductId = freezed,
    Object? productCategoryId = freezed,
    Object? productCost = freezed,
    Object? productPrice = freezed,
    Object? isActive = freezed,
    Object? stock = freezed,
    Object? createdAt = freezed,
    Object? inStock = freezed,
    Object? link = freezed,
    Object? customCost = freezed,
    Object? customDescription = freezed,
    Object? customName = freezed,
    Object? customPrice = freezed,
    Object? brandName = freezed,
    Object? productCategoryName = freezed,
    Object? stockAlert = freezed,
    Object? productUnitName = freezed,
    Object? warehouse = freezed,
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
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      mainProductId: freezed == mainProductId
          ? _value.mainProductId
          : mainProductId // ignore: cast_nullable_to_non_nullable
              as int?,
      productCategoryId: freezed == productCategoryId
          ? _value.productCategoryId
          : productCategoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      productCost: freezed == productCost
          ? _value.productCost
          : productCost // ignore: cast_nullable_to_non_nullable
              as double?,
      productPrice: freezed == productPrice
          ? _value.productPrice
          : productPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      stock: freezed == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as Stock?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      inStock: freezed == inStock
          ? _value.inStock
          : inStock // ignore: cast_nullable_to_non_nullable
              as int?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
      customCost: freezed == customCost
          ? _value.customCost
          : customCost // ignore: cast_nullable_to_non_nullable
              as double?,
      customDescription: freezed == customDescription
          ? _value.customDescription
          : customDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      customName: freezed == customName
          ? _value.customName
          : customName // ignore: cast_nullable_to_non_nullable
              as String?,
      customPrice: freezed == customPrice
          ? _value.customPrice
          : customPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      brandName: freezed == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String?,
      productCategoryName: freezed == productCategoryName
          ? _value.productCategoryName
          : productCategoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      stockAlert: freezed == stockAlert
          ? _value.stockAlert
          : stockAlert // ignore: cast_nullable_to_non_nullable
              as String?,
      productUnitName: freezed == productUnitName
          ? _value.productUnitName
          : productUnitName // ignore: cast_nullable_to_non_nullable
              as ProductUnitName?,
      warehouse: freezed == warehouse
          ? _value.warehouse
          : warehouse // ignore: cast_nullable_to_non_nullable
              as List<ProductWarehouse>?,
    ) as $Val);
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StockCopyWith<$Res>? get stock {
    if (_value.stock == null) {
      return null;
    }

    return $StockCopyWith<$Res>(_value.stock!, (value) {
      return _then(_value.copyWith(stock: value) as $Val);
    });
  }

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductUnitNameCopyWith<$Res>? get productUnitName {
    if (_value.productUnitName == null) {
      return null;
    }

    return $ProductUnitNameCopyWith<$Res>(_value.productUnitName!, (value) {
      return _then(_value.copyWith(productUnitName: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
          _$ProductImpl value, $Res Function(_$ProductImpl) then) =
      __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      int? companyId,
      String? code,
      DateTime? expiryDate,
      int? mainProductId,
      int? productCategoryId,
      double? productCost,
      double? productPrice,
      bool? isActive,
      Stock? stock,
      DateTime? createdAt,
      int? inStock,
      String? link,
      double? customCost,
      String? customDescription,
      String? customName,
      double? customPrice,
      String? brandName,
      String? productCategoryName,
      String? stockAlert,
      ProductUnitName? productUnitName,
      List<ProductWarehouse>? warehouse});

  @override
  $StockCopyWith<$Res>? get stock;
  @override
  $ProductUnitNameCopyWith<$Res>? get productUnitName;
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
      _$ProductImpl _value, $Res Function(_$ProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? companyId = freezed,
    Object? code = freezed,
    Object? expiryDate = freezed,
    Object? mainProductId = freezed,
    Object? productCategoryId = freezed,
    Object? productCost = freezed,
    Object? productPrice = freezed,
    Object? isActive = freezed,
    Object? stock = freezed,
    Object? createdAt = freezed,
    Object? inStock = freezed,
    Object? link = freezed,
    Object? customCost = freezed,
    Object? customDescription = freezed,
    Object? customName = freezed,
    Object? customPrice = freezed,
    Object? brandName = freezed,
    Object? productCategoryName = freezed,
    Object? stockAlert = freezed,
    Object? productUnitName = freezed,
    Object? warehouse = freezed,
  }) {
    return _then(_$ProductImpl(
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
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      mainProductId: freezed == mainProductId
          ? _value.mainProductId
          : mainProductId // ignore: cast_nullable_to_non_nullable
              as int?,
      productCategoryId: freezed == productCategoryId
          ? _value.productCategoryId
          : productCategoryId // ignore: cast_nullable_to_non_nullable
              as int?,
      productCost: freezed == productCost
          ? _value.productCost
          : productCost // ignore: cast_nullable_to_non_nullable
              as double?,
      productPrice: freezed == productPrice
          ? _value.productPrice
          : productPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      stock: freezed == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as Stock?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      inStock: freezed == inStock
          ? _value.inStock
          : inStock // ignore: cast_nullable_to_non_nullable
              as int?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
      customCost: freezed == customCost
          ? _value.customCost
          : customCost // ignore: cast_nullable_to_non_nullable
              as double?,
      customDescription: freezed == customDescription
          ? _value.customDescription
          : customDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      customName: freezed == customName
          ? _value.customName
          : customName // ignore: cast_nullable_to_non_nullable
              as String?,
      customPrice: freezed == customPrice
          ? _value.customPrice
          : customPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      brandName: freezed == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String?,
      productCategoryName: freezed == productCategoryName
          ? _value.productCategoryName
          : productCategoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      stockAlert: freezed == stockAlert
          ? _value.stockAlert
          : stockAlert // ignore: cast_nullable_to_non_nullable
              as String?,
      productUnitName: freezed == productUnitName
          ? _value.productUnitName
          : productUnitName // ignore: cast_nullable_to_non_nullable
              as ProductUnitName?,
      warehouse: freezed == warehouse
          ? _value._warehouse
          : warehouse // ignore: cast_nullable_to_non_nullable
              as List<ProductWarehouse>?,
    ));
  }
}

/// @nodoc

class _$ProductImpl implements _Product {
  const _$ProductImpl(
      {this.id,
      this.name,
      this.companyId,
      this.code,
      this.expiryDate,
      this.mainProductId,
      this.productCategoryId,
      this.productCost,
      this.productPrice,
      this.isActive,
      this.stock,
      this.createdAt,
      this.inStock,
      this.link,
      this.customCost,
      this.customDescription,
      this.customName,
      this.customPrice,
      this.brandName,
      this.productCategoryName,
      this.stockAlert,
      this.productUnitName,
      final List<ProductWarehouse>? warehouse})
      : _warehouse = warehouse;

  @override
  final int? id;
  @override
  final String? name;
  @override
  final int? companyId;
  @override
  final String? code;
  @override
  final DateTime? expiryDate;
  @override
  final int? mainProductId;
  @override
  final int? productCategoryId;
  @override
  final double? productCost;
  @override
  final double? productPrice;
  @override
  final bool? isActive;
  @override
  final Stock? stock;
  @override
  final DateTime? createdAt;
  @override
  final int? inStock;
  @override
  final String? link;
  @override
  final double? customCost;
  @override
  final String? customDescription;
  @override
  final String? customName;
  @override
  final double? customPrice;
  @override
  final String? brandName;
  @override
  final String? productCategoryName;
  @override
  final String? stockAlert;
  @override
  final ProductUnitName? productUnitName;
  final List<ProductWarehouse>? _warehouse;
  @override
  List<ProductWarehouse>? get warehouse {
    final value = _warehouse;
    if (value == null) return null;
    if (_warehouse is EqualUnmodifiableListView) return _warehouse;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, companyId: $companyId, code: $code, expiryDate: $expiryDate, mainProductId: $mainProductId, productCategoryId: $productCategoryId, productCost: $productCost, productPrice: $productPrice, isActive: $isActive, stock: $stock, createdAt: $createdAt, inStock: $inStock, link: $link, customCost: $customCost, customDescription: $customDescription, customName: $customName, customPrice: $customPrice, brandName: $brandName, productCategoryName: $productCategoryName, stockAlert: $stockAlert, productUnitName: $productUnitName, warehouse: $warehouse)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.mainProductId, mainProductId) ||
                other.mainProductId == mainProductId) &&
            (identical(other.productCategoryId, productCategoryId) ||
                other.productCategoryId == productCategoryId) &&
            (identical(other.productCost, productCost) ||
                other.productCost == productCost) &&
            (identical(other.productPrice, productPrice) ||
                other.productPrice == productPrice) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.inStock, inStock) || other.inStock == inStock) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.customCost, customCost) ||
                other.customCost == customCost) &&
            (identical(other.customDescription, customDescription) ||
                other.customDescription == customDescription) &&
            (identical(other.customName, customName) ||
                other.customName == customName) &&
            (identical(other.customPrice, customPrice) ||
                other.customPrice == customPrice) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.productCategoryName, productCategoryName) ||
                other.productCategoryName == productCategoryName) &&
            (identical(other.stockAlert, stockAlert) ||
                other.stockAlert == stockAlert) &&
            (identical(other.productUnitName, productUnitName) ||
                other.productUnitName == productUnitName) &&
            const DeepCollectionEquality()
                .equals(other._warehouse, _warehouse));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        companyId,
        code,
        expiryDate,
        mainProductId,
        productCategoryId,
        productCost,
        productPrice,
        isActive,
        stock,
        createdAt,
        inStock,
        link,
        customCost,
        customDescription,
        customName,
        customPrice,
        brandName,
        productCategoryName,
        stockAlert,
        productUnitName,
        const DeepCollectionEquality().hash(_warehouse)
      ]);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);
}

abstract class _Product implements Product {
  const factory _Product(
      {final int? id,
      final String? name,
      final int? companyId,
      final String? code,
      final DateTime? expiryDate,
      final int? mainProductId,
      final int? productCategoryId,
      final double? productCost,
      final double? productPrice,
      final bool? isActive,
      final Stock? stock,
      final DateTime? createdAt,
      final int? inStock,
      final String? link,
      final double? customCost,
      final String? customDescription,
      final String? customName,
      final double? customPrice,
      final String? brandName,
      final String? productCategoryName,
      final String? stockAlert,
      final ProductUnitName? productUnitName,
      final List<ProductWarehouse>? warehouse}) = _$ProductImpl;

  @override
  int? get id;
  @override
  String? get name;
  @override
  int? get companyId;
  @override
  String? get code;
  @override
  DateTime? get expiryDate;
  @override
  int? get mainProductId;
  @override
  int? get productCategoryId;
  @override
  double? get productCost;
  @override
  double? get productPrice;
  @override
  bool? get isActive;
  @override
  Stock? get stock;
  @override
  DateTime? get createdAt;
  @override
  int? get inStock;
  @override
  String? get link;
  @override
  double? get customCost;
  @override
  String? get customDescription;
  @override
  String? get customName;
  @override
  double? get customPrice;
  @override
  String? get brandName;
  @override
  String? get productCategoryName;
  @override
  String? get stockAlert;
  @override
  ProductUnitName? get productUnitName;
  @override
  List<ProductWarehouse>? get warehouse;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
