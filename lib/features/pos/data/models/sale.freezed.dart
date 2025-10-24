// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Sale _$SaleFromJson(Map<String, dynamic> json) {
  return _Sale.fromJson(json);
}

/// @nodoc
mixin _$Sale {
  int? get id => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  Map<String, dynamic>? get links => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_return')
  int? get isReturn => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_id')
  int? get customerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'company_id')
  int? get companyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'logged_user')
  SaleLoggedUser? get loggedUser => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_name')
  String? get customerName => throw _privateConstructorUsedError;
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
  @JsonKey(name: 'discount_amount')
  double? get discountAmount => throw _privateConstructorUsedError;
  double? get shipping => throw _privateConstructorUsedError;
  @JsonKey(name: 'grand_total')
  double? get grandTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'received_amount')
  double? get receivedAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'paid_amount')
  double? get paidAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'partial_amount')
  double? get partialAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'due_amount')
  double? get dueAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_type')
  PaymentType? get paymentType => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  SaleStatus? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_status')
  PaymentStatus? get paymentStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'reference_code')
  String? get referenceCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'sale_items')
  List<SaleItem>? get saleItems => throw _privateConstructorUsedError;
  List<SalePayment>? get payments => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_methods')
  List<String>? get paymentMethods => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'barcode_url')
  String? get barcodeUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_offline')
  int get isOffline => throw _privateConstructorUsedError;
  @JsonKey(name: 'offline_customer_name')
  String? get offlineCustomerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_id')
  int? get staffId => throw _privateConstructorUsedError;
  @JsonKey(name: 'attendant_name')
  String? get attendantName => throw _privateConstructorUsedError;
  @JsonKey(name: 'room_details')
  dynamic get roomDetails => throw _privateConstructorUsedError;
  @JsonKey(name: 'attendant_id')
  int? get attendantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'partial_payment_method')
  String? get partialPaymentMethod => throw _privateConstructorUsedError;

  /// Serializes this Sale to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleCopyWith<Sale> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleCopyWith<$Res> {
  factory $SaleCopyWith(Sale value, $Res Function(Sale) then) =
      _$SaleCopyWithImpl<$Res, Sale>;
  @useResult
  $Res call(
      {int? id,
      String? type,
      Map<String, dynamic>? links,
      DateTime? date,
      @JsonKey(name: 'is_return') int? isReturn,
      @JsonKey(name: 'customer_id') int? customerId,
      @JsonKey(name: 'company_id') int? companyId,
      @JsonKey(name: 'logged_user') SaleLoggedUser? loggedUser,
      @JsonKey(name: 'customer_name') String? customerName,
      @JsonKey(name: 'staff_name') String? staffName,
      @JsonKey(name: 'warehouse_id') int? warehouseId,
      @JsonKey(name: 'warehouse_name') String? warehouseName,
      @JsonKey(name: 'tax_rate') double? taxRate,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      double? discount,
      @JsonKey(name: 'discount_amount') double? discountAmount,
      double? shipping,
      @JsonKey(name: 'grand_total') double? grandTotal,
      @JsonKey(name: 'received_amount') double? receivedAmount,
      @JsonKey(name: 'paid_amount') double? paidAmount,
      @JsonKey(name: 'partial_amount') double? partialAmount,
      @JsonKey(name: 'due_amount') double? dueAmount,
      @JsonKey(name: 'payment_type') PaymentType? paymentType,
      String? note,
      SaleStatus? status,
      @JsonKey(name: 'payment_status') PaymentStatus? paymentStatus,
      @JsonKey(name: 'reference_code') String? referenceCode,
      @JsonKey(name: 'sale_items') List<SaleItem>? saleItems,
      List<SalePayment>? payments,
      @JsonKey(name: 'payment_methods') List<String>? paymentMethods,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'barcode_url') String? barcodeUrl,
      @JsonKey(name: 'is_offline') int isOffline,
      @JsonKey(name: 'offline_customer_name') String? offlineCustomerName,
      @JsonKey(name: 'staff_id') int? staffId,
      @JsonKey(name: 'attendant_name') String? attendantName,
      @JsonKey(name: 'room_details') dynamic roomDetails,
      @JsonKey(name: 'attendant_id') int? attendantId,
      @JsonKey(name: 'partial_payment_method') String? partialPaymentMethod});

  $SaleLoggedUserCopyWith<$Res>? get loggedUser;
}

/// @nodoc
class _$SaleCopyWithImpl<$Res, $Val extends Sale>
    implements $SaleCopyWith<$Res> {
  _$SaleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? links = freezed,
    Object? date = freezed,
    Object? isReturn = freezed,
    Object? customerId = freezed,
    Object? companyId = freezed,
    Object? loggedUser = freezed,
    Object? customerName = freezed,
    Object? staffName = freezed,
    Object? warehouseId = freezed,
    Object? warehouseName = freezed,
    Object? taxRate = freezed,
    Object? taxAmount = freezed,
    Object? discount = freezed,
    Object? discountAmount = freezed,
    Object? shipping = freezed,
    Object? grandTotal = freezed,
    Object? receivedAmount = freezed,
    Object? paidAmount = freezed,
    Object? partialAmount = freezed,
    Object? dueAmount = freezed,
    Object? paymentType = freezed,
    Object? note = freezed,
    Object? status = freezed,
    Object? paymentStatus = freezed,
    Object? referenceCode = freezed,
    Object? saleItems = freezed,
    Object? payments = freezed,
    Object? paymentMethods = freezed,
    Object? createdAt = freezed,
    Object? barcodeUrl = freezed,
    Object? isOffline = null,
    Object? offlineCustomerName = freezed,
    Object? staffId = freezed,
    Object? attendantName = freezed,
    Object? roomDetails = freezed,
    Object? attendantId = freezed,
    Object? partialPaymentMethod = freezed,
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
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isReturn: freezed == isReturn
          ? _value.isReturn
          : isReturn // ignore: cast_nullable_to_non_nullable
              as int?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as int?,
      loggedUser: freezed == loggedUser
          ? _value.loggedUser
          : loggedUser // ignore: cast_nullable_to_non_nullable
              as SaleLoggedUser?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
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
      receivedAmount: freezed == receivedAmount
          ? _value.receivedAmount
          : receivedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      partialAmount: freezed == partialAmount
          ? _value.partialAmount
          : partialAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      dueAmount: freezed == dueAmount
          ? _value.dueAmount
          : dueAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      paymentType: freezed == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as PaymentType?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SaleStatus?,
      paymentStatus: freezed == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as PaymentStatus?,
      referenceCode: freezed == referenceCode
          ? _value.referenceCode
          : referenceCode // ignore: cast_nullable_to_non_nullable
              as String?,
      saleItems: freezed == saleItems
          ? _value.saleItems
          : saleItems // ignore: cast_nullable_to_non_nullable
              as List<SaleItem>?,
      payments: freezed == payments
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<SalePayment>?,
      paymentMethods: freezed == paymentMethods
          ? _value.paymentMethods
          : paymentMethods // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      barcodeUrl: freezed == barcodeUrl
          ? _value.barcodeUrl
          : barcodeUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isOffline: null == isOffline
          ? _value.isOffline
          : isOffline // ignore: cast_nullable_to_non_nullable
              as int,
      offlineCustomerName: freezed == offlineCustomerName
          ? _value.offlineCustomerName
          : offlineCustomerName // ignore: cast_nullable_to_non_nullable
              as String?,
      staffId: freezed == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int?,
      attendantName: freezed == attendantName
          ? _value.attendantName
          : attendantName // ignore: cast_nullable_to_non_nullable
              as String?,
      roomDetails: freezed == roomDetails
          ? _value.roomDetails
          : roomDetails // ignore: cast_nullable_to_non_nullable
              as dynamic,
      attendantId: freezed == attendantId
          ? _value.attendantId
          : attendantId // ignore: cast_nullable_to_non_nullable
              as int?,
      partialPaymentMethod: freezed == partialPaymentMethod
          ? _value.partialPaymentMethod
          : partialPaymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SaleLoggedUserCopyWith<$Res>? get loggedUser {
    if (_value.loggedUser == null) {
      return null;
    }

    return $SaleLoggedUserCopyWith<$Res>(_value.loggedUser!, (value) {
      return _then(_value.copyWith(loggedUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SaleImplCopyWith<$Res> implements $SaleCopyWith<$Res> {
  factory _$$SaleImplCopyWith(
          _$SaleImpl value, $Res Function(_$SaleImpl) then) =
      __$$SaleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? type,
      Map<String, dynamic>? links,
      DateTime? date,
      @JsonKey(name: 'is_return') int? isReturn,
      @JsonKey(name: 'customer_id') int? customerId,
      @JsonKey(name: 'company_id') int? companyId,
      @JsonKey(name: 'logged_user') SaleLoggedUser? loggedUser,
      @JsonKey(name: 'customer_name') String? customerName,
      @JsonKey(name: 'staff_name') String? staffName,
      @JsonKey(name: 'warehouse_id') int? warehouseId,
      @JsonKey(name: 'warehouse_name') String? warehouseName,
      @JsonKey(name: 'tax_rate') double? taxRate,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      double? discount,
      @JsonKey(name: 'discount_amount') double? discountAmount,
      double? shipping,
      @JsonKey(name: 'grand_total') double? grandTotal,
      @JsonKey(name: 'received_amount') double? receivedAmount,
      @JsonKey(name: 'paid_amount') double? paidAmount,
      @JsonKey(name: 'partial_amount') double? partialAmount,
      @JsonKey(name: 'due_amount') double? dueAmount,
      @JsonKey(name: 'payment_type') PaymentType? paymentType,
      String? note,
      SaleStatus? status,
      @JsonKey(name: 'payment_status') PaymentStatus? paymentStatus,
      @JsonKey(name: 'reference_code') String? referenceCode,
      @JsonKey(name: 'sale_items') List<SaleItem>? saleItems,
      List<SalePayment>? payments,
      @JsonKey(name: 'payment_methods') List<String>? paymentMethods,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'barcode_url') String? barcodeUrl,
      @JsonKey(name: 'is_offline') int isOffline,
      @JsonKey(name: 'offline_customer_name') String? offlineCustomerName,
      @JsonKey(name: 'staff_id') int? staffId,
      @JsonKey(name: 'attendant_name') String? attendantName,
      @JsonKey(name: 'room_details') dynamic roomDetails,
      @JsonKey(name: 'attendant_id') int? attendantId,
      @JsonKey(name: 'partial_payment_method') String? partialPaymentMethod});

  @override
  $SaleLoggedUserCopyWith<$Res>? get loggedUser;
}

/// @nodoc
class __$$SaleImplCopyWithImpl<$Res>
    extends _$SaleCopyWithImpl<$Res, _$SaleImpl>
    implements _$$SaleImplCopyWith<$Res> {
  __$$SaleImplCopyWithImpl(_$SaleImpl _value, $Res Function(_$SaleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? links = freezed,
    Object? date = freezed,
    Object? isReturn = freezed,
    Object? customerId = freezed,
    Object? companyId = freezed,
    Object? loggedUser = freezed,
    Object? customerName = freezed,
    Object? staffName = freezed,
    Object? warehouseId = freezed,
    Object? warehouseName = freezed,
    Object? taxRate = freezed,
    Object? taxAmount = freezed,
    Object? discount = freezed,
    Object? discountAmount = freezed,
    Object? shipping = freezed,
    Object? grandTotal = freezed,
    Object? receivedAmount = freezed,
    Object? paidAmount = freezed,
    Object? partialAmount = freezed,
    Object? dueAmount = freezed,
    Object? paymentType = freezed,
    Object? note = freezed,
    Object? status = freezed,
    Object? paymentStatus = freezed,
    Object? referenceCode = freezed,
    Object? saleItems = freezed,
    Object? payments = freezed,
    Object? paymentMethods = freezed,
    Object? createdAt = freezed,
    Object? barcodeUrl = freezed,
    Object? isOffline = null,
    Object? offlineCustomerName = freezed,
    Object? staffId = freezed,
    Object? attendantName = freezed,
    Object? roomDetails = freezed,
    Object? attendantId = freezed,
    Object? partialPaymentMethod = freezed,
  }) {
    return _then(_$SaleImpl(
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
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isReturn: freezed == isReturn
          ? _value.isReturn
          : isReturn // ignore: cast_nullable_to_non_nullable
              as int?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as int?,
      loggedUser: freezed == loggedUser
          ? _value.loggedUser
          : loggedUser // ignore: cast_nullable_to_non_nullable
              as SaleLoggedUser?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
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
      receivedAmount: freezed == receivedAmount
          ? _value.receivedAmount
          : receivedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      partialAmount: freezed == partialAmount
          ? _value.partialAmount
          : partialAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      dueAmount: freezed == dueAmount
          ? _value.dueAmount
          : dueAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      paymentType: freezed == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as PaymentType?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SaleStatus?,
      paymentStatus: freezed == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as PaymentStatus?,
      referenceCode: freezed == referenceCode
          ? _value.referenceCode
          : referenceCode // ignore: cast_nullable_to_non_nullable
              as String?,
      saleItems: freezed == saleItems
          ? _value._saleItems
          : saleItems // ignore: cast_nullable_to_non_nullable
              as List<SaleItem>?,
      payments: freezed == payments
          ? _value._payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<SalePayment>?,
      paymentMethods: freezed == paymentMethods
          ? _value._paymentMethods
          : paymentMethods // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      barcodeUrl: freezed == barcodeUrl
          ? _value.barcodeUrl
          : barcodeUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isOffline: null == isOffline
          ? _value.isOffline
          : isOffline // ignore: cast_nullable_to_non_nullable
              as int,
      offlineCustomerName: freezed == offlineCustomerName
          ? _value.offlineCustomerName
          : offlineCustomerName // ignore: cast_nullable_to_non_nullable
              as String?,
      staffId: freezed == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int?,
      attendantName: freezed == attendantName
          ? _value.attendantName
          : attendantName // ignore: cast_nullable_to_non_nullable
              as String?,
      roomDetails: freezed == roomDetails
          ? _value.roomDetails
          : roomDetails // ignore: cast_nullable_to_non_nullable
              as dynamic,
      attendantId: freezed == attendantId
          ? _value.attendantId
          : attendantId // ignore: cast_nullable_to_non_nullable
              as int?,
      partialPaymentMethod: freezed == partialPaymentMethod
          ? _value.partialPaymentMethod
          : partialPaymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleImpl implements _Sale {
  const _$SaleImpl(
      {this.id,
      this.type,
      final Map<String, dynamic>? links,
      this.date,
      @JsonKey(name: 'is_return') this.isReturn,
      @JsonKey(name: 'customer_id') this.customerId,
      @JsonKey(name: 'company_id') this.companyId,
      @JsonKey(name: 'logged_user') this.loggedUser,
      @JsonKey(name: 'customer_name') this.customerName,
      @JsonKey(name: 'staff_name') this.staffName,
      @JsonKey(name: 'warehouse_id') this.warehouseId,
      @JsonKey(name: 'warehouse_name') this.warehouseName,
      @JsonKey(name: 'tax_rate') this.taxRate,
      @JsonKey(name: 'tax_amount') this.taxAmount,
      this.discount,
      @JsonKey(name: 'discount_amount') this.discountAmount,
      this.shipping,
      @JsonKey(name: 'grand_total') this.grandTotal,
      @JsonKey(name: 'received_amount') this.receivedAmount,
      @JsonKey(name: 'paid_amount') this.paidAmount,
      @JsonKey(name: 'partial_amount') this.partialAmount,
      @JsonKey(name: 'due_amount') this.dueAmount,
      @JsonKey(name: 'payment_type') this.paymentType,
      this.note,
      this.status,
      @JsonKey(name: 'payment_status') this.paymentStatus,
      @JsonKey(name: 'reference_code') this.referenceCode,
      @JsonKey(name: 'sale_items') final List<SaleItem>? saleItems,
      final List<SalePayment>? payments,
      @JsonKey(name: 'payment_methods') final List<String>? paymentMethods,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'barcode_url') this.barcodeUrl,
      @JsonKey(name: 'is_offline') required this.isOffline,
      @JsonKey(name: 'offline_customer_name') this.offlineCustomerName,
      @JsonKey(name: 'staff_id') this.staffId,
      @JsonKey(name: 'attendant_name') this.attendantName,
      @JsonKey(name: 'room_details') this.roomDetails,
      @JsonKey(name: 'attendant_id') this.attendantId,
      @JsonKey(name: 'partial_payment_method') this.partialPaymentMethod})
      : _links = links,
        _saleItems = saleItems,
        _payments = payments,
        _paymentMethods = paymentMethods;

  factory _$SaleImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleImplFromJson(json);

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
  final DateTime? date;
  @override
  @JsonKey(name: 'is_return')
  final int? isReturn;
  @override
  @JsonKey(name: 'customer_id')
  final int? customerId;
  @override
  @JsonKey(name: 'company_id')
  final int? companyId;
  @override
  @JsonKey(name: 'logged_user')
  final SaleLoggedUser? loggedUser;
  @override
  @JsonKey(name: 'customer_name')
  final String? customerName;
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
  @JsonKey(name: 'discount_amount')
  final double? discountAmount;
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
  @JsonKey(name: 'partial_amount')
  final double? partialAmount;
  @override
  @JsonKey(name: 'due_amount')
  final double? dueAmount;
  @override
  @JsonKey(name: 'payment_type')
  final PaymentType? paymentType;
  @override
  final String? note;
  @override
  final SaleStatus? status;
  @override
  @JsonKey(name: 'payment_status')
  final PaymentStatus? paymentStatus;
  @override
  @JsonKey(name: 'reference_code')
  final String? referenceCode;
  final List<SaleItem>? _saleItems;
  @override
  @JsonKey(name: 'sale_items')
  List<SaleItem>? get saleItems {
    final value = _saleItems;
    if (value == null) return null;
    if (_saleItems is EqualUnmodifiableListView) return _saleItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<SalePayment>? _payments;
  @override
  List<SalePayment>? get payments {
    final value = _payments;
    if (value == null) return null;
    if (_payments is EqualUnmodifiableListView) return _payments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _paymentMethods;
  @override
  @JsonKey(name: 'payment_methods')
  List<String>? get paymentMethods {
    final value = _paymentMethods;
    if (value == null) return null;
    if (_paymentMethods is EqualUnmodifiableListView) return _paymentMethods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'barcode_url')
  final String? barcodeUrl;
  @override
  @JsonKey(name: 'is_offline')
  final int isOffline;
  @override
  @JsonKey(name: 'offline_customer_name')
  final String? offlineCustomerName;
  @override
  @JsonKey(name: 'staff_id')
  final int? staffId;
  @override
  @JsonKey(name: 'attendant_name')
  final String? attendantName;
  @override
  @JsonKey(name: 'room_details')
  final dynamic roomDetails;
  @override
  @JsonKey(name: 'attendant_id')
  final int? attendantId;
  @override
  @JsonKey(name: 'partial_payment_method')
  final String? partialPaymentMethod;

  @override
  String toString() {
    return 'Sale(id: $id, type: $type, links: $links, date: $date, isReturn: $isReturn, customerId: $customerId, companyId: $companyId, loggedUser: $loggedUser, customerName: $customerName, staffName: $staffName, warehouseId: $warehouseId, warehouseName: $warehouseName, taxRate: $taxRate, taxAmount: $taxAmount, discount: $discount, discountAmount: $discountAmount, shipping: $shipping, grandTotal: $grandTotal, receivedAmount: $receivedAmount, paidAmount: $paidAmount, partialAmount: $partialAmount, dueAmount: $dueAmount, paymentType: $paymentType, note: $note, status: $status, paymentStatus: $paymentStatus, referenceCode: $referenceCode, saleItems: $saleItems, payments: $payments, paymentMethods: $paymentMethods, createdAt: $createdAt, barcodeUrl: $barcodeUrl, isOffline: $isOffline, offlineCustomerName: $offlineCustomerName, staffId: $staffId, attendantName: $attendantName, roomDetails: $roomDetails, attendantId: $attendantId, partialPaymentMethod: $partialPaymentMethod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._links, _links) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isReturn, isReturn) ||
                other.isReturn == isReturn) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.loggedUser, loggedUser) ||
                other.loggedUser == loggedUser) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
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
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.shipping, shipping) ||
                other.shipping == shipping) &&
            (identical(other.grandTotal, grandTotal) ||
                other.grandTotal == grandTotal) &&
            (identical(other.receivedAmount, receivedAmount) ||
                other.receivedAmount == receivedAmount) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.partialAmount, partialAmount) ||
                other.partialAmount == partialAmount) &&
            (identical(other.dueAmount, dueAmount) ||
                other.dueAmount == dueAmount) &&
            (identical(other.paymentType, paymentType) ||
                other.paymentType == paymentType) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.referenceCode, referenceCode) ||
                other.referenceCode == referenceCode) &&
            const DeepCollectionEquality()
                .equals(other._saleItems, _saleItems) &&
            const DeepCollectionEquality().equals(other._payments, _payments) &&
            const DeepCollectionEquality()
                .equals(other._paymentMethods, _paymentMethods) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.barcodeUrl, barcodeUrl) ||
                other.barcodeUrl == barcodeUrl) &&
            (identical(other.isOffline, isOffline) ||
                other.isOffline == isOffline) &&
            (identical(other.offlineCustomerName, offlineCustomerName) ||
                other.offlineCustomerName == offlineCustomerName) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.attendantName, attendantName) ||
                other.attendantName == attendantName) &&
            const DeepCollectionEquality()
                .equals(other.roomDetails, roomDetails) &&
            (identical(other.attendantId, attendantId) ||
                other.attendantId == attendantId) &&
            (identical(other.partialPaymentMethod, partialPaymentMethod) ||
                other.partialPaymentMethod == partialPaymentMethod));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        type,
        const DeepCollectionEquality().hash(_links),
        date,
        isReturn,
        customerId,
        companyId,
        loggedUser,
        customerName,
        staffName,
        warehouseId,
        warehouseName,
        taxRate,
        taxAmount,
        discount,
        discountAmount,
        shipping,
        grandTotal,
        receivedAmount,
        paidAmount,
        partialAmount,
        dueAmount,
        paymentType,
        note,
        status,
        paymentStatus,
        referenceCode,
        const DeepCollectionEquality().hash(_saleItems),
        const DeepCollectionEquality().hash(_payments),
        const DeepCollectionEquality().hash(_paymentMethods),
        createdAt,
        barcodeUrl,
        isOffline,
        offlineCustomerName,
        staffId,
        attendantName,
        const DeepCollectionEquality().hash(roomDetails),
        attendantId,
        partialPaymentMethod
      ]);

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleImplCopyWith<_$SaleImpl> get copyWith =>
      __$$SaleImplCopyWithImpl<_$SaleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleImplToJson(
      this,
    );
  }
}

abstract class _Sale implements Sale {
  const factory _Sale(
      {final int? id,
      final String? type,
      final Map<String, dynamic>? links,
      final DateTime? date,
      @JsonKey(name: 'is_return') final int? isReturn,
      @JsonKey(name: 'customer_id') final int? customerId,
      @JsonKey(name: 'company_id') final int? companyId,
      @JsonKey(name: 'logged_user') final SaleLoggedUser? loggedUser,
      @JsonKey(name: 'customer_name') final String? customerName,
      @JsonKey(name: 'staff_name') final String? staffName,
      @JsonKey(name: 'warehouse_id') final int? warehouseId,
      @JsonKey(name: 'warehouse_name') final String? warehouseName,
      @JsonKey(name: 'tax_rate') final double? taxRate,
      @JsonKey(name: 'tax_amount') final double? taxAmount,
      final double? discount,
      @JsonKey(name: 'discount_amount') final double? discountAmount,
      final double? shipping,
      @JsonKey(name: 'grand_total') final double? grandTotal,
      @JsonKey(name: 'received_amount') final double? receivedAmount,
      @JsonKey(name: 'paid_amount') final double? paidAmount,
      @JsonKey(name: 'partial_amount') final double? partialAmount,
      @JsonKey(name: 'due_amount') final double? dueAmount,
      @JsonKey(name: 'payment_type') final PaymentType? paymentType,
      final String? note,
      final SaleStatus? status,
      @JsonKey(name: 'payment_status') final PaymentStatus? paymentStatus,
      @JsonKey(name: 'reference_code') final String? referenceCode,
      @JsonKey(name: 'sale_items') final List<SaleItem>? saleItems,
      final List<SalePayment>? payments,
      @JsonKey(name: 'payment_methods') final List<String>? paymentMethods,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'barcode_url') final String? barcodeUrl,
      @JsonKey(name: 'is_offline') required final int isOffline,
      @JsonKey(name: 'offline_customer_name') final String? offlineCustomerName,
      @JsonKey(name: 'staff_id') final int? staffId,
      @JsonKey(name: 'attendant_name') final String? attendantName,
      @JsonKey(name: 'room_details') final dynamic roomDetails,
      @JsonKey(name: 'attendant_id') final int? attendantId,
      @JsonKey(name: 'partial_payment_method')
      final String? partialPaymentMethod}) = _$SaleImpl;

  factory _Sale.fromJson(Map<String, dynamic> json) = _$SaleImpl.fromJson;

  @override
  int? get id;
  @override
  String? get type;
  @override
  Map<String, dynamic>? get links;
  @override
  DateTime? get date;
  @override
  @JsonKey(name: 'is_return')
  int? get isReturn;
  @override
  @JsonKey(name: 'customer_id')
  int? get customerId;
  @override
  @JsonKey(name: 'company_id')
  int? get companyId;
  @override
  @JsonKey(name: 'logged_user')
  SaleLoggedUser? get loggedUser;
  @override
  @JsonKey(name: 'customer_name')
  String? get customerName;
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
  @JsonKey(name: 'discount_amount')
  double? get discountAmount;
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
  @JsonKey(name: 'partial_amount')
  double? get partialAmount;
  @override
  @JsonKey(name: 'due_amount')
  double? get dueAmount;
  @override
  @JsonKey(name: 'payment_type')
  PaymentType? get paymentType;
  @override
  String? get note;
  @override
  SaleStatus? get status;
  @override
  @JsonKey(name: 'payment_status')
  PaymentStatus? get paymentStatus;
  @override
  @JsonKey(name: 'reference_code')
  String? get referenceCode;
  @override
  @JsonKey(name: 'sale_items')
  List<SaleItem>? get saleItems;
  @override
  List<SalePayment>? get payments;
  @override
  @JsonKey(name: 'payment_methods')
  List<String>? get paymentMethods;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'barcode_url')
  String? get barcodeUrl;
  @override
  @JsonKey(name: 'is_offline')
  int get isOffline;
  @override
  @JsonKey(name: 'offline_customer_name')
  String? get offlineCustomerName;
  @override
  @JsonKey(name: 'staff_id')
  int? get staffId;
  @override
  @JsonKey(name: 'attendant_name')
  String? get attendantName;
  @override
  @JsonKey(name: 'room_details')
  dynamic get roomDetails;
  @override
  @JsonKey(name: 'attendant_id')
  int? get attendantId;
  @override
  @JsonKey(name: 'partial_payment_method')
  String? get partialPaymentMethod;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleImplCopyWith<_$SaleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleLoggedUser _$SaleLoggedUserFromJson(Map<String, dynamic> json) {
  return _SaleLoggedUser.fromJson(json);
}

/// @nodoc
mixin _$SaleLoggedUser {
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
  int? get warehouseId => throw _privateConstructorUsedError;
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
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  List<dynamic>? get media => throw _privateConstructorUsedError;

  /// Serializes this SaleLoggedUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleLoggedUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleLoggedUserCopyWith<SaleLoggedUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleLoggedUserCopyWith<$Res> {
  factory $SaleLoggedUserCopyWith(
          SaleLoggedUser value, $Res Function(SaleLoggedUser) then) =
      _$SaleLoggedUserCopyWithImpl<$Res, SaleLoggedUser>;
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
      @JsonKey(name: 'warehouse_id') int? warehouseId,
      @JsonKey(name: 'branch_id') int? branchId,
      String? type,
      @JsonKey(name: 'salary_amount') double? salaryAmount,
      double? balance,
      @JsonKey(name: 'date_employed') DateTime? dateEmployed,
      String? note,
      @JsonKey(name: 'is_attendant') int? isAttendant,
      @JsonKey(name: 'image_url') String? imageUrl,
      List<dynamic>? media});
}

/// @nodoc
class _$SaleLoggedUserCopyWithImpl<$Res, $Val extends SaleLoggedUser>
    implements $SaleLoggedUserCopyWith<$Res> {
  _$SaleLoggedUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleLoggedUser
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
              as int?,
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
abstract class _$$SaleLoggedUserImplCopyWith<$Res>
    implements $SaleLoggedUserCopyWith<$Res> {
  factory _$$SaleLoggedUserImplCopyWith(_$SaleLoggedUserImpl value,
          $Res Function(_$SaleLoggedUserImpl) then) =
      __$$SaleLoggedUserImplCopyWithImpl<$Res>;
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
      @JsonKey(name: 'warehouse_id') int? warehouseId,
      @JsonKey(name: 'branch_id') int? branchId,
      String? type,
      @JsonKey(name: 'salary_amount') double? salaryAmount,
      double? balance,
      @JsonKey(name: 'date_employed') DateTime? dateEmployed,
      String? note,
      @JsonKey(name: 'is_attendant') int? isAttendant,
      @JsonKey(name: 'image_url') String? imageUrl,
      List<dynamic>? media});
}

/// @nodoc
class __$$SaleLoggedUserImplCopyWithImpl<$Res>
    extends _$SaleLoggedUserCopyWithImpl<$Res, _$SaleLoggedUserImpl>
    implements _$$SaleLoggedUserImplCopyWith<$Res> {
  __$$SaleLoggedUserImplCopyWithImpl(
      _$SaleLoggedUserImpl _value, $Res Function(_$SaleLoggedUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaleLoggedUser
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
    Object? imageUrl = freezed,
    Object? media = freezed,
  }) {
    return _then(_$SaleLoggedUserImpl(
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
              as int?,
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
class _$SaleLoggedUserImpl implements _SaleLoggedUser {
  const _$SaleLoggedUserImpl(
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
      @JsonKey(name: 'image_url') this.imageUrl,
      final List<dynamic>? media})
      : _media = media;

  factory _$SaleLoggedUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleLoggedUserImplFromJson(json);

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
  final int? warehouseId;
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
    return 'SaleLoggedUser(id: $id, firstName: $firstName, lastName: $lastName, dob: $dob, salaryDate: $salaryDate, email: $email, phone: $phone, emailVerifiedAt: $emailVerifiedAt, defaultPassword: $defaultPassword, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, language: $language, companyId: $companyId, isAdmin: $isAdmin, isSuper: $isSuper, warehouseId: $warehouseId, branchId: $branchId, type: $type, salaryAmount: $salaryAmount, balance: $balance, dateEmployed: $dateEmployed, note: $note, isAttendant: $isAttendant, imageUrl: $imageUrl, media: $media)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleLoggedUserImpl &&
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
        imageUrl,
        const DeepCollectionEquality().hash(_media)
      ]);

  /// Create a copy of SaleLoggedUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleLoggedUserImplCopyWith<_$SaleLoggedUserImpl> get copyWith =>
      __$$SaleLoggedUserImplCopyWithImpl<_$SaleLoggedUserImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleLoggedUserImplToJson(
      this,
    );
  }
}

abstract class _SaleLoggedUser implements SaleLoggedUser {
  const factory _SaleLoggedUser(
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
      @JsonKey(name: 'warehouse_id') final int? warehouseId,
      @JsonKey(name: 'branch_id') final int? branchId,
      final String? type,
      @JsonKey(name: 'salary_amount') final double? salaryAmount,
      final double? balance,
      @JsonKey(name: 'date_employed') final DateTime? dateEmployed,
      final String? note,
      @JsonKey(name: 'is_attendant') final int? isAttendant,
      @JsonKey(name: 'image_url') final String? imageUrl,
      final List<dynamic>? media}) = _$SaleLoggedUserImpl;

  factory _SaleLoggedUser.fromJson(Map<String, dynamic> json) =
      _$SaleLoggedUserImpl.fromJson;

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
  int? get warehouseId;
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
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  List<dynamic>? get media;

  /// Create a copy of SaleLoggedUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleLoggedUserImplCopyWith<_$SaleLoggedUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleItem _$SaleItemFromJson(Map<String, dynamic> json) {
  return _SaleItem.fromJson(json);
}

/// @nodoc
mixin _$SaleItem {
  @JsonKey(name: 'product_id')
  int? get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String? get productName => throw _privateConstructorUsedError;
  @JsonKey(name: 'company_id')
  int? get companyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'net_unit_price')
  double? get netUnitPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_price')
  double? get productPrice => throw _privateConstructorUsedError;
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
  SaleUnit? get saleUnit => throw _privateConstructorUsedError;
  double? get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_total')
  double? get subTotal => throw _privateConstructorUsedError;

  /// Serializes this SaleItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleItemCopyWith<SaleItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleItemCopyWith<$Res> {
  factory $SaleItemCopyWith(SaleItem value, $Res Function(SaleItem) then) =
      _$SaleItemCopyWithImpl<$Res, SaleItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'product_id') int? productId,
      @JsonKey(name: 'product_name') String? productName,
      @JsonKey(name: 'company_id') int? companyId,
      @JsonKey(name: 'net_unit_price') double? netUnitPrice,
      @JsonKey(name: 'product_price') double? productPrice,
      @JsonKey(name: 'tax_type') int? taxType,
      @JsonKey(name: 'tax_value') double? taxValue,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      @JsonKey(name: 'discount_type') int? discountType,
      @JsonKey(name: 'discount_value') double? discountValue,
      @JsonKey(name: 'discount_amount') double? discountAmount,
      @JsonKey(name: 'sale_unit') SaleUnit? saleUnit,
      double? quantity,
      @JsonKey(name: 'sub_total') double? subTotal});

  $SaleUnitCopyWith<$Res>? get saleUnit;
}

/// @nodoc
class _$SaleItemCopyWithImpl<$Res, $Val extends SaleItem>
    implements $SaleItemCopyWith<$Res> {
  _$SaleItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = freezed,
    Object? productName = freezed,
    Object? companyId = freezed,
    Object? netUnitPrice = freezed,
    Object? productPrice = freezed,
    Object? taxType = freezed,
    Object? taxValue = freezed,
    Object? taxAmount = freezed,
    Object? discountType = freezed,
    Object? discountValue = freezed,
    Object? discountAmount = freezed,
    Object? saleUnit = freezed,
    Object? quantity = freezed,
    Object? subTotal = freezed,
  }) {
    return _then(_value.copyWith(
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as int?,
      netUnitPrice: freezed == netUnitPrice
          ? _value.netUnitPrice
          : netUnitPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      productPrice: freezed == productPrice
          ? _value.productPrice
          : productPrice // ignore: cast_nullable_to_non_nullable
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
              as SaleUnit?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      subTotal: freezed == subTotal
          ? _value.subTotal
          : subTotal // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

  /// Create a copy of SaleItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SaleUnitCopyWith<$Res>? get saleUnit {
    if (_value.saleUnit == null) {
      return null;
    }

    return $SaleUnitCopyWith<$Res>(_value.saleUnit!, (value) {
      return _then(_value.copyWith(saleUnit: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SaleItemImplCopyWith<$Res>
    implements $SaleItemCopyWith<$Res> {
  factory _$$SaleItemImplCopyWith(
          _$SaleItemImpl value, $Res Function(_$SaleItemImpl) then) =
      __$$SaleItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'product_id') int? productId,
      @JsonKey(name: 'product_name') String? productName,
      @JsonKey(name: 'company_id') int? companyId,
      @JsonKey(name: 'net_unit_price') double? netUnitPrice,
      @JsonKey(name: 'product_price') double? productPrice,
      @JsonKey(name: 'tax_type') int? taxType,
      @JsonKey(name: 'tax_value') double? taxValue,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      @JsonKey(name: 'discount_type') int? discountType,
      @JsonKey(name: 'discount_value') double? discountValue,
      @JsonKey(name: 'discount_amount') double? discountAmount,
      @JsonKey(name: 'sale_unit') SaleUnit? saleUnit,
      double? quantity,
      @JsonKey(name: 'sub_total') double? subTotal});

  @override
  $SaleUnitCopyWith<$Res>? get saleUnit;
}

/// @nodoc
class __$$SaleItemImplCopyWithImpl<$Res>
    extends _$SaleItemCopyWithImpl<$Res, _$SaleItemImpl>
    implements _$$SaleItemImplCopyWith<$Res> {
  __$$SaleItemImplCopyWithImpl(
      _$SaleItemImpl _value, $Res Function(_$SaleItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaleItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = freezed,
    Object? productName = freezed,
    Object? companyId = freezed,
    Object? netUnitPrice = freezed,
    Object? productPrice = freezed,
    Object? taxType = freezed,
    Object? taxValue = freezed,
    Object? taxAmount = freezed,
    Object? discountType = freezed,
    Object? discountValue = freezed,
    Object? discountAmount = freezed,
    Object? saleUnit = freezed,
    Object? quantity = freezed,
    Object? subTotal = freezed,
  }) {
    return _then(_$SaleItemImpl(
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as int?,
      netUnitPrice: freezed == netUnitPrice
          ? _value.netUnitPrice
          : netUnitPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      productPrice: freezed == productPrice
          ? _value.productPrice
          : productPrice // ignore: cast_nullable_to_non_nullable
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
              as SaleUnit?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      subTotal: freezed == subTotal
          ? _value.subTotal
          : subTotal // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleItemImpl implements _SaleItem {
  const _$SaleItemImpl(
      {@JsonKey(name: 'product_id') this.productId,
      @JsonKey(name: 'product_name') this.productName,
      @JsonKey(name: 'company_id') this.companyId,
      @JsonKey(name: 'net_unit_price') this.netUnitPrice,
      @JsonKey(name: 'product_price') this.productPrice,
      @JsonKey(name: 'tax_type') this.taxType,
      @JsonKey(name: 'tax_value') this.taxValue,
      @JsonKey(name: 'tax_amount') this.taxAmount,
      @JsonKey(name: 'discount_type') this.discountType,
      @JsonKey(name: 'discount_value') this.discountValue,
      @JsonKey(name: 'discount_amount') this.discountAmount,
      @JsonKey(name: 'sale_unit') this.saleUnit,
      this.quantity,
      @JsonKey(name: 'sub_total') this.subTotal});

  factory _$SaleItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleItemImplFromJson(json);

  @override
  @JsonKey(name: 'product_id')
  final int? productId;
  @override
  @JsonKey(name: 'product_name')
  final String? productName;
  @override
  @JsonKey(name: 'company_id')
  final int? companyId;
  @override
  @JsonKey(name: 'net_unit_price')
  final double? netUnitPrice;
  @override
  @JsonKey(name: 'product_price')
  final double? productPrice;
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
  final SaleUnit? saleUnit;
  @override
  final double? quantity;
  @override
  @JsonKey(name: 'sub_total')
  final double? subTotal;

  @override
  String toString() {
    return 'SaleItem(productId: $productId, productName: $productName, companyId: $companyId, netUnitPrice: $netUnitPrice, productPrice: $productPrice, taxType: $taxType, taxValue: $taxValue, taxAmount: $taxAmount, discountType: $discountType, discountValue: $discountValue, discountAmount: $discountAmount, saleUnit: $saleUnit, quantity: $quantity, subTotal: $subTotal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleItemImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.netUnitPrice, netUnitPrice) ||
                other.netUnitPrice == netUnitPrice) &&
            (identical(other.productPrice, productPrice) ||
                other.productPrice == productPrice) &&
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
                other.subTotal == subTotal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      productId,
      productName,
      companyId,
      netUnitPrice,
      productPrice,
      taxType,
      taxValue,
      taxAmount,
      discountType,
      discountValue,
      discountAmount,
      saleUnit,
      quantity,
      subTotal);

  /// Create a copy of SaleItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleItemImplCopyWith<_$SaleItemImpl> get copyWith =>
      __$$SaleItemImplCopyWithImpl<_$SaleItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleItemImplToJson(
      this,
    );
  }
}

abstract class _SaleItem implements SaleItem {
  const factory _SaleItem(
      {@JsonKey(name: 'product_id') final int? productId,
      @JsonKey(name: 'product_name') final String? productName,
      @JsonKey(name: 'company_id') final int? companyId,
      @JsonKey(name: 'net_unit_price') final double? netUnitPrice,
      @JsonKey(name: 'product_price') final double? productPrice,
      @JsonKey(name: 'tax_type') final int? taxType,
      @JsonKey(name: 'tax_value') final double? taxValue,
      @JsonKey(name: 'tax_amount') final double? taxAmount,
      @JsonKey(name: 'discount_type') final int? discountType,
      @JsonKey(name: 'discount_value') final double? discountValue,
      @JsonKey(name: 'discount_amount') final double? discountAmount,
      @JsonKey(name: 'sale_unit') final SaleUnit? saleUnit,
      final double? quantity,
      @JsonKey(name: 'sub_total') final double? subTotal}) = _$SaleItemImpl;

  factory _SaleItem.fromJson(Map<String, dynamic> json) =
      _$SaleItemImpl.fromJson;

  @override
  @JsonKey(name: 'product_id')
  int? get productId;
  @override
  @JsonKey(name: 'product_name')
  String? get productName;
  @override
  @JsonKey(name: 'company_id')
  int? get companyId;
  @override
  @JsonKey(name: 'net_unit_price')
  double? get netUnitPrice;
  @override
  @JsonKey(name: 'product_price')
  double? get productPrice;
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
  SaleUnit? get saleUnit;
  @override
  double? get quantity;
  @override
  @JsonKey(name: 'sub_total')
  double? get subTotal;

  /// Create a copy of SaleItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleItemImplCopyWith<_$SaleItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleUnit _$SaleUnitFromJson(Map<String, dynamic> json) {
  return _SaleUnit.fromJson(json);
}

/// @nodoc
mixin _$SaleUnit {
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

  /// Serializes this SaleUnit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleUnit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleUnitCopyWith<SaleUnit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleUnitCopyWith<$Res> {
  factory $SaleUnitCopyWith(SaleUnit value, $Res Function(SaleUnit) then) =
      _$SaleUnitCopyWithImpl<$Res, SaleUnit>;
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
class _$SaleUnitCopyWithImpl<$Res, $Val extends SaleUnit>
    implements $SaleUnitCopyWith<$Res> {
  _$SaleUnitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleUnit
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
abstract class _$$SaleUnitImplCopyWith<$Res>
    implements $SaleUnitCopyWith<$Res> {
  factory _$$SaleUnitImplCopyWith(
          _$SaleUnitImpl value, $Res Function(_$SaleUnitImpl) then) =
      __$$SaleUnitImplCopyWithImpl<$Res>;
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
class __$$SaleUnitImplCopyWithImpl<$Res>
    extends _$SaleUnitCopyWithImpl<$Res, _$SaleUnitImpl>
    implements _$$SaleUnitImplCopyWith<$Res> {
  __$$SaleUnitImplCopyWithImpl(
      _$SaleUnitImpl _value, $Res Function(_$SaleUnitImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaleUnit
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
    return _then(_$SaleUnitImpl(
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
class _$SaleUnitImpl implements _SaleUnit {
  const _$SaleUnitImpl(
      {this.id,
      this.name,
      @JsonKey(name: 'short_name') this.shortName,
      @JsonKey(name: 'base_unit') this.baseUnit,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'company_id') this.companyId});

  factory _$SaleUnitImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleUnitImplFromJson(json);

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
    return 'SaleUnit(id: $id, name: $name, shortName: $shortName, baseUnit: $baseUnit, createdAt: $createdAt, updatedAt: $updatedAt, companyId: $companyId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleUnitImpl &&
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

  /// Create a copy of SaleUnit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleUnitImplCopyWith<_$SaleUnitImpl> get copyWith =>
      __$$SaleUnitImplCopyWithImpl<_$SaleUnitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleUnitImplToJson(
      this,
    );
  }
}

abstract class _SaleUnit implements SaleUnit {
  const factory _SaleUnit(
      {final int? id,
      final String? name,
      @JsonKey(name: 'short_name') final String? shortName,
      @JsonKey(name: 'base_unit') final int? baseUnit,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      @JsonKey(name: 'company_id') final int? companyId}) = _$SaleUnitImpl;

  factory _SaleUnit.fromJson(Map<String, dynamic> json) =
      _$SaleUnitImpl.fromJson;

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

  /// Create a copy of SaleUnit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleUnitImplCopyWith<_$SaleUnitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SalePayment _$SalePaymentFromJson(Map<String, dynamic> json) {
  return _SalePayment.fromJson(json);
}

/// @nodoc
mixin _$SalePayment {
  @JsonKey(name: 'sale_id')
  int? get saleId => throw _privateConstructorUsedError;
  @JsonKey(name: 'company_id')
  int? get companyId => throw _privateConstructorUsedError;
  String? get reference => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_date')
  DateTime? get paymentDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_type')
  PaymentType? get paymentType => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method')
  String? get paymentMethod => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'received_amount')
  double? get receivedAmount => throw _privateConstructorUsedError;

  /// Serializes this SalePayment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SalePayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalePaymentCopyWith<SalePayment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalePaymentCopyWith<$Res> {
  factory $SalePaymentCopyWith(
          SalePayment value, $Res Function(SalePayment) then) =
      _$SalePaymentCopyWithImpl<$Res, SalePayment>;
  @useResult
  $Res call(
      {@JsonKey(name: 'sale_id') int? saleId,
      @JsonKey(name: 'company_id') int? companyId,
      String? reference,
      @JsonKey(name: 'payment_date') DateTime? paymentDate,
      @JsonKey(name: 'payment_type') PaymentType? paymentType,
      @JsonKey(name: 'payment_method') String? paymentMethod,
      double? amount,
      @JsonKey(name: 'received_amount') double? receivedAmount});
}

/// @nodoc
class _$SalePaymentCopyWithImpl<$Res, $Val extends SalePayment>
    implements $SalePaymentCopyWith<$Res> {
  _$SalePaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalePayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saleId = freezed,
    Object? companyId = freezed,
    Object? reference = freezed,
    Object? paymentDate = freezed,
    Object? paymentType = freezed,
    Object? paymentMethod = freezed,
    Object? amount = freezed,
    Object? receivedAmount = freezed,
  }) {
    return _then(_value.copyWith(
      saleId: freezed == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as int?,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as int?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentDate: freezed == paymentDate
          ? _value.paymentDate
          : paymentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paymentType: freezed == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as PaymentType?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      receivedAmount: freezed == receivedAmount
          ? _value.receivedAmount
          : receivedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SalePaymentImplCopyWith<$Res>
    implements $SalePaymentCopyWith<$Res> {
  factory _$$SalePaymentImplCopyWith(
          _$SalePaymentImpl value, $Res Function(_$SalePaymentImpl) then) =
      __$$SalePaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'sale_id') int? saleId,
      @JsonKey(name: 'company_id') int? companyId,
      String? reference,
      @JsonKey(name: 'payment_date') DateTime? paymentDate,
      @JsonKey(name: 'payment_type') PaymentType? paymentType,
      @JsonKey(name: 'payment_method') String? paymentMethod,
      double? amount,
      @JsonKey(name: 'received_amount') double? receivedAmount});
}

/// @nodoc
class __$$SalePaymentImplCopyWithImpl<$Res>
    extends _$SalePaymentCopyWithImpl<$Res, _$SalePaymentImpl>
    implements _$$SalePaymentImplCopyWith<$Res> {
  __$$SalePaymentImplCopyWithImpl(
      _$SalePaymentImpl _value, $Res Function(_$SalePaymentImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalePayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saleId = freezed,
    Object? companyId = freezed,
    Object? reference = freezed,
    Object? paymentDate = freezed,
    Object? paymentType = freezed,
    Object? paymentMethod = freezed,
    Object? amount = freezed,
    Object? receivedAmount = freezed,
  }) {
    return _then(_$SalePaymentImpl(
      saleId: freezed == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as int?,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as int?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentDate: freezed == paymentDate
          ? _value.paymentDate
          : paymentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paymentType: freezed == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as PaymentType?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      receivedAmount: freezed == receivedAmount
          ? _value.receivedAmount
          : receivedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SalePaymentImpl implements _SalePayment {
  const _$SalePaymentImpl(
      {@JsonKey(name: 'sale_id') this.saleId,
      @JsonKey(name: 'company_id') this.companyId,
      this.reference,
      @JsonKey(name: 'payment_date') this.paymentDate,
      @JsonKey(name: 'payment_type') this.paymentType,
      @JsonKey(name: 'payment_method') this.paymentMethod,
      this.amount,
      @JsonKey(name: 'received_amount') this.receivedAmount});

  factory _$SalePaymentImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalePaymentImplFromJson(json);

  @override
  @JsonKey(name: 'sale_id')
  final int? saleId;
  @override
  @JsonKey(name: 'company_id')
  final int? companyId;
  @override
  final String? reference;
  @override
  @JsonKey(name: 'payment_date')
  final DateTime? paymentDate;
  @override
  @JsonKey(name: 'payment_type')
  final PaymentType? paymentType;
  @override
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @override
  final double? amount;
  @override
  @JsonKey(name: 'received_amount')
  final double? receivedAmount;

  @override
  String toString() {
    return 'SalePayment(saleId: $saleId, companyId: $companyId, reference: $reference, paymentDate: $paymentDate, paymentType: $paymentType, paymentMethod: $paymentMethod, amount: $amount, receivedAmount: $receivedAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalePaymentImpl &&
            (identical(other.saleId, saleId) || other.saleId == saleId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.paymentDate, paymentDate) ||
                other.paymentDate == paymentDate) &&
            (identical(other.paymentType, paymentType) ||
                other.paymentType == paymentType) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.receivedAmount, receivedAmount) ||
                other.receivedAmount == receivedAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, saleId, companyId, reference,
      paymentDate, paymentType, paymentMethod, amount, receivedAmount);

  /// Create a copy of SalePayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalePaymentImplCopyWith<_$SalePaymentImpl> get copyWith =>
      __$$SalePaymentImplCopyWithImpl<_$SalePaymentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalePaymentImplToJson(
      this,
    );
  }
}

abstract class _SalePayment implements SalePayment {
  const factory _SalePayment(
          {@JsonKey(name: 'sale_id') final int? saleId,
          @JsonKey(name: 'company_id') final int? companyId,
          final String? reference,
          @JsonKey(name: 'payment_date') final DateTime? paymentDate,
          @JsonKey(name: 'payment_type') final PaymentType? paymentType,
          @JsonKey(name: 'payment_method') final String? paymentMethod,
          final double? amount,
          @JsonKey(name: 'received_amount') final double? receivedAmount}) =
      _$SalePaymentImpl;

  factory _SalePayment.fromJson(Map<String, dynamic> json) =
      _$SalePaymentImpl.fromJson;

  @override
  @JsonKey(name: 'sale_id')
  int? get saleId;
  @override
  @JsonKey(name: 'company_id')
  int? get companyId;
  @override
  String? get reference;
  @override
  @JsonKey(name: 'payment_date')
  DateTime? get paymentDate;
  @override
  @JsonKey(name: 'payment_type')
  PaymentType? get paymentType;
  @override
  @JsonKey(name: 'payment_method')
  String? get paymentMethod;
  @override
  double? get amount;
  @override
  @JsonKey(name: 'received_amount')
  double? get receivedAmount;

  /// Create a copy of SalePayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalePaymentImplCopyWith<_$SalePaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
