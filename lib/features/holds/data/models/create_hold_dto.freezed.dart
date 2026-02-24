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
  @JsonKey(name: 'customer_id')
  int? get customerId => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  double? get discount => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_amount')
  double? get discountAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'grand_total')
  double? get grandTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'hold_items')
  List<HoldItemDto>? get holdItems => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  @JsonKey(name: 'reference_code')
  String? get referenceCode => throw _privateConstructorUsedError;
  double? get shipping => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_id')
  int? get staffId => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_name')
  String? get staffName => throw _privateConstructorUsedError;
  double? get subTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_amount')
  double? get taxAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_rate')
  double? get taxRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'table_id')
  String? get tableId => throw _privateConstructorUsedError;
  @JsonKey(name: 'warehouse_id')
  int? get warehouseId => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic>? get links => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  int? get userId => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  HoldAttendant? get attendant => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get customerName => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get warehouseName => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  dynamic get status => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get tableName => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  double? get receivedAmount => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  double? get paidAmount => throw _privateConstructorUsedError;

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
      {@JsonKey(name: 'customer_id') int? customerId,
      DateTime? date,
      double? discount,
      @JsonKey(name: 'discount_amount') double? discountAmount,
      @JsonKey(name: 'grand_total') double? grandTotal,
      @JsonKey(name: 'hold_items') List<HoldItemDto>? holdItems,
      String? note,
      @JsonKey(name: 'reference_code') String? referenceCode,
      double? shipping,
      @JsonKey(name: 'staff_id') int? staffId,
      @JsonKey(name: 'staff_name') String? staffName,
      double? subTotal,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      @JsonKey(name: 'tax_rate') double? taxRate,
      @JsonKey(name: 'table_id') String? tableId,
      @JsonKey(name: 'warehouse_id') int? warehouseId,
      @JsonKey(includeFromJson: false, includeToJson: false) String? type,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Map<String, dynamic>? links,
      @JsonKey(includeFromJson: false, includeToJson: false) int? userId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      HoldAttendant? attendant,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? customerName,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? warehouseName,
      @JsonKey(includeFromJson: false, includeToJson: false) dynamic status,
      @JsonKey(includeFromJson: false, includeToJson: false) String? tableName,
      @JsonKey(includeFromJson: false, includeToJson: false)
      DateTime? createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      double? receivedAmount,
      @JsonKey(includeFromJson: false, includeToJson: false)
      double? paidAmount});

  $HoldAttendantCopyWith<$Res>? get attendant;
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
    Object? customerId = freezed,
    Object? date = freezed,
    Object? discount = freezed,
    Object? discountAmount = freezed,
    Object? grandTotal = freezed,
    Object? holdItems = freezed,
    Object? note = freezed,
    Object? referenceCode = freezed,
    Object? shipping = freezed,
    Object? staffId = freezed,
    Object? staffName = freezed,
    Object? subTotal = freezed,
    Object? taxAmount = freezed,
    Object? taxRate = freezed,
    Object? tableId = freezed,
    Object? warehouseId = freezed,
    Object? type = freezed,
    Object? links = freezed,
    Object? userId = freezed,
    Object? attendant = freezed,
    Object? customerName = freezed,
    Object? warehouseName = freezed,
    Object? status = freezed,
    Object? tableName = freezed,
    Object? createdAt = freezed,
    Object? receivedAmount = freezed,
    Object? paidAmount = freezed,
  }) {
    return _then(_value.copyWith(
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      discount: freezed == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      grandTotal: freezed == grandTotal
          ? _value.grandTotal
          : grandTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      holdItems: freezed == holdItems
          ? _value.holdItems
          : holdItems // ignore: cast_nullable_to_non_nullable
              as List<HoldItemDto>?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceCode: freezed == referenceCode
          ? _value.referenceCode
          : referenceCode // ignore: cast_nullable_to_non_nullable
              as String?,
      shipping: freezed == shipping
          ? _value.shipping
          : shipping // ignore: cast_nullable_to_non_nullable
              as double?,
      staffId: freezed == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int?,
      staffName: freezed == staffName
          ? _value.staffName
          : staffName // ignore: cast_nullable_to_non_nullable
              as String?,
      subTotal: freezed == subTotal
          ? _value.subTotal
          : subTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      taxAmount: freezed == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      taxRate: freezed == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double?,
      tableId: freezed == tableId
          ? _value.tableId
          : tableId // ignore: cast_nullable_to_non_nullable
              as String?,
      warehouseId: freezed == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      links: freezed == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      attendant: freezed == attendant
          ? _value.attendant
          : attendant // ignore: cast_nullable_to_non_nullable
              as HoldAttendant?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      warehouseName: freezed == warehouseName
          ? _value.warehouseName
          : warehouseName // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as dynamic,
      tableName: freezed == tableName
          ? _value.tableName
          : tableName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      receivedAmount: freezed == receivedAmount
          ? _value.receivedAmount
          : receivedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

  /// Create a copy of CreateHoldDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HoldAttendantCopyWith<$Res>? get attendant {
    if (_value.attendant == null) {
      return null;
    }

    return $HoldAttendantCopyWith<$Res>(_value.attendant!, (value) {
      return _then(_value.copyWith(attendant: value) as $Val);
    });
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
      {@JsonKey(name: 'customer_id') int? customerId,
      DateTime? date,
      double? discount,
      @JsonKey(name: 'discount_amount') double? discountAmount,
      @JsonKey(name: 'grand_total') double? grandTotal,
      @JsonKey(name: 'hold_items') List<HoldItemDto>? holdItems,
      String? note,
      @JsonKey(name: 'reference_code') String? referenceCode,
      double? shipping,
      @JsonKey(name: 'staff_id') int? staffId,
      @JsonKey(name: 'staff_name') String? staffName,
      double? subTotal,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      @JsonKey(name: 'tax_rate') double? taxRate,
      @JsonKey(name: 'table_id') String? tableId,
      @JsonKey(name: 'warehouse_id') int? warehouseId,
      @JsonKey(includeFromJson: false, includeToJson: false) String? type,
      @JsonKey(includeFromJson: false, includeToJson: false)
      Map<String, dynamic>? links,
      @JsonKey(includeFromJson: false, includeToJson: false) int? userId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      HoldAttendant? attendant,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? customerName,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? warehouseName,
      @JsonKey(includeFromJson: false, includeToJson: false) dynamic status,
      @JsonKey(includeFromJson: false, includeToJson: false) String? tableName,
      @JsonKey(includeFromJson: false, includeToJson: false)
      DateTime? createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      double? receivedAmount,
      @JsonKey(includeFromJson: false, includeToJson: false)
      double? paidAmount});

  @override
  $HoldAttendantCopyWith<$Res>? get attendant;
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
    Object? customerId = freezed,
    Object? date = freezed,
    Object? discount = freezed,
    Object? discountAmount = freezed,
    Object? grandTotal = freezed,
    Object? holdItems = freezed,
    Object? note = freezed,
    Object? referenceCode = freezed,
    Object? shipping = freezed,
    Object? staffId = freezed,
    Object? staffName = freezed,
    Object? subTotal = freezed,
    Object? taxAmount = freezed,
    Object? taxRate = freezed,
    Object? tableId = freezed,
    Object? warehouseId = freezed,
    Object? type = freezed,
    Object? links = freezed,
    Object? userId = freezed,
    Object? attendant = freezed,
    Object? customerName = freezed,
    Object? warehouseName = freezed,
    Object? status = freezed,
    Object? tableName = freezed,
    Object? createdAt = freezed,
    Object? receivedAmount = freezed,
    Object? paidAmount = freezed,
  }) {
    return _then(_$CreateHoldDtoImpl(
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      discount: freezed == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      grandTotal: freezed == grandTotal
          ? _value.grandTotal
          : grandTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      holdItems: freezed == holdItems
          ? _value._holdItems
          : holdItems // ignore: cast_nullable_to_non_nullable
              as List<HoldItemDto>?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceCode: freezed == referenceCode
          ? _value.referenceCode
          : referenceCode // ignore: cast_nullable_to_non_nullable
              as String?,
      shipping: freezed == shipping
          ? _value.shipping
          : shipping // ignore: cast_nullable_to_non_nullable
              as double?,
      staffId: freezed == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int?,
      staffName: freezed == staffName
          ? _value.staffName
          : staffName // ignore: cast_nullable_to_non_nullable
              as String?,
      subTotal: freezed == subTotal
          ? _value.subTotal
          : subTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      taxAmount: freezed == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      taxRate: freezed == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double?,
      tableId: freezed == tableId
          ? _value.tableId
          : tableId // ignore: cast_nullable_to_non_nullable
              as String?,
      warehouseId: freezed == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      links: freezed == links
          ? _value._links
          : links // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      attendant: freezed == attendant
          ? _value.attendant
          : attendant // ignore: cast_nullable_to_non_nullable
              as HoldAttendant?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      warehouseName: freezed == warehouseName
          ? _value.warehouseName
          : warehouseName // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as dynamic,
      tableName: freezed == tableName
          ? _value.tableName
          : tableName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      receivedAmount: freezed == receivedAmount
          ? _value.receivedAmount
          : receivedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateHoldDtoImpl implements _CreateHoldDto {
  const _$CreateHoldDtoImpl(
      {@JsonKey(name: 'customer_id') this.customerId,
      this.date,
      this.discount,
      @JsonKey(name: 'discount_amount') this.discountAmount,
      @JsonKey(name: 'grand_total') this.grandTotal,
      @JsonKey(name: 'hold_items') final List<HoldItemDto>? holdItems,
      this.note,
      @JsonKey(name: 'reference_code') this.referenceCode,
      this.shipping,
      @JsonKey(name: 'staff_id') this.staffId,
      @JsonKey(name: 'staff_name') this.staffName,
      this.subTotal,
      @JsonKey(name: 'tax_amount') this.taxAmount,
      @JsonKey(name: 'tax_rate') this.taxRate,
      @JsonKey(name: 'table_id') this.tableId,
      @JsonKey(name: 'warehouse_id') this.warehouseId,
      @JsonKey(includeFromJson: false, includeToJson: false) this.type,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Map<String, dynamic>? links,
      @JsonKey(includeFromJson: false, includeToJson: false) this.userId,
      @JsonKey(includeFromJson: false, includeToJson: false) this.attendant,
      @JsonKey(includeFromJson: false, includeToJson: false) this.customerName,
      @JsonKey(includeFromJson: false, includeToJson: false) this.warehouseName,
      @JsonKey(includeFromJson: false, includeToJson: false) this.status,
      @JsonKey(includeFromJson: false, includeToJson: false) this.tableName,
      @JsonKey(includeFromJson: false, includeToJson: false) this.createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.receivedAmount,
      @JsonKey(includeFromJson: false, includeToJson: false) this.paidAmount})
      : _holdItems = holdItems,
        _links = links;

  factory _$CreateHoldDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateHoldDtoImplFromJson(json);

  @override
  @JsonKey(name: 'customer_id')
  final int? customerId;
  @override
  final DateTime? date;
  @override
  final double? discount;
  @override
  @JsonKey(name: 'discount_amount')
  final double? discountAmount;
  @override
  @JsonKey(name: 'grand_total')
  final double? grandTotal;
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
  @JsonKey(name: 'reference_code')
  final String? referenceCode;
  @override
  final double? shipping;
  @override
  @JsonKey(name: 'staff_id')
  final int? staffId;
  @override
  @JsonKey(name: 'staff_name')
  final String? staffName;
  @override
  final double? subTotal;
  @override
  @JsonKey(name: 'tax_amount')
  final double? taxAmount;
  @override
  @JsonKey(name: 'tax_rate')
  final double? taxRate;
  @override
  @JsonKey(name: 'table_id')
  final String? tableId;
  @override
  @JsonKey(name: 'warehouse_id')
  final int? warehouseId;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? type;
  final Map<String, dynamic>? _links;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic>? get links {
    final value = _links;
    if (value == null) return null;
    if (_links is EqualUnmodifiableMapView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int? userId;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final HoldAttendant? attendant;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? customerName;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? warehouseName;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final dynamic status;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? tableName;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final DateTime? createdAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final double? receivedAmount;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final double? paidAmount;

  @override
  String toString() {
    return 'CreateHoldDto(customerId: $customerId, date: $date, discount: $discount, discountAmount: $discountAmount, grandTotal: $grandTotal, holdItems: $holdItems, note: $note, referenceCode: $referenceCode, shipping: $shipping, staffId: $staffId, staffName: $staffName, subTotal: $subTotal, taxAmount: $taxAmount, taxRate: $taxRate, tableId: $tableId, warehouseId: $warehouseId, type: $type, links: $links, userId: $userId, attendant: $attendant, customerName: $customerName, warehouseName: $warehouseName, status: $status, tableName: $tableName, createdAt: $createdAt, receivedAmount: $receivedAmount, paidAmount: $paidAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateHoldDtoImpl &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.grandTotal, grandTotal) ||
                other.grandTotal == grandTotal) &&
            const DeepCollectionEquality()
                .equals(other._holdItems, _holdItems) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.referenceCode, referenceCode) ||
                other.referenceCode == referenceCode) &&
            (identical(other.shipping, shipping) ||
                other.shipping == shipping) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.staffName, staffName) ||
                other.staffName == staffName) &&
            (identical(other.subTotal, subTotal) ||
                other.subTotal == subTotal) &&
            (identical(other.taxAmount, taxAmount) ||
                other.taxAmount == taxAmount) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._links, _links) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.attendant, attendant) ||
                other.attendant == attendant) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.warehouseName, warehouseName) ||
                other.warehouseName == warehouseName) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            (identical(other.tableName, tableName) ||
                other.tableName == tableName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.receivedAmount, receivedAmount) ||
                other.receivedAmount == receivedAmount) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        customerId,
        date,
        discount,
        discountAmount,
        grandTotal,
        const DeepCollectionEquality().hash(_holdItems),
        note,
        referenceCode,
        shipping,
        staffId,
        staffName,
        subTotal,
        taxAmount,
        taxRate,
        tableId,
        warehouseId,
        type,
        const DeepCollectionEquality().hash(_links),
        userId,
        attendant,
        customerName,
        warehouseName,
        const DeepCollectionEquality().hash(status),
        tableName,
        createdAt,
        receivedAmount,
        paidAmount
      ]);

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
      {@JsonKey(name: 'customer_id') final int? customerId,
      final DateTime? date,
      final double? discount,
      @JsonKey(name: 'discount_amount') final double? discountAmount,
      @JsonKey(name: 'grand_total') final double? grandTotal,
      @JsonKey(name: 'hold_items') final List<HoldItemDto>? holdItems,
      final String? note,
      @JsonKey(name: 'reference_code') final String? referenceCode,
      final double? shipping,
      @JsonKey(name: 'staff_id') final int? staffId,
      @JsonKey(name: 'staff_name') final String? staffName,
      final double? subTotal,
      @JsonKey(name: 'tax_amount') final double? taxAmount,
      @JsonKey(name: 'tax_rate') final double? taxRate,
      @JsonKey(name: 'table_id') final String? tableId,
      @JsonKey(name: 'warehouse_id') final int? warehouseId,
      @JsonKey(includeFromJson: false, includeToJson: false) final String? type,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Map<String, dynamic>? links,
      @JsonKey(includeFromJson: false, includeToJson: false) final int? userId,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final HoldAttendant? attendant,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final String? customerName,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final String? warehouseName,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final dynamic status,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final String? tableName,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final DateTime? createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final double? receivedAmount,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final double? paidAmount}) = _$CreateHoldDtoImpl;

  factory _CreateHoldDto.fromJson(Map<String, dynamic> json) =
      _$CreateHoldDtoImpl.fromJson;

  @override
  @JsonKey(name: 'customer_id')
  int? get customerId;
  @override
  DateTime? get date;
  @override
  double? get discount;
  @override
  @JsonKey(name: 'discount_amount')
  double? get discountAmount;
  @override
  @JsonKey(name: 'grand_total')
  double? get grandTotal;
  @override
  @JsonKey(name: 'hold_items')
  List<HoldItemDto>? get holdItems;
  @override
  String? get note;
  @override
  @JsonKey(name: 'reference_code')
  String? get referenceCode;
  @override
  double? get shipping;
  @override
  @JsonKey(name: 'staff_id')
  int? get staffId;
  @override
  @JsonKey(name: 'staff_name')
  String? get staffName;
  @override
  double? get subTotal;
  @override
  @JsonKey(name: 'tax_amount')
  double? get taxAmount;
  @override
  @JsonKey(name: 'tax_rate')
  double? get taxRate;
  @override
  @JsonKey(name: 'table_id')
  String? get tableId;
  @override
  @JsonKey(name: 'warehouse_id')
  int? get warehouseId;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get type;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, dynamic>? get links;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  int? get userId;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  HoldAttendant? get attendant;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get customerName;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get warehouseName;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  dynamic get status;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get tableName;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  DateTime? get createdAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  double? get receivedAmount;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  double? get paidAmount;

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
  String? get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_amount')
  double? get discountAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_type')
  int? get discountType => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_value')
  double? get discountValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'hold_item_id')
  String? get holdItemId => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'net_unit_cost')
  double? get netUnitCost => throw _privateConstructorUsedError;
  @JsonKey(name: 'net_unit_price')
  double? get netUnitPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_cost')
  double? get productCost => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int? get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_price')
  double? get productPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_unit')
  String? get productUnit => throw _privateConstructorUsedError;
  double? get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'sale_id')
  int? get saleId => throw _privateConstructorUsedError;
  @JsonKey(name: 'sale_unit')
  dynamic get saleUnit => throw _privateConstructorUsedError;
  @JsonKey(name: 'stock_alert')
  String? get stockAlert => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_total')
  double? get subTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_amount')
  double? get taxAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_type')
  int? get taxType => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_value')
  double? get taxValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_cost')
  @StringOrNumToDoubleConverter()
  double? get customCost => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_price')
  @StringOrNumToDoubleConverter()
  double? get customPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_name')
  String? get customName => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_description')
  String? get customDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_custom')
  @IntBoolConverter()
  bool get isCustom => throw _privateConstructorUsedError;

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
      {String? code,
      @JsonKey(name: 'discount_amount') double? discountAmount,
      @JsonKey(name: 'discount_type') int? discountType,
      @JsonKey(name: 'discount_value') double? discountValue,
      @JsonKey(name: 'hold_item_id') String? holdItemId,
      int? id,
      String? name,
      @JsonKey(name: 'net_unit_cost') double? netUnitCost,
      @JsonKey(name: 'net_unit_price') double? netUnitPrice,
      @JsonKey(name: 'product_cost') double? productCost,
      @JsonKey(name: 'product_id') int? productId,
      @JsonKey(name: 'product_price') double? productPrice,
      @JsonKey(name: 'product_unit') String? productUnit,
      double? quantity,
      @JsonKey(name: 'sale_id') int? saleId,
      @JsonKey(name: 'sale_unit') dynamic saleUnit,
      @JsonKey(name: 'stock_alert') String? stockAlert,
      @JsonKey(name: 'sub_total') double? subTotal,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      @JsonKey(name: 'tax_type') int? taxType,
      @JsonKey(name: 'tax_value') double? taxValue,
      @JsonKey(name: 'custom_cost')
      @StringOrNumToDoubleConverter()
      double? customCost,
      @JsonKey(name: 'custom_price')
      @StringOrNumToDoubleConverter()
      double? customPrice,
      @JsonKey(name: 'custom_name') String? customName,
      @JsonKey(name: 'custom_description') String? customDescription,
      @JsonKey(name: 'is_custom') @IntBoolConverter() bool isCustom});
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
    Object? code = freezed,
    Object? discountAmount = freezed,
    Object? discountType = freezed,
    Object? discountValue = freezed,
    Object? holdItemId = freezed,
    Object? id = freezed,
    Object? name = freezed,
    Object? netUnitCost = freezed,
    Object? netUnitPrice = freezed,
    Object? productCost = freezed,
    Object? productId = freezed,
    Object? productPrice = freezed,
    Object? productUnit = freezed,
    Object? quantity = freezed,
    Object? saleId = freezed,
    Object? saleUnit = freezed,
    Object? stockAlert = freezed,
    Object? subTotal = freezed,
    Object? taxAmount = freezed,
    Object? taxType = freezed,
    Object? taxValue = freezed,
    Object? customCost = freezed,
    Object? customPrice = freezed,
    Object? customName = freezed,
    Object? customDescription = freezed,
    Object? isCustom = null,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      discountType: freezed == discountType
          ? _value.discountType
          : discountType // ignore: cast_nullable_to_non_nullable
              as int?,
      discountValue: freezed == discountValue
          ? _value.discountValue
          : discountValue // ignore: cast_nullable_to_non_nullable
              as double?,
      holdItemId: freezed == holdItemId
          ? _value.holdItemId
          : holdItemId // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      netUnitCost: freezed == netUnitCost
          ? _value.netUnitCost
          : netUnitCost // ignore: cast_nullable_to_non_nullable
              as double?,
      netUnitPrice: freezed == netUnitPrice
          ? _value.netUnitPrice
          : netUnitPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      productCost: freezed == productCost
          ? _value.productCost
          : productCost // ignore: cast_nullable_to_non_nullable
              as double?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      productPrice: freezed == productPrice
          ? _value.productPrice
          : productPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      productUnit: freezed == productUnit
          ? _value.productUnit
          : productUnit // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      saleId: freezed == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as int?,
      saleUnit: freezed == saleUnit
          ? _value.saleUnit
          : saleUnit // ignore: cast_nullable_to_non_nullable
              as dynamic,
      stockAlert: freezed == stockAlert
          ? _value.stockAlert
          : stockAlert // ignore: cast_nullable_to_non_nullable
              as String?,
      subTotal: freezed == subTotal
          ? _value.subTotal
          : subTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      taxAmount: freezed == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      taxType: freezed == taxType
          ? _value.taxType
          : taxType // ignore: cast_nullable_to_non_nullable
              as int?,
      taxValue: freezed == taxValue
          ? _value.taxValue
          : taxValue // ignore: cast_nullable_to_non_nullable
              as double?,
      customCost: freezed == customCost
          ? _value.customCost
          : customCost // ignore: cast_nullable_to_non_nullable
              as double?,
      customPrice: freezed == customPrice
          ? _value.customPrice
          : customPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      customName: freezed == customName
          ? _value.customName
          : customName // ignore: cast_nullable_to_non_nullable
              as String?,
      customDescription: freezed == customDescription
          ? _value.customDescription
          : customDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      isCustom: null == isCustom
          ? _value.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
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
      {String? code,
      @JsonKey(name: 'discount_amount') double? discountAmount,
      @JsonKey(name: 'discount_type') int? discountType,
      @JsonKey(name: 'discount_value') double? discountValue,
      @JsonKey(name: 'hold_item_id') String? holdItemId,
      int? id,
      String? name,
      @JsonKey(name: 'net_unit_cost') double? netUnitCost,
      @JsonKey(name: 'net_unit_price') double? netUnitPrice,
      @JsonKey(name: 'product_cost') double? productCost,
      @JsonKey(name: 'product_id') int? productId,
      @JsonKey(name: 'product_price') double? productPrice,
      @JsonKey(name: 'product_unit') String? productUnit,
      double? quantity,
      @JsonKey(name: 'sale_id') int? saleId,
      @JsonKey(name: 'sale_unit') dynamic saleUnit,
      @JsonKey(name: 'stock_alert') String? stockAlert,
      @JsonKey(name: 'sub_total') double? subTotal,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      @JsonKey(name: 'tax_type') int? taxType,
      @JsonKey(name: 'tax_value') double? taxValue,
      @JsonKey(name: 'custom_cost')
      @StringOrNumToDoubleConverter()
      double? customCost,
      @JsonKey(name: 'custom_price')
      @StringOrNumToDoubleConverter()
      double? customPrice,
      @JsonKey(name: 'custom_name') String? customName,
      @JsonKey(name: 'custom_description') String? customDescription,
      @JsonKey(name: 'is_custom') @IntBoolConverter() bool isCustom});
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
    Object? code = freezed,
    Object? discountAmount = freezed,
    Object? discountType = freezed,
    Object? discountValue = freezed,
    Object? holdItemId = freezed,
    Object? id = freezed,
    Object? name = freezed,
    Object? netUnitCost = freezed,
    Object? netUnitPrice = freezed,
    Object? productCost = freezed,
    Object? productId = freezed,
    Object? productPrice = freezed,
    Object? productUnit = freezed,
    Object? quantity = freezed,
    Object? saleId = freezed,
    Object? saleUnit = freezed,
    Object? stockAlert = freezed,
    Object? subTotal = freezed,
    Object? taxAmount = freezed,
    Object? taxType = freezed,
    Object? taxValue = freezed,
    Object? customCost = freezed,
    Object? customPrice = freezed,
    Object? customName = freezed,
    Object? customDescription = freezed,
    Object? isCustom = null,
  }) {
    return _then(_$HoldItemDtoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      discountType: freezed == discountType
          ? _value.discountType
          : discountType // ignore: cast_nullable_to_non_nullable
              as int?,
      discountValue: freezed == discountValue
          ? _value.discountValue
          : discountValue // ignore: cast_nullable_to_non_nullable
              as double?,
      holdItemId: freezed == holdItemId
          ? _value.holdItemId
          : holdItemId // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      netUnitCost: freezed == netUnitCost
          ? _value.netUnitCost
          : netUnitCost // ignore: cast_nullable_to_non_nullable
              as double?,
      netUnitPrice: freezed == netUnitPrice
          ? _value.netUnitPrice
          : netUnitPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      productCost: freezed == productCost
          ? _value.productCost
          : productCost // ignore: cast_nullable_to_non_nullable
              as double?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      productPrice: freezed == productPrice
          ? _value.productPrice
          : productPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      productUnit: freezed == productUnit
          ? _value.productUnit
          : productUnit // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      saleId: freezed == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as int?,
      saleUnit: freezed == saleUnit
          ? _value.saleUnit
          : saleUnit // ignore: cast_nullable_to_non_nullable
              as dynamic,
      stockAlert: freezed == stockAlert
          ? _value.stockAlert
          : stockAlert // ignore: cast_nullable_to_non_nullable
              as String?,
      subTotal: freezed == subTotal
          ? _value.subTotal
          : subTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      taxAmount: freezed == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      taxType: freezed == taxType
          ? _value.taxType
          : taxType // ignore: cast_nullable_to_non_nullable
              as int?,
      taxValue: freezed == taxValue
          ? _value.taxValue
          : taxValue // ignore: cast_nullable_to_non_nullable
              as double?,
      customCost: freezed == customCost
          ? _value.customCost
          : customCost // ignore: cast_nullable_to_non_nullable
              as double?,
      customPrice: freezed == customPrice
          ? _value.customPrice
          : customPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      customName: freezed == customName
          ? _value.customName
          : customName // ignore: cast_nullable_to_non_nullable
              as String?,
      customDescription: freezed == customDescription
          ? _value.customDescription
          : customDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      isCustom: null == isCustom
          ? _value.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HoldItemDtoImpl implements _HoldItemDto {
  const _$HoldItemDtoImpl(
      {this.code,
      @JsonKey(name: 'discount_amount') this.discountAmount,
      @JsonKey(name: 'discount_type') this.discountType,
      @JsonKey(name: 'discount_value') this.discountValue,
      @JsonKey(name: 'hold_item_id') this.holdItemId,
      this.id,
      this.name,
      @JsonKey(name: 'net_unit_cost') this.netUnitCost,
      @JsonKey(name: 'net_unit_price') this.netUnitPrice,
      @JsonKey(name: 'product_cost') this.productCost,
      @JsonKey(name: 'product_id') this.productId,
      @JsonKey(name: 'product_price') this.productPrice,
      @JsonKey(name: 'product_unit') this.productUnit,
      this.quantity,
      @JsonKey(name: 'sale_id') this.saleId,
      @JsonKey(name: 'sale_unit') this.saleUnit,
      @JsonKey(name: 'stock_alert') this.stockAlert,
      @JsonKey(name: 'sub_total') this.subTotal,
      @JsonKey(name: 'tax_amount') this.taxAmount,
      @JsonKey(name: 'tax_type') this.taxType,
      @JsonKey(name: 'tax_value') this.taxValue,
      @JsonKey(name: 'custom_cost')
      @StringOrNumToDoubleConverter()
      this.customCost,
      @JsonKey(name: 'custom_price')
      @StringOrNumToDoubleConverter()
      this.customPrice,
      @JsonKey(name: 'custom_name') this.customName,
      @JsonKey(name: 'custom_description') this.customDescription,
      @JsonKey(name: 'is_custom') @IntBoolConverter() this.isCustom = false});

  factory _$HoldItemDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$HoldItemDtoImplFromJson(json);

  @override
  final String? code;
  @override
  @JsonKey(name: 'discount_amount')
  final double? discountAmount;
  @override
  @JsonKey(name: 'discount_type')
  final int? discountType;
  @override
  @JsonKey(name: 'discount_value')
  final double? discountValue;
  @override
  @JsonKey(name: 'hold_item_id')
  final String? holdItemId;
  @override
  final int? id;
  @override
  final String? name;
  @override
  @JsonKey(name: 'net_unit_cost')
  final double? netUnitCost;
  @override
  @JsonKey(name: 'net_unit_price')
  final double? netUnitPrice;
  @override
  @JsonKey(name: 'product_cost')
  final double? productCost;
  @override
  @JsonKey(name: 'product_id')
  final int? productId;
  @override
  @JsonKey(name: 'product_price')
  final double? productPrice;
  @override
  @JsonKey(name: 'product_unit')
  final String? productUnit;
  @override
  final double? quantity;
  @override
  @JsonKey(name: 'sale_id')
  final int? saleId;
  @override
  @JsonKey(name: 'sale_unit')
  final dynamic saleUnit;
  @override
  @JsonKey(name: 'stock_alert')
  final String? stockAlert;
  @override
  @JsonKey(name: 'sub_total')
  final double? subTotal;
  @override
  @JsonKey(name: 'tax_amount')
  final double? taxAmount;
  @override
  @JsonKey(name: 'tax_type')
  final int? taxType;
  @override
  @JsonKey(name: 'tax_value')
  final double? taxValue;
  @override
  @JsonKey(name: 'custom_cost')
  @StringOrNumToDoubleConverter()
  final double? customCost;
  @override
  @JsonKey(name: 'custom_price')
  @StringOrNumToDoubleConverter()
  final double? customPrice;
  @override
  @JsonKey(name: 'custom_name')
  final String? customName;
  @override
  @JsonKey(name: 'custom_description')
  final String? customDescription;
  @override
  @JsonKey(name: 'is_custom')
  @IntBoolConverter()
  final bool isCustom;

  @override
  String toString() {
    return 'HoldItemDto(code: $code, discountAmount: $discountAmount, discountType: $discountType, discountValue: $discountValue, holdItemId: $holdItemId, id: $id, name: $name, netUnitCost: $netUnitCost, netUnitPrice: $netUnitPrice, productCost: $productCost, productId: $productId, productPrice: $productPrice, productUnit: $productUnit, quantity: $quantity, saleId: $saleId, saleUnit: $saleUnit, stockAlert: $stockAlert, subTotal: $subTotal, taxAmount: $taxAmount, taxType: $taxType, taxValue: $taxValue, customCost: $customCost, customPrice: $customPrice, customName: $customName, customDescription: $customDescription, isCustom: $isCustom)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HoldItemDtoImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.discountType, discountType) ||
                other.discountType == discountType) &&
            (identical(other.discountValue, discountValue) ||
                other.discountValue == discountValue) &&
            (identical(other.holdItemId, holdItemId) ||
                other.holdItemId == holdItemId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.netUnitCost, netUnitCost) ||
                other.netUnitCost == netUnitCost) &&
            (identical(other.netUnitPrice, netUnitPrice) ||
                other.netUnitPrice == netUnitPrice) &&
            (identical(other.productCost, productCost) ||
                other.productCost == productCost) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productPrice, productPrice) ||
                other.productPrice == productPrice) &&
            (identical(other.productUnit, productUnit) ||
                other.productUnit == productUnit) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.saleId, saleId) || other.saleId == saleId) &&
            const DeepCollectionEquality().equals(other.saleUnit, saleUnit) &&
            (identical(other.stockAlert, stockAlert) ||
                other.stockAlert == stockAlert) &&
            (identical(other.subTotal, subTotal) ||
                other.subTotal == subTotal) &&
            (identical(other.taxAmount, taxAmount) ||
                other.taxAmount == taxAmount) &&
            (identical(other.taxType, taxType) || other.taxType == taxType) &&
            (identical(other.taxValue, taxValue) ||
                other.taxValue == taxValue) &&
            (identical(other.customCost, customCost) ||
                other.customCost == customCost) &&
            (identical(other.customPrice, customPrice) ||
                other.customPrice == customPrice) &&
            (identical(other.customName, customName) ||
                other.customName == customName) &&
            (identical(other.customDescription, customDescription) ||
                other.customDescription == customDescription) &&
            (identical(other.isCustom, isCustom) ||
                other.isCustom == isCustom));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        code,
        discountAmount,
        discountType,
        discountValue,
        holdItemId,
        id,
        name,
        netUnitCost,
        netUnitPrice,
        productCost,
        productId,
        productPrice,
        productUnit,
        quantity,
        saleId,
        const DeepCollectionEquality().hash(saleUnit),
        stockAlert,
        subTotal,
        taxAmount,
        taxType,
        taxValue,
        customCost,
        customPrice,
        customName,
        customDescription,
        isCustom
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
      {final String? code,
      @JsonKey(name: 'discount_amount') final double? discountAmount,
      @JsonKey(name: 'discount_type') final int? discountType,
      @JsonKey(name: 'discount_value') final double? discountValue,
      @JsonKey(name: 'hold_item_id') final String? holdItemId,
      final int? id,
      final String? name,
      @JsonKey(name: 'net_unit_cost') final double? netUnitCost,
      @JsonKey(name: 'net_unit_price') final double? netUnitPrice,
      @JsonKey(name: 'product_cost') final double? productCost,
      @JsonKey(name: 'product_id') final int? productId,
      @JsonKey(name: 'product_price') final double? productPrice,
      @JsonKey(name: 'product_unit') final String? productUnit,
      final double? quantity,
      @JsonKey(name: 'sale_id') final int? saleId,
      @JsonKey(name: 'sale_unit') final dynamic saleUnit,
      @JsonKey(name: 'stock_alert') final String? stockAlert,
      @JsonKey(name: 'sub_total') final double? subTotal,
      @JsonKey(name: 'tax_amount') final double? taxAmount,
      @JsonKey(name: 'tax_type') final int? taxType,
      @JsonKey(name: 'tax_value') final double? taxValue,
      @JsonKey(name: 'custom_cost')
      @StringOrNumToDoubleConverter()
      final double? customCost,
      @JsonKey(name: 'custom_price')
      @StringOrNumToDoubleConverter()
      final double? customPrice,
      @JsonKey(name: 'custom_name') final String? customName,
      @JsonKey(name: 'custom_description') final String? customDescription,
      @JsonKey(name: 'is_custom')
      @IntBoolConverter()
      final bool isCustom}) = _$HoldItemDtoImpl;

  factory _HoldItemDto.fromJson(Map<String, dynamic> json) =
      _$HoldItemDtoImpl.fromJson;

  @override
  String? get code;
  @override
  @JsonKey(name: 'discount_amount')
  double? get discountAmount;
  @override
  @JsonKey(name: 'discount_type')
  int? get discountType;
  @override
  @JsonKey(name: 'discount_value')
  double? get discountValue;
  @override
  @JsonKey(name: 'hold_item_id')
  String? get holdItemId;
  @override
  int? get id;
  @override
  String? get name;
  @override
  @JsonKey(name: 'net_unit_cost')
  double? get netUnitCost;
  @override
  @JsonKey(name: 'net_unit_price')
  double? get netUnitPrice;
  @override
  @JsonKey(name: 'product_cost')
  double? get productCost;
  @override
  @JsonKey(name: 'product_id')
  int? get productId;
  @override
  @JsonKey(name: 'product_price')
  double? get productPrice;
  @override
  @JsonKey(name: 'product_unit')
  String? get productUnit;
  @override
  double? get quantity;
  @override
  @JsonKey(name: 'sale_id')
  int? get saleId;
  @override
  @JsonKey(name: 'sale_unit')
  dynamic get saleUnit;
  @override
  @JsonKey(name: 'stock_alert')
  String? get stockAlert;
  @override
  @JsonKey(name: 'sub_total')
  double? get subTotal;
  @override
  @JsonKey(name: 'tax_amount')
  double? get taxAmount;
  @override
  @JsonKey(name: 'tax_type')
  int? get taxType;
  @override
  @JsonKey(name: 'tax_value')
  double? get taxValue;
  @override
  @JsonKey(name: 'custom_cost')
  @StringOrNumToDoubleConverter()
  double? get customCost;
  @override
  @JsonKey(name: 'custom_price')
  @StringOrNumToDoubleConverter()
  double? get customPrice;
  @override
  @JsonKey(name: 'custom_name')
  String? get customName;
  @override
  @JsonKey(name: 'custom_description')
  String? get customDescription;
  @override
  @JsonKey(name: 'is_custom')
  @IntBoolConverter()
  bool get isCustom;

  /// Create a copy of HoldItemDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HoldItemDtoImplCopyWith<_$HoldItemDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
