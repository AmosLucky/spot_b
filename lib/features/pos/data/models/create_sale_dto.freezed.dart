// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_sale_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreateSaleDto _$CreateSaleDtoFromJson(Map<String, dynamic> json) {
  return _CreateSaleDto.fromJson(json);
}

/// @nodoc
mixin _$CreateSaleDto {
  @JsonKey(name: 'reference_code')
  String? get referenceCode => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_id')
  int? get customerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'warehouse_id')
  int? get warehouseId => throw _privateConstructorUsedError;
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
  SaleStatus? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_status')
  PaymentStatus? get paymentStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_type')
  PaymentType? get paymentType => throw _privateConstructorUsedError;
  @JsonKey(name: 'received_amount')
  double? get receivedAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'paid_amount')
  double? get paidAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'payments')
  List<PaymentDto>? get payments => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'sale_items')
  List<SaleItemDto>? get saleItems => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  @JsonKey(name: 'partial_payment_amount')
  double? get partialPaymentAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'partial_payment_method')
  String? get partialPaymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_id')
  int? get staffId => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_name')
  String? get staffName => throw _privateConstructorUsedError;
  @JsonKey(name: 'attendant_id')
  int? get attendantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'attendant_name')
  String? get attendantName => throw _privateConstructorUsedError;
  @JsonKey(name: 'room_details')
  dynamic get roomDetails => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_offline')
  @IntOrBoolToBoolConverter()
  bool? get isOffline => throw _privateConstructorUsedError;
  @JsonKey(name: 'offline_customer_name')
  String? get offlineCustomerName => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get warehouseName => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get customerName => throw _privateConstructorUsedError;

  /// Serializes this CreateSaleDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateSaleDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateSaleDtoCopyWith<CreateSaleDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateSaleDtoCopyWith<$Res> {
  factory $CreateSaleDtoCopyWith(
          CreateSaleDto value, $Res Function(CreateSaleDto) then) =
      _$CreateSaleDtoCopyWithImpl<$Res, CreateSaleDto>;
  @useResult
  $Res call(
      {@JsonKey(name: 'reference_code') String? referenceCode,
      DateTime? date,
      @JsonKey(name: 'customer_id') int? customerId,
      @JsonKey(name: 'warehouse_id') int? warehouseId,
      @JsonKey(name: 'tax_rate') double? taxRate,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      double? discount,
      @JsonKey(name: 'discount_amount') double? discountAmount,
      double? shipping,
      @JsonKey(name: 'grand_total') double? grandTotal,
      SaleStatus? status,
      @JsonKey(name: 'payment_status') PaymentStatus? paymentStatus,
      @JsonKey(name: 'payment_type') PaymentType? paymentType,
      @JsonKey(name: 'received_amount') double? receivedAmount,
      @JsonKey(name: 'paid_amount') double? paidAmount,
      @JsonKey(name: 'payments') List<PaymentDto>? payments,
      String? notes,
      @JsonKey(name: 'sale_items') List<SaleItemDto>? saleItems,
      String? note,
      @JsonKey(name: 'partial_payment_amount') double? partialPaymentAmount,
      @JsonKey(name: 'partial_payment_method') String? partialPaymentMethod,
      @JsonKey(name: 'staff_id') int? staffId,
      @JsonKey(name: 'staff_name') String? staffName,
      @JsonKey(name: 'attendant_id') int? attendantId,
      @JsonKey(name: 'attendant_name') String? attendantName,
      @JsonKey(name: 'room_details') dynamic roomDetails,
      @JsonKey(name: 'is_offline') @IntOrBoolToBoolConverter() bool? isOffline,
      @JsonKey(name: 'offline_customer_name') String? offlineCustomerName,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? warehouseName,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? customerName});
}

/// @nodoc
class _$CreateSaleDtoCopyWithImpl<$Res, $Val extends CreateSaleDto>
    implements $CreateSaleDtoCopyWith<$Res> {
  _$CreateSaleDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateSaleDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referenceCode = freezed,
    Object? date = freezed,
    Object? customerId = freezed,
    Object? warehouseId = freezed,
    Object? taxRate = freezed,
    Object? taxAmount = freezed,
    Object? discount = freezed,
    Object? discountAmount = freezed,
    Object? shipping = freezed,
    Object? grandTotal = freezed,
    Object? status = freezed,
    Object? paymentStatus = freezed,
    Object? paymentType = freezed,
    Object? receivedAmount = freezed,
    Object? paidAmount = freezed,
    Object? payments = freezed,
    Object? notes = freezed,
    Object? saleItems = freezed,
    Object? note = freezed,
    Object? partialPaymentAmount = freezed,
    Object? partialPaymentMethod = freezed,
    Object? staffId = freezed,
    Object? staffName = freezed,
    Object? attendantId = freezed,
    Object? attendantName = freezed,
    Object? roomDetails = freezed,
    Object? isOffline = freezed,
    Object? offlineCustomerName = freezed,
    Object? warehouseName = freezed,
    Object? customerName = freezed,
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
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SaleStatus?,
      paymentStatus: freezed == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as PaymentStatus?,
      paymentType: freezed == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as PaymentType?,
      receivedAmount: freezed == receivedAmount
          ? _value.receivedAmount
          : receivedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      payments: freezed == payments
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<PaymentDto>?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      saleItems: freezed == saleItems
          ? _value.saleItems
          : saleItems // ignore: cast_nullable_to_non_nullable
              as List<SaleItemDto>?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      partialPaymentAmount: freezed == partialPaymentAmount
          ? _value.partialPaymentAmount
          : partialPaymentAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      partialPaymentMethod: freezed == partialPaymentMethod
          ? _value.partialPaymentMethod
          : partialPaymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      staffId: freezed == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int?,
      staffName: freezed == staffName
          ? _value.staffName
          : staffName // ignore: cast_nullable_to_non_nullable
              as String?,
      attendantId: freezed == attendantId
          ? _value.attendantId
          : attendantId // ignore: cast_nullable_to_non_nullable
              as int?,
      attendantName: freezed == attendantName
          ? _value.attendantName
          : attendantName // ignore: cast_nullable_to_non_nullable
              as String?,
      roomDetails: freezed == roomDetails
          ? _value.roomDetails
          : roomDetails // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isOffline: freezed == isOffline
          ? _value.isOffline
          : isOffline // ignore: cast_nullable_to_non_nullable
              as bool?,
      offlineCustomerName: freezed == offlineCustomerName
          ? _value.offlineCustomerName
          : offlineCustomerName // ignore: cast_nullable_to_non_nullable
              as String?,
      warehouseName: freezed == warehouseName
          ? _value.warehouseName
          : warehouseName // ignore: cast_nullable_to_non_nullable
              as String?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateSaleDtoImplCopyWith<$Res>
    implements $CreateSaleDtoCopyWith<$Res> {
  factory _$$CreateSaleDtoImplCopyWith(
          _$CreateSaleDtoImpl value, $Res Function(_$CreateSaleDtoImpl) then) =
      __$$CreateSaleDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'reference_code') String? referenceCode,
      DateTime? date,
      @JsonKey(name: 'customer_id') int? customerId,
      @JsonKey(name: 'warehouse_id') int? warehouseId,
      @JsonKey(name: 'tax_rate') double? taxRate,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      double? discount,
      @JsonKey(name: 'discount_amount') double? discountAmount,
      double? shipping,
      @JsonKey(name: 'grand_total') double? grandTotal,
      SaleStatus? status,
      @JsonKey(name: 'payment_status') PaymentStatus? paymentStatus,
      @JsonKey(name: 'payment_type') PaymentType? paymentType,
      @JsonKey(name: 'received_amount') double? receivedAmount,
      @JsonKey(name: 'paid_amount') double? paidAmount,
      @JsonKey(name: 'payments') List<PaymentDto>? payments,
      String? notes,
      @JsonKey(name: 'sale_items') List<SaleItemDto>? saleItems,
      String? note,
      @JsonKey(name: 'partial_payment_amount') double? partialPaymentAmount,
      @JsonKey(name: 'partial_payment_method') String? partialPaymentMethod,
      @JsonKey(name: 'staff_id') int? staffId,
      @JsonKey(name: 'staff_name') String? staffName,
      @JsonKey(name: 'attendant_id') int? attendantId,
      @JsonKey(name: 'attendant_name') String? attendantName,
      @JsonKey(name: 'room_details') dynamic roomDetails,
      @JsonKey(name: 'is_offline') @IntOrBoolToBoolConverter() bool? isOffline,
      @JsonKey(name: 'offline_customer_name') String? offlineCustomerName,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? warehouseName,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? customerName});
}

/// @nodoc
class __$$CreateSaleDtoImplCopyWithImpl<$Res>
    extends _$CreateSaleDtoCopyWithImpl<$Res, _$CreateSaleDtoImpl>
    implements _$$CreateSaleDtoImplCopyWith<$Res> {
  __$$CreateSaleDtoImplCopyWithImpl(
      _$CreateSaleDtoImpl _value, $Res Function(_$CreateSaleDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateSaleDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referenceCode = freezed,
    Object? date = freezed,
    Object? customerId = freezed,
    Object? warehouseId = freezed,
    Object? taxRate = freezed,
    Object? taxAmount = freezed,
    Object? discount = freezed,
    Object? discountAmount = freezed,
    Object? shipping = freezed,
    Object? grandTotal = freezed,
    Object? status = freezed,
    Object? paymentStatus = freezed,
    Object? paymentType = freezed,
    Object? receivedAmount = freezed,
    Object? paidAmount = freezed,
    Object? payments = freezed,
    Object? notes = freezed,
    Object? saleItems = freezed,
    Object? note = freezed,
    Object? partialPaymentAmount = freezed,
    Object? partialPaymentMethod = freezed,
    Object? staffId = freezed,
    Object? staffName = freezed,
    Object? attendantId = freezed,
    Object? attendantName = freezed,
    Object? roomDetails = freezed,
    Object? isOffline = freezed,
    Object? offlineCustomerName = freezed,
    Object? warehouseName = freezed,
    Object? customerName = freezed,
  }) {
    return _then(_$CreateSaleDtoImpl(
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
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SaleStatus?,
      paymentStatus: freezed == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as PaymentStatus?,
      paymentType: freezed == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as PaymentType?,
      receivedAmount: freezed == receivedAmount
          ? _value.receivedAmount
          : receivedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      payments: freezed == payments
          ? _value._payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<PaymentDto>?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      saleItems: freezed == saleItems
          ? _value._saleItems
          : saleItems // ignore: cast_nullable_to_non_nullable
              as List<SaleItemDto>?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      partialPaymentAmount: freezed == partialPaymentAmount
          ? _value.partialPaymentAmount
          : partialPaymentAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      partialPaymentMethod: freezed == partialPaymentMethod
          ? _value.partialPaymentMethod
          : partialPaymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      staffId: freezed == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int?,
      staffName: freezed == staffName
          ? _value.staffName
          : staffName // ignore: cast_nullable_to_non_nullable
              as String?,
      attendantId: freezed == attendantId
          ? _value.attendantId
          : attendantId // ignore: cast_nullable_to_non_nullable
              as int?,
      attendantName: freezed == attendantName
          ? _value.attendantName
          : attendantName // ignore: cast_nullable_to_non_nullable
              as String?,
      roomDetails: freezed == roomDetails
          ? _value.roomDetails
          : roomDetails // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isOffline: freezed == isOffline
          ? _value.isOffline
          : isOffline // ignore: cast_nullable_to_non_nullable
              as bool?,
      offlineCustomerName: freezed == offlineCustomerName
          ? _value.offlineCustomerName
          : offlineCustomerName // ignore: cast_nullable_to_non_nullable
              as String?,
      warehouseName: freezed == warehouseName
          ? _value.warehouseName
          : warehouseName // ignore: cast_nullable_to_non_nullable
              as String?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateSaleDtoImpl implements _CreateSaleDto {
  const _$CreateSaleDtoImpl(
      {@JsonKey(name: 'reference_code') this.referenceCode,
      this.date,
      @JsonKey(name: 'customer_id') this.customerId,
      @JsonKey(name: 'warehouse_id') this.warehouseId,
      @JsonKey(name: 'tax_rate') this.taxRate,
      @JsonKey(name: 'tax_amount') this.taxAmount,
      this.discount,
      @JsonKey(name: 'discount_amount') this.discountAmount,
      this.shipping,
      @JsonKey(name: 'grand_total') this.grandTotal,
      this.status,
      @JsonKey(name: 'payment_status') this.paymentStatus,
      @JsonKey(name: 'payment_type') this.paymentType,
      @JsonKey(name: 'received_amount') this.receivedAmount,
      @JsonKey(name: 'paid_amount') this.paidAmount,
      @JsonKey(name: 'payments') final List<PaymentDto>? payments,
      this.notes,
      @JsonKey(name: 'sale_items') final List<SaleItemDto>? saleItems,
      this.note,
      @JsonKey(name: 'partial_payment_amount') this.partialPaymentAmount,
      @JsonKey(name: 'partial_payment_method') this.partialPaymentMethod,
      @JsonKey(name: 'staff_id') this.staffId,
      @JsonKey(name: 'staff_name') this.staffName,
      @JsonKey(name: 'attendant_id') this.attendantId,
      @JsonKey(name: 'attendant_name') this.attendantName,
      @JsonKey(name: 'room_details') this.roomDetails,
      @JsonKey(name: 'is_offline')
      @IntOrBoolToBoolConverter()
      this.isOffline = false,
      @JsonKey(name: 'offline_customer_name') this.offlineCustomerName,
      @JsonKey(includeFromJson: false, includeToJson: false) this.warehouseName,
      @JsonKey(includeFromJson: false, includeToJson: false) this.customerName})
      : _payments = payments,
        _saleItems = saleItems;

  factory _$CreateSaleDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateSaleDtoImplFromJson(json);

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
  final SaleStatus? status;
  @override
  @JsonKey(name: 'payment_status')
  final PaymentStatus? paymentStatus;
  @override
  @JsonKey(name: 'payment_type')
  final PaymentType? paymentType;
  @override
  @JsonKey(name: 'received_amount')
  final double? receivedAmount;
  @override
  @JsonKey(name: 'paid_amount')
  final double? paidAmount;
  final List<PaymentDto>? _payments;
  @override
  @JsonKey(name: 'payments')
  List<PaymentDto>? get payments {
    final value = _payments;
    if (value == null) return null;
    if (_payments is EqualUnmodifiableListView) return _payments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? notes;
  final List<SaleItemDto>? _saleItems;
  @override
  @JsonKey(name: 'sale_items')
  List<SaleItemDto>? get saleItems {
    final value = _saleItems;
    if (value == null) return null;
    if (_saleItems is EqualUnmodifiableListView) return _saleItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? note;
  @override
  @JsonKey(name: 'partial_payment_amount')
  final double? partialPaymentAmount;
  @override
  @JsonKey(name: 'partial_payment_method')
  final String? partialPaymentMethod;
  @override
  @JsonKey(name: 'staff_id')
  final int? staffId;
  @override
  @JsonKey(name: 'staff_name')
  final String? staffName;
  @override
  @JsonKey(name: 'attendant_id')
  final int? attendantId;
  @override
  @JsonKey(name: 'attendant_name')
  final String? attendantName;
  @override
  @JsonKey(name: 'room_details')
  final dynamic roomDetails;
  @override
  @JsonKey(name: 'is_offline')
  @IntOrBoolToBoolConverter()
  final bool? isOffline;
  @override
  @JsonKey(name: 'offline_customer_name')
  final String? offlineCustomerName;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? warehouseName;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? customerName;

  @override
  String toString() {
    return 'CreateSaleDto(referenceCode: $referenceCode, date: $date, customerId: $customerId, warehouseId: $warehouseId, taxRate: $taxRate, taxAmount: $taxAmount, discount: $discount, discountAmount: $discountAmount, shipping: $shipping, grandTotal: $grandTotal, status: $status, paymentStatus: $paymentStatus, paymentType: $paymentType, receivedAmount: $receivedAmount, paidAmount: $paidAmount, payments: $payments, notes: $notes, saleItems: $saleItems, note: $note, partialPaymentAmount: $partialPaymentAmount, partialPaymentMethod: $partialPaymentMethod, staffId: $staffId, staffName: $staffName, attendantId: $attendantId, attendantName: $attendantName, roomDetails: $roomDetails, isOffline: $isOffline, offlineCustomerName: $offlineCustomerName, warehouseName: $warehouseName, customerName: $customerName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateSaleDtoImpl &&
            (identical(other.referenceCode, referenceCode) ||
                other.referenceCode == referenceCode) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId) &&
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
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.paymentType, paymentType) ||
                other.paymentType == paymentType) &&
            (identical(other.receivedAmount, receivedAmount) ||
                other.receivedAmount == receivedAmount) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            const DeepCollectionEquality().equals(other._payments, _payments) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._saleItems, _saleItems) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.partialPaymentAmount, partialPaymentAmount) ||
                other.partialPaymentAmount == partialPaymentAmount) &&
            (identical(other.partialPaymentMethod, partialPaymentMethod) ||
                other.partialPaymentMethod == partialPaymentMethod) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.staffName, staffName) ||
                other.staffName == staffName) &&
            (identical(other.attendantId, attendantId) ||
                other.attendantId == attendantId) &&
            (identical(other.attendantName, attendantName) ||
                other.attendantName == attendantName) &&
            const DeepCollectionEquality()
                .equals(other.roomDetails, roomDetails) &&
            (identical(other.isOffline, isOffline) ||
                other.isOffline == isOffline) &&
            (identical(other.offlineCustomerName, offlineCustomerName) ||
                other.offlineCustomerName == offlineCustomerName) &&
            (identical(other.warehouseName, warehouseName) ||
                other.warehouseName == warehouseName) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        referenceCode,
        date,
        customerId,
        warehouseId,
        taxRate,
        taxAmount,
        discount,
        discountAmount,
        shipping,
        grandTotal,
        status,
        paymentStatus,
        paymentType,
        receivedAmount,
        paidAmount,
        const DeepCollectionEquality().hash(_payments),
        notes,
        const DeepCollectionEquality().hash(_saleItems),
        note,
        partialPaymentAmount,
        partialPaymentMethod,
        staffId,
        staffName,
        attendantId,
        attendantName,
        const DeepCollectionEquality().hash(roomDetails),
        isOffline,
        offlineCustomerName,
        warehouseName,
        customerName
      ]);

  /// Create a copy of CreateSaleDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateSaleDtoImplCopyWith<_$CreateSaleDtoImpl> get copyWith =>
      __$$CreateSaleDtoImplCopyWithImpl<_$CreateSaleDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateSaleDtoImplToJson(
      this,
    );
  }
}

abstract class _CreateSaleDto implements CreateSaleDto {
  const factory _CreateSaleDto(
      {@JsonKey(name: 'reference_code') final String? referenceCode,
      final DateTime? date,
      @JsonKey(name: 'customer_id') final int? customerId,
      @JsonKey(name: 'warehouse_id') final int? warehouseId,
      @JsonKey(name: 'tax_rate') final double? taxRate,
      @JsonKey(name: 'tax_amount') final double? taxAmount,
      final double? discount,
      @JsonKey(name: 'discount_amount') final double? discountAmount,
      final double? shipping,
      @JsonKey(name: 'grand_total') final double? grandTotal,
      final SaleStatus? status,
      @JsonKey(name: 'payment_status') final PaymentStatus? paymentStatus,
      @JsonKey(name: 'payment_type') final PaymentType? paymentType,
      @JsonKey(name: 'received_amount') final double? receivedAmount,
      @JsonKey(name: 'paid_amount') final double? paidAmount,
      @JsonKey(name: 'payments') final List<PaymentDto>? payments,
      final String? notes,
      @JsonKey(name: 'sale_items') final List<SaleItemDto>? saleItems,
      final String? note,
      @JsonKey(name: 'partial_payment_amount')
      final double? partialPaymentAmount,
      @JsonKey(name: 'partial_payment_method')
      final String? partialPaymentMethod,
      @JsonKey(name: 'staff_id') final int? staffId,
      @JsonKey(name: 'staff_name') final String? staffName,
      @JsonKey(name: 'attendant_id') final int? attendantId,
      @JsonKey(name: 'attendant_name') final String? attendantName,
      @JsonKey(name: 'room_details') final dynamic roomDetails,
      @JsonKey(name: 'is_offline')
      @IntOrBoolToBoolConverter()
      final bool? isOffline,
      @JsonKey(name: 'offline_customer_name') final String? offlineCustomerName,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final String? warehouseName,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final String? customerName}) = _$CreateSaleDtoImpl;

  factory _CreateSaleDto.fromJson(Map<String, dynamic> json) =
      _$CreateSaleDtoImpl.fromJson;

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
  SaleStatus? get status;
  @override
  @JsonKey(name: 'payment_status')
  PaymentStatus? get paymentStatus;
  @override
  @JsonKey(name: 'payment_type')
  PaymentType? get paymentType;
  @override
  @JsonKey(name: 'received_amount')
  double? get receivedAmount;
  @override
  @JsonKey(name: 'paid_amount')
  double? get paidAmount;
  @override
  @JsonKey(name: 'payments')
  List<PaymentDto>? get payments;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'sale_items')
  List<SaleItemDto>? get saleItems;
  @override
  String? get note;
  @override
  @JsonKey(name: 'partial_payment_amount')
  double? get partialPaymentAmount;
  @override
  @JsonKey(name: 'partial_payment_method')
  String? get partialPaymentMethod;
  @override
  @JsonKey(name: 'staff_id')
  int? get staffId;
  @override
  @JsonKey(name: 'staff_name')
  String? get staffName;
  @override
  @JsonKey(name: 'attendant_id')
  int? get attendantId;
  @override
  @JsonKey(name: 'attendant_name')
  String? get attendantName;
  @override
  @JsonKey(name: 'room_details')
  dynamic get roomDetails;
  @override
  @JsonKey(name: 'is_offline')
  @IntOrBoolToBoolConverter()
  bool? get isOffline;
  @override
  @JsonKey(name: 'offline_customer_name')
  String? get offlineCustomerName;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get warehouseName;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get customerName;

  /// Create a copy of CreateSaleDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateSaleDtoImplCopyWith<_$CreateSaleDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentDto _$PaymentDtoFromJson(Map<String, dynamic> json) {
  return _PaymentDto.fromJson(json);
}

/// @nodoc
mixin _$PaymentDto {
  @JsonKey(name: 'payment_type')
  PaymentType? get paymentType => throw _privateConstructorUsedError;
  @JsonKey(name: 'amount')
  double? get amount => throw _privateConstructorUsedError;

  /// Serializes this PaymentDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentDtoCopyWith<PaymentDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentDtoCopyWith<$Res> {
  factory $PaymentDtoCopyWith(
          PaymentDto value, $Res Function(PaymentDto) then) =
      _$PaymentDtoCopyWithImpl<$Res, PaymentDto>;
  @useResult
  $Res call(
      {@JsonKey(name: 'payment_type') PaymentType? paymentType,
      @JsonKey(name: 'amount') double? amount});
}

/// @nodoc
class _$PaymentDtoCopyWithImpl<$Res, $Val extends PaymentDto>
    implements $PaymentDtoCopyWith<$Res> {
  _$PaymentDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentType = freezed,
    Object? amount = freezed,
  }) {
    return _then(_value.copyWith(
      paymentType: freezed == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as PaymentType?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentDtoImplCopyWith<$Res>
    implements $PaymentDtoCopyWith<$Res> {
  factory _$$PaymentDtoImplCopyWith(
          _$PaymentDtoImpl value, $Res Function(_$PaymentDtoImpl) then) =
      __$$PaymentDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'payment_type') PaymentType? paymentType,
      @JsonKey(name: 'amount') double? amount});
}

/// @nodoc
class __$$PaymentDtoImplCopyWithImpl<$Res>
    extends _$PaymentDtoCopyWithImpl<$Res, _$PaymentDtoImpl>
    implements _$$PaymentDtoImplCopyWith<$Res> {
  __$$PaymentDtoImplCopyWithImpl(
      _$PaymentDtoImpl _value, $Res Function(_$PaymentDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentType = freezed,
    Object? amount = freezed,
  }) {
    return _then(_$PaymentDtoImpl(
      paymentType: freezed == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as PaymentType?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentDtoImpl implements _PaymentDto {
  const _$PaymentDtoImpl(
      {@JsonKey(name: 'payment_type') this.paymentType,
      @JsonKey(name: 'amount') this.amount});

  factory _$PaymentDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentDtoImplFromJson(json);

  @override
  @JsonKey(name: 'payment_type')
  final PaymentType? paymentType;
  @override
  @JsonKey(name: 'amount')
  final double? amount;

  @override
  String toString() {
    return 'PaymentDto(paymentType: $paymentType, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentDtoImpl &&
            (identical(other.paymentType, paymentType) ||
                other.paymentType == paymentType) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, paymentType, amount);

  /// Create a copy of PaymentDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentDtoImplCopyWith<_$PaymentDtoImpl> get copyWith =>
      __$$PaymentDtoImplCopyWithImpl<_$PaymentDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentDtoImplToJson(
      this,
    );
  }
}

abstract class _PaymentDto implements PaymentDto {
  const factory _PaymentDto(
      {@JsonKey(name: 'payment_type') final PaymentType? paymentType,
      @JsonKey(name: 'amount') final double? amount}) = _$PaymentDtoImpl;

  factory _PaymentDto.fromJson(Map<String, dynamic> json) =
      _$PaymentDtoImpl.fromJson;

  @override
  @JsonKey(name: 'payment_type')
  PaymentType? get paymentType;
  @override
  @JsonKey(name: 'amount')
  double? get amount;

  /// Create a copy of PaymentDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentDtoImplCopyWith<_$PaymentDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleItemDto _$SaleItemDtoFromJson(Map<String, dynamic> json) {
  return _SaleItemDto.fromJson(json);
}

/// @nodoc
mixin _$SaleItemDto {
  @JsonKey(name: 'product_id')
  int? get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'table_id')
  int? get tableId => throw _privateConstructorUsedError;
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
  dynamic get saleUnit => throw _privateConstructorUsedError;
  @JsonKey(name: 'quantity')
  double? get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_total')
  double? get subTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_custom', fromJson: _toBool, toJson: _fromBool)
  bool? get isCustom => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_cost')
  double? get customCost => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_description')
  String? get customDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_name')
  String? get customName => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_price')
  double? get customPrice => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get productName => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get productCode => throw _privateConstructorUsedError;

  /// Serializes this SaleItemDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleItemDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleItemDtoCopyWith<SaleItemDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleItemDtoCopyWith<$Res> {
  factory $SaleItemDtoCopyWith(
          SaleItemDto value, $Res Function(SaleItemDto) then) =
      _$SaleItemDtoCopyWithImpl<$Res, SaleItemDto>;
  @useResult
  $Res call(
      {@JsonKey(name: 'product_id') int? productId,
      @JsonKey(name: 'table_id') int? tableId,
      @JsonKey(name: 'product_price') double? productPrice,
      @JsonKey(name: 'net_unit_price') double? netUnitPrice,
      @JsonKey(name: 'tax_type') int? taxType,
      @JsonKey(name: 'tax_value') double? taxValue,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      @JsonKey(name: 'discount_type') int? discountType,
      @JsonKey(name: 'discount_value') double? discountValue,
      @JsonKey(name: 'discount_amount') double? discountAmount,
      @JsonKey(name: 'sale_unit') dynamic saleUnit,
      @JsonKey(name: 'quantity') double? quantity,
      @JsonKey(name: 'sub_total') double? subTotal,
      @JsonKey(name: 'is_custom', fromJson: _toBool, toJson: _fromBool)
      bool? isCustom,
      @JsonKey(name: 'custom_cost') double? customCost,
      @JsonKey(name: 'custom_description') String? customDescription,
      @JsonKey(name: 'custom_name') String? customName,
      @JsonKey(name: 'custom_price') double? customPrice,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? productName,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? productCode});
}

/// @nodoc
class _$SaleItemDtoCopyWithImpl<$Res, $Val extends SaleItemDto>
    implements $SaleItemDtoCopyWith<$Res> {
  _$SaleItemDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleItemDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = freezed,
    Object? tableId = freezed,
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
    Object? isCustom = freezed,
    Object? customCost = freezed,
    Object? customDescription = freezed,
    Object? customName = freezed,
    Object? customPrice = freezed,
    Object? productName = freezed,
    Object? productCode = freezed,
  }) {
    return _then(_value.copyWith(
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      tableId: freezed == tableId
          ? _value.tableId
          : tableId // ignore: cast_nullable_to_non_nullable
              as int?,
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
              as dynamic,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      subTotal: freezed == subTotal
          ? _value.subTotal
          : subTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      isCustom: freezed == isCustom
          ? _value.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool?,
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
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      productCode: freezed == productCode
          ? _value.productCode
          : productCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SaleItemDtoImplCopyWith<$Res>
    implements $SaleItemDtoCopyWith<$Res> {
  factory _$$SaleItemDtoImplCopyWith(
          _$SaleItemDtoImpl value, $Res Function(_$SaleItemDtoImpl) then) =
      __$$SaleItemDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'product_id') int? productId,
      @JsonKey(name: 'table_id') int? tableId,
      @JsonKey(name: 'product_price') double? productPrice,
      @JsonKey(name: 'net_unit_price') double? netUnitPrice,
      @JsonKey(name: 'tax_type') int? taxType,
      @JsonKey(name: 'tax_value') double? taxValue,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      @JsonKey(name: 'discount_type') int? discountType,
      @JsonKey(name: 'discount_value') double? discountValue,
      @JsonKey(name: 'discount_amount') double? discountAmount,
      @JsonKey(name: 'sale_unit') dynamic saleUnit,
      @JsonKey(name: 'quantity') double? quantity,
      @JsonKey(name: 'sub_total') double? subTotal,
      @JsonKey(name: 'is_custom', fromJson: _toBool, toJson: _fromBool)
      bool? isCustom,
      @JsonKey(name: 'custom_cost') double? customCost,
      @JsonKey(name: 'custom_description') String? customDescription,
      @JsonKey(name: 'custom_name') String? customName,
      @JsonKey(name: 'custom_price') double? customPrice,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? productName,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? productCode});
}

/// @nodoc
class __$$SaleItemDtoImplCopyWithImpl<$Res>
    extends _$SaleItemDtoCopyWithImpl<$Res, _$SaleItemDtoImpl>
    implements _$$SaleItemDtoImplCopyWith<$Res> {
  __$$SaleItemDtoImplCopyWithImpl(
      _$SaleItemDtoImpl _value, $Res Function(_$SaleItemDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaleItemDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = freezed,
    Object? tableId = freezed,
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
    Object? isCustom = freezed,
    Object? customCost = freezed,
    Object? customDescription = freezed,
    Object? customName = freezed,
    Object? customPrice = freezed,
    Object? productName = freezed,
    Object? productCode = freezed,
  }) {
    return _then(_$SaleItemDtoImpl(
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      tableId: freezed == tableId
          ? _value.tableId
          : tableId // ignore: cast_nullable_to_non_nullable
              as int?,
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
              as dynamic,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      subTotal: freezed == subTotal
          ? _value.subTotal
          : subTotal // ignore: cast_nullable_to_non_nullable
              as double?,
      isCustom: freezed == isCustom
          ? _value.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool?,
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
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      productCode: freezed == productCode
          ? _value.productCode
          : productCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleItemDtoImpl implements _SaleItemDto {
  const _$SaleItemDtoImpl(
      {@JsonKey(name: 'product_id') required this.productId,
      @JsonKey(name: 'table_id') this.tableId,
      @JsonKey(name: 'product_price') this.productPrice,
      @JsonKey(name: 'net_unit_price') this.netUnitPrice,
      @JsonKey(name: 'tax_type') this.taxType,
      @JsonKey(name: 'tax_value') this.taxValue,
      @JsonKey(name: 'tax_amount') this.taxAmount,
      @JsonKey(name: 'discount_type') this.discountType,
      @JsonKey(name: 'discount_value') this.discountValue,
      @JsonKey(name: 'discount_amount') this.discountAmount,
      @JsonKey(name: 'sale_unit') this.saleUnit,
      @JsonKey(name: 'quantity') this.quantity,
      @JsonKey(name: 'sub_total') this.subTotal,
      @JsonKey(name: 'is_custom', fromJson: _toBool, toJson: _fromBool)
      this.isCustom,
      @JsonKey(name: 'custom_cost') this.customCost,
      @JsonKey(name: 'custom_description') this.customDescription,
      @JsonKey(name: 'custom_name') this.customName,
      @JsonKey(name: 'custom_price') this.customPrice,
      @JsonKey(includeFromJson: false, includeToJson: false) this.productName,
      @JsonKey(includeFromJson: false, includeToJson: false) this.productCode});

  factory _$SaleItemDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleItemDtoImplFromJson(json);

  @override
  @JsonKey(name: 'product_id')
  final int? productId;
  @override
  @JsonKey(name: 'table_id')
  final int? tableId;
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
  final dynamic saleUnit;
  @override
  @JsonKey(name: 'quantity')
  final double? quantity;
  @override
  @JsonKey(name: 'sub_total')
  final double? subTotal;
  @override
  @JsonKey(name: 'is_custom', fromJson: _toBool, toJson: _fromBool)
  final bool? isCustom;
  @override
  @JsonKey(name: 'custom_cost')
  final double? customCost;
  @override
  @JsonKey(name: 'custom_description')
  final String? customDescription;
  @override
  @JsonKey(name: 'custom_name')
  final String? customName;
  @override
  @JsonKey(name: 'custom_price')
  final double? customPrice;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? productName;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? productCode;

  @override
  String toString() {
    return 'SaleItemDto(productId: $productId, tableId: $tableId, productPrice: $productPrice, netUnitPrice: $netUnitPrice, taxType: $taxType, taxValue: $taxValue, taxAmount: $taxAmount, discountType: $discountType, discountValue: $discountValue, discountAmount: $discountAmount, saleUnit: $saleUnit, quantity: $quantity, subTotal: $subTotal, isCustom: $isCustom, customCost: $customCost, customDescription: $customDescription, customName: $customName, customPrice: $customPrice, productName: $productName, productCode: $productCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleItemDtoImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
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
            const DeepCollectionEquality().equals(other.saleUnit, saleUnit) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.subTotal, subTotal) ||
                other.subTotal == subTotal) &&
            (identical(other.isCustom, isCustom) ||
                other.isCustom == isCustom) &&
            (identical(other.customCost, customCost) ||
                other.customCost == customCost) &&
            (identical(other.customDescription, customDescription) ||
                other.customDescription == customDescription) &&
            (identical(other.customName, customName) ||
                other.customName == customName) &&
            (identical(other.customPrice, customPrice) ||
                other.customPrice == customPrice) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productCode, productCode) ||
                other.productCode == productCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        productId,
        tableId,
        productPrice,
        netUnitPrice,
        taxType,
        taxValue,
        taxAmount,
        discountType,
        discountValue,
        discountAmount,
        const DeepCollectionEquality().hash(saleUnit),
        quantity,
        subTotal,
        isCustom,
        customCost,
        customDescription,
        customName,
        customPrice,
        productName,
        productCode
      ]);

  /// Create a copy of SaleItemDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleItemDtoImplCopyWith<_$SaleItemDtoImpl> get copyWith =>
      __$$SaleItemDtoImplCopyWithImpl<_$SaleItemDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleItemDtoImplToJson(
      this,
    );
  }
}

abstract class _SaleItemDto implements SaleItemDto {
  const factory _SaleItemDto(
      {@JsonKey(name: 'product_id') required final int? productId,
      @JsonKey(name: 'table_id') final int? tableId,
      @JsonKey(name: 'product_price') final double? productPrice,
      @JsonKey(name: 'net_unit_price') final double? netUnitPrice,
      @JsonKey(name: 'tax_type') final int? taxType,
      @JsonKey(name: 'tax_value') final double? taxValue,
      @JsonKey(name: 'tax_amount') final double? taxAmount,
      @JsonKey(name: 'discount_type') final int? discountType,
      @JsonKey(name: 'discount_value') final double? discountValue,
      @JsonKey(name: 'discount_amount') final double? discountAmount,
      @JsonKey(name: 'sale_unit') final dynamic saleUnit,
      @JsonKey(name: 'quantity') final double? quantity,
      @JsonKey(name: 'sub_total') final double? subTotal,
      @JsonKey(name: 'is_custom', fromJson: _toBool, toJson: _fromBool)
      final bool? isCustom,
      @JsonKey(name: 'custom_cost') final double? customCost,
      @JsonKey(name: 'custom_description') final String? customDescription,
      @JsonKey(name: 'custom_name') final String? customName,
      @JsonKey(name: 'custom_price') final double? customPrice,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final String? productName,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final String? productCode}) = _$SaleItemDtoImpl;

  factory _SaleItemDto.fromJson(Map<String, dynamic> json) =
      _$SaleItemDtoImpl.fromJson;

  @override
  @JsonKey(name: 'product_id')
  int? get productId;
  @override
  @JsonKey(name: 'table_id')
  int? get tableId;
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
  dynamic get saleUnit;
  @override
  @JsonKey(name: 'quantity')
  double? get quantity;
  @override
  @JsonKey(name: 'sub_total')
  double? get subTotal;
  @override
  @JsonKey(name: 'is_custom', fromJson: _toBool, toJson: _fromBool)
  bool? get isCustom;
  @override
  @JsonKey(name: 'custom_cost')
  double? get customCost;
  @override
  @JsonKey(name: 'custom_description')
  String? get customDescription;
  @override
  @JsonKey(name: 'custom_name')
  String? get customName;
  @override
  @JsonKey(name: 'custom_price')
  double? get customPrice;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get productName;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get productCode;

  /// Create a copy of SaleItemDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleItemDtoImplCopyWith<_$SaleItemDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
