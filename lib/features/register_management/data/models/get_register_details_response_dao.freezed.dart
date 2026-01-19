// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_register_details_response_dao.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetRegisterDetailsResponseDao _$GetRegisterDetailsResponseDaoFromJson(
    Map<String, dynamic> json) {
  return _GetRegisterDetailsResponseDao.fromJson(json);
}

/// @nodoc
mixin _$GetRegisterDetailsResponseDao {
  @JsonKey(name: 'today_sales_amount')
  double? get todaySalesAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'today_sales_cash_payment')
  double? get todaySalesCashPayment => throw _privateConstructorUsedError;
  @JsonKey(name: 'today_sales_folio_payment')
  double? get todaySalesFolioPayment => throw _privateConstructorUsedError;
  @JsonKey(name: 'today_sales_pos_payment')
  double? get todaySalesPosPayment => throw _privateConstructorUsedError;
  @JsonKey(name: 'today_sales_bank_transfer_payment')
  double? get todaySalesBankTransferPayment =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'today_sales_other_payment')
  double? get todaySalesOtherPayment => throw _privateConstructorUsedError;
  @JsonKey(name: 'today_sales_return_amount')
  double? get todaySalesReturnAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'today_sales_payment_amount')
  double? get todaySalesPaymentAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'refunded_cash')
  double? get refundedCash => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_stock_returned')
  double? get totalStockReturned => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_stock_sold')
  double? get totalStockSold => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_stock_remaining')
  double? get totalStockRemaining => throw _privateConstructorUsedError;
  @JsonKey(name: 'items_sold')
  List<SaleItem>? get itemsSold => throw _privateConstructorUsedError;
  @JsonKey(name: 'today_sales')
  List<RegisterSaleDao>? get todaySales => throw _privateConstructorUsedError;
  @JsonKey(name: 'opened_at')
  DateTime? get openedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'closed_at')
  DateTime? get closedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'cash_in_hand')
  double? get cashInHand => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_cash_amount')
  double? get totalCashAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_closed')
  @IntOrBoolToBoolConverter()
  bool get isClosed => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff')
  GetRegisterDetailsResponseStaffDao? get staff =>
      throw _privateConstructorUsedError;

  /// Serializes this GetRegisterDetailsResponseDao to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetRegisterDetailsResponseDao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetRegisterDetailsResponseDaoCopyWith<GetRegisterDetailsResponseDao>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetRegisterDetailsResponseDaoCopyWith<$Res> {
  factory $GetRegisterDetailsResponseDaoCopyWith(
          GetRegisterDetailsResponseDao value,
          $Res Function(GetRegisterDetailsResponseDao) then) =
      _$GetRegisterDetailsResponseDaoCopyWithImpl<$Res,
          GetRegisterDetailsResponseDao>;
  @useResult
  $Res call(
      {@JsonKey(name: 'today_sales_amount') double? todaySalesAmount,
      @JsonKey(name: 'today_sales_cash_payment') double? todaySalesCashPayment,
      @JsonKey(name: 'today_sales_folio_payment')
      double? todaySalesFolioPayment,
      @JsonKey(name: 'today_sales_pos_payment') double? todaySalesPosPayment,
      @JsonKey(name: 'today_sales_bank_transfer_payment')
      double? todaySalesBankTransferPayment,
      @JsonKey(name: 'today_sales_other_payment')
      double? todaySalesOtherPayment,
      @JsonKey(name: 'today_sales_return_amount')
      double? todaySalesReturnAmount,
      @JsonKey(name: 'today_sales_payment_amount')
      double? todaySalesPaymentAmount,
      @JsonKey(name: 'refunded_cash') double? refundedCash,
      @JsonKey(name: 'total_stock_returned') double? totalStockReturned,
      @JsonKey(name: 'total_stock_sold') double? totalStockSold,
      @JsonKey(name: 'total_stock_remaining') double? totalStockRemaining,
      @JsonKey(name: 'items_sold') List<SaleItem>? itemsSold,
      @JsonKey(name: 'today_sales') List<RegisterSaleDao>? todaySales,
      @JsonKey(name: 'opened_at') DateTime? openedAt,
      @JsonKey(name: 'closed_at') DateTime? closedAt,
      @JsonKey(name: 'cash_in_hand') double? cashInHand,
      @JsonKey(name: 'total_cash_amount') double? totalCashAmount,
      @JsonKey(name: 'is_closed') @IntOrBoolToBoolConverter() bool isClosed,
      @JsonKey(name: 'staff') GetRegisterDetailsResponseStaffDao? staff});

  $GetRegisterDetailsResponseStaffDaoCopyWith<$Res>? get staff;
}

/// @nodoc
class _$GetRegisterDetailsResponseDaoCopyWithImpl<$Res,
        $Val extends GetRegisterDetailsResponseDao>
    implements $GetRegisterDetailsResponseDaoCopyWith<$Res> {
  _$GetRegisterDetailsResponseDaoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetRegisterDetailsResponseDao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todaySalesAmount = freezed,
    Object? todaySalesCashPayment = freezed,
    Object? todaySalesFolioPayment = freezed,
    Object? todaySalesPosPayment = freezed,
    Object? todaySalesBankTransferPayment = freezed,
    Object? todaySalesOtherPayment = freezed,
    Object? todaySalesReturnAmount = freezed,
    Object? todaySalesPaymentAmount = freezed,
    Object? refundedCash = freezed,
    Object? totalStockReturned = freezed,
    Object? totalStockSold = freezed,
    Object? totalStockRemaining = freezed,
    Object? itemsSold = freezed,
    Object? todaySales = freezed,
    Object? openedAt = freezed,
    Object? closedAt = freezed,
    Object? cashInHand = freezed,
    Object? totalCashAmount = freezed,
    Object? isClosed = null,
    Object? staff = freezed,
  }) {
    return _then(_value.copyWith(
      todaySalesAmount: freezed == todaySalesAmount
          ? _value.todaySalesAmount
          : todaySalesAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      todaySalesCashPayment: freezed == todaySalesCashPayment
          ? _value.todaySalesCashPayment
          : todaySalesCashPayment // ignore: cast_nullable_to_non_nullable
              as double?,
      todaySalesFolioPayment: freezed == todaySalesFolioPayment
          ? _value.todaySalesFolioPayment
          : todaySalesFolioPayment // ignore: cast_nullable_to_non_nullable
              as double?,
      todaySalesPosPayment: freezed == todaySalesPosPayment
          ? _value.todaySalesPosPayment
          : todaySalesPosPayment // ignore: cast_nullable_to_non_nullable
              as double?,
      todaySalesBankTransferPayment: freezed == todaySalesBankTransferPayment
          ? _value.todaySalesBankTransferPayment
          : todaySalesBankTransferPayment // ignore: cast_nullable_to_non_nullable
              as double?,
      todaySalesOtherPayment: freezed == todaySalesOtherPayment
          ? _value.todaySalesOtherPayment
          : todaySalesOtherPayment // ignore: cast_nullable_to_non_nullable
              as double?,
      todaySalesReturnAmount: freezed == todaySalesReturnAmount
          ? _value.todaySalesReturnAmount
          : todaySalesReturnAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      todaySalesPaymentAmount: freezed == todaySalesPaymentAmount
          ? _value.todaySalesPaymentAmount
          : todaySalesPaymentAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      refundedCash: freezed == refundedCash
          ? _value.refundedCash
          : refundedCash // ignore: cast_nullable_to_non_nullable
              as double?,
      totalStockReturned: freezed == totalStockReturned
          ? _value.totalStockReturned
          : totalStockReturned // ignore: cast_nullable_to_non_nullable
              as double?,
      totalStockSold: freezed == totalStockSold
          ? _value.totalStockSold
          : totalStockSold // ignore: cast_nullable_to_non_nullable
              as double?,
      totalStockRemaining: freezed == totalStockRemaining
          ? _value.totalStockRemaining
          : totalStockRemaining // ignore: cast_nullable_to_non_nullable
              as double?,
      itemsSold: freezed == itemsSold
          ? _value.itemsSold
          : itemsSold // ignore: cast_nullable_to_non_nullable
              as List<SaleItem>?,
      todaySales: freezed == todaySales
          ? _value.todaySales
          : todaySales // ignore: cast_nullable_to_non_nullable
              as List<RegisterSaleDao>?,
      openedAt: freezed == openedAt
          ? _value.openedAt
          : openedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      closedAt: freezed == closedAt
          ? _value.closedAt
          : closedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cashInHand: freezed == cashInHand
          ? _value.cashInHand
          : cashInHand // ignore: cast_nullable_to_non_nullable
              as double?,
      totalCashAmount: freezed == totalCashAmount
          ? _value.totalCashAmount
          : totalCashAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      isClosed: null == isClosed
          ? _value.isClosed
          : isClosed // ignore: cast_nullable_to_non_nullable
              as bool,
      staff: freezed == staff
          ? _value.staff
          : staff // ignore: cast_nullable_to_non_nullable
              as GetRegisterDetailsResponseStaffDao?,
    ) as $Val);
  }

  /// Create a copy of GetRegisterDetailsResponseDao
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GetRegisterDetailsResponseStaffDaoCopyWith<$Res>? get staff {
    if (_value.staff == null) {
      return null;
    }

    return $GetRegisterDetailsResponseStaffDaoCopyWith<$Res>(_value.staff!,
        (value) {
      return _then(_value.copyWith(staff: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetRegisterDetailsResponseDaoImplCopyWith<$Res>
    implements $GetRegisterDetailsResponseDaoCopyWith<$Res> {
  factory _$$GetRegisterDetailsResponseDaoImplCopyWith(
          _$GetRegisterDetailsResponseDaoImpl value,
          $Res Function(_$GetRegisterDetailsResponseDaoImpl) then) =
      __$$GetRegisterDetailsResponseDaoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'today_sales_amount') double? todaySalesAmount,
      @JsonKey(name: 'today_sales_cash_payment') double? todaySalesCashPayment,
      @JsonKey(name: 'today_sales_folio_payment')
      double? todaySalesFolioPayment,
      @JsonKey(name: 'today_sales_pos_payment') double? todaySalesPosPayment,
      @JsonKey(name: 'today_sales_bank_transfer_payment')
      double? todaySalesBankTransferPayment,
      @JsonKey(name: 'today_sales_other_payment')
      double? todaySalesOtherPayment,
      @JsonKey(name: 'today_sales_return_amount')
      double? todaySalesReturnAmount,
      @JsonKey(name: 'today_sales_payment_amount')
      double? todaySalesPaymentAmount,
      @JsonKey(name: 'refunded_cash') double? refundedCash,
      @JsonKey(name: 'total_stock_returned') double? totalStockReturned,
      @JsonKey(name: 'total_stock_sold') double? totalStockSold,
      @JsonKey(name: 'total_stock_remaining') double? totalStockRemaining,
      @JsonKey(name: 'items_sold') List<SaleItem>? itemsSold,
      @JsonKey(name: 'today_sales') List<RegisterSaleDao>? todaySales,
      @JsonKey(name: 'opened_at') DateTime? openedAt,
      @JsonKey(name: 'closed_at') DateTime? closedAt,
      @JsonKey(name: 'cash_in_hand') double? cashInHand,
      @JsonKey(name: 'total_cash_amount') double? totalCashAmount,
      @JsonKey(name: 'is_closed') @IntOrBoolToBoolConverter() bool isClosed,
      @JsonKey(name: 'staff') GetRegisterDetailsResponseStaffDao? staff});

  @override
  $GetRegisterDetailsResponseStaffDaoCopyWith<$Res>? get staff;
}

/// @nodoc
class __$$GetRegisterDetailsResponseDaoImplCopyWithImpl<$Res>
    extends _$GetRegisterDetailsResponseDaoCopyWithImpl<$Res,
        _$GetRegisterDetailsResponseDaoImpl>
    implements _$$GetRegisterDetailsResponseDaoImplCopyWith<$Res> {
  __$$GetRegisterDetailsResponseDaoImplCopyWithImpl(
      _$GetRegisterDetailsResponseDaoImpl _value,
      $Res Function(_$GetRegisterDetailsResponseDaoImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetRegisterDetailsResponseDao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todaySalesAmount = freezed,
    Object? todaySalesCashPayment = freezed,
    Object? todaySalesFolioPayment = freezed,
    Object? todaySalesPosPayment = freezed,
    Object? todaySalesBankTransferPayment = freezed,
    Object? todaySalesOtherPayment = freezed,
    Object? todaySalesReturnAmount = freezed,
    Object? todaySalesPaymentAmount = freezed,
    Object? refundedCash = freezed,
    Object? totalStockReturned = freezed,
    Object? totalStockSold = freezed,
    Object? totalStockRemaining = freezed,
    Object? itemsSold = freezed,
    Object? todaySales = freezed,
    Object? openedAt = freezed,
    Object? closedAt = freezed,
    Object? cashInHand = freezed,
    Object? totalCashAmount = freezed,
    Object? isClosed = null,
    Object? staff = freezed,
  }) {
    return _then(_$GetRegisterDetailsResponseDaoImpl(
      todaySalesAmount: freezed == todaySalesAmount
          ? _value.todaySalesAmount
          : todaySalesAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      todaySalesCashPayment: freezed == todaySalesCashPayment
          ? _value.todaySalesCashPayment
          : todaySalesCashPayment // ignore: cast_nullable_to_non_nullable
              as double?,
      todaySalesFolioPayment: freezed == todaySalesFolioPayment
          ? _value.todaySalesFolioPayment
          : todaySalesFolioPayment // ignore: cast_nullable_to_non_nullable
              as double?,
      todaySalesPosPayment: freezed == todaySalesPosPayment
          ? _value.todaySalesPosPayment
          : todaySalesPosPayment // ignore: cast_nullable_to_non_nullable
              as double?,
      todaySalesBankTransferPayment: freezed == todaySalesBankTransferPayment
          ? _value.todaySalesBankTransferPayment
          : todaySalesBankTransferPayment // ignore: cast_nullable_to_non_nullable
              as double?,
      todaySalesOtherPayment: freezed == todaySalesOtherPayment
          ? _value.todaySalesOtherPayment
          : todaySalesOtherPayment // ignore: cast_nullable_to_non_nullable
              as double?,
      todaySalesReturnAmount: freezed == todaySalesReturnAmount
          ? _value.todaySalesReturnAmount
          : todaySalesReturnAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      todaySalesPaymentAmount: freezed == todaySalesPaymentAmount
          ? _value.todaySalesPaymentAmount
          : todaySalesPaymentAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      refundedCash: freezed == refundedCash
          ? _value.refundedCash
          : refundedCash // ignore: cast_nullable_to_non_nullable
              as double?,
      totalStockReturned: freezed == totalStockReturned
          ? _value.totalStockReturned
          : totalStockReturned // ignore: cast_nullable_to_non_nullable
              as double?,
      totalStockSold: freezed == totalStockSold
          ? _value.totalStockSold
          : totalStockSold // ignore: cast_nullable_to_non_nullable
              as double?,
      totalStockRemaining: freezed == totalStockRemaining
          ? _value.totalStockRemaining
          : totalStockRemaining // ignore: cast_nullable_to_non_nullable
              as double?,
      itemsSold: freezed == itemsSold
          ? _value._itemsSold
          : itemsSold // ignore: cast_nullable_to_non_nullable
              as List<SaleItem>?,
      todaySales: freezed == todaySales
          ? _value._todaySales
          : todaySales // ignore: cast_nullable_to_non_nullable
              as List<RegisterSaleDao>?,
      openedAt: freezed == openedAt
          ? _value.openedAt
          : openedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      closedAt: freezed == closedAt
          ? _value.closedAt
          : closedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cashInHand: freezed == cashInHand
          ? _value.cashInHand
          : cashInHand // ignore: cast_nullable_to_non_nullable
              as double?,
      totalCashAmount: freezed == totalCashAmount
          ? _value.totalCashAmount
          : totalCashAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      isClosed: null == isClosed
          ? _value.isClosed
          : isClosed // ignore: cast_nullable_to_non_nullable
              as bool,
      staff: freezed == staff
          ? _value.staff
          : staff // ignore: cast_nullable_to_non_nullable
              as GetRegisterDetailsResponseStaffDao?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetRegisterDetailsResponseDaoImpl
    implements _GetRegisterDetailsResponseDao {
  const _$GetRegisterDetailsResponseDaoImpl(
      {@JsonKey(name: 'today_sales_amount') this.todaySalesAmount,
      @JsonKey(name: 'today_sales_cash_payment') this.todaySalesCashPayment,
      @JsonKey(name: 'today_sales_folio_payment') this.todaySalesFolioPayment,
      @JsonKey(name: 'today_sales_pos_payment') this.todaySalesPosPayment,
      @JsonKey(name: 'today_sales_bank_transfer_payment')
      this.todaySalesBankTransferPayment,
      @JsonKey(name: 'today_sales_other_payment') this.todaySalesOtherPayment,
      @JsonKey(name: 'today_sales_return_amount') this.todaySalesReturnAmount,
      @JsonKey(name: 'today_sales_payment_amount') this.todaySalesPaymentAmount,
      @JsonKey(name: 'refunded_cash') this.refundedCash,
      @JsonKey(name: 'total_stock_returned') this.totalStockReturned,
      @JsonKey(name: 'total_stock_sold') this.totalStockSold,
      @JsonKey(name: 'total_stock_remaining') this.totalStockRemaining,
      @JsonKey(name: 'items_sold') final List<SaleItem>? itemsSold,
      @JsonKey(name: 'today_sales') final List<RegisterSaleDao>? todaySales,
      @JsonKey(name: 'opened_at') this.openedAt,
      @JsonKey(name: 'closed_at') this.closedAt,
      @JsonKey(name: 'cash_in_hand') this.cashInHand,
      @JsonKey(name: 'total_cash_amount') this.totalCashAmount,
      @JsonKey(name: 'is_closed')
      @IntOrBoolToBoolConverter()
      this.isClosed = false,
      @JsonKey(name: 'staff') this.staff})
      : _itemsSold = itemsSold,
        _todaySales = todaySales;

  factory _$GetRegisterDetailsResponseDaoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetRegisterDetailsResponseDaoImplFromJson(json);

  @override
  @JsonKey(name: 'today_sales_amount')
  final double? todaySalesAmount;
  @override
  @JsonKey(name: 'today_sales_cash_payment')
  final double? todaySalesCashPayment;
  @override
  @JsonKey(name: 'today_sales_folio_payment')
  final double? todaySalesFolioPayment;
  @override
  @JsonKey(name: 'today_sales_pos_payment')
  final double? todaySalesPosPayment;
  @override
  @JsonKey(name: 'today_sales_bank_transfer_payment')
  final double? todaySalesBankTransferPayment;
  @override
  @JsonKey(name: 'today_sales_other_payment')
  final double? todaySalesOtherPayment;
  @override
  @JsonKey(name: 'today_sales_return_amount')
  final double? todaySalesReturnAmount;
  @override
  @JsonKey(name: 'today_sales_payment_amount')
  final double? todaySalesPaymentAmount;
  @override
  @JsonKey(name: 'refunded_cash')
  final double? refundedCash;
  @override
  @JsonKey(name: 'total_stock_returned')
  final double? totalStockReturned;
  @override
  @JsonKey(name: 'total_stock_sold')
  final double? totalStockSold;
  @override
  @JsonKey(name: 'total_stock_remaining')
  final double? totalStockRemaining;
  final List<SaleItem>? _itemsSold;
  @override
  @JsonKey(name: 'items_sold')
  List<SaleItem>? get itemsSold {
    final value = _itemsSold;
    if (value == null) return null;
    if (_itemsSold is EqualUnmodifiableListView) return _itemsSold;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<RegisterSaleDao>? _todaySales;
  @override
  @JsonKey(name: 'today_sales')
  List<RegisterSaleDao>? get todaySales {
    final value = _todaySales;
    if (value == null) return null;
    if (_todaySales is EqualUnmodifiableListView) return _todaySales;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'opened_at')
  final DateTime? openedAt;
  @override
  @JsonKey(name: 'closed_at')
  final DateTime? closedAt;
  @override
  @JsonKey(name: 'cash_in_hand')
  final double? cashInHand;
  @override
  @JsonKey(name: 'total_cash_amount')
  final double? totalCashAmount;
  @override
  @JsonKey(name: 'is_closed')
  @IntOrBoolToBoolConverter()
  final bool isClosed;
  @override
  @JsonKey(name: 'staff')
  final GetRegisterDetailsResponseStaffDao? staff;

  @override
  String toString() {
    return 'GetRegisterDetailsResponseDao(todaySalesAmount: $todaySalesAmount, todaySalesCashPayment: $todaySalesCashPayment, todaySalesFolioPayment: $todaySalesFolioPayment, todaySalesPosPayment: $todaySalesPosPayment, todaySalesBankTransferPayment: $todaySalesBankTransferPayment, todaySalesOtherPayment: $todaySalesOtherPayment, todaySalesReturnAmount: $todaySalesReturnAmount, todaySalesPaymentAmount: $todaySalesPaymentAmount, refundedCash: $refundedCash, totalStockReturned: $totalStockReturned, totalStockSold: $totalStockSold, totalStockRemaining: $totalStockRemaining, itemsSold: $itemsSold, todaySales: $todaySales, openedAt: $openedAt, closedAt: $closedAt, cashInHand: $cashInHand, totalCashAmount: $totalCashAmount, isClosed: $isClosed, staff: $staff)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetRegisterDetailsResponseDaoImpl &&
            (identical(other.todaySalesAmount, todaySalesAmount) ||
                other.todaySalesAmount == todaySalesAmount) &&
            (identical(other.todaySalesCashPayment, todaySalesCashPayment) ||
                other.todaySalesCashPayment == todaySalesCashPayment) &&
            (identical(other.todaySalesFolioPayment, todaySalesFolioPayment) ||
                other.todaySalesFolioPayment == todaySalesFolioPayment) &&
            (identical(other.todaySalesPosPayment, todaySalesPosPayment) ||
                other.todaySalesPosPayment == todaySalesPosPayment) &&
            (identical(other.todaySalesBankTransferPayment,
                    todaySalesBankTransferPayment) ||
                other.todaySalesBankTransferPayment ==
                    todaySalesBankTransferPayment) &&
            (identical(other.todaySalesOtherPayment, todaySalesOtherPayment) ||
                other.todaySalesOtherPayment == todaySalesOtherPayment) &&
            (identical(other.todaySalesReturnAmount, todaySalesReturnAmount) ||
                other.todaySalesReturnAmount == todaySalesReturnAmount) &&
            (identical(
                    other.todaySalesPaymentAmount, todaySalesPaymentAmount) ||
                other.todaySalesPaymentAmount == todaySalesPaymentAmount) &&
            (identical(other.refundedCash, refundedCash) ||
                other.refundedCash == refundedCash) &&
            (identical(other.totalStockReturned, totalStockReturned) ||
                other.totalStockReturned == totalStockReturned) &&
            (identical(other.totalStockSold, totalStockSold) ||
                other.totalStockSold == totalStockSold) &&
            (identical(other.totalStockRemaining, totalStockRemaining) ||
                other.totalStockRemaining == totalStockRemaining) &&
            const DeepCollectionEquality()
                .equals(other._itemsSold, _itemsSold) &&
            const DeepCollectionEquality()
                .equals(other._todaySales, _todaySales) &&
            (identical(other.openedAt, openedAt) ||
                other.openedAt == openedAt) &&
            (identical(other.closedAt, closedAt) ||
                other.closedAt == closedAt) &&
            (identical(other.cashInHand, cashInHand) ||
                other.cashInHand == cashInHand) &&
            (identical(other.totalCashAmount, totalCashAmount) ||
                other.totalCashAmount == totalCashAmount) &&
            (identical(other.isClosed, isClosed) ||
                other.isClosed == isClosed) &&
            (identical(other.staff, staff) || other.staff == staff));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        todaySalesAmount,
        todaySalesCashPayment,
        todaySalesFolioPayment,
        todaySalesPosPayment,
        todaySalesBankTransferPayment,
        todaySalesOtherPayment,
        todaySalesReturnAmount,
        todaySalesPaymentAmount,
        refundedCash,
        totalStockReturned,
        totalStockSold,
        totalStockRemaining,
        const DeepCollectionEquality().hash(_itemsSold),
        const DeepCollectionEquality().hash(_todaySales),
        openedAt,
        closedAt,
        cashInHand,
        totalCashAmount,
        isClosed,
        staff
      ]);

  /// Create a copy of GetRegisterDetailsResponseDao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetRegisterDetailsResponseDaoImplCopyWith<
          _$GetRegisterDetailsResponseDaoImpl>
      get copyWith => __$$GetRegisterDetailsResponseDaoImplCopyWithImpl<
          _$GetRegisterDetailsResponseDaoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetRegisterDetailsResponseDaoImplToJson(
      this,
    );
  }
}

abstract class _GetRegisterDetailsResponseDao
    implements GetRegisterDetailsResponseDao {
  const factory _GetRegisterDetailsResponseDao(
      {@JsonKey(name: 'today_sales_amount') final double? todaySalesAmount,
      @JsonKey(name: 'today_sales_cash_payment')
      final double? todaySalesCashPayment,
      @JsonKey(name: 'today_sales_folio_payment')
      final double? todaySalesFolioPayment,
      @JsonKey(name: 'today_sales_pos_payment')
      final double? todaySalesPosPayment,
      @JsonKey(name: 'today_sales_bank_transfer_payment')
      final double? todaySalesBankTransferPayment,
      @JsonKey(name: 'today_sales_other_payment')
      final double? todaySalesOtherPayment,
      @JsonKey(name: 'today_sales_return_amount')
      final double? todaySalesReturnAmount,
      @JsonKey(name: 'today_sales_payment_amount')
      final double? todaySalesPaymentAmount,
      @JsonKey(name: 'refunded_cash') final double? refundedCash,
      @JsonKey(name: 'total_stock_returned') final double? totalStockReturned,
      @JsonKey(name: 'total_stock_sold') final double? totalStockSold,
      @JsonKey(name: 'total_stock_remaining') final double? totalStockRemaining,
      @JsonKey(name: 'items_sold') final List<SaleItem>? itemsSold,
      @JsonKey(name: 'today_sales') final List<RegisterSaleDao>? todaySales,
      @JsonKey(name: 'opened_at') final DateTime? openedAt,
      @JsonKey(name: 'closed_at') final DateTime? closedAt,
      @JsonKey(name: 'cash_in_hand') final double? cashInHand,
      @JsonKey(name: 'total_cash_amount') final double? totalCashAmount,
      @JsonKey(name: 'is_closed')
      @IntOrBoolToBoolConverter()
      final bool isClosed,
      @JsonKey(name: 'staff')
      final GetRegisterDetailsResponseStaffDao?
          staff}) = _$GetRegisterDetailsResponseDaoImpl;

  factory _GetRegisterDetailsResponseDao.fromJson(Map<String, dynamic> json) =
      _$GetRegisterDetailsResponseDaoImpl.fromJson;

  @override
  @JsonKey(name: 'today_sales_amount')
  double? get todaySalesAmount;
  @override
  @JsonKey(name: 'today_sales_cash_payment')
  double? get todaySalesCashPayment;
  @override
  @JsonKey(name: 'today_sales_folio_payment')
  double? get todaySalesFolioPayment;
  @override
  @JsonKey(name: 'today_sales_pos_payment')
  double? get todaySalesPosPayment;
  @override
  @JsonKey(name: 'today_sales_bank_transfer_payment')
  double? get todaySalesBankTransferPayment;
  @override
  @JsonKey(name: 'today_sales_other_payment')
  double? get todaySalesOtherPayment;
  @override
  @JsonKey(name: 'today_sales_return_amount')
  double? get todaySalesReturnAmount;
  @override
  @JsonKey(name: 'today_sales_payment_amount')
  double? get todaySalesPaymentAmount;
  @override
  @JsonKey(name: 'refunded_cash')
  double? get refundedCash;
  @override
  @JsonKey(name: 'total_stock_returned')
  double? get totalStockReturned;
  @override
  @JsonKey(name: 'total_stock_sold')
  double? get totalStockSold;
  @override
  @JsonKey(name: 'total_stock_remaining')
  double? get totalStockRemaining;
  @override
  @JsonKey(name: 'items_sold')
  List<SaleItem>? get itemsSold;
  @override
  @JsonKey(name: 'today_sales')
  List<RegisterSaleDao>? get todaySales;
  @override
  @JsonKey(name: 'opened_at')
  DateTime? get openedAt;
  @override
  @JsonKey(name: 'closed_at')
  DateTime? get closedAt;
  @override
  @JsonKey(name: 'cash_in_hand')
  double? get cashInHand;
  @override
  @JsonKey(name: 'total_cash_amount')
  double? get totalCashAmount;
  @override
  @JsonKey(name: 'is_closed')
  @IntOrBoolToBoolConverter()
  bool get isClosed;
  @override
  @JsonKey(name: 'staff')
  GetRegisterDetailsResponseStaffDao? get staff;

  /// Create a copy of GetRegisterDetailsResponseDao
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetRegisterDetailsResponseDaoImplCopyWith<
          _$GetRegisterDetailsResponseDaoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

RegisterSaleDao _$RegisterSaleDaoFromJson(Map<String, dynamic> json) {
  return _RegisterSaleDao.fromJson(json);
}

/// @nodoc
mixin _$RegisterSaleDao {
  int? get id => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_return')
  int? get isReturn => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_id')
  int? get customerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'warehouse_id')
  int? get warehouseId => throw _privateConstructorUsedError;
  @JsonKey(name: 'folio_id')
  int? get folioId => throw _privateConstructorUsedError;
  @JsonKey(name: 'table_id')
  int? get tableId => throw _privateConstructorUsedError;
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
  @JsonKey(name: 'partial_amount')
  @StringOrNumToDoubleConverter()
  double? get partialAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_type')
  int? get paymentType => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  @JsonKey(name: 'reference_code')
  String? get referenceCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_direct_delivery')
  int? get isDirectDelivery => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_status')
  PaymentStatus? get paymentStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'company_id')
  int? get companyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_offline')
  int? get isOffline => throw _privateConstructorUsedError;
  @JsonKey(name: 'offline_customer_name')
  String? get offlineCustomerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_id')
  int? get staffId => throw _privateConstructorUsedError;
  @JsonKey(name: 'purchase_id')
  int? get purchaseId => throw _privateConstructorUsedError;
  @JsonKey(name: 'shipment_id')
  int? get shipmentId => throw _privateConstructorUsedError;

  /// Serializes this RegisterSaleDao to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegisterSaleDao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterSaleDaoCopyWith<RegisterSaleDao> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterSaleDaoCopyWith<$Res> {
  factory $RegisterSaleDaoCopyWith(
          RegisterSaleDao value, $Res Function(RegisterSaleDao) then) =
      _$RegisterSaleDaoCopyWithImpl<$Res, RegisterSaleDao>;
  @useResult
  $Res call(
      {int? id,
      DateTime? date,
      @JsonKey(name: 'is_return') int? isReturn,
      @JsonKey(name: 'customer_id') int? customerId,
      @JsonKey(name: 'warehouse_id') int? warehouseId,
      @JsonKey(name: 'folio_id') int? folioId,
      @JsonKey(name: 'table_id') int? tableId,
      @JsonKey(name: 'tax_rate') double? taxRate,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      double? discount,
      double? shipping,
      @JsonKey(name: 'grand_total') double? grandTotal,
      @JsonKey(name: 'received_amount') double? receivedAmount,
      @JsonKey(name: 'paid_amount') double? paidAmount,
      @JsonKey(name: 'partial_amount')
      @StringOrNumToDoubleConverter()
      double? partialAmount,
      @JsonKey(name: 'payment_type') int? paymentType,
      String? note,
      @JsonKey(name: 'reference_code') String? referenceCode,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      int? status,
      @JsonKey(name: 'is_direct_delivery') int? isDirectDelivery,
      @JsonKey(name: 'payment_status') PaymentStatus? paymentStatus,
      @JsonKey(name: 'user_id') int? userId,
      @JsonKey(name: 'company_id') int? companyId,
      @JsonKey(name: 'is_offline') int? isOffline,
      @JsonKey(name: 'offline_customer_name') String? offlineCustomerName,
      @JsonKey(name: 'staff_id') int? staffId,
      @JsonKey(name: 'purchase_id') int? purchaseId,
      @JsonKey(name: 'shipment_id') int? shipmentId});
}

/// @nodoc
class _$RegisterSaleDaoCopyWithImpl<$Res, $Val extends RegisterSaleDao>
    implements $RegisterSaleDaoCopyWith<$Res> {
  _$RegisterSaleDaoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterSaleDao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? date = freezed,
    Object? isReturn = freezed,
    Object? customerId = freezed,
    Object? warehouseId = freezed,
    Object? folioId = freezed,
    Object? tableId = freezed,
    Object? taxRate = freezed,
    Object? taxAmount = freezed,
    Object? discount = freezed,
    Object? shipping = freezed,
    Object? grandTotal = freezed,
    Object? receivedAmount = freezed,
    Object? paidAmount = freezed,
    Object? partialAmount = freezed,
    Object? paymentType = freezed,
    Object? note = freezed,
    Object? referenceCode = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? status = freezed,
    Object? isDirectDelivery = freezed,
    Object? paymentStatus = freezed,
    Object? userId = freezed,
    Object? companyId = freezed,
    Object? isOffline = freezed,
    Object? offlineCustomerName = freezed,
    Object? staffId = freezed,
    Object? purchaseId = freezed,
    Object? shipmentId = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
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
      warehouseId: freezed == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as int?,
      folioId: freezed == folioId
          ? _value.folioId
          : folioId // ignore: cast_nullable_to_non_nullable
              as int?,
      tableId: freezed == tableId
          ? _value.tableId
          : tableId // ignore: cast_nullable_to_non_nullable
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
      paymentType: freezed == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as int?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceCode: freezed == referenceCode
          ? _value.referenceCode
          : referenceCode // ignore: cast_nullable_to_non_nullable
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
      isDirectDelivery: freezed == isDirectDelivery
          ? _value.isDirectDelivery
          : isDirectDelivery // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentStatus: freezed == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as PaymentStatus?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as int?,
      isOffline: freezed == isOffline
          ? _value.isOffline
          : isOffline // ignore: cast_nullable_to_non_nullable
              as int?,
      offlineCustomerName: freezed == offlineCustomerName
          ? _value.offlineCustomerName
          : offlineCustomerName // ignore: cast_nullable_to_non_nullable
              as String?,
      staffId: freezed == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int?,
      purchaseId: freezed == purchaseId
          ? _value.purchaseId
          : purchaseId // ignore: cast_nullable_to_non_nullable
              as int?,
      shipmentId: freezed == shipmentId
          ? _value.shipmentId
          : shipmentId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterSaleDaoImplCopyWith<$Res>
    implements $RegisterSaleDaoCopyWith<$Res> {
  factory _$$RegisterSaleDaoImplCopyWith(_$RegisterSaleDaoImpl value,
          $Res Function(_$RegisterSaleDaoImpl) then) =
      __$$RegisterSaleDaoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      DateTime? date,
      @JsonKey(name: 'is_return') int? isReturn,
      @JsonKey(name: 'customer_id') int? customerId,
      @JsonKey(name: 'warehouse_id') int? warehouseId,
      @JsonKey(name: 'folio_id') int? folioId,
      @JsonKey(name: 'table_id') int? tableId,
      @JsonKey(name: 'tax_rate') double? taxRate,
      @JsonKey(name: 'tax_amount') double? taxAmount,
      double? discount,
      double? shipping,
      @JsonKey(name: 'grand_total') double? grandTotal,
      @JsonKey(name: 'received_amount') double? receivedAmount,
      @JsonKey(name: 'paid_amount') double? paidAmount,
      @JsonKey(name: 'partial_amount')
      @StringOrNumToDoubleConverter()
      double? partialAmount,
      @JsonKey(name: 'payment_type') int? paymentType,
      String? note,
      @JsonKey(name: 'reference_code') String? referenceCode,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      int? status,
      @JsonKey(name: 'is_direct_delivery') int? isDirectDelivery,
      @JsonKey(name: 'payment_status') PaymentStatus? paymentStatus,
      @JsonKey(name: 'user_id') int? userId,
      @JsonKey(name: 'company_id') int? companyId,
      @JsonKey(name: 'is_offline') int? isOffline,
      @JsonKey(name: 'offline_customer_name') String? offlineCustomerName,
      @JsonKey(name: 'staff_id') int? staffId,
      @JsonKey(name: 'purchase_id') int? purchaseId,
      @JsonKey(name: 'shipment_id') int? shipmentId});
}

/// @nodoc
class __$$RegisterSaleDaoImplCopyWithImpl<$Res>
    extends _$RegisterSaleDaoCopyWithImpl<$Res, _$RegisterSaleDaoImpl>
    implements _$$RegisterSaleDaoImplCopyWith<$Res> {
  __$$RegisterSaleDaoImplCopyWithImpl(
      _$RegisterSaleDaoImpl _value, $Res Function(_$RegisterSaleDaoImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterSaleDao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? date = freezed,
    Object? isReturn = freezed,
    Object? customerId = freezed,
    Object? warehouseId = freezed,
    Object? folioId = freezed,
    Object? tableId = freezed,
    Object? taxRate = freezed,
    Object? taxAmount = freezed,
    Object? discount = freezed,
    Object? shipping = freezed,
    Object? grandTotal = freezed,
    Object? receivedAmount = freezed,
    Object? paidAmount = freezed,
    Object? partialAmount = freezed,
    Object? paymentType = freezed,
    Object? note = freezed,
    Object? referenceCode = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? status = freezed,
    Object? isDirectDelivery = freezed,
    Object? paymentStatus = freezed,
    Object? userId = freezed,
    Object? companyId = freezed,
    Object? isOffline = freezed,
    Object? offlineCustomerName = freezed,
    Object? staffId = freezed,
    Object? purchaseId = freezed,
    Object? shipmentId = freezed,
  }) {
    return _then(_$RegisterSaleDaoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
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
      warehouseId: freezed == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as int?,
      folioId: freezed == folioId
          ? _value.folioId
          : folioId // ignore: cast_nullable_to_non_nullable
              as int?,
      tableId: freezed == tableId
          ? _value.tableId
          : tableId // ignore: cast_nullable_to_non_nullable
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
      paymentType: freezed == paymentType
          ? _value.paymentType
          : paymentType // ignore: cast_nullable_to_non_nullable
              as int?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceCode: freezed == referenceCode
          ? _value.referenceCode
          : referenceCode // ignore: cast_nullable_to_non_nullable
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
      isDirectDelivery: freezed == isDirectDelivery
          ? _value.isDirectDelivery
          : isDirectDelivery // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentStatus: freezed == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as PaymentStatus?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as int?,
      isOffline: freezed == isOffline
          ? _value.isOffline
          : isOffline // ignore: cast_nullable_to_non_nullable
              as int?,
      offlineCustomerName: freezed == offlineCustomerName
          ? _value.offlineCustomerName
          : offlineCustomerName // ignore: cast_nullable_to_non_nullable
              as String?,
      staffId: freezed == staffId
          ? _value.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as int?,
      purchaseId: freezed == purchaseId
          ? _value.purchaseId
          : purchaseId // ignore: cast_nullable_to_non_nullable
              as int?,
      shipmentId: freezed == shipmentId
          ? _value.shipmentId
          : shipmentId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterSaleDaoImpl implements _RegisterSaleDao {
  const _$RegisterSaleDaoImpl(
      {this.id,
      this.date,
      @JsonKey(name: 'is_return') this.isReturn,
      @JsonKey(name: 'customer_id') this.customerId,
      @JsonKey(name: 'warehouse_id') this.warehouseId,
      @JsonKey(name: 'folio_id') this.folioId,
      @JsonKey(name: 'table_id') this.tableId,
      @JsonKey(name: 'tax_rate') this.taxRate,
      @JsonKey(name: 'tax_amount') this.taxAmount,
      this.discount,
      this.shipping,
      @JsonKey(name: 'grand_total') this.grandTotal,
      @JsonKey(name: 'received_amount') this.receivedAmount,
      @JsonKey(name: 'paid_amount') this.paidAmount,
      @JsonKey(name: 'partial_amount')
      @StringOrNumToDoubleConverter()
      this.partialAmount,
      @JsonKey(name: 'payment_type') this.paymentType,
      this.note,
      @JsonKey(name: 'reference_code') this.referenceCode,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      this.status,
      @JsonKey(name: 'is_direct_delivery') this.isDirectDelivery,
      @JsonKey(name: 'payment_status') this.paymentStatus,
      @JsonKey(name: 'user_id') this.userId,
      @JsonKey(name: 'company_id') this.companyId,
      @JsonKey(name: 'is_offline') this.isOffline,
      @JsonKey(name: 'offline_customer_name') this.offlineCustomerName,
      @JsonKey(name: 'staff_id') this.staffId,
      @JsonKey(name: 'purchase_id') this.purchaseId,
      @JsonKey(name: 'shipment_id') this.shipmentId});

  factory _$RegisterSaleDaoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterSaleDaoImplFromJson(json);

  @override
  final int? id;
  @override
  final DateTime? date;
  @override
  @JsonKey(name: 'is_return')
  final int? isReturn;
  @override
  @JsonKey(name: 'customer_id')
  final int? customerId;
  @override
  @JsonKey(name: 'warehouse_id')
  final int? warehouseId;
  @override
  @JsonKey(name: 'folio_id')
  final int? folioId;
  @override
  @JsonKey(name: 'table_id')
  final int? tableId;
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
  @JsonKey(name: 'partial_amount')
  @StringOrNumToDoubleConverter()
  final double? partialAmount;
  @override
  @JsonKey(name: 'payment_type')
  final int? paymentType;
  @override
  final String? note;
  @override
  @JsonKey(name: 'reference_code')
  final String? referenceCode;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  final int? status;
  @override
  @JsonKey(name: 'is_direct_delivery')
  final int? isDirectDelivery;
  @override
  @JsonKey(name: 'payment_status')
  final PaymentStatus? paymentStatus;
  @override
  @JsonKey(name: 'user_id')
  final int? userId;
  @override
  @JsonKey(name: 'company_id')
  final int? companyId;
  @override
  @JsonKey(name: 'is_offline')
  final int? isOffline;
  @override
  @JsonKey(name: 'offline_customer_name')
  final String? offlineCustomerName;
  @override
  @JsonKey(name: 'staff_id')
  final int? staffId;
  @override
  @JsonKey(name: 'purchase_id')
  final int? purchaseId;
  @override
  @JsonKey(name: 'shipment_id')
  final int? shipmentId;

  @override
  String toString() {
    return 'RegisterSaleDao(id: $id, date: $date, isReturn: $isReturn, customerId: $customerId, warehouseId: $warehouseId, folioId: $folioId, tableId: $tableId, taxRate: $taxRate, taxAmount: $taxAmount, discount: $discount, shipping: $shipping, grandTotal: $grandTotal, receivedAmount: $receivedAmount, paidAmount: $paidAmount, partialAmount: $partialAmount, paymentType: $paymentType, note: $note, referenceCode: $referenceCode, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, isDirectDelivery: $isDirectDelivery, paymentStatus: $paymentStatus, userId: $userId, companyId: $companyId, isOffline: $isOffline, offlineCustomerName: $offlineCustomerName, staffId: $staffId, purchaseId: $purchaseId, shipmentId: $shipmentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterSaleDaoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isReturn, isReturn) ||
                other.isReturn == isReturn) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId) &&
            (identical(other.folioId, folioId) || other.folioId == folioId) &&
            (identical(other.tableId, tableId) || other.tableId == tableId) &&
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
            (identical(other.partialAmount, partialAmount) ||
                other.partialAmount == partialAmount) &&
            (identical(other.paymentType, paymentType) ||
                other.paymentType == paymentType) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.referenceCode, referenceCode) ||
                other.referenceCode == referenceCode) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isDirectDelivery, isDirectDelivery) ||
                other.isDirectDelivery == isDirectDelivery) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.isOffline, isOffline) ||
                other.isOffline == isOffline) &&
            (identical(other.offlineCustomerName, offlineCustomerName) ||
                other.offlineCustomerName == offlineCustomerName) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.purchaseId, purchaseId) ||
                other.purchaseId == purchaseId) &&
            (identical(other.shipmentId, shipmentId) ||
                other.shipmentId == shipmentId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        date,
        isReturn,
        customerId,
        warehouseId,
        folioId,
        tableId,
        taxRate,
        taxAmount,
        discount,
        shipping,
        grandTotal,
        receivedAmount,
        paidAmount,
        partialAmount,
        paymentType,
        note,
        referenceCode,
        createdAt,
        updatedAt,
        status,
        isDirectDelivery,
        paymentStatus,
        userId,
        companyId,
        isOffline,
        offlineCustomerName,
        staffId,
        purchaseId,
        shipmentId
      ]);

  /// Create a copy of RegisterSaleDao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterSaleDaoImplCopyWith<_$RegisterSaleDaoImpl> get copyWith =>
      __$$RegisterSaleDaoImplCopyWithImpl<_$RegisterSaleDaoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterSaleDaoImplToJson(
      this,
    );
  }
}

abstract class _RegisterSaleDao implements RegisterSaleDao {
  const factory _RegisterSaleDao(
      {final int? id,
      final DateTime? date,
      @JsonKey(name: 'is_return') final int? isReturn,
      @JsonKey(name: 'customer_id') final int? customerId,
      @JsonKey(name: 'warehouse_id') final int? warehouseId,
      @JsonKey(name: 'folio_id') final int? folioId,
      @JsonKey(name: 'table_id') final int? tableId,
      @JsonKey(name: 'tax_rate') final double? taxRate,
      @JsonKey(name: 'tax_amount') final double? taxAmount,
      final double? discount,
      final double? shipping,
      @JsonKey(name: 'grand_total') final double? grandTotal,
      @JsonKey(name: 'received_amount') final double? receivedAmount,
      @JsonKey(name: 'paid_amount') final double? paidAmount,
      @JsonKey(name: 'partial_amount')
      @StringOrNumToDoubleConverter()
      final double? partialAmount,
      @JsonKey(name: 'payment_type') final int? paymentType,
      final String? note,
      @JsonKey(name: 'reference_code') final String? referenceCode,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      final int? status,
      @JsonKey(name: 'is_direct_delivery') final int? isDirectDelivery,
      @JsonKey(name: 'payment_status') final PaymentStatus? paymentStatus,
      @JsonKey(name: 'user_id') final int? userId,
      @JsonKey(name: 'company_id') final int? companyId,
      @JsonKey(name: 'is_offline') final int? isOffline,
      @JsonKey(name: 'offline_customer_name') final String? offlineCustomerName,
      @JsonKey(name: 'staff_id') final int? staffId,
      @JsonKey(name: 'purchase_id') final int? purchaseId,
      @JsonKey(name: 'shipment_id')
      final int? shipmentId}) = _$RegisterSaleDaoImpl;

  factory _RegisterSaleDao.fromJson(Map<String, dynamic> json) =
      _$RegisterSaleDaoImpl.fromJson;

  @override
  int? get id;
  @override
  DateTime? get date;
  @override
  @JsonKey(name: 'is_return')
  int? get isReturn;
  @override
  @JsonKey(name: 'customer_id')
  int? get customerId;
  @override
  @JsonKey(name: 'warehouse_id')
  int? get warehouseId;
  @override
  @JsonKey(name: 'folio_id')
  int? get folioId;
  @override
  @JsonKey(name: 'table_id')
  int? get tableId;
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
  @JsonKey(name: 'partial_amount')
  @StringOrNumToDoubleConverter()
  double? get partialAmount;
  @override
  @JsonKey(name: 'payment_type')
  int? get paymentType;
  @override
  String? get note;
  @override
  @JsonKey(name: 'reference_code')
  String? get referenceCode;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  int? get status;
  @override
  @JsonKey(name: 'is_direct_delivery')
  int? get isDirectDelivery;
  @override
  @JsonKey(name: 'payment_status')
  PaymentStatus? get paymentStatus;
  @override
  @JsonKey(name: 'user_id')
  int? get userId;
  @override
  @JsonKey(name: 'company_id')
  int? get companyId;
  @override
  @JsonKey(name: 'is_offline')
  int? get isOffline;
  @override
  @JsonKey(name: 'offline_customer_name')
  String? get offlineCustomerName;
  @override
  @JsonKey(name: 'staff_id')
  int? get staffId;
  @override
  @JsonKey(name: 'purchase_id')
  int? get purchaseId;
  @override
  @JsonKey(name: 'shipment_id')
  int? get shipmentId;

  /// Create a copy of RegisterSaleDao
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterSaleDaoImplCopyWith<_$RegisterSaleDaoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GetRegisterDetailsResponseStaffDao _$GetRegisterDetailsResponseStaffDaoFromJson(
    Map<String, dynamic> json) {
  return _GetRegisterDetailsResponseStaffDao.fromJson(json);
}

/// @nodoc
mixin _$GetRegisterDetailsResponseStaffDao {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;

  /// Serializes this GetRegisterDetailsResponseStaffDao to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetRegisterDetailsResponseStaffDao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetRegisterDetailsResponseStaffDaoCopyWith<
          GetRegisterDetailsResponseStaffDao>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetRegisterDetailsResponseStaffDaoCopyWith<$Res> {
  factory $GetRegisterDetailsResponseStaffDaoCopyWith(
          GetRegisterDetailsResponseStaffDao value,
          $Res Function(GetRegisterDetailsResponseStaffDao) then) =
      _$GetRegisterDetailsResponseStaffDaoCopyWithImpl<$Res,
          GetRegisterDetailsResponseStaffDao>;
  @useResult
  $Res call({int? id, String? name, String? email});
}

/// @nodoc
class _$GetRegisterDetailsResponseStaffDaoCopyWithImpl<$Res,
        $Val extends GetRegisterDetailsResponseStaffDao>
    implements $GetRegisterDetailsResponseStaffDaoCopyWith<$Res> {
  _$GetRegisterDetailsResponseStaffDaoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetRegisterDetailsResponseStaffDao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? email = freezed,
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
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetRegisterDetailsResponseStaffDaoImplCopyWith<$Res>
    implements $GetRegisterDetailsResponseStaffDaoCopyWith<$Res> {
  factory _$$GetRegisterDetailsResponseStaffDaoImplCopyWith(
          _$GetRegisterDetailsResponseStaffDaoImpl value,
          $Res Function(_$GetRegisterDetailsResponseStaffDaoImpl) then) =
      __$$GetRegisterDetailsResponseStaffDaoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name, String? email});
}

/// @nodoc
class __$$GetRegisterDetailsResponseStaffDaoImplCopyWithImpl<$Res>
    extends _$GetRegisterDetailsResponseStaffDaoCopyWithImpl<$Res,
        _$GetRegisterDetailsResponseStaffDaoImpl>
    implements _$$GetRegisterDetailsResponseStaffDaoImplCopyWith<$Res> {
  __$$GetRegisterDetailsResponseStaffDaoImplCopyWithImpl(
      _$GetRegisterDetailsResponseStaffDaoImpl _value,
      $Res Function(_$GetRegisterDetailsResponseStaffDaoImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetRegisterDetailsResponseStaffDao
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? email = freezed,
  }) {
    return _then(_$GetRegisterDetailsResponseStaffDaoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetRegisterDetailsResponseStaffDaoImpl
    implements _GetRegisterDetailsResponseStaffDao {
  const _$GetRegisterDetailsResponseStaffDaoImpl(
      {this.id, this.name, this.email});

  factory _$GetRegisterDetailsResponseStaffDaoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetRegisterDetailsResponseStaffDaoImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? email;

  @override
  String toString() {
    return 'GetRegisterDetailsResponseStaffDao(id: $id, name: $name, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetRegisterDetailsResponseStaffDaoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email);

  /// Create a copy of GetRegisterDetailsResponseStaffDao
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetRegisterDetailsResponseStaffDaoImplCopyWith<
          _$GetRegisterDetailsResponseStaffDaoImpl>
      get copyWith => __$$GetRegisterDetailsResponseStaffDaoImplCopyWithImpl<
          _$GetRegisterDetailsResponseStaffDaoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetRegisterDetailsResponseStaffDaoImplToJson(
      this,
    );
  }
}

abstract class _GetRegisterDetailsResponseStaffDao
    implements GetRegisterDetailsResponseStaffDao {
  const factory _GetRegisterDetailsResponseStaffDao(
      {final int? id,
      final String? name,
      final String? email}) = _$GetRegisterDetailsResponseStaffDaoImpl;

  factory _GetRegisterDetailsResponseStaffDao.fromJson(
          Map<String, dynamic> json) =
      _$GetRegisterDetailsResponseStaffDaoImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get email;

  /// Create a copy of GetRegisterDetailsResponseStaffDao
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetRegisterDetailsResponseStaffDaoImplCopyWith<
          _$GetRegisterDetailsResponseStaffDaoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
