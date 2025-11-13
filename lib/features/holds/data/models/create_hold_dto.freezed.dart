// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_hold_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreateHoldDto _$CreateHoldDtoFromJson(Map<String, dynamic> json) {
  return _CreateHoldDto.fromJson(json);
}

/// @nodoc
mixin _$CreateHoldDto {
  @JsonKey(name: 'reference_code')
  String? get referenceCode => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_id')
  int? get customerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'warehouse_id')
  int? get warehouseId => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_id')
  int? get staffId => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_name')
  String? get staffName => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_rate')
  double? get taxRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_amount')
  double? get taxAmount => throw _privateConstructorUsedError;
  double? get discount => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_amount')
  double? get discountAmount => throw _privateConstructorUsedError;
  double? get shipping => throw _privateConstructorUsedError;
  @JsonKey(name: 'grand_total')
  double? get grandTotal => throw _privateConstructorUsedError;
  double? get subTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'hold_items')
  List<HoldItemDto>? get holdItems => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  @JsonKey(name: 'table_id')
  String? get tableId => throw _privateConstructorUsedError;

  /// Serializes this CreateHoldDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateHoldDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateHoldDtoCopyWith<CreateHoldDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateHoldDtoCopyWith<$Res> {
  factory $CreateHoldDtoCopyWith(
          CreateHoldDto value, $Res Function(CreateHoldDto) then) =
      _$CreateHoldDtoCopyWithImpl<$Res, CreateHoldDto>;
  @useResult
  $Res call(
      {@JsonKey(name: 'reference_code') String? referenceCode,
      DateTime? date,
      @JsonKey(name: 'customer_id') int? customerId,
      @JsonKey(name: 'warehouse_id') int? warehouseId,
      @JsonKey(name: 'staff_id') int? staffId,
      @JsonKey(name: 'staff_name') String? staffName,
      @JsonKey(name: 'tax_rate') double? taxRate,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      double? discount,
      @JsonKey(name: 'discount_amount') double? discountAmount,
      double? shipping,
      @JsonKey(name: 'grand_total') double? grandTotal,
      double? subTotal,
      @JsonKey(name: 'hold_items') List<HoldItemDto>? holdItems,
      String? note,
      @JsonKey(name: 'table_id') String? tableId});
}

/// @nodoc
class _$CreateHoldDtoCopyWithImpl<$Res, $Val extends CreateHoldDto>
    implements $CreateHoldDtoCopyWith<$Res> {
  _$CreateHoldDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateHoldDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referenceCode = freezed,
    Object? date = freezed,
    Object? customerId = freezed,
    Object? warehouseId = freezed,
    Object? staffId = freezed,
    Object? staffName = freezed,
    Object? taxRate = freezed,
    Object? taxAmount = freezed,
    Object? discount = freezed,
    Object? discountAmount = freezed,
    Object? shipping = freezed,
    Object? grandTotal = freezed,
    Object? subTotal = freezed,
    Object? holdItems = freezed,
    Object? note = freezed,
    Object? tableId = freezed,
  }) {
    return _then(_value.copyWith(
      referenceCode: freezed == referenceCode
          ? _value.referenceCode
          : referenceCode // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
      warehouseId: freezed == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as int?,
      staffId: freezed == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int?,
      staffName: freezed == staffName
          ? _value.staffName
          : staffName // ignore: cast_nullable_to_non_nullable
              as String?,
      taxRate: freezed == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double?,
      taxAmount: freezed == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      discount: freezed == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      shipping: freezed == shipping
          ? _value.shipping
          : shipping // ignore: cast_nullable_to_non_nullable
              as double?,
      grandTotal: freezed == grandTotal
          ? _value.grandTotal
          : grandTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      subTotal: freezed == subTotal
          ? _value.subTotal
          : subTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      holdItems: freezed == holdItems
          ? _value.holdItems
          : holdItems // ignore: cast_nullable_to_non_nullable
              as List<HoldItemDto>?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      tableId: freezed == tableId
          ? _value.tableId
          : tableId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateHoldDtoImplCopyWith<$Res>
    implements $CreateHoldDtoCopyWith<$Res> {
  factory _$$CreateHoldDtoImplCopyWith(
          _$CreateHoldDtoImpl value, $Res Function(_$CreateHoldDtoImpl) then) =
      __$$CreateHoldDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'reference_code') String? referenceCode,
      DateTime? date,
      @JsonKey(name: 'customer_id') int? customerId,
      @JsonKey(name: 'warehouse_id') int? warehouseId,
      @JsonKey(name: 'staff_id') int? staffId,
      @JsonKey(name: 'staff_name') String? staffName,
      @JsonKey(name: 'tax_rate') double? taxRate,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      double? discount,
      @JsonKey(name: 'discount_amount') double? discountAmount,
      double? shipping,
      @JsonKey(name: 'grand_total') double? grandTotal,
      double? subTotal,
      @JsonKey(name: 'hold_items') List<HoldItemDto>? holdItems,
      String? note,
      @JsonKey(name: 'table_id') String? tableId});
}

/// @nodoc
class __$$CreateHoldDtoImplCopyWithImpl<$Res>
    extends _$CreateHoldDtoCopyWithImpl<$Res, _$CreateHoldDtoImpl>
    implements _$$CreateHoldDtoImplCopyWith<$Res> {
  __$$CreateHoldDtoImplCopyWithImpl(
      _$CreateHoldDtoImpl _value, $Res Function(_$CreateHoldDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateHoldDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referenceCode = freezed,
    Object? date = freezed,
    Object? customerId = freezed,
    Object? warehouseId = freezed,
    Object? staffId = freezed,
    Object? staffName = freezed,
    Object? taxRate = freezed,
    Object? taxAmount = freezed,
    Object? discount = freezed,
    Object? discountAmount = freezed,
    Object? shipping = freezed,
    Object? grandTotal = freezed,
    Object? subTotal = freezed,
    Object? holdItems = freezed,
    Object? note = freezed,
    Object? tableId = freezed,
  }) {
    return _then(_$CreateHoldDtoImpl(
      referenceCode: freezed == referenceCode
          ? _value.referenceCode
          : referenceCode // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
      warehouseId: freezed == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as int?,
      staffId: freezed == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int?,
      staffName: freezed == staffName
          ? _value.staffName
          : staffName // ignore: cast_nullable_to_non_nullable
              as String?,
      taxRate: freezed == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double?,
      taxAmount: freezed == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      discount: freezed == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      shipping: freezed == shipping
          ? _value.shipping
          : shipping // ignore: cast_nullable_to_non_nullable
              as double?,
      grandTotal: freezed == grandTotal
          ? _value.grandTotal
          : grandTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      subTotal: freezed == subTotal
          ? _value.subTotal
          : subTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      holdItems: freezed == holdItems
          ? _value._holdItems
          : holdItems // ignore: cast_nullable_to_non_nullable
              as List<HoldItemDto>?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      tableId: freezed == tableId
          ? _value.tableId
          : tableId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateHoldDtoImpl implements _CreateHoldDto {
  const _$CreateHoldDtoImpl(
      {@JsonKey(name: 'reference_code') this.referenceCode,
      this.date,
      @JsonKey(name: 'customer_id') this.customerId,
      @JsonKey(name: 'warehouse_id') this.warehouseId,
      @JsonKey(name: 'staff_id') this.staffId,
      @JsonKey(name: 'staff_name') this.staffName,
      @JsonKey(name: 'tax_rate') this.taxRate,
      @JsonKey(name: 'tax_amount') this.taxAmount,
      this.discount,
      @JsonKey(name: 'discount_amount') this.discountAmount,
      this.shipping,
      @JsonKey(name: 'grand_total') this.grandTotal,
      this.subTotal,
      @JsonKey(name: 'hold_items') final List<HoldItemDto>? holdItems,
      this.note,
      @JsonKey(name: 'table_id') this.tableId})
      : _holdItems = holdItems;

  factory _$CreateHoldDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateHoldDtoImplFromJson(json);

  @override
  @JsonKey(name: 'reference_code')
  final String? referenceCode;
  @override
  final DateTime? date;
  @override
  @JsonKey(name: 'customer_id')
  final int? customerId;
  @override
  @JsonKey(name: 'warehouse_id')
  final int? warehouseId;
  @override
  @JsonKey(name: 'staff_id')
  final int? staffId;
  @override
  @JsonKey(name: 'staff_name')
  final String? staffName;
  @override
  @JsonKey(name: 'tax_rate')
  final double? taxRate;
  @override
  @JsonKey(name: 'tax_amount')
  final double? taxAmount;
  @override
  final double? discount;
  @override
  @JsonKey(name: 'discount_amount')
  final double? discountAmount;
  @override
  final double? shipping;
  @override
  @JsonKey(name: 'grand_total')
  final double? grandTotal;
  @override
  final double? subTotal;
  final List<HoldItemDto>? _holdItems;
  @override
  @JsonKey(name: 'hold_items')
  List<HoldItemDto>? get holdItems {
    final value = _holdItems;
    if (value == null) return null;
    if (_holdItems is EqualUnmodifiableListView) return _holdItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? note;
  @override
  @JsonKey(name: 'table_id')
  final String? tableId;

  @override
  String toString() {
    return 'CreateHoldDto(referenceCode: $referenceCode, date: $date, customerId: $customerId, warehouseId: $warehouseId, staffId: $staffId, staffName: $staffName, taxRate: $taxRate, taxAmount: $taxAmount, discount: $discount, discountAmount: $discountAmount, shipping: $shipping, grandTotal: $grandTotal, subTotal: $subTotal, holdItems: $holdItems, note: $note, tableId: $tableId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateHoldDtoImpl &&
            (identical(other.referenceCode, referenceCode) ||
                other.referenceCode == referenceCode) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.staffName, staffName) ||
                other.staffName == staffName) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            (identical(other.taxAmount, taxAmount) ||
                other.taxAmount == taxAmount) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.shipping, shipping) ||
                other.shipping == shipping) &&
            (identical(other.grandTotal, grandTotal) ||
                other.grandTotal == grandTotal) &&
            (identical(other.subTotal, subTotal) ||
                other.subTotal == subTotal) &&
            const DeepCollectionEquality()
                .equals(other._holdItems, _holdItems) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.tableId, tableId) || other.tableId == tableId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      referenceCode,
      date,
      customerId,
      warehouseId,
      staffId,
      staffName,
      taxRate,
      taxAmount,
      discount,
      discountAmount,
      shipping,
      grandTotal,
      subTotal,
      const DeepCollectionEquality().hash(_holdItems),
      note,
      tableId);

  /// Create a copy of CreateHoldDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateHoldDtoImplCopyWith<_$CreateHoldDtoImpl> get copyWith =>
      __$$CreateHoldDtoImplCopyWithImpl<_$CreateHoldDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateHoldDtoImplToJson(
      this,
    );
  }
}

abstract class _CreateHoldDto implements CreateHoldDto {
  const factory _CreateHoldDto(
      {@JsonKey(name: 'reference_code') final String? referenceCode,
      final DateTime? date,
      @JsonKey(name: 'customer_id') final int? customerId,
      @JsonKey(name: 'warehouse_id') final int? warehouseId,
      @JsonKey(name: 'staff_id') final int? staffId,
      @JsonKey(name: 'staff_name') final String? staffName,
      @JsonKey(name: 'tax_rate') final double? taxRate,
      @JsonKey(name: 'tax_amount') final double? taxAmount,
      final double? discount,
      @JsonKey(name: 'discount_amount') final double? discountAmount,
      final double? shipping,
      @JsonKey(name: 'grand_total') final double? grandTotal,
      final double? subTotal,
      @JsonKey(name: 'hold_items') final List<HoldItemDto>? holdItems,
      final String? note,
      @JsonKey(name: 'table_id') final String? tableId}) = _$CreateHoldDtoImpl;

  factory _CreateHoldDto.fromJson(Map<String, dynamic> json) =
      _$CreateHoldDtoImpl.fromJson;

  @override
  @JsonKey(name: 'reference_code')
  String? get referenceCode;
  @override
  DateTime? get date;
  @override
  @JsonKey(name: 'customer_id')
  int? get customerId;
  @override
  @JsonKey(name: 'warehouse_id')
  int? get warehouseId;
  @override
  @JsonKey(name: 'staff_id')
  int? get staffId;
  @override
  @JsonKey(name: 'staff_name')
  String? get staffName;
  @override
  @JsonKey(name: 'tax_rate')
  double? get taxRate;
  @override
  @JsonKey(name: 'tax_amount')
  double? get taxAmount;
  @override
  double? get discount;
  @override
  @JsonKey(name: 'discount_amount')
  double? get discountAmount;
  @override
  double? get shipping;
  @override
  @JsonKey(name: 'grand_total')
  double? get grandTotal;
  @override
  double? get subTotal;
  @override
  @JsonKey(name: 'hold_items')
  List<HoldItemDto>? get holdItems;
  @override
  String? get note;
  @override
  @JsonKey(name: 'table_id')
  String? get tableId;

  /// Create a copy of CreateHoldDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateHoldDtoImplCopyWith<_$CreateHoldDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HoldItemDto _$HoldItemDtoFromJson(Map<String, dynamic> json) {
  return _HoldItemDto.fromJson(json);
}

/// @nodoc
mixin _$HoldItemDto {
  String? get name => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'stock_alert')
  String? get stockAlert => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int? get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_cost')
  double? get productCost => throw _privateConstructorUsedError;
  @JsonKey(name: 'net_unit_cost')
  double? get netUnitCost => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_price')
  double? get productPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'net_unit_price')
  double? get netUnitPrice => throw _privateConstructorUsedError;
  double? get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_total')
  double? get subTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_type')
  int? get taxType => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_value')
  double? get taxValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_amount')
  double? get taxAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_type')
  int? get discountType => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_value')
  double? get discountValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_amount')
  double? get discountAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_unit')
  String? get productUnit => throw _privateConstructorUsedError;
  @JsonKey(name: 'sale_unit')
  dynamic get saleUnit => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'sale_id')
  int? get saleId => throw _privateConstructorUsedError;
  @JsonKey(name: 'hold_item_id')
  String? get holdItemId => throw _privateConstructorUsedError;

  /// Serializes this HoldItemDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HoldItemDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HoldItemDtoCopyWith<HoldItemDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HoldItemDtoCopyWith<$Res> {
  factory $HoldItemDtoCopyWith(
          HoldItemDto value, $Res Function(HoldItemDto) then) =
      _$HoldItemDtoCopyWithImpl<$Res, HoldItemDto>;
  @useResult
  $Res call(
      {String? name,
      String? code,
      @JsonKey(name: 'stock_alert') String? stockAlert,
      @JsonKey(name: 'product_id') int? productId,
      @JsonKey(name: 'product_cost') double? productCost,
      @JsonKey(name: 'net_unit_cost') double? netUnitCost,
      @JsonKey(name: 'product_price') double? productPrice,
      @JsonKey(name: 'net_unit_price') double? netUnitPrice,
      double? quantity,
      @JsonKey(name: 'sub_total') double? subTotal,
      @JsonKey(name: 'tax_type') int? taxType,
      @JsonKey(name: 'tax_value') double? taxValue,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      @JsonKey(name: 'discount_type') int? discountType,
      @JsonKey(name: 'discount_value') double? discountValue,
      @JsonKey(name: 'discount_amount') double? discountAmount,
      @JsonKey(name: 'product_unit') String? productUnit,
      @JsonKey(name: 'sale_unit') dynamic saleUnit,
      int? id,
      @JsonKey(name: 'sale_id') int? saleId,
      @JsonKey(name: 'hold_item_id') String? holdItemId});
}

/// @nodoc
class _$HoldItemDtoCopyWithImpl<$Res, $Val extends HoldItemDto>
    implements $HoldItemDtoCopyWith<$Res> {
  _$HoldItemDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HoldItemDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? code = freezed,
    Object? stockAlert = freezed,
    Object? productId = freezed,
    Object? productCost = freezed,
    Object? netUnitCost = freezed,
    Object? productPrice = freezed,
    Object? netUnitPrice = freezed,
    Object? quantity = freezed,
    Object? subTotal = freezed,
    Object? taxType = freezed,
    Object? taxValue = freezed,
    Object? taxAmount = freezed,
    Object? discountType = freezed,
    Object? discountValue = freezed,
    Object? discountAmount = freezed,
    Object? productUnit = freezed,
    Object? saleUnit = freezed,
    Object? id = freezed,
    Object? saleId = freezed,
    Object? holdItemId = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      stockAlert: freezed == stockAlert
          ? _value.stockAlert
          : stockAlert // ignore: cast_nullable_to_non_nullable
              as String?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      productCost: freezed == productCost
          ? _value.productCost
          : productCost // ignore: cast_nullable_to_non_nullable
              as double?,
      netUnitCost: freezed == netUnitCost
          ? _value.netUnitCost
          : netUnitCost // ignore: cast_nullable_to_non_nullable
              as double?,
      productPrice: freezed == productPrice
          ? _value.productPrice
          : productPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      netUnitPrice: freezed == netUnitPrice
          ? _value.netUnitPrice
          : netUnitPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      subTotal: freezed == subTotal
          ? _value.subTotal
          : subTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      taxType: freezed == taxType
          ? _value.taxType
          : taxType // ignore: cast_nullable_to_non_nullable
              as int?,
      taxValue: freezed == taxValue
          ? _value.taxValue
          : taxValue // ignore: cast_nullable_to_non_nullable
              as double?,
      taxAmount: freezed == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      discountType: freezed == discountType
          ? _value.discountType
          : discountType // ignore: cast_nullable_to_non_nullable
              as int?,
      discountValue: freezed == discountValue
          ? _value.discountValue
          : discountValue // ignore: cast_nullable_to_non_nullable
              as double?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      productUnit: freezed == productUnit
          ? _value.productUnit
          : productUnit // ignore: cast_nullable_to_non_nullable
              as String?,
      saleUnit: freezed == saleUnit
          ? _value.saleUnit
          : saleUnit // ignore: cast_nullable_to_non_nullable
              as dynamic,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      saleId: freezed == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as int?,
      holdItemId: freezed == holdItemId
          ? _value.holdItemId
          : holdItemId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HoldItemDtoImplCopyWith<$Res>
    implements $HoldItemDtoCopyWith<$Res> {
  factory _$$HoldItemDtoImplCopyWith(
          _$HoldItemDtoImpl value, $Res Function(_$HoldItemDtoImpl) then) =
      __$$HoldItemDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? code,
      @JsonKey(name: 'stock_alert') String? stockAlert,
      @JsonKey(name: 'product_id') int? productId,
      @JsonKey(name: 'product_cost') double? productCost,
      @JsonKey(name: 'net_unit_cost') double? netUnitCost,
      @JsonKey(name: 'product_price') double? productPrice,
      @JsonKey(name: 'net_unit_price') double? netUnitPrice,
      double? quantity,
      @JsonKey(name: 'sub_total') double? subTotal,
      @JsonKey(name: 'tax_type') int? taxType,
      @JsonKey(name: 'tax_value') double? taxValue,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      @JsonKey(name: 'discount_type') int? discountType,
      @JsonKey(name: 'discount_value') double? discountValue,
      @JsonKey(name: 'discount_amount') double? discountAmount,
      @JsonKey(name: 'product_unit') String? productUnit,
      @JsonKey(name: 'sale_unit') dynamic saleUnit,
      int? id,
      @JsonKey(name: 'sale_id') int? saleId,
      @JsonKey(name: 'hold_item_id') String? holdItemId});
}

/// @nodoc
class __$$HoldItemDtoImplCopyWithImpl<$Res>
    extends _$HoldItemDtoCopyWithImpl<$Res, _$HoldItemDtoImpl>
    implements _$$HoldItemDtoImplCopyWith<$Res> {
  __$$HoldItemDtoImplCopyWithImpl(
      _$HoldItemDtoImpl _value, $Res Function(_$HoldItemDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of HoldItemDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? code = freezed,
    Object? stockAlert = freezed,
    Object? productId = freezed,
    Object? productCost = freezed,
    Object? netUnitCost = freezed,
    Object? productPrice = freezed,
    Object? netUnitPrice = freezed,
    Object? quantity = freezed,
    Object? subTotal = freezed,
    Object? taxType = freezed,
    Object? taxValue = freezed,
    Object? taxAmount = freezed,
    Object? discountType = freezed,
    Object? discountValue = freezed,
    Object? discountAmount = freezed,
    Object? productUnit = freezed,
    Object? saleUnit = freezed,
    Object? id = freezed,
    Object? saleId = freezed,
    Object? holdItemId = freezed,
  }) {
    return _then(_$HoldItemDtoImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      stockAlert: freezed == stockAlert
          ? _value.stockAlert
          : stockAlert // ignore: cast_nullable_to_non_nullable
              as String?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      productCost: freezed == productCost
          ? _value.productCost
          : productCost // ignore: cast_nullable_to_non_nullable
              as double?,
      netUnitCost: freezed == netUnitCost
          ? _value.netUnitCost
          : netUnitCost // ignore: cast_nullable_to_non_nullable
              as double?,
      productPrice: freezed == productPrice
          ? _value.productPrice
          : productPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      netUnitPrice: freezed == netUnitPrice
          ? _value.netUnitPrice
          : netUnitPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      subTotal: freezed == subTotal
          ? _value.subTotal
          : subTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      taxType: freezed == taxType
          ? _value.taxType
          : taxType // ignore: cast_nullable_to_non_nullable
              as int?,
      taxValue: freezed == taxValue
          ? _value.taxValue
          : taxValue // ignore: cast_nullable_to_non_nullable
              as double?,
      taxAmount: freezed == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      discountType: freezed == discountType
          ? _value.discountType
          : discountType // ignore: cast_nullable_to_non_nullable
              as int?,
      discountValue: freezed == discountValue
          ? _value.discountValue
          : discountValue // ignore: cast_nullable_to_non_nullable
              as double?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      productUnit: freezed == productUnit
          ? _value.productUnit
          : productUnit // ignore: cast_nullable_to_non_nullable
              as String?,
      saleUnit: freezed == saleUnit
          ? _value.saleUnit
          : saleUnit // ignore: cast_nullable_to_non_nullable
              as dynamic,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      saleId: freezed == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as int?,
      holdItemId: freezed == holdItemId
          ? _value.holdItemId
          : holdItemId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HoldItemDtoImpl implements _HoldItemDto {
  const _$HoldItemDtoImpl(
      {this.name,
      this.code,
      @JsonKey(name: 'stock_alert') this.stockAlert,
      @JsonKey(name: 'product_id') this.productId,
      @JsonKey(name: 'product_cost') this.productCost,
      @JsonKey(name: 'net_unit_cost') this.netUnitCost,
      @JsonKey(name: 'product_price') this.productPrice,
      @JsonKey(name: 'net_unit_price') this.netUnitPrice,
      this.quantity,
      @JsonKey(name: 'sub_total') this.subTotal,
      @JsonKey(name: 'tax_type') this.taxType,
      @JsonKey(name: 'tax_value') this.taxValue,
      @JsonKey(name: 'tax_amount') this.taxAmount,
      @JsonKey(name: 'discount_type') this.discountType,
      @JsonKey(name: 'discount_value') this.discountValue,
      @JsonKey(name: 'discount_amount') this.discountAmount,
      @JsonKey(name: 'product_unit') this.productUnit,
      @JsonKey(name: 'sale_unit') this.saleUnit,
      this.id,
      @JsonKey(name: 'sale_id') this.saleId,
      @JsonKey(name: 'hold_item_id') this.holdItemId});

  factory _$HoldItemDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$HoldItemDtoImplFromJson(json);

  @override
  final String? name;
  @override
  final String? code;
  @override
  @JsonKey(name: 'stock_alert')
  final String? stockAlert;
  @override
  @JsonKey(name: 'product_id')
  final int? productId;
  @override
  @JsonKey(name: 'product_cost')
  final double? productCost;
  @override
  @JsonKey(name: 'net_unit_cost')
  final double? netUnitCost;
  @override
  @JsonKey(name: 'product_price')
  final double? productPrice;
  @override
  @JsonKey(name: 'net_unit_price')
  final double? netUnitPrice;
  @override
  final double? quantity;
  @override
  @JsonKey(name: 'sub_total')
  final double? subTotal;
  @override
  @JsonKey(name: 'tax_type')
  final int? taxType;
  @override
  @JsonKey(name: 'tax_value')
  final double? taxValue;
  @override
  @JsonKey(name: 'tax_amount')
  final double? taxAmount;
  @override
  @JsonKey(name: 'discount_type')
  final int? discountType;
  @override
  @JsonKey(name: 'discount_value')
  final double? discountValue;
  @override
  @JsonKey(name: 'discount_amount')
  final double? discountAmount;
  @override
  @JsonKey(name: 'product_unit')
  final String? productUnit;
  @override
  @JsonKey(name: 'sale_unit')
  final dynamic saleUnit;
  @override
  final int? id;
  @override
  @JsonKey(name: 'sale_id')
  final int? saleId;
  @override
  @JsonKey(name: 'hold_item_id')
  final String? holdItemId;

  @override
  String toString() {
    return 'HoldItemDto(name: $name, code: $code, stockAlert: $stockAlert, productId: $productId, productCost: $productCost, netUnitCost: $netUnitCost, productPrice: $productPrice, netUnitPrice: $netUnitPrice, quantity: $quantity, subTotal: $subTotal, taxType: $taxType, taxValue: $taxValue, taxAmount: $taxAmount, discountType: $discountType, discountValue: $discountValue, discountAmount: $discountAmount, productUnit: $productUnit, saleUnit: $saleUnit, id: $id, saleId: $saleId, holdItemId: $holdItemId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HoldItemDtoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.stockAlert, stockAlert) ||
                other.stockAlert == stockAlert) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productCost, productCost) ||
                other.productCost == productCost) &&
            (identical(other.netUnitCost, netUnitCost) ||
                other.netUnitCost == netUnitCost) &&
            (identical(other.productPrice, productPrice) ||
                other.productPrice == productPrice) &&
            (identical(other.netUnitPrice, netUnitPrice) ||
                other.netUnitPrice == netUnitPrice) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.subTotal, subTotal) ||
                other.subTotal == subTotal) &&
            (identical(other.taxType, taxType) || other.taxType == taxType) &&
            (identical(other.taxValue, taxValue) ||
                other.taxValue == taxValue) &&
            (identical(other.taxAmount, taxAmount) ||
                other.taxAmount == taxAmount) &&
            (identical(other.discountType, discountType) ||
                other.discountType == discountType) &&
            (identical(other.discountValue, discountValue) ||
                other.discountValue == discountValue) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.productUnit, productUnit) ||
                other.productUnit == productUnit) &&
            const DeepCollectionEquality().equals(other.saleUnit, saleUnit) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.saleId, saleId) || other.saleId == saleId) &&
            (identical(other.holdItemId, holdItemId) ||
                other.holdItemId == holdItemId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        name,
        code,
        stockAlert,
        productId,
        productCost,
        netUnitCost,
        productPrice,
        netUnitPrice,
        quantity,
        subTotal,
        taxType,
        taxValue,
        taxAmount,
        discountType,
        discountValue,
        discountAmount,
        productUnit,
        const DeepCollectionEquality().hash(saleUnit),
        id,
        saleId,
        holdItemId
      ]);

  /// Create a copy of HoldItemDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HoldItemDtoImplCopyWith<_$HoldItemDtoImpl> get copyWith =>
      __$$HoldItemDtoImplCopyWithImpl<_$HoldItemDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HoldItemDtoImplToJson(
      this,
    );
  }
}

abstract class _HoldItemDto implements HoldItemDto {
  const factory _HoldItemDto(
          {final String? name,
          final String? code,
          @JsonKey(name: 'stock_alert') final String? stockAlert,
          @JsonKey(name: 'product_id') final int? productId,
          @JsonKey(name: 'product_cost') final double? productCost,
          @JsonKey(name: 'net_unit_cost') final double? netUnitCost,
          @JsonKey(name: 'product_price') final double? productPrice,
          @JsonKey(name: 'net_unit_price') final double? netUnitPrice,
          final double? quantity,
          @JsonKey(name: 'sub_total') final double? subTotal,
          @JsonKey(name: 'tax_type') final int? taxType,
          @JsonKey(name: 'tax_value') final double? taxValue,
          @JsonKey(name: 'tax_amount') final double? taxAmount,
          @JsonKey(name: 'discount_type') final int? discountType,
          @JsonKey(name: 'discount_value') final double? discountValue,
          @JsonKey(name: 'discount_amount') final double? discountAmount,
          @JsonKey(name: 'product_unit') final String? productUnit,
          @JsonKey(name: 'sale_unit') final dynamic saleUnit,
          final int? id,
          @JsonKey(name: 'sale_id') final int? saleId,
          @JsonKey(name: 'hold_item_id') final String? holdItemId}) =
      _$HoldItemDtoImpl;

  factory _HoldItemDto.fromJson(Map<String, dynamic> json) =
      _$HoldItemDtoImpl.fromJson;

  @override
  String? get name;
  @override
  String? get code;
  @override
  @JsonKey(name: 'stock_alert')
  String? get stockAlert;
  @override
  @JsonKey(name: 'product_id')
  int? get productId;
  @override
  @JsonKey(name: 'product_cost')
  double? get productCost;
  @override
  @JsonKey(name: 'net_unit_cost')
  double? get netUnitCost;
  @override
  @JsonKey(name: 'product_price')
  double? get productPrice;
  @override
  @JsonKey(name: 'net_unit_price')
  double? get netUnitPrice;
  @override
  double? get quantity;
  @override
  @JsonKey(name: 'sub_total')
  double? get subTotal;
  @override
  @JsonKey(name: 'tax_type')
  int? get taxType;
  @override
  @JsonKey(name: 'tax_value')
  double? get taxValue;
  @override
  @JsonKey(name: 'tax_amount')
  double? get taxAmount;
  @override
  @JsonKey(name: 'discount_type')
  int? get discountType;
  @override
  @JsonKey(name: 'discount_value')
  double? get discountValue;
  @override
  @JsonKey(name: 'discount_amount')
  double? get discountAmount;
  @override
  @JsonKey(name: 'product_unit')
  String? get productUnit;
  @override
  @JsonKey(name: 'sale_unit')
  dynamic get saleUnit;
  @override
  int? get id;
  @override
  @JsonKey(name: 'sale_id')
  int? get saleId;
  @override
  @JsonKey(name: 'hold_item_id')
  String? get holdItemId;

  /// Create a copy of HoldItemDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HoldItemDtoImplCopyWith<_$HoldItemDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
