// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../pos/data/enums/enums.dart';
import '../../../pos/data/models/sale.dart';
import '../../../pos/data/models/sale_creation_response.dart';

part 'get_register_details_response_dao.freezed.dart';
part 'get_register_details_response_dao.g.dart';

@freezed
class GetRegisterDetailsResponseDao with _$GetRegisterDetailsResponseDao {
  const factory GetRegisterDetailsResponseDao({
    @JsonKey(name: 'today_sales_amount') double? todaySalesAmount,
    @JsonKey(name: 'today_sales_cash_payment') double? todaySalesCashPayment,
    @JsonKey(name: 'today_sales_folio_payment') double? todaySalesFolioPayment,
    @JsonKey(name: 'today_sales_pos_payment') double? todaySalesPosPayment,
    @JsonKey(name: 'today_sales_bank_transfer_payment') double? todaySalesBankTransferPayment,
    @JsonKey(name: 'today_sales_other_payment') double? todaySalesOtherPayment,
    @JsonKey(name: 'today_sales_return_amount') double? todaySalesReturnAmount,
    @JsonKey(name: 'today_sales_payment_amount') double? todaySalesPaymentAmount,
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
    @JsonKey(name: 'is_closed') @IntOrBoolToBoolConverter() @Default(false) bool isClosed,
    @JsonKey(name: 'staff') GetRegisterDetailsResponseStaffDao? staff,
  }) = _GetRegisterDetailsResponseDao;

  factory GetRegisterDetailsResponseDao.fromJson(Map<String, dynamic> json) => _$GetRegisterDetailsResponseDaoFromJson(json);
}

@freezed
class RegisterSaleDao with _$RegisterSaleDao {
  const factory RegisterSaleDao({
    int? id,
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
    @JsonKey(name: 'partial_amount') @StringOrNumToDoubleConverter() double? partialAmount,
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
    @JsonKey(name: 'shipment_id') int? shipmentId,
  }) = _RegisterSaleDao;

  factory RegisterSaleDao.fromJson(Map<String, dynamic> json) => _$RegisterSaleDaoFromJson(json);
}

@freezed
class GetRegisterDetailsResponseStaffDao with _$GetRegisterDetailsResponseStaffDao {
  const factory GetRegisterDetailsResponseStaffDao({
    int? id,
    String? name,
    String? email,
  }) = _GetRegisterDetailsResponseStaffDao;

  factory GetRegisterDetailsResponseStaffDao.fromJson(Map<String, dynamic> json) => _$GetRegisterDetailsResponseStaffDaoFromJson(json);
}
