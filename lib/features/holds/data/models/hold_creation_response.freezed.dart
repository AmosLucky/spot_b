// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hold_creation_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HoldCreationResponseAttributesDao _$HoldCreationResponseAttributesDaoFromJson(
    Map<String, dynamic> json) {
  return _HoldCreationResponseAttributesDao.fromJson(json);
}

/// @nodoc
mixin _$HoldCreationResponseAttributesDao {
  @JsonKey(name: 'reference_code')
  String? get referenceCode => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int? get userId => throw _privateConstructorUsedError;
  HoldCreationResponseAttendantDao? get attendant =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_id')
  int? get customerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_name')
  String? get customerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_id')
  int? get staffId => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_name')
  String? get staffName => throw _privateConstructorUsedError;
  @JsonKey(name: 'warehouse_id')
  int? get warehouseId => throw _privateConstructorUsedError;
  @JsonKey(name: 'warehouse_name')
  String? get warehouseName => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_rate')
  double? get taxRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_amount')
  double? get taxAmount => throw _privateConstructorUsedError;
  double? get discount => throw _privateConstructorUsedError;
  double? get shipping => throw _privateConstructorUsedError;
  @JsonKey(name: 'grand_total')
  double? get grandTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'received_amount')
  double? get receivedAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'paid_amount')
  double? get paidAmount => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'table_id')
  String? get tableId => throw _privateConstructorUsedError;
  @JsonKey(name: 'table_name')
  String? get tableName => throw _privateConstructorUsedError;
  @JsonKey(name: 'hold_items')
  List<HoldCreationResponseHoldItemDao>? get holdItems =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this HoldCreationResponseAttributesDao to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HoldCreationResponseAttributesDao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HoldCreationResponseAttributesDaoCopyWith<HoldCreationResponseAttributesDao>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HoldCreationResponseAttributesDaoCopyWith<$Res> {
  factory $HoldCreationResponseAttributesDaoCopyWith(
          HoldCreationResponseAttributesDao value,
          $Res Function(HoldCreationResponseAttributesDao) then) =
      _$HoldCreationResponseAttributesDaoCopyWithImpl<$Res,
          HoldCreationResponseAttributesDao>;
  @useResult
  $Res call(
      {@JsonKey(name: 'reference_code') String? referenceCode,
      DateTime? date,
      @JsonKey(name: 'user_id') int? userId,
      HoldCreationResponseAttendantDao? attendant,
      @JsonKey(name: 'customer_id') int? customerId,
      @JsonKey(name: 'customer_name') String? customerName,
      @JsonKey(name: 'staff_id') int? staffId,
      @JsonKey(name: 'staff_name') String? staffName,
      @JsonKey(name: 'warehouse_id') int? warehouseId,
      @JsonKey(name: 'warehouse_name') String? warehouseName,
      @JsonKey(name: 'tax_rate') double? taxRate,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      double? discount,
      double? shipping,
      @JsonKey(name: 'grand_total') double? grandTotal,
      @JsonKey(name: 'received_amount') double? receivedAmount,
      @JsonKey(name: 'paid_amount') double? paidAmount,
      String? note,
      String? status,
      @JsonKey(name: 'table_id') String? tableId,
      @JsonKey(name: 'table_name') String? tableName,
      @JsonKey(name: 'hold_items')
      List<HoldCreationResponseHoldItemDao>? holdItems,
      @JsonKey(name: 'created_at') DateTime? createdAt});

  $HoldCreationResponseAttendantDaoCopyWith<$Res>? get attendant;
}

/// @nodoc
class _$HoldCreationResponseAttributesDaoCopyWithImpl<$Res,
        $Val extends HoldCreationResponseAttributesDao>
    implements $HoldCreationResponseAttributesDaoCopyWith<$Res> {
  _$HoldCreationResponseAttributesDaoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HoldCreationResponseAttributesDao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referenceCode = freezed,
    Object? date = freezed,
    Object? userId = freezed,
    Object? attendant = freezed,
    Object? customerId = freezed,
    Object? customerName = freezed,
    Object? staffId = freezed,
    Object? staffName = freezed,
    Object? warehouseId = freezed,
    Object? warehouseName = freezed,
    Object? taxRate = freezed,
    Object? taxAmount = freezed,
    Object? discount = freezed,
    Object? shipping = freezed,
    Object? grandTotal = freezed,
    Object? receivedAmount = freezed,
    Object? paidAmount = freezed,
    Object? note = freezed,
    Object? status = freezed,
    Object? tableId = freezed,
    Object? tableName = freezed,
    Object? holdItems = freezed,
    Object? createdAt = freezed,
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
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      attendant: freezed == attendant
          ? _value.attendant
          : attendant // ignore: cast_nullable_to_non_nullable
              as HoldCreationResponseAttendantDao?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      staffId: freezed == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int?,
      staffName: freezed == staffName
          ? _value.staffName
          : staffName // ignore: cast_nullable_to_non_nullable
              as String?,
      warehouseId: freezed == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as int?,
      warehouseName: freezed == warehouseName
          ? _value.warehouseName
          : warehouseName // ignore: cast_nullable_to_non_nullable
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
      shipping: freezed == shipping
          ? _value.shipping
          : shipping // ignore: cast_nullable_to_non_nullable
              as double?,
      grandTotal: freezed == grandTotal
          ? _value.grandTotal
          : grandTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      receivedAmount: freezed == receivedAmount
          ? _value.receivedAmount
          : receivedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      tableId: freezed == tableId
          ? _value.tableId
          : tableId // ignore: cast_nullable_to_non_nullable
              as String?,
      tableName: freezed == tableName
          ? _value.tableName
          : tableName // ignore: cast_nullable_to_non_nullable
              as String?,
      holdItems: freezed == holdItems
          ? _value.holdItems
          : holdItems // ignore: cast_nullable_to_non_nullable
              as List<HoldCreationResponseHoldItemDao>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of HoldCreationResponseAttributesDao
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HoldCreationResponseAttendantDaoCopyWith<$Res>? get attendant {
    if (_value.attendant == null) {
      return null;
    }

    return $HoldCreationResponseAttendantDaoCopyWith<$Res>(_value.attendant!,
        (value) {
      return _then(_value.copyWith(attendant: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HoldCreationResponseAttributesDaoImplCopyWith<$Res>
    implements $HoldCreationResponseAttributesDaoCopyWith<$Res> {
  factory _$$HoldCreationResponseAttributesDaoImplCopyWith(
          _$HoldCreationResponseAttributesDaoImpl value,
          $Res Function(_$HoldCreationResponseAttributesDaoImpl) then) =
      __$$HoldCreationResponseAttributesDaoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'reference_code') String? referenceCode,
      DateTime? date,
      @JsonKey(name: 'user_id') int? userId,
      HoldCreationResponseAttendantDao? attendant,
      @JsonKey(name: 'customer_id') int? customerId,
      @JsonKey(name: 'customer_name') String? customerName,
      @JsonKey(name: 'staff_id') int? staffId,
      @JsonKey(name: 'staff_name') String? staffName,
      @JsonKey(name: 'warehouse_id') int? warehouseId,
      @JsonKey(name: 'warehouse_name') String? warehouseName,
      @JsonKey(name: 'tax_rate') double? taxRate,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      double? discount,
      double? shipping,
      @JsonKey(name: 'grand_total') double? grandTotal,
      @JsonKey(name: 'received_amount') double? receivedAmount,
      @JsonKey(name: 'paid_amount') double? paidAmount,
      String? note,
      String? status,
      @JsonKey(name: 'table_id') String? tableId,
      @JsonKey(name: 'table_name') String? tableName,
      @JsonKey(name: 'hold_items')
      List<HoldCreationResponseHoldItemDao>? holdItems,
      @JsonKey(name: 'created_at') DateTime? createdAt});

  @override
  $HoldCreationResponseAttendantDaoCopyWith<$Res>? get attendant;
}

/// @nodoc
class __$$HoldCreationResponseAttributesDaoImplCopyWithImpl<$Res>
    extends _$HoldCreationResponseAttributesDaoCopyWithImpl<$Res,
        _$HoldCreationResponseAttributesDaoImpl>
    implements _$$HoldCreationResponseAttributesDaoImplCopyWith<$Res> {
  __$$HoldCreationResponseAttributesDaoImplCopyWithImpl(
      _$HoldCreationResponseAttributesDaoImpl _value,
      $Res Function(_$HoldCreationResponseAttributesDaoImpl) _then)
      : super(_value, _then);

  /// Create a copy of HoldCreationResponseAttributesDao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referenceCode = freezed,
    Object? date = freezed,
    Object? userId = freezed,
    Object? attendant = freezed,
    Object? customerId = freezed,
    Object? customerName = freezed,
    Object? staffId = freezed,
    Object? staffName = freezed,
    Object? warehouseId = freezed,
    Object? warehouseName = freezed,
    Object? taxRate = freezed,
    Object? taxAmount = freezed,
    Object? discount = freezed,
    Object? shipping = freezed,
    Object? grandTotal = freezed,
    Object? receivedAmount = freezed,
    Object? paidAmount = freezed,
    Object? note = freezed,
    Object? status = freezed,
    Object? tableId = freezed,
    Object? tableName = freezed,
    Object? holdItems = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$HoldCreationResponseAttributesDaoImpl(
      referenceCode: freezed == referenceCode
          ? _value.referenceCode
          : referenceCode // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      attendant: freezed == attendant
          ? _value.attendant
          : attendant // ignore: cast_nullable_to_non_nullable
              as HoldCreationResponseAttendantDao?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      staffId: freezed == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int?,
      staffName: freezed == staffName
          ? _value.staffName
          : staffName // ignore: cast_nullable_to_non_nullable
              as String?,
      warehouseId: freezed == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as int?,
      warehouseName: freezed == warehouseName
          ? _value.warehouseName
          : warehouseName // ignore: cast_nullable_to_non_nullable
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
      shipping: freezed == shipping
          ? _value.shipping
          : shipping // ignore: cast_nullable_to_non_nullable
              as double?,
      grandTotal: freezed == grandTotal
          ? _value.grandTotal
          : grandTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      receivedAmount: freezed == receivedAmount
          ? _value.receivedAmount
          : receivedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      tableId: freezed == tableId
          ? _value.tableId
          : tableId // ignore: cast_nullable_to_non_nullable
              as String?,
      tableName: freezed == tableName
          ? _value.tableName
          : tableName // ignore: cast_nullable_to_non_nullable
              as String?,
      holdItems: freezed == holdItems
          ? _value._holdItems
          : holdItems // ignore: cast_nullable_to_non_nullable
              as List<HoldCreationResponseHoldItemDao>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HoldCreationResponseAttributesDaoImpl
    implements _HoldCreationResponseAttributesDao {
  const _$HoldCreationResponseAttributesDaoImpl(
      {@JsonKey(name: 'reference_code') this.referenceCode,
      this.date,
      @JsonKey(name: 'user_id') this.userId,
      this.attendant,
      @JsonKey(name: 'customer_id') this.customerId,
      @JsonKey(name: 'customer_name') this.customerName,
      @JsonKey(name: 'staff_id') this.staffId,
      @JsonKey(name: 'staff_name') this.staffName,
      @JsonKey(name: 'warehouse_id') this.warehouseId,
      @JsonKey(name: 'warehouse_name') this.warehouseName,
      @JsonKey(name: 'tax_rate') this.taxRate,
      @JsonKey(name: 'tax_amount') this.taxAmount,
      this.discount,
      this.shipping,
      @JsonKey(name: 'grand_total') this.grandTotal,
      @JsonKey(name: 'received_amount') this.receivedAmount,
      @JsonKey(name: 'paid_amount') this.paidAmount,
      this.note,
      this.status,
      @JsonKey(name: 'table_id') this.tableId,
      @JsonKey(name: 'table_name') this.tableName,
      @JsonKey(name: 'hold_items')
      final List<HoldCreationResponseHoldItemDao>? holdItems,
      @JsonKey(name: 'created_at') this.createdAt})
      : _holdItems = holdItems;

  factory _$HoldCreationResponseAttributesDaoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$HoldCreationResponseAttributesDaoImplFromJson(json);

  @override
  @JsonKey(name: 'reference_code')
  final String? referenceCode;
  @override
  final DateTime? date;
  @override
  @JsonKey(name: 'user_id')
  final int? userId;
  @override
  final HoldCreationResponseAttendantDao? attendant;
  @override
  @JsonKey(name: 'customer_id')
  final int? customerId;
  @override
  @JsonKey(name: 'customer_name')
  final String? customerName;
  @override
  @JsonKey(name: 'staff_id')
  final int? staffId;
  @override
  @JsonKey(name: 'staff_name')
  final String? staffName;
  @override
  @JsonKey(name: 'warehouse_id')
  final int? warehouseId;
  @override
  @JsonKey(name: 'warehouse_name')
  final String? warehouseName;
  @override
  @JsonKey(name: 'tax_rate')
  final double? taxRate;
  @override
  @JsonKey(name: 'tax_amount')
  final double? taxAmount;
  @override
  final double? discount;
  @override
  final double? shipping;
  @override
  @JsonKey(name: 'grand_total')
  final double? grandTotal;
  @override
  @JsonKey(name: 'received_amount')
  final double? receivedAmount;
  @override
  @JsonKey(name: 'paid_amount')
  final double? paidAmount;
  @override
  final String? note;
  @override
  final String? status;
  @override
  @JsonKey(name: 'table_id')
  final String? tableId;
  @override
  @JsonKey(name: 'table_name')
  final String? tableName;
  final List<HoldCreationResponseHoldItemDao>? _holdItems;
  @override
  @JsonKey(name: 'hold_items')
  List<HoldCreationResponseHoldItemDao>? get holdItems {
    final value = _holdItems;
    if (value == null) return null;
    if (_holdItems is EqualUnmodifiableListView) return _holdItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'HoldCreationResponseAttributesDao(referenceCode: $referenceCode, date: $date, userId: $userId, attendant: $attendant, customerId: $customerId, customerName: $customerName, staffId: $staffId, staffName: $staffName, warehouseId: $warehouseId, warehouseName: $warehouseName, taxRate: $taxRate, taxAmount: $taxAmount, discount: $discount, shipping: $shipping, grandTotal: $grandTotal, receivedAmount: $receivedAmount, paidAmount: $paidAmount, note: $note, status: $status, tableId: $tableId, tableName: $tableName, holdItems: $holdItems, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HoldCreationResponseAttributesDaoImpl &&
            (identical(other.referenceCode, referenceCode) ||
                other.referenceCode == referenceCode) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.attendant, attendant) ||
                other.attendant == attendant) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.staffName, staffName) ||
                other.staffName == staffName) &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId) &&
            (identical(other.warehouseName, warehouseName) ||
                other.warehouseName == warehouseName) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            (identical(other.taxAmount, taxAmount) ||
                other.taxAmount == taxAmount) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.shipping, shipping) ||
                other.shipping == shipping) &&
            (identical(other.grandTotal, grandTotal) ||
                other.grandTotal == grandTotal) &&
            (identical(other.receivedAmount, receivedAmount) ||
                other.receivedAmount == receivedAmount) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.tableName, tableName) ||
                other.tableName == tableName) &&
            const DeepCollectionEquality()
                .equals(other._holdItems, _holdItems) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        referenceCode,
        date,
        userId,
        attendant,
        customerId,
        customerName,
        staffId,
        staffName,
        warehouseId,
        warehouseName,
        taxRate,
        taxAmount,
        discount,
        shipping,
        grandTotal,
        receivedAmount,
        paidAmount,
        note,
        status,
        tableId,
        tableName,
        const DeepCollectionEquality().hash(_holdItems),
        createdAt
      ]);

  /// Create a copy of HoldCreationResponseAttributesDao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HoldCreationResponseAttributesDaoImplCopyWith<
          _$HoldCreationResponseAttributesDaoImpl>
      get copyWith => __$$HoldCreationResponseAttributesDaoImplCopyWithImpl<
          _$HoldCreationResponseAttributesDaoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HoldCreationResponseAttributesDaoImplToJson(
      this,
    );
  }
}

abstract class _HoldCreationResponseAttributesDao
    implements HoldCreationResponseAttributesDao {
  const factory _HoldCreationResponseAttributesDao(
          {@JsonKey(name: 'reference_code') final String? referenceCode,
          final DateTime? date,
          @JsonKey(name: 'user_id') final int? userId,
          final HoldCreationResponseAttendantDao? attendant,
          @JsonKey(name: 'customer_id') final int? customerId,
          @JsonKey(name: 'customer_name') final String? customerName,
          @JsonKey(name: 'staff_id') final int? staffId,
          @JsonKey(name: 'staff_name') final String? staffName,
          @JsonKey(name: 'warehouse_id') final int? warehouseId,
          @JsonKey(name: 'warehouse_name') final String? warehouseName,
          @JsonKey(name: 'tax_rate') final double? taxRate,
          @JsonKey(name: 'tax_amount') final double? taxAmount,
          final double? discount,
          final double? shipping,
          @JsonKey(name: 'grand_total') final double? grandTotal,
          @JsonKey(name: 'received_amount') final double? receivedAmount,
          @JsonKey(name: 'paid_amount') final double? paidAmount,
          final String? note,
          final String? status,
          @JsonKey(name: 'table_id') final String? tableId,
          @JsonKey(name: 'table_name') final String? tableName,
          @JsonKey(name: 'hold_items')
          final List<HoldCreationResponseHoldItemDao>? holdItems,
          @JsonKey(name: 'created_at') final DateTime? createdAt}) =
      _$HoldCreationResponseAttributesDaoImpl;

  factory _HoldCreationResponseAttributesDao.fromJson(
          Map<String, dynamic> json) =
      _$HoldCreationResponseAttributesDaoImpl.fromJson;

  @override
  @JsonKey(name: 'reference_code')
  String? get referenceCode;
  @override
  DateTime? get date;
  @override
  @JsonKey(name: 'user_id')
  int? get userId;
  @override
  HoldCreationResponseAttendantDao? get attendant;
  @override
  @JsonKey(name: 'customer_id')
  int? get customerId;
  @override
  @JsonKey(name: 'customer_name')
  String? get customerName;
  @override
  @JsonKey(name: 'staff_id')
  int? get staffId;
  @override
  @JsonKey(name: 'staff_name')
  String? get staffName;
  @override
  @JsonKey(name: 'warehouse_id')
  int? get warehouseId;
  @override
  @JsonKey(name: 'warehouse_name')
  String? get warehouseName;
  @override
  @JsonKey(name: 'tax_rate')
  double? get taxRate;
  @override
  @JsonKey(name: 'tax_amount')
  double? get taxAmount;
  @override
  double? get discount;
  @override
  double? get shipping;
  @override
  @JsonKey(name: 'grand_total')
  double? get grandTotal;
  @override
  @JsonKey(name: 'received_amount')
  double? get receivedAmount;
  @override
  @JsonKey(name: 'paid_amount')
  double? get paidAmount;
  @override
  String? get note;
  @override
  String? get status;
  @override
  @JsonKey(name: 'table_id')
  String? get tableId;
  @override
  @JsonKey(name: 'table_name')
  String? get tableName;
  @override
  @JsonKey(name: 'hold_items')
  List<HoldCreationResponseHoldItemDao>? get holdItems;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of HoldCreationResponseAttributesDao
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HoldCreationResponseAttributesDaoImplCopyWith<
          _$HoldCreationResponseAttributesDaoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

HoldCreationResponseAttendantDao _$HoldCreationResponseAttendantDaoFromJson(
    Map<String, dynamic> json) {
  return _HoldCreationResponseAttendantDao.fromJson(json);
}

/// @nodoc
mixin _$HoldCreationResponseAttendantDao {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String? get lastName => throw _privateConstructorUsedError;
  DateTime? get dob => throw _privateConstructorUsedError;
  @JsonKey(name: 'salary_date')
  DateTime? get salaryDate => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'email_verified_at')
  DateTime? get emailVerifiedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'default_password')
  String? get defaultPassword => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;
  @JsonKey(name: 'company_id')
  int? get companyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_admin')
  int? get isAdmin => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_super')
  int? get isSuper => throw _privateConstructorUsedError;
  @JsonKey(name: 'warehouse_id')
  String? get warehouseId => throw _privateConstructorUsedError;
  @JsonKey(name: 'branch_id')
  dynamic get branchId => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'salary_amount')
  double? get salaryAmount => throw _privateConstructorUsedError;
  double? get balance => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_employed')
  DateTime? get dateEmployed => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_attendant')
  int? get isAttendant => throw _privateConstructorUsedError;
  @JsonKey(name: 'table_id')
  String? get tableId => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  List<dynamic>? get media => throw _privateConstructorUsedError;

  /// Serializes this HoldCreationResponseAttendantDao to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HoldCreationResponseAttendantDao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HoldCreationResponseAttendantDaoCopyWith<HoldCreationResponseAttendantDao>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HoldCreationResponseAttendantDaoCopyWith<$Res> {
  factory $HoldCreationResponseAttendantDaoCopyWith(
          HoldCreationResponseAttendantDao value,
          $Res Function(HoldCreationResponseAttendantDao) then) =
      _$HoldCreationResponseAttendantDaoCopyWithImpl<$Res,
          HoldCreationResponseAttendantDao>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'first_name') String? firstName,
      @JsonKey(name: 'last_name') String? lastName,
      DateTime? dob,
      @JsonKey(name: 'salary_date') DateTime? salaryDate,
      String? email,
      String? phone,
      @JsonKey(name: 'email_verified_at') DateTime? emailVerifiedAt,
      @JsonKey(name: 'default_password') String? defaultPassword,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      int? status,
      String? language,
      @JsonKey(name: 'company_id') int? companyId,
      @JsonKey(name: 'is_admin') int? isAdmin,
      @JsonKey(name: 'is_super') int? isSuper,
      @JsonKey(name: 'warehouse_id') String? warehouseId,
      @JsonKey(name: 'branch_id') dynamic branchId,
      String? type,
      @JsonKey(name: 'salary_amount') double? salaryAmount,
      double? balance,
      @JsonKey(name: 'date_employed') DateTime? dateEmployed,
      String? note,
      @JsonKey(name: 'is_attendant') int? isAttendant,
      @JsonKey(name: 'table_id') String? tableId,
      @JsonKey(name: 'image_url') String? imageUrl,
      List<dynamic>? media});
}

/// @nodoc
class _$HoldCreationResponseAttendantDaoCopyWithImpl<$Res,
        $Val extends HoldCreationResponseAttendantDao>
    implements $HoldCreationResponseAttendantDaoCopyWith<$Res> {
  _$HoldCreationResponseAttendantDaoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HoldCreationResponseAttendantDao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? dob = freezed,
    Object? salaryDate = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? emailVerifiedAt = freezed,
    Object? defaultPassword = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? status = freezed,
    Object? language = freezed,
    Object? companyId = freezed,
    Object? isAdmin = freezed,
    Object? isSuper = freezed,
    Object? warehouseId = freezed,
    Object? branchId = freezed,
    Object? type = freezed,
    Object? salaryAmount = freezed,
    Object? balance = freezed,
    Object? dateEmployed = freezed,
    Object? note = freezed,
    Object? isAttendant = freezed,
    Object? tableId = freezed,
    Object? imageUrl = freezed,
    Object? media = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      dob: freezed == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      salaryDate: freezed == salaryDate
          ? _value.salaryDate
          : salaryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      emailVerifiedAt: freezed == emailVerifiedAt
          ? _value.emailVerifiedAt
          : emailVerifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      defaultPassword: freezed == defaultPassword
          ? _value.defaultPassword
          : defaultPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as int?,
      isAdmin: freezed == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as int?,
      isSuper: freezed == isSuper
          ? _value.isSuper
          : isSuper // ignore: cast_nullable_to_non_nullable
              as int?,
      warehouseId: freezed == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as String?,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      salaryAmount: freezed == salaryAmount
          ? _value.salaryAmount
          : salaryAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      balance: freezed == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double?,
      dateEmployed: freezed == dateEmployed
          ? _value.dateEmployed
          : dateEmployed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      isAttendant: freezed == isAttendant
          ? _value.isAttendant
          : isAttendant // ignore: cast_nullable_to_non_nullable
              as int?,
      tableId: freezed == tableId
          ? _value.tableId
          : tableId // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      media: freezed == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HoldCreationResponseAttendantDaoImplCopyWith<$Res>
    implements $HoldCreationResponseAttendantDaoCopyWith<$Res> {
  factory _$$HoldCreationResponseAttendantDaoImplCopyWith(
          _$HoldCreationResponseAttendantDaoImpl value,
          $Res Function(_$HoldCreationResponseAttendantDaoImpl) then) =
      __$$HoldCreationResponseAttendantDaoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'first_name') String? firstName,
      @JsonKey(name: 'last_name') String? lastName,
      DateTime? dob,
      @JsonKey(name: 'salary_date') DateTime? salaryDate,
      String? email,
      String? phone,
      @JsonKey(name: 'email_verified_at') DateTime? emailVerifiedAt,
      @JsonKey(name: 'default_password') String? defaultPassword,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      int? status,
      String? language,
      @JsonKey(name: 'company_id') int? companyId,
      @JsonKey(name: 'is_admin') int? isAdmin,
      @JsonKey(name: 'is_super') int? isSuper,
      @JsonKey(name: 'warehouse_id') String? warehouseId,
      @JsonKey(name: 'branch_id') dynamic branchId,
      String? type,
      @JsonKey(name: 'salary_amount') double? salaryAmount,
      double? balance,
      @JsonKey(name: 'date_employed') DateTime? dateEmployed,
      String? note,
      @JsonKey(name: 'is_attendant') int? isAttendant,
      @JsonKey(name: 'table_id') String? tableId,
      @JsonKey(name: 'image_url') String? imageUrl,
      List<dynamic>? media});
}

/// @nodoc
class __$$HoldCreationResponseAttendantDaoImplCopyWithImpl<$Res>
    extends _$HoldCreationResponseAttendantDaoCopyWithImpl<$Res,
        _$HoldCreationResponseAttendantDaoImpl>
    implements _$$HoldCreationResponseAttendantDaoImplCopyWith<$Res> {
  __$$HoldCreationResponseAttendantDaoImplCopyWithImpl(
      _$HoldCreationResponseAttendantDaoImpl _value,
      $Res Function(_$HoldCreationResponseAttendantDaoImpl) _then)
      : super(_value, _then);

  /// Create a copy of HoldCreationResponseAttendantDao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? dob = freezed,
    Object? salaryDate = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? emailVerifiedAt = freezed,
    Object? defaultPassword = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? status = freezed,
    Object? language = freezed,
    Object? companyId = freezed,
    Object? isAdmin = freezed,
    Object? isSuper = freezed,
    Object? warehouseId = freezed,
    Object? branchId = freezed,
    Object? type = freezed,
    Object? salaryAmount = freezed,
    Object? balance = freezed,
    Object? dateEmployed = freezed,
    Object? note = freezed,
    Object? isAttendant = freezed,
    Object? tableId = freezed,
    Object? imageUrl = freezed,
    Object? media = freezed,
  }) {
    return _then(_$HoldCreationResponseAttendantDaoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      dob: freezed == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      salaryDate: freezed == salaryDate
          ? _value.salaryDate
          : salaryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      emailVerifiedAt: freezed == emailVerifiedAt
          ? _value.emailVerifiedAt
          : emailVerifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      defaultPassword: freezed == defaultPassword
          ? _value.defaultPassword
          : defaultPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as int?,
      isAdmin: freezed == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as int?,
      isSuper: freezed == isSuper
          ? _value.isSuper
          : isSuper // ignore: cast_nullable_to_non_nullable
              as int?,
      warehouseId: freezed == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as String?,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      salaryAmount: freezed == salaryAmount
          ? _value.salaryAmount
          : salaryAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      balance: freezed == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double?,
      dateEmployed: freezed == dateEmployed
          ? _value.dateEmployed
          : dateEmployed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      isAttendant: freezed == isAttendant
          ? _value.isAttendant
          : isAttendant // ignore: cast_nullable_to_non_nullable
              as int?,
      tableId: freezed == tableId
          ? _value.tableId
          : tableId // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      media: freezed == media
          ? _value._media
          : media // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HoldCreationResponseAttendantDaoImpl
    implements _HoldCreationResponseAttendantDao {
  const _$HoldCreationResponseAttendantDaoImpl(
      {this.id,
      @JsonKey(name: 'first_name') this.firstName,
      @JsonKey(name: 'last_name') this.lastName,
      this.dob,
      @JsonKey(name: 'salary_date') this.salaryDate,
      this.email,
      this.phone,
      @JsonKey(name: 'email_verified_at') this.emailVerifiedAt,
      @JsonKey(name: 'default_password') this.defaultPassword,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.status,
      this.language,
      @JsonKey(name: 'company_id') this.companyId,
      @JsonKey(name: 'is_admin') this.isAdmin,
      @JsonKey(name: 'is_super') this.isSuper,
      @JsonKey(name: 'warehouse_id') this.warehouseId,
      @JsonKey(name: 'branch_id') this.branchId,
      this.type,
      @JsonKey(name: 'salary_amount') this.salaryAmount,
      this.balance,
      @JsonKey(name: 'date_employed') this.dateEmployed,
      this.note,
      @JsonKey(name: 'is_attendant') this.isAttendant,
      @JsonKey(name: 'table_id') this.tableId,
      @JsonKey(name: 'image_url') this.imageUrl,
      final List<dynamic>? media})
      : _media = media;

  factory _$HoldCreationResponseAttendantDaoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$HoldCreationResponseAttendantDaoImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'first_name')
  final String? firstName;
  @override
  @JsonKey(name: 'last_name')
  final String? lastName;
  @override
  final DateTime? dob;
  @override
  @JsonKey(name: 'salary_date')
  final DateTime? salaryDate;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  @JsonKey(name: 'email_verified_at')
  final DateTime? emailVerifiedAt;
  @override
  @JsonKey(name: 'default_password')
  final String? defaultPassword;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  final int? status;
  @override
  final String? language;
  @override
  @JsonKey(name: 'company_id')
  final int? companyId;
  @override
  @JsonKey(name: 'is_admin')
  final int? isAdmin;
  @override
  @JsonKey(name: 'is_super')
  final int? isSuper;
  @override
  @JsonKey(name: 'warehouse_id')
  final String? warehouseId;
  @override
  @JsonKey(name: 'branch_id')
  final dynamic branchId;
  @override
  final String? type;
  @override
  @JsonKey(name: 'salary_amount')
  final double? salaryAmount;
  @override
  final double? balance;
  @override
  @JsonKey(name: 'date_employed')
  final DateTime? dateEmployed;
  @override
  final String? note;
  @override
  @JsonKey(name: 'is_attendant')
  final int? isAttendant;
  @override
  @JsonKey(name: 'table_id')
  final String? tableId;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final List<dynamic>? _media;
  @override
  List<dynamic>? get media {
    final value = _media;
    if (value == null) return null;
    if (_media is EqualUnmodifiableListView) return _media;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'HoldCreationResponseAttendantDao(id: $id, firstName: $firstName, lastName: $lastName, dob: $dob, salaryDate: $salaryDate, email: $email, phone: $phone, emailVerifiedAt: $emailVerifiedAt, defaultPassword: $defaultPassword, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, language: $language, companyId: $companyId, isAdmin: $isAdmin, isSuper: $isSuper, warehouseId: $warehouseId, branchId: $branchId, type: $type, salaryAmount: $salaryAmount, balance: $balance, dateEmployed: $dateEmployed, note: $note, isAttendant: $isAttendant, tableId: $tableId, imageUrl: $imageUrl, media: $media)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HoldCreationResponseAttendantDaoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.salaryDate, salaryDate) ||
                other.salaryDate == salaryDate) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.emailVerifiedAt, emailVerifiedAt) ||
                other.emailVerifiedAt == emailVerifiedAt) &&
            (identical(other.defaultPassword, defaultPassword) ||
                other.defaultPassword == defaultPassword) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.isSuper, isSuper) || other.isSuper == isSuper) &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId) &&
            const DeepCollectionEquality().equals(other.branchId, branchId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.salaryAmount, salaryAmount) ||
                other.salaryAmount == salaryAmount) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.dateEmployed, dateEmployed) ||
                other.dateEmployed == dateEmployed) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.isAttendant, isAttendant) ||
                other.isAttendant == isAttendant) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._media, _media));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        firstName,
        lastName,
        dob,
        salaryDate,
        email,
        phone,
        emailVerifiedAt,
        defaultPassword,
        createdAt,
        updatedAt,
        status,
        language,
        companyId,
        isAdmin,
        isSuper,
        warehouseId,
        const DeepCollectionEquality().hash(branchId),
        type,
        salaryAmount,
        balance,
        dateEmployed,
        note,
        isAttendant,
        tableId,
        imageUrl,
        const DeepCollectionEquality().hash(_media)
      ]);

  /// Create a copy of HoldCreationResponseAttendantDao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HoldCreationResponseAttendantDaoImplCopyWith<
          _$HoldCreationResponseAttendantDaoImpl>
      get copyWith => __$$HoldCreationResponseAttendantDaoImplCopyWithImpl<
          _$HoldCreationResponseAttendantDaoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HoldCreationResponseAttendantDaoImplToJson(
      this,
    );
  }
}

abstract class _HoldCreationResponseAttendantDao
    implements HoldCreationResponseAttendantDao {
  const factory _HoldCreationResponseAttendantDao(
      {final int? id,
      @JsonKey(name: 'first_name') final String? firstName,
      @JsonKey(name: 'last_name') final String? lastName,
      final DateTime? dob,
      @JsonKey(name: 'salary_date') final DateTime? salaryDate,
      final String? email,
      final String? phone,
      @JsonKey(name: 'email_verified_at') final DateTime? emailVerifiedAt,
      @JsonKey(name: 'default_password') final String? defaultPassword,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      final int? status,
      final String? language,
      @JsonKey(name: 'company_id') final int? companyId,
      @JsonKey(name: 'is_admin') final int? isAdmin,
      @JsonKey(name: 'is_super') final int? isSuper,
      @JsonKey(name: 'warehouse_id') final String? warehouseId,
      @JsonKey(name: 'branch_id') final dynamic branchId,
      final String? type,
      @JsonKey(name: 'salary_amount') final double? salaryAmount,
      final double? balance,
      @JsonKey(name: 'date_employed') final DateTime? dateEmployed,
      final String? note,
      @JsonKey(name: 'is_attendant') final int? isAttendant,
      @JsonKey(name: 'table_id') final String? tableId,
      @JsonKey(name: 'image_url') final String? imageUrl,
      final List<dynamic>? media}) = _$HoldCreationResponseAttendantDaoImpl;

  factory _HoldCreationResponseAttendantDao.fromJson(
          Map<String, dynamic> json) =
      _$HoldCreationResponseAttendantDaoImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'first_name')
  String? get firstName;
  @override
  @JsonKey(name: 'last_name')
  String? get lastName;
  @override
  DateTime? get dob;
  @override
  @JsonKey(name: 'salary_date')
  DateTime? get salaryDate;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  @JsonKey(name: 'email_verified_at')
  DateTime? get emailVerifiedAt;
  @override
  @JsonKey(name: 'default_password')
  String? get defaultPassword;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  int? get status;
  @override
  String? get language;
  @override
  @JsonKey(name: 'company_id')
  int? get companyId;
  @override
  @JsonKey(name: 'is_admin')
  int? get isAdmin;
  @override
  @JsonKey(name: 'is_super')
  int? get isSuper;
  @override
  @JsonKey(name: 'warehouse_id')
  String? get warehouseId;
  @override
  @JsonKey(name: 'branch_id')
  dynamic get branchId;
  @override
  String? get type;
  @override
  @JsonKey(name: 'salary_amount')
  double? get salaryAmount;
  @override
  double? get balance;
  @override
  @JsonKey(name: 'date_employed')
  DateTime? get dateEmployed;
  @override
  String? get note;
  @override
  @JsonKey(name: 'is_attendant')
  int? get isAttendant;
  @override
  @JsonKey(name: 'table_id')
  String? get tableId;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  List<dynamic>? get media;

  /// Create a copy of HoldCreationResponseAttendantDao
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HoldCreationResponseAttendantDaoImplCopyWith<
          _$HoldCreationResponseAttendantDaoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

HoldCreationResponseHoldItemDao _$HoldCreationResponseHoldItemDaoFromJson(
    Map<String, dynamic> json) {
  return _HoldCreationResponseHoldItemDao.fromJson(json);
}

/// @nodoc
mixin _$HoldCreationResponseHoldItemDao {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'hold_id')
  int? get holdId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int? get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String? get productName => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_price')
  double? get productPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'net_unit_price')
  double? get netUnitPrice => throw _privateConstructorUsedError;
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
  @JsonKey(name: 'sale_unit')
  HoldCreationResponseSaleUnitDao? get saleUnit =>
      throw _privateConstructorUsedError;
  double? get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_total')
  double? get subTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_custom')
  @IntBoolConverter()
  bool get isCustom => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_name')
  String? get customName => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_cost')
  @StringOrNumToDoubleConverter()
  double? get customCost => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_price')
  @StringOrNumToDoubleConverter()
  double? get customPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_description')
  String? get customDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this HoldCreationResponseHoldItemDao to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HoldCreationResponseHoldItemDao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HoldCreationResponseHoldItemDaoCopyWith<HoldCreationResponseHoldItemDao>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HoldCreationResponseHoldItemDaoCopyWith<$Res> {
  factory $HoldCreationResponseHoldItemDaoCopyWith(
          HoldCreationResponseHoldItemDao value,
          $Res Function(HoldCreationResponseHoldItemDao) then) =
      _$HoldCreationResponseHoldItemDaoCopyWithImpl<$Res,
          HoldCreationResponseHoldItemDao>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'hold_id') int? holdId,
      @JsonKey(name: 'product_id') int? productId,
      @JsonKey(name: 'product_name') String? productName,
      @JsonKey(name: 'product_price') double? productPrice,
      @JsonKey(name: 'net_unit_price') double? netUnitPrice,
      @JsonKey(name: 'tax_type') int? taxType,
      @JsonKey(name: 'tax_value') double? taxValue,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      @JsonKey(name: 'discount_type') int? discountType,
      @JsonKey(name: 'discount_value') double? discountValue,
      @JsonKey(name: 'discount_amount') double? discountAmount,
      @JsonKey(name: 'sale_unit') HoldCreationResponseSaleUnitDao? saleUnit,
      double? quantity,
      @JsonKey(name: 'sub_total') double? subTotal,
      @JsonKey(name: 'is_custom') @IntBoolConverter() bool isCustom,
      @JsonKey(name: 'custom_name') String? customName,
      @JsonKey(name: 'custom_cost')
      @StringOrNumToDoubleConverter()
      double? customCost,
      @JsonKey(name: 'custom_price')
      @StringOrNumToDoubleConverter()
      double? customPrice,
      @JsonKey(name: 'custom_description') String? customDescription,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});

  $HoldCreationResponseSaleUnitDaoCopyWith<$Res>? get saleUnit;
}

/// @nodoc
class _$HoldCreationResponseHoldItemDaoCopyWithImpl<$Res,
        $Val extends HoldCreationResponseHoldItemDao>
    implements $HoldCreationResponseHoldItemDaoCopyWith<$Res> {
  _$HoldCreationResponseHoldItemDaoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HoldCreationResponseHoldItemDao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? holdId = freezed,
    Object? productId = freezed,
    Object? productName = freezed,
    Object? productPrice = freezed,
    Object? netUnitPrice = freezed,
    Object? taxType = freezed,
    Object? taxValue = freezed,
    Object? taxAmount = freezed,
    Object? discountType = freezed,
    Object? discountValue = freezed,
    Object? discountAmount = freezed,
    Object? saleUnit = freezed,
    Object? quantity = freezed,
    Object? subTotal = freezed,
    Object? isCustom = null,
    Object? customName = freezed,
    Object? customCost = freezed,
    Object? customPrice = freezed,
    Object? customDescription = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      holdId: freezed == holdId
          ? _value.holdId
          : holdId // ignore: cast_nullable_to_non_nullable
              as int?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      productPrice: freezed == productPrice
          ? _value.productPrice
          : productPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      netUnitPrice: freezed == netUnitPrice
          ? _value.netUnitPrice
          : netUnitPrice // ignore: cast_nullable_to_non_nullable
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
      saleUnit: freezed == saleUnit
          ? _value.saleUnit
          : saleUnit // ignore: cast_nullable_to_non_nullable
              as HoldCreationResponseSaleUnitDao?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      subTotal: freezed == subTotal
          ? _value.subTotal
          : subTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      isCustom: null == isCustom
          ? _value.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
      customName: freezed == customName
          ? _value.customName
          : customName // ignore: cast_nullable_to_non_nullable
              as String?,
      customCost: freezed == customCost
          ? _value.customCost
          : customCost // ignore: cast_nullable_to_non_nullable
              as double?,
      customPrice: freezed == customPrice
          ? _value.customPrice
          : customPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      customDescription: freezed == customDescription
          ? _value.customDescription
          : customDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of HoldCreationResponseHoldItemDao
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HoldCreationResponseSaleUnitDaoCopyWith<$Res>? get saleUnit {
    if (_value.saleUnit == null) {
      return null;
    }

    return $HoldCreationResponseSaleUnitDaoCopyWith<$Res>(_value.saleUnit!,
        (value) {
      return _then(_value.copyWith(saleUnit: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HoldCreationResponseHoldItemDaoImplCopyWith<$Res>
    implements $HoldCreationResponseHoldItemDaoCopyWith<$Res> {
  factory _$$HoldCreationResponseHoldItemDaoImplCopyWith(
          _$HoldCreationResponseHoldItemDaoImpl value,
          $Res Function(_$HoldCreationResponseHoldItemDaoImpl) then) =
      __$$HoldCreationResponseHoldItemDaoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'hold_id') int? holdId,
      @JsonKey(name: 'product_id') int? productId,
      @JsonKey(name: 'product_name') String? productName,
      @JsonKey(name: 'product_price') double? productPrice,
      @JsonKey(name: 'net_unit_price') double? netUnitPrice,
      @JsonKey(name: 'tax_type') int? taxType,
      @JsonKey(name: 'tax_value') double? taxValue,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      @JsonKey(name: 'discount_type') int? discountType,
      @JsonKey(name: 'discount_value') double? discountValue,
      @JsonKey(name: 'discount_amount') double? discountAmount,
      @JsonKey(name: 'sale_unit') HoldCreationResponseSaleUnitDao? saleUnit,
      double? quantity,
      @JsonKey(name: 'sub_total') double? subTotal,
      @JsonKey(name: 'is_custom') @IntBoolConverter() bool isCustom,
      @JsonKey(name: 'custom_name') String? customName,
      @JsonKey(name: 'custom_cost')
      @StringOrNumToDoubleConverter()
      double? customCost,
      @JsonKey(name: 'custom_price')
      @StringOrNumToDoubleConverter()
      double? customPrice,
      @JsonKey(name: 'custom_description') String? customDescription,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});

  @override
  $HoldCreationResponseSaleUnitDaoCopyWith<$Res>? get saleUnit;
}

/// @nodoc
class __$$HoldCreationResponseHoldItemDaoImplCopyWithImpl<$Res>
    extends _$HoldCreationResponseHoldItemDaoCopyWithImpl<$Res,
        _$HoldCreationResponseHoldItemDaoImpl>
    implements _$$HoldCreationResponseHoldItemDaoImplCopyWith<$Res> {
  __$$HoldCreationResponseHoldItemDaoImplCopyWithImpl(
      _$HoldCreationResponseHoldItemDaoImpl _value,
      $Res Function(_$HoldCreationResponseHoldItemDaoImpl) _then)
      : super(_value, _then);

  /// Create a copy of HoldCreationResponseHoldItemDao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? holdId = freezed,
    Object? productId = freezed,
    Object? productName = freezed,
    Object? productPrice = freezed,
    Object? netUnitPrice = freezed,
    Object? taxType = freezed,
    Object? taxValue = freezed,
    Object? taxAmount = freezed,
    Object? discountType = freezed,
    Object? discountValue = freezed,
    Object? discountAmount = freezed,
    Object? saleUnit = freezed,
    Object? quantity = freezed,
    Object? subTotal = freezed,
    Object? isCustom = null,
    Object? customName = freezed,
    Object? customCost = freezed,
    Object? customPrice = freezed,
    Object? customDescription = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$HoldCreationResponseHoldItemDaoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      holdId: freezed == holdId
          ? _value.holdId
          : holdId // ignore: cast_nullable_to_non_nullable
              as int?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      productPrice: freezed == productPrice
          ? _value.productPrice
          : productPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      netUnitPrice: freezed == netUnitPrice
          ? _value.netUnitPrice
          : netUnitPrice // ignore: cast_nullable_to_non_nullable
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
      saleUnit: freezed == saleUnit
          ? _value.saleUnit
          : saleUnit // ignore: cast_nullable_to_non_nullable
              as HoldCreationResponseSaleUnitDao?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      subTotal: freezed == subTotal
          ? _value.subTotal
          : subTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      isCustom: null == isCustom
          ? _value.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
      customName: freezed == customName
          ? _value.customName
          : customName // ignore: cast_nullable_to_non_nullable
              as String?,
      customCost: freezed == customCost
          ? _value.customCost
          : customCost // ignore: cast_nullable_to_non_nullable
              as double?,
      customPrice: freezed == customPrice
          ? _value.customPrice
          : customPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      customDescription: freezed == customDescription
          ? _value.customDescription
          : customDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HoldCreationResponseHoldItemDaoImpl
    implements _HoldCreationResponseHoldItemDao {
  const _$HoldCreationResponseHoldItemDaoImpl(
      {this.id,
      @JsonKey(name: 'hold_id') this.holdId,
      @JsonKey(name: 'product_id') this.productId,
      @JsonKey(name: 'product_name') this.productName,
      @JsonKey(name: 'product_price') this.productPrice,
      @JsonKey(name: 'net_unit_price') this.netUnitPrice,
      @JsonKey(name: 'tax_type') this.taxType,
      @JsonKey(name: 'tax_value') this.taxValue,
      @JsonKey(name: 'tax_amount') this.taxAmount,
      @JsonKey(name: 'discount_type') this.discountType,
      @JsonKey(name: 'discount_value') this.discountValue,
      @JsonKey(name: 'discount_amount') this.discountAmount,
      @JsonKey(name: 'sale_unit') this.saleUnit,
      this.quantity,
      @JsonKey(name: 'sub_total') this.subTotal,
      @JsonKey(name: 'is_custom') @IntBoolConverter() this.isCustom = false,
      @JsonKey(name: 'custom_name') this.customName,
      @JsonKey(name: 'custom_cost')
      @StringOrNumToDoubleConverter()
      this.customCost,
      @JsonKey(name: 'custom_price')
      @StringOrNumToDoubleConverter()
      this.customPrice,
      @JsonKey(name: 'custom_description') this.customDescription,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$HoldCreationResponseHoldItemDaoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$HoldCreationResponseHoldItemDaoImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'hold_id')
  final int? holdId;
  @override
  @JsonKey(name: 'product_id')
  final int? productId;
  @override
  @JsonKey(name: 'product_name')
  final String? productName;
  @override
  @JsonKey(name: 'product_price')
  final double? productPrice;
  @override
  @JsonKey(name: 'net_unit_price')
  final double? netUnitPrice;
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
  @JsonKey(name: 'sale_unit')
  final HoldCreationResponseSaleUnitDao? saleUnit;
  @override
  final double? quantity;
  @override
  @JsonKey(name: 'sub_total')
  final double? subTotal;
  @override
  @JsonKey(name: 'is_custom')
  @IntBoolConverter()
  final bool isCustom;
  @override
  @JsonKey(name: 'custom_name')
  final String? customName;
  @override
  @JsonKey(name: 'custom_cost')
  @StringOrNumToDoubleConverter()
  final double? customCost;
  @override
  @JsonKey(name: 'custom_price')
  @StringOrNumToDoubleConverter()
  final double? customPrice;
  @override
  @JsonKey(name: 'custom_description')
  final String? customDescription;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'HoldCreationResponseHoldItemDao(id: $id, holdId: $holdId, productId: $productId, productName: $productName, productPrice: $productPrice, netUnitPrice: $netUnitPrice, taxType: $taxType, taxValue: $taxValue, taxAmount: $taxAmount, discountType: $discountType, discountValue: $discountValue, discountAmount: $discountAmount, saleUnit: $saleUnit, quantity: $quantity, subTotal: $subTotal, isCustom: $isCustom, customName: $customName, customCost: $customCost, customPrice: $customPrice, customDescription: $customDescription, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HoldCreationResponseHoldItemDaoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.holdId, holdId) || other.holdId == holdId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productPrice, productPrice) ||
                other.productPrice == productPrice) &&
            (identical(other.netUnitPrice, netUnitPrice) ||
                other.netUnitPrice == netUnitPrice) &&
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
            (identical(other.saleUnit, saleUnit) ||
                other.saleUnit == saleUnit) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.subTotal, subTotal) ||
                other.subTotal == subTotal) &&
            (identical(other.isCustom, isCustom) ||
                other.isCustom == isCustom) &&
            (identical(other.customName, customName) ||
                other.customName == customName) &&
            (identical(other.customCost, customCost) ||
                other.customCost == customCost) &&
            (identical(other.customPrice, customPrice) ||
                other.customPrice == customPrice) &&
            (identical(other.customDescription, customDescription) ||
                other.customDescription == customDescription) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        holdId,
        productId,
        productName,
        productPrice,
        netUnitPrice,
        taxType,
        taxValue,
        taxAmount,
        discountType,
        discountValue,
        discountAmount,
        saleUnit,
        quantity,
        subTotal,
        isCustom,
        customName,
        customCost,
        customPrice,
        customDescription,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of HoldCreationResponseHoldItemDao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HoldCreationResponseHoldItemDaoImplCopyWith<
          _$HoldCreationResponseHoldItemDaoImpl>
      get copyWith => __$$HoldCreationResponseHoldItemDaoImplCopyWithImpl<
          _$HoldCreationResponseHoldItemDaoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HoldCreationResponseHoldItemDaoImplToJson(
      this,
    );
  }
}

abstract class _HoldCreationResponseHoldItemDao
    implements HoldCreationResponseHoldItemDao {
  const factory _HoldCreationResponseHoldItemDao(
          {final int? id,
          @JsonKey(name: 'hold_id') final int? holdId,
          @JsonKey(name: 'product_id') final int? productId,
          @JsonKey(name: 'product_name') final String? productName,
          @JsonKey(name: 'product_price') final double? productPrice,
          @JsonKey(name: 'net_unit_price') final double? netUnitPrice,
          @JsonKey(name: 'tax_type') final int? taxType,
          @JsonKey(name: 'tax_value') final double? taxValue,
          @JsonKey(name: 'tax_amount') final double? taxAmount,
          @JsonKey(name: 'discount_type') final int? discountType,
          @JsonKey(name: 'discount_value') final double? discountValue,
          @JsonKey(name: 'discount_amount') final double? discountAmount,
          @JsonKey(name: 'sale_unit')
          final HoldCreationResponseSaleUnitDao? saleUnit,
          final double? quantity,
          @JsonKey(name: 'sub_total') final double? subTotal,
          @JsonKey(name: 'is_custom') @IntBoolConverter() final bool isCustom,
          @JsonKey(name: 'custom_name') final String? customName,
          @JsonKey(name: 'custom_cost')
          @StringOrNumToDoubleConverter()
          final double? customCost,
          @JsonKey(name: 'custom_price')
          @StringOrNumToDoubleConverter()
          final double? customPrice,
          @JsonKey(name: 'custom_description') final String? customDescription,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$HoldCreationResponseHoldItemDaoImpl;

  factory _HoldCreationResponseHoldItemDao.fromJson(Map<String, dynamic> json) =
      _$HoldCreationResponseHoldItemDaoImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'hold_id')
  int? get holdId;
  @override
  @JsonKey(name: 'product_id')
  int? get productId;
  @override
  @JsonKey(name: 'product_name')
  String? get productName;
  @override
  @JsonKey(name: 'product_price')
  double? get productPrice;
  @override
  @JsonKey(name: 'net_unit_price')
  double? get netUnitPrice;
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
  @JsonKey(name: 'sale_unit')
  HoldCreationResponseSaleUnitDao? get saleUnit;
  @override
  double? get quantity;
  @override
  @JsonKey(name: 'sub_total')
  double? get subTotal;
  @override
  @JsonKey(name: 'is_custom')
  @IntBoolConverter()
  bool get isCustom;
  @override
  @JsonKey(name: 'custom_name')
  String? get customName;
  @override
  @JsonKey(name: 'custom_cost')
  @StringOrNumToDoubleConverter()
  double? get customCost;
  @override
  @JsonKey(name: 'custom_price')
  @StringOrNumToDoubleConverter()
  double? get customPrice;
  @override
  @JsonKey(name: 'custom_description')
  String? get customDescription;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of HoldCreationResponseHoldItemDao
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HoldCreationResponseHoldItemDaoImplCopyWith<
          _$HoldCreationResponseHoldItemDaoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

HoldCreationResponseSaleUnitDao _$HoldCreationResponseSaleUnitDaoFromJson(
    Map<String, dynamic> json) {
  return _HoldCreationResponseSaleUnitDao.fromJson(json);
}

/// @nodoc
mixin _$HoldCreationResponseSaleUnitDao {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'short_name')
  String? get shortName => throw _privateConstructorUsedError;
  @JsonKey(name: 'base_unit')
  int? get baseUnit => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'company_id')
  int? get companyId => throw _privateConstructorUsedError;

  /// Serializes this HoldCreationResponseSaleUnitDao to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HoldCreationResponseSaleUnitDao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HoldCreationResponseSaleUnitDaoCopyWith<HoldCreationResponseSaleUnitDao>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HoldCreationResponseSaleUnitDaoCopyWith<$Res> {
  factory $HoldCreationResponseSaleUnitDaoCopyWith(
          HoldCreationResponseSaleUnitDao value,
          $Res Function(HoldCreationResponseSaleUnitDao) then) =
      _$HoldCreationResponseSaleUnitDaoCopyWithImpl<$Res,
          HoldCreationResponseSaleUnitDao>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      @JsonKey(name: 'short_name') String? shortName,
      @JsonKey(name: 'base_unit') int? baseUnit,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'company_id') int? companyId});
}

/// @nodoc
class _$HoldCreationResponseSaleUnitDaoCopyWithImpl<$Res,
        $Val extends HoldCreationResponseSaleUnitDao>
    implements $HoldCreationResponseSaleUnitDaoCopyWith<$Res> {
  _$HoldCreationResponseSaleUnitDaoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HoldCreationResponseSaleUnitDao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? shortName = freezed,
    Object? baseUnit = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? companyId = freezed,
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
      shortName: freezed == shortName
          ? _value.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      baseUnit: freezed == baseUnit
          ? _value.baseUnit
          : baseUnit // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HoldCreationResponseSaleUnitDaoImplCopyWith<$Res>
    implements $HoldCreationResponseSaleUnitDaoCopyWith<$Res> {
  factory _$$HoldCreationResponseSaleUnitDaoImplCopyWith(
          _$HoldCreationResponseSaleUnitDaoImpl value,
          $Res Function(_$HoldCreationResponseSaleUnitDaoImpl) then) =
      __$$HoldCreationResponseSaleUnitDaoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      @JsonKey(name: 'short_name') String? shortName,
      @JsonKey(name: 'base_unit') int? baseUnit,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'company_id') int? companyId});
}

/// @nodoc
class __$$HoldCreationResponseSaleUnitDaoImplCopyWithImpl<$Res>
    extends _$HoldCreationResponseSaleUnitDaoCopyWithImpl<$Res,
        _$HoldCreationResponseSaleUnitDaoImpl>
    implements _$$HoldCreationResponseSaleUnitDaoImplCopyWith<$Res> {
  __$$HoldCreationResponseSaleUnitDaoImplCopyWithImpl(
      _$HoldCreationResponseSaleUnitDaoImpl _value,
      $Res Function(_$HoldCreationResponseSaleUnitDaoImpl) _then)
      : super(_value, _then);

  /// Create a copy of HoldCreationResponseSaleUnitDao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? shortName = freezed,
    Object? baseUnit = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? companyId = freezed,
  }) {
    return _then(_$HoldCreationResponseSaleUnitDaoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _value.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      baseUnit: freezed == baseUnit
          ? _value.baseUnit
          : baseUnit // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HoldCreationResponseSaleUnitDaoImpl
    implements _HoldCreationResponseSaleUnitDao {
  const _$HoldCreationResponseSaleUnitDaoImpl(
      {this.id,
      this.name,
      @JsonKey(name: 'short_name') this.shortName,
      @JsonKey(name: 'base_unit') this.baseUnit,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'company_id') this.companyId});

  factory _$HoldCreationResponseSaleUnitDaoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$HoldCreationResponseSaleUnitDaoImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  @JsonKey(name: 'short_name')
  final String? shortName;
  @override
  @JsonKey(name: 'base_unit')
  final int? baseUnit;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'company_id')
  final int? companyId;

  @override
  String toString() {
    return 'HoldCreationResponseSaleUnitDao(id: $id, name: $name, shortName: $shortName, baseUnit: $baseUnit, createdAt: $createdAt, updatedAt: $updatedAt, companyId: $companyId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HoldCreationResponseSaleUnitDaoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.baseUnit, baseUnit) ||
                other.baseUnit == baseUnit) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, shortName, baseUnit,
      createdAt, updatedAt, companyId);

  /// Create a copy of HoldCreationResponseSaleUnitDao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HoldCreationResponseSaleUnitDaoImplCopyWith<
          _$HoldCreationResponseSaleUnitDaoImpl>
      get copyWith => __$$HoldCreationResponseSaleUnitDaoImplCopyWithImpl<
          _$HoldCreationResponseSaleUnitDaoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HoldCreationResponseSaleUnitDaoImplToJson(
      this,
    );
  }
}

abstract class _HoldCreationResponseSaleUnitDao
    implements HoldCreationResponseSaleUnitDao {
  const factory _HoldCreationResponseSaleUnitDao(
          {final int? id,
          final String? name,
          @JsonKey(name: 'short_name') final String? shortName,
          @JsonKey(name: 'base_unit') final int? baseUnit,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt,
          @JsonKey(name: 'company_id') final int? companyId}) =
      _$HoldCreationResponseSaleUnitDaoImpl;

  factory _HoldCreationResponseSaleUnitDao.fromJson(Map<String, dynamic> json) =
      _$HoldCreationResponseSaleUnitDaoImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  @JsonKey(name: 'short_name')
  String? get shortName;
  @override
  @JsonKey(name: 'base_unit')
  int? get baseUnit;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(name: 'company_id')
  int? get companyId;

  /// Create a copy of HoldCreationResponseSaleUnitDao
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HoldCreationResponseSaleUnitDaoImplCopyWith<
          _$HoldCreationResponseSaleUnitDaoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
