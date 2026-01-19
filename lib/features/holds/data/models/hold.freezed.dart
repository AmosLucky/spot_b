// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hold.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Hold {
  int? get id => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  Map<String, dynamic>? get links => throw _privateConstructorUsedError;
  @JsonKey(name: 'reference_code')
  String? get referenceCode => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int? get userId => throw _privateConstructorUsedError;
  HoldAttendant? get attendant => throw _privateConstructorUsedError;
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
  dynamic get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'table_id')
  String? get tableId => throw _privateConstructorUsedError;
  @JsonKey(name: 'table_name')
  dynamic get tableName => throw _privateConstructorUsedError;
  @JsonKey(name: 'hold_items')
  List<HoldItem>? get holdItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? get isSynced => throw _privateConstructorUsedError;

  /// Create a copy of Hold
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HoldCopyWith<Hold> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HoldCopyWith<$Res> {
  factory $HoldCopyWith(Hold value, $Res Function(Hold) then) =
      _$HoldCopyWithImpl<$Res, Hold>;
  @useResult
  $Res call(
      {int? id,
      String? type,
      Map<String, dynamic>? links,
      @JsonKey(name: 'reference_code') String? referenceCode,
      DateTime? date,
      @JsonKey(name: 'user_id') int? userId,
      HoldAttendant? attendant,
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
      dynamic status,
      @JsonKey(name: 'table_id') String? tableId,
      @JsonKey(name: 'table_name') dynamic tableName,
      @JsonKey(name: 'hold_items') List<HoldItem>? holdItems,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false) bool? isSynced});

  $HoldAttendantCopyWith<$Res>? get attendant;
}

/// @nodoc
class _$HoldCopyWithImpl<$Res, $Val extends Hold>
    implements $HoldCopyWith<$Res> {
  _$HoldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Hold
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? links = freezed,
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
    Object? isSynced = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      links: freezed == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
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
              as HoldAttendant?,
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
              as dynamic,
      tableId: freezed == tableId
          ? _value.tableId
          : tableId // ignore: cast_nullable_to_non_nullable
              as String?,
      tableName: freezed == tableName
          ? _value.tableName
          : tableName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      holdItems: freezed == holdItems
          ? _value.holdItems
          : holdItems // ignore: cast_nullable_to_non_nullable
              as List<HoldItem>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isSynced: freezed == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  /// Create a copy of Hold
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
abstract class _$$HoldImplCopyWith<$Res> implements $HoldCopyWith<$Res> {
  factory _$$HoldImplCopyWith(
          _$HoldImpl value, $Res Function(_$HoldImpl) then) =
      __$$HoldImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? type,
      Map<String, dynamic>? links,
      @JsonKey(name: 'reference_code') String? referenceCode,
      DateTime? date,
      @JsonKey(name: 'user_id') int? userId,
      HoldAttendant? attendant,
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
      dynamic status,
      @JsonKey(name: 'table_id') String? tableId,
      @JsonKey(name: 'table_name') dynamic tableName,
      @JsonKey(name: 'hold_items') List<HoldItem>? holdItems,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false) bool? isSynced});

  @override
  $HoldAttendantCopyWith<$Res>? get attendant;
}

/// @nodoc
class __$$HoldImplCopyWithImpl<$Res>
    extends _$HoldCopyWithImpl<$Res, _$HoldImpl>
    implements _$$HoldImplCopyWith<$Res> {
  __$$HoldImplCopyWithImpl(_$HoldImpl _value, $Res Function(_$HoldImpl) _then)
      : super(_value, _then);

  /// Create a copy of Hold
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? links = freezed,
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
    Object? isSynced = freezed,
  }) {
    return _then(_$HoldImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      links: freezed == links
          ? _value._links
          : links // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
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
              as HoldAttendant?,
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
              as dynamic,
      tableId: freezed == tableId
          ? _value.tableId
          : tableId // ignore: cast_nullable_to_non_nullable
              as String?,
      tableName: freezed == tableName
          ? _value.tableName
          : tableName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      holdItems: freezed == holdItems
          ? _value._holdItems
          : holdItems // ignore: cast_nullable_to_non_nullable
              as List<HoldItem>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isSynced: freezed == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$HoldImpl implements _Hold {
  const _$HoldImpl(
      {this.id,
      this.type,
      final Map<String, dynamic>? links,
      @JsonKey(name: 'reference_code') this.referenceCode,
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
      @JsonKey(name: 'hold_items') final List<HoldItem>? holdItems,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false) this.isSynced})
      : _links = links,
        _holdItems = holdItems;

  @override
  final int? id;
  @override
  final String? type;
  final Map<String, dynamic>? _links;
  @override
  Map<String, dynamic>? get links {
    final value = _links;
    if (value == null) return null;
    if (_links is EqualUnmodifiableMapView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'reference_code')
  final String? referenceCode;
  @override
  final DateTime? date;
  @override
  @JsonKey(name: 'user_id')
  final int? userId;
  @override
  final HoldAttendant? attendant;
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
  final dynamic status;
  @override
  @JsonKey(name: 'table_id')
  final String? tableId;
  @override
  @JsonKey(name: 'table_name')
  final dynamic tableName;
  final List<HoldItem>? _holdItems;
  @override
  @JsonKey(name: 'hold_items')
  List<HoldItem>? get holdItems {
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
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool? isSynced;

  @override
  String toString() {
    return 'Hold(id: $id, type: $type, links: $links, referenceCode: $referenceCode, date: $date, userId: $userId, attendant: $attendant, customerId: $customerId, customerName: $customerName, staffId: $staffId, staffName: $staffName, warehouseId: $warehouseId, warehouseName: $warehouseName, taxRate: $taxRate, taxAmount: $taxAmount, discount: $discount, shipping: $shipping, grandTotal: $grandTotal, receivedAmount: $receivedAmount, paidAmount: $paidAmount, note: $note, status: $status, tableId: $tableId, tableName: $tableName, holdItems: $holdItems, createdAt: $createdAt, isSynced: $isSynced)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HoldImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._links, _links) &&
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
            const DeepCollectionEquality().equals(other.status, status) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
            const DeepCollectionEquality().equals(other.tableName, tableName) &&
            const DeepCollectionEquality()
                .equals(other._holdItems, _holdItems) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        type,
        const DeepCollectionEquality().hash(_links),
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
        const DeepCollectionEquality().hash(status),
        tableId,
        const DeepCollectionEquality().hash(tableName),
        const DeepCollectionEquality().hash(_holdItems),
        createdAt,
        isSynced
      ]);

  /// Create a copy of Hold
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HoldImplCopyWith<_$HoldImpl> get copyWith =>
      __$$HoldImplCopyWithImpl<_$HoldImpl>(this, _$identity);
}

abstract class _Hold implements Hold {
  const factory _Hold(
      {final int? id,
      final String? type,
      final Map<String, dynamic>? links,
      @JsonKey(name: 'reference_code') final String? referenceCode,
      final DateTime? date,
      @JsonKey(name: 'user_id') final int? userId,
      final HoldAttendant? attendant,
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
      final dynamic status,
      @JsonKey(name: 'table_id') final String? tableId,
      @JsonKey(name: 'table_name') final dynamic tableName,
      @JsonKey(name: 'hold_items') final List<HoldItem>? holdItems,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final bool? isSynced}) = _$HoldImpl;

  @override
  int? get id;
  @override
  String? get type;
  @override
  Map<String, dynamic>? get links;
  @override
  @JsonKey(name: 'reference_code')
  String? get referenceCode;
  @override
  DateTime? get date;
  @override
  @JsonKey(name: 'user_id')
  int? get userId;
  @override
  HoldAttendant? get attendant;
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
  dynamic get status;
  @override
  @JsonKey(name: 'table_id')
  String? get tableId;
  @override
  @JsonKey(name: 'table_name')
  dynamic get tableName;
  @override
  @JsonKey(name: 'hold_items')
  List<HoldItem>? get holdItems;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? get isSynced;

  /// Create a copy of Hold
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HoldImplCopyWith<_$HoldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HoldAttendant _$HoldAttendantFromJson(Map<String, dynamic> json) {
  return _HoldAttendant.fromJson(json);
}

/// @nodoc
mixin _$HoldAttendant {
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
  int? get branchId => throw _privateConstructorUsedError;
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

  /// Serializes this HoldAttendant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HoldAttendant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HoldAttendantCopyWith<HoldAttendant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HoldAttendantCopyWith<$Res> {
  factory $HoldAttendantCopyWith(
          HoldAttendant value, $Res Function(HoldAttendant) then) =
      _$HoldAttendantCopyWithImpl<$Res, HoldAttendant>;
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
      @JsonKey(name: 'branch_id') int? branchId,
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
class _$HoldAttendantCopyWithImpl<$Res, $Val extends HoldAttendant>
    implements $HoldAttendantCopyWith<$Res> {
  _$HoldAttendantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HoldAttendant
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
              as int?,
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
abstract class _$$HoldAttendantImplCopyWith<$Res>
    implements $HoldAttendantCopyWith<$Res> {
  factory _$$HoldAttendantImplCopyWith(
          _$HoldAttendantImpl value, $Res Function(_$HoldAttendantImpl) then) =
      __$$HoldAttendantImplCopyWithImpl<$Res>;
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
      @JsonKey(name: 'branch_id') int? branchId,
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
class __$$HoldAttendantImplCopyWithImpl<$Res>
    extends _$HoldAttendantCopyWithImpl<$Res, _$HoldAttendantImpl>
    implements _$$HoldAttendantImplCopyWith<$Res> {
  __$$HoldAttendantImplCopyWithImpl(
      _$HoldAttendantImpl _value, $Res Function(_$HoldAttendantImpl) _then)
      : super(_value, _then);

  /// Create a copy of HoldAttendant
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
    return _then(_$HoldAttendantImpl(
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
              as int?,
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
class _$HoldAttendantImpl implements _HoldAttendant {
  const _$HoldAttendantImpl(
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

  factory _$HoldAttendantImpl.fromJson(Map<String, dynamic> json) =>
      _$$HoldAttendantImplFromJson(json);

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
  final int? branchId;
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
    return 'HoldAttendant(id: $id, firstName: $firstName, lastName: $lastName, dob: $dob, salaryDate: $salaryDate, email: $email, phone: $phone, emailVerifiedAt: $emailVerifiedAt, defaultPassword: $defaultPassword, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, language: $language, companyId: $companyId, isAdmin: $isAdmin, isSuper: $isSuper, warehouseId: $warehouseId, branchId: $branchId, type: $type, salaryAmount: $salaryAmount, balance: $balance, dateEmployed: $dateEmployed, note: $note, isAttendant: $isAttendant, tableId: $tableId, imageUrl: $imageUrl, media: $media)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HoldAttendantImpl &&
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
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
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
        branchId,
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

  /// Create a copy of HoldAttendant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HoldAttendantImplCopyWith<_$HoldAttendantImpl> get copyWith =>
      __$$HoldAttendantImplCopyWithImpl<_$HoldAttendantImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HoldAttendantImplToJson(
      this,
    );
  }
}

abstract class _HoldAttendant implements HoldAttendant {
  const factory _HoldAttendant(
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
      @JsonKey(name: 'branch_id') final int? branchId,
      final String? type,
      @JsonKey(name: 'salary_amount') final double? salaryAmount,
      final double? balance,
      @JsonKey(name: 'date_employed') final DateTime? dateEmployed,
      final String? note,
      @JsonKey(name: 'is_attendant') final int? isAttendant,
      @JsonKey(name: 'table_id') final String? tableId,
      @JsonKey(name: 'image_url') final String? imageUrl,
      final List<dynamic>? media}) = _$HoldAttendantImpl;

  factory _HoldAttendant.fromJson(Map<String, dynamic> json) =
      _$HoldAttendantImpl.fromJson;

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
  int? get branchId;
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

  /// Create a copy of HoldAttendant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HoldAttendantImplCopyWith<_$HoldAttendantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HoldItem _$HoldItemFromJson(Map<String, dynamic> json) {
  return _HoldItem.fromJson(json);
}

/// @nodoc
mixin _$HoldItem {
  int? get id => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
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
  HoldUnit? get saleUnit => throw _privateConstructorUsedError;
  double? get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_total')
  double? get subTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
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

  /// Serializes this HoldItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HoldItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HoldItemCopyWith<HoldItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HoldItemCopyWith<$Res> {
  factory $HoldItemCopyWith(HoldItem value, $Res Function(HoldItem) then) =
      _$HoldItemCopyWithImpl<$Res, HoldItem>;
  @useResult
  $Res call(
      {int? id,
      String? code,
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
      @JsonKey(name: 'sale_unit') HoldUnit? saleUnit,
      double? quantity,
      @JsonKey(name: 'sub_total') double? subTotal,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'custom_cost')
      @StringOrNumToDoubleConverter()
      double? customCost,
      @JsonKey(name: 'custom_price')
      @StringOrNumToDoubleConverter()
      double? customPrice,
      @JsonKey(name: 'custom_name') String? customName,
      @JsonKey(name: 'custom_description') String? customDescription,
      @JsonKey(name: 'is_custom') @IntBoolConverter() bool isCustom});

  $HoldUnitCopyWith<$Res>? get saleUnit;
}

/// @nodoc
class _$HoldItemCopyWithImpl<$Res, $Val extends HoldItem>
    implements $HoldItemCopyWith<$Res> {
  _$HoldItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HoldItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
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
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? customCost = freezed,
    Object? customPrice = freezed,
    Object? customName = freezed,
    Object? customDescription = freezed,
    Object? isCustom = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
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
              as HoldUnit?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      subTotal: freezed == subTotal
          ? _value.subTotal
          : subTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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

  /// Create a copy of HoldItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HoldUnitCopyWith<$Res>? get saleUnit {
    if (_value.saleUnit == null) {
      return null;
    }

    return $HoldUnitCopyWith<$Res>(_value.saleUnit!, (value) {
      return _then(_value.copyWith(saleUnit: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HoldItemImplCopyWith<$Res>
    implements $HoldItemCopyWith<$Res> {
  factory _$$HoldItemImplCopyWith(
          _$HoldItemImpl value, $Res Function(_$HoldItemImpl) then) =
      __$$HoldItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? code,
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
      @JsonKey(name: 'sale_unit') HoldUnit? saleUnit,
      double? quantity,
      @JsonKey(name: 'sub_total') double? subTotal,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'custom_cost')
      @StringOrNumToDoubleConverter()
      double? customCost,
      @JsonKey(name: 'custom_price')
      @StringOrNumToDoubleConverter()
      double? customPrice,
      @JsonKey(name: 'custom_name') String? customName,
      @JsonKey(name: 'custom_description') String? customDescription,
      @JsonKey(name: 'is_custom') @IntBoolConverter() bool isCustom});

  @override
  $HoldUnitCopyWith<$Res>? get saleUnit;
}

/// @nodoc
class __$$HoldItemImplCopyWithImpl<$Res>
    extends _$HoldItemCopyWithImpl<$Res, _$HoldItemImpl>
    implements _$$HoldItemImplCopyWith<$Res> {
  __$$HoldItemImplCopyWithImpl(
      _$HoldItemImpl _value, $Res Function(_$HoldItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of HoldItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? code = freezed,
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
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? customCost = freezed,
    Object? customPrice = freezed,
    Object? customName = freezed,
    Object? customDescription = freezed,
    Object? isCustom = null,
  }) {
    return _then(_$HoldItemImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
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
              as HoldUnit?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      subTotal: freezed == subTotal
          ? _value.subTotal
          : subTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
class _$HoldItemImpl implements _HoldItem {
  const _$HoldItemImpl(
      {this.id,
      this.code,
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
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'custom_cost')
      @StringOrNumToDoubleConverter()
      this.customCost,
      @JsonKey(name: 'custom_price')
      @StringOrNumToDoubleConverter()
      this.customPrice,
      @JsonKey(name: 'custom_name') this.customName,
      @JsonKey(name: 'custom_description') this.customDescription,
      @JsonKey(name: 'is_custom') @IntBoolConverter() this.isCustom = false});

  factory _$HoldItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$HoldItemImplFromJson(json);

  @override
  final int? id;
  @override
  final String? code;
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
  final HoldUnit? saleUnit;
  @override
  final double? quantity;
  @override
  @JsonKey(name: 'sub_total')
  final double? subTotal;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
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
    return 'HoldItem(id: $id, code: $code, holdId: $holdId, productId: $productId, productName: $productName, productPrice: $productPrice, netUnitPrice: $netUnitPrice, taxType: $taxType, taxValue: $taxValue, taxAmount: $taxAmount, discountType: $discountType, discountValue: $discountValue, discountAmount: $discountAmount, saleUnit: $saleUnit, quantity: $quantity, subTotal: $subTotal, createdAt: $createdAt, updatedAt: $updatedAt, customCost: $customCost, customPrice: $customPrice, customName: $customName, customDescription: $customDescription, isCustom: $isCustom)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HoldItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
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
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
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
        id,
        code,
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
        createdAt,
        updatedAt,
        customCost,
        customPrice,
        customName,
        customDescription,
        isCustom
      ]);

  /// Create a copy of HoldItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HoldItemImplCopyWith<_$HoldItemImpl> get copyWith =>
      __$$HoldItemImplCopyWithImpl<_$HoldItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HoldItemImplToJson(
      this,
    );
  }
}

abstract class _HoldItem implements HoldItem {
  const factory _HoldItem(
      {final int? id,
      final String? code,
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
      @JsonKey(name: 'sale_unit') final HoldUnit? saleUnit,
      final double? quantity,
      @JsonKey(name: 'sub_total') final double? subTotal,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
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
      final bool isCustom}) = _$HoldItemImpl;

  factory _HoldItem.fromJson(Map<String, dynamic> json) =
      _$HoldItemImpl.fromJson;

  @override
  int? get id;
  @override
  String? get code;
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
  HoldUnit? get saleUnit;
  @override
  double? get quantity;
  @override
  @JsonKey(name: 'sub_total')
  double? get subTotal;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
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

  /// Create a copy of HoldItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HoldItemImplCopyWith<_$HoldItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HoldUnit _$HoldUnitFromJson(Map<String, dynamic> json) {
  return _HoldUnit.fromJson(json);
}

/// @nodoc
mixin _$HoldUnit {
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

  /// Serializes this HoldUnit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HoldUnit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HoldUnitCopyWith<HoldUnit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HoldUnitCopyWith<$Res> {
  factory $HoldUnitCopyWith(HoldUnit value, $Res Function(HoldUnit) then) =
      _$HoldUnitCopyWithImpl<$Res, HoldUnit>;
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
class _$HoldUnitCopyWithImpl<$Res, $Val extends HoldUnit>
    implements $HoldUnitCopyWith<$Res> {
  _$HoldUnitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HoldUnit
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
abstract class _$$HoldUnitImplCopyWith<$Res>
    implements $HoldUnitCopyWith<$Res> {
  factory _$$HoldUnitImplCopyWith(
          _$HoldUnitImpl value, $Res Function(_$HoldUnitImpl) then) =
      __$$HoldUnitImplCopyWithImpl<$Res>;
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
class __$$HoldUnitImplCopyWithImpl<$Res>
    extends _$HoldUnitCopyWithImpl<$Res, _$HoldUnitImpl>
    implements _$$HoldUnitImplCopyWith<$Res> {
  __$$HoldUnitImplCopyWithImpl(
      _$HoldUnitImpl _value, $Res Function(_$HoldUnitImpl) _then)
      : super(_value, _then);

  /// Create a copy of HoldUnit
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
    return _then(_$HoldUnitImpl(
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
class _$HoldUnitImpl implements _HoldUnit {
  const _$HoldUnitImpl(
      {this.id,
      this.name,
      @JsonKey(name: 'short_name') this.shortName,
      @JsonKey(name: 'base_unit') this.baseUnit,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'company_id') this.companyId});

  factory _$HoldUnitImpl.fromJson(Map<String, dynamic> json) =>
      _$$HoldUnitImplFromJson(json);

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
    return 'HoldUnit(id: $id, name: $name, shortName: $shortName, baseUnit: $baseUnit, createdAt: $createdAt, updatedAt: $updatedAt, companyId: $companyId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HoldUnitImpl &&
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

  /// Create a copy of HoldUnit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HoldUnitImplCopyWith<_$HoldUnitImpl> get copyWith =>
      __$$HoldUnitImplCopyWithImpl<_$HoldUnitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HoldUnitImplToJson(
      this,
    );
  }
}

abstract class _HoldUnit implements HoldUnit {
  const factory _HoldUnit(
      {final int? id,
      final String? name,
      @JsonKey(name: 'short_name') final String? shortName,
      @JsonKey(name: 'base_unit') final int? baseUnit,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      @JsonKey(name: 'company_id') final int? companyId}) = _$HoldUnitImpl;

  factory _HoldUnit.fromJson(Map<String, dynamic> json) =
      _$HoldUnitImpl.fromJson;

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

  /// Create a copy of HoldUnit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HoldUnitImplCopyWith<_$HoldUnitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
