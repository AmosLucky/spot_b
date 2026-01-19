// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_register_details_response_dao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetRegisterDetailsResponseDaoImpl
    _$$GetRegisterDetailsResponseDaoImplFromJson(Map<String, dynamic> json) =>
        _$GetRegisterDetailsResponseDaoImpl(
          todaySalesAmount: (json['today_sales_amount'] as num?)?.toDouble(),
          todaySalesCashPayment:
              (json['today_sales_cash_payment'] as num?)?.toDouble(),
          todaySalesFolioPayment:
              (json['today_sales_folio_payment'] as num?)?.toDouble(),
          todaySalesPosPayment:
              (json['today_sales_pos_payment'] as num?)?.toDouble(),
          todaySalesBankTransferPayment:
              (json['today_sales_bank_transfer_payment'] as num?)?.toDouble(),
          todaySalesOtherPayment:
              (json['today_sales_other_payment'] as num?)?.toDouble(),
          todaySalesReturnAmount:
              (json['today_sales_return_amount'] as num?)?.toDouble(),
          todaySalesPaymentAmount:
              (json['today_sales_payment_amount'] as num?)?.toDouble(),
          refundedCash: (json['refunded_cash'] as num?)?.toDouble(),
          totalStockReturned:
              (json['total_stock_returned'] as num?)?.toDouble(),
          totalStockSold: (json['total_stock_sold'] as num?)?.toDouble(),
          totalStockRemaining:
              (json['total_stock_remaining'] as num?)?.toDouble(),
          itemsSold: (json['items_sold'] as List<dynamic>?)
              ?.map((e) => SaleItem.fromJson(e as Map<String, dynamic>))
              .toList(),
          todaySales: (json['today_sales'] as List<dynamic>?)
              ?.map((e) => RegisterSaleDao.fromJson(e as Map<String, dynamic>))
              .toList(),
          openedAt: json['opened_at'] == null
              ? null
              : DateTime.parse(json['opened_at'] as String),
          closedAt: json['closed_at'] == null
              ? null
              : DateTime.parse(json['closed_at'] as String),
          cashInHand: (json['cash_in_hand'] as num?)?.toDouble(),
          totalCashAmount: (json['total_cash_amount'] as num?)?.toDouble(),
          isClosed: json['is_closed'] == null
              ? false
              : const IntOrBoolToBoolConverter().fromJson(json['is_closed']),
          staff: json['staff'] == null
              ? null
              : GetRegisterDetailsResponseStaffDao.fromJson(
                  json['staff'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$GetRegisterDetailsResponseDaoImplToJson(
        _$GetRegisterDetailsResponseDaoImpl instance) =>
    <String, dynamic>{
      'today_sales_amount': instance.todaySalesAmount,
      'today_sales_cash_payment': instance.todaySalesCashPayment,
      'today_sales_folio_payment': instance.todaySalesFolioPayment,
      'today_sales_pos_payment': instance.todaySalesPosPayment,
      'today_sales_bank_transfer_payment':
          instance.todaySalesBankTransferPayment,
      'today_sales_other_payment': instance.todaySalesOtherPayment,
      'today_sales_return_amount': instance.todaySalesReturnAmount,
      'today_sales_payment_amount': instance.todaySalesPaymentAmount,
      'refunded_cash': instance.refundedCash,
      'total_stock_returned': instance.totalStockReturned,
      'total_stock_sold': instance.totalStockSold,
      'total_stock_remaining': instance.totalStockRemaining,
      'items_sold': instance.itemsSold,
      'today_sales': instance.todaySales,
      'opened_at': instance.openedAt?.toIso8601String(),
      'closed_at': instance.closedAt?.toIso8601String(),
      'cash_in_hand': instance.cashInHand,
      'total_cash_amount': instance.totalCashAmount,
      'is_closed': const IntOrBoolToBoolConverter().toJson(instance.isClosed),
      'staff': instance.staff,
    };

_$RegisterSaleDaoImpl _$$RegisterSaleDaoImplFromJson(
        Map<String, dynamic> json) =>
    _$RegisterSaleDaoImpl(
      id: (json['id'] as num?)?.toInt(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      isReturn: (json['is_return'] as num?)?.toInt(),
      customerId: (json['customer_id'] as num?)?.toInt(),
      warehouseId: (json['warehouse_id'] as num?)?.toInt(),
      folioId: (json['folio_id'] as num?)?.toInt(),
      tableId: (json['table_id'] as num?)?.toInt(),
      taxRate: (json['tax_rate'] as num?)?.toDouble(),
      taxAmount: (json['tax_amount'] as num?)?.toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      shipping: (json['shipping'] as num?)?.toDouble(),
      grandTotal: (json['grand_total'] as num?)?.toDouble(),
      receivedAmount: (json['received_amount'] as num?)?.toDouble(),
      paidAmount: (json['paid_amount'] as num?)?.toDouble(),
      partialAmount:
          const StringOrNumToDoubleConverter().fromJson(json['partial_amount']),
      paymentType: (json['payment_type'] as num?)?.toInt(),
      note: json['note'] as String?,
      referenceCode: json['reference_code'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      status: (json['status'] as num?)?.toInt(),
      isDirectDelivery: (json['is_direct_delivery'] as num?)?.toInt(),
      paymentStatus:
          $enumDecodeNullable(_$PaymentStatusEnumMap, json['payment_status']),
      userId: (json['user_id'] as num?)?.toInt(),
      companyId: (json['company_id'] as num?)?.toInt(),
      isOffline: (json['is_offline'] as num?)?.toInt(),
      offlineCustomerName: json['offline_customer_name'] as String?,
      staffId: (json['staff_id'] as num?)?.toInt(),
      purchaseId: (json['purchase_id'] as num?)?.toInt(),
      shipmentId: (json['shipment_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$RegisterSaleDaoImplToJson(
        _$RegisterSaleDaoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'is_return': instance.isReturn,
      'customer_id': instance.customerId,
      'warehouse_id': instance.warehouseId,
      'folio_id': instance.folioId,
      'table_id': instance.tableId,
      'tax_rate': instance.taxRate,
      'tax_amount': instance.taxAmount,
      'discount': instance.discount,
      'shipping': instance.shipping,
      'grand_total': instance.grandTotal,
      'received_amount': instance.receivedAmount,
      'paid_amount': instance.paidAmount,
      'partial_amount':
          const StringOrNumToDoubleConverter().toJson(instance.partialAmount),
      'payment_type': instance.paymentType,
      'note': instance.note,
      'reference_code': instance.referenceCode,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'is_direct_delivery': instance.isDirectDelivery,
      'payment_status': _$PaymentStatusEnumMap[instance.paymentStatus],
      'user_id': instance.userId,
      'company_id': instance.companyId,
      'is_offline': instance.isOffline,
      'offline_customer_name': instance.offlineCustomerName,
      'staff_id': instance.staffId,
      'purchase_id': instance.purchaseId,
      'shipment_id': instance.shipmentId,
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.paid: 1,
  PaymentStatus.unpaid: 2,
  PaymentStatus.partial: 3,
};

_$GetRegisterDetailsResponseStaffDaoImpl
    _$$GetRegisterDetailsResponseStaffDaoImplFromJson(
            Map<String, dynamic> json) =>
        _$GetRegisterDetailsResponseStaffDaoImpl(
          id: (json['id'] as num?)?.toInt(),
          name: json['name'] as String?,
          email: json['email'] as String?,
        );

Map<String, dynamic> _$$GetRegisterDetailsResponseStaffDaoImplToJson(
        _$GetRegisterDetailsResponseStaffDaoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
    };
