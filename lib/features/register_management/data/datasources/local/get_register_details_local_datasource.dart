import 'package:drift/drift.dart';

import '../../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../../core/database/database_client.dart';
import '../../../../../core/networking/spotstock_status_code.dart';
import '../../../../../core/shared/result.dart';
import '../../../../pos/data/enums/enums.dart';
import '../../../../pos/data/models/sale.dart';
import '../../../../pos/domain/errors/errors.dart';
import '../../models/get_register_details_response_dao.dart';

class GetRegisterDetailsLocalDatasource {
  final DatabaseClient db;

  GetRegisterDetailsLocalDatasource(this.db);

  Future<Result<GetRegisterDetailsResponseDao>> getRegisterDetails({int? registerId}) async {
    try {
      // 1. Get the register
      final registerQuery = db.select(db.localRegisters);
      if (registerId != null) {
        registerQuery.where((t) => t.id.equals(registerId));
      } else {
        registerQuery.orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
      }
      registerQuery.limit(1);

      final register = await registerQuery.getSingleOrNull();

      if (register == null) {
        return Result.failure(LocalDatabaseError(
          message: SpotstockStrings.registerNotFound,
          subtitle: SpotstockStrings.somethingWentWrong,
          code: SpotstockStatusCode.internalAppDatabaseError.toString(),
          originalError: null,
        ));
      }

      final registerOpenedAt = register.createdAt;
      final registerClosedAt = register.closedAt ?? DateTime.now();

      // 2. Query sales within register time range
      final salesQuery = db.select(db.localSales)
        ..where((sale) {
          if (registerOpenedAt != null) {
            return sale.createdAt.isBiggerOrEqualValue(registerOpenedAt) & sale.createdAt.isSmallerOrEqualValue(registerClosedAt);
          }
          return sale.createdAt.isSmallerOrEqualValue(registerClosedAt);
        });
      final sales = await salesQuery.get();

      // 3. Compute payment breakdowns
      double totalSalesAmount = 0;
      double cashPayment = 0;
      double posPayment = 0;
      double bankTransferPayment = 0;
      double folioPayment = 0;
      double otherPayment = 0;
      double returnAmount = 0;
      double refundedCash = 0;
      double totalPaymentAmount = 0;
      double totalStockSold = 0;
      final List<SaleItem> allItemsSold = [];
      final List<RegisterSaleDao> todaySales = [];

      for (final sale in sales) {
        final grandTotal = sale.grandTotal ?? 0;
        final isReturn = sale.isReturn == 1;
        final paymentType = sale.paymentType;

        if (isReturn) {
          returnAmount += grandTotal;
          if (paymentType == 1) {
            refundedCash += grandTotal;
          }
        } else {
          totalSalesAmount += grandTotal;
          totalPaymentAmount += sale.paidAmount ?? sale.receivedAmount ?? grandTotal;

          // Aggregate by payment type
          switch (paymentType) {
            case 1:
              cashPayment += grandTotal;
              break;
            case 2:
              posPayment += grandTotal;
              break;
            case 3:
              bankTransferPayment += grandTotal;
              break;
            case 4:
              folioPayment += grandTotal;
              break;
            case 5:
              otherPayment += grandTotal;
              break;
          }
        }

        // Aggregate items sold
        if (sale.saleItems != null) {
          for (final item in sale.saleItems!) {
            if (!isReturn) {
              totalStockSold += item.quantity ?? 0;
            }
            allItemsSold.add(item);
          }
        }

        // Map to RegisterSaleDao
        todaySales.add(RegisterSaleDao(
          id: sale.remoteId ?? sale.id,
          date: sale.date,
          isReturn: sale.isReturn,
          customerId: sale.customerId,
          warehouseId: sale.warehouseId,
          taxRate: sale.taxRate,
          taxAmount: sale.taxAmount,
          discount: sale.discount,
          grandTotal: sale.grandTotal,
          receivedAmount: sale.receivedAmount,
          paidAmount: sale.paidAmount,
          paymentType: sale.paymentType,
          note: sale.note,
          referenceCode: sale.referenceCode,
          createdAt: sale.createdAt,
          status: sale.status,
          paymentStatus: sale.paymentStatus != null ? PaymentStatusX.fromInt(sale.paymentStatus ?? 1) : null,
          companyId: sale.companyId,
          isOffline: sale.isOffline ? 1 : 0,
          offlineCustomerName: sale.offlineCustomerName,
          staffId: sale.staffId,
        ));
      }

      // 4. Compute stock remaining from products
      final productsQuery = db.select(db.localProducts);
      final products = await productsQuery.get();
      double totalStockRemaining = 0;
      for (final product in products) {
        totalStockRemaining += product.inStock ?? 0;
      }

      // 5. Compute total cash amount
      final openingCash = register.openingCashAtHand ?? 0;
      final totalCashAmount = openingCash + cashPayment - refundedCash;

      // 6. Build and return DAO
      final getRegisterDetailsResponseDao = GetRegisterDetailsResponseDao(
        todaySalesAmount: totalSalesAmount,
        todaySalesCashPayment: cashPayment,
        todaySalesFolioPayment: folioPayment,
        todaySalesPosPayment: posPayment,
        todaySalesBankTransferPayment: bankTransferPayment,
        todaySalesOtherPayment: otherPayment,
        todaySalesReturnAmount: returnAmount,
        todaySalesPaymentAmount: totalPaymentAmount,
        refundedCash: refundedCash,
        totalStockReturned: returnAmount > 0 ? totalStockSold : 0,
        totalStockSold: totalStockSold,
        totalStockRemaining: totalStockRemaining,
        itemsSold: allItemsSold,
        todaySales: todaySales,
        openedAt: registerOpenedAt,
        closedAt: register.closedAt,
        cashInHand: openingCash,
        totalCashAmount: totalCashAmount,
        isClosed: register.closedAt != null,
        staff: GetRegisterDetailsResponseStaffDao(
          id: register.user?.id,
          name: register.user?.firstName ?? SpotstockStrings.na,
          email: register.user?.email,
        ),
      );
      return Result.success(getRegisterDetailsResponseDao);
    } catch (e) {
      final appError = LocalDatabaseError(
        message: SpotstockStrings.failedToReadData,
        subtitle: SpotstockStrings.somethingWentWrong,
        code: SpotstockStatusCode.internalAppDatabaseError.toString(),
        originalError: e,
      );
      return Result.failure(appError);
    }
  }
}
