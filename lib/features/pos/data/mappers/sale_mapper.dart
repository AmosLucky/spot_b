import 'package:drift/drift.dart';
import 'package:spotstock_inventory/core/networking/spotstock_api_constants.dart';

import '../../../../core/database/database_client.dart';
import '../../../../core/networking/api_response/spotstock_api_data_item.dart';
import '../../../../core/networking/api_response/spotstock_api_response.dart';
import '../../../holds/data/models/create_hold_dto.dart';
import '../../../holds/data/models/hold.dart';
import '../enums/enums.dart';
import '../models/create_sale_dto.dart';
import '../models/sale.dart';
import '../models/sale_creation_response.dart';

extension SaleMapper on Sale {
  CreateSaleDto toCreateDto() {
    return CreateSaleDto(
      referenceCode: referenceCode,
      date: date,
      customerId: customerId,
      warehouseId: warehouseId,
      taxRate: taxRate,
      taxAmount: taxAmount,
      discount: discount,
      discountAmount: discountAmount,
      shipping: shipping,
      grandTotal: grandTotal,
      status: status,
      paymentStatus: paymentStatus,
      paymentType: paymentType,
      receivedAmount: receivedAmount,
      paidAmount: paidAmount,
      payments: (payments ?? [])
          .map((p) => PaymentDto(
                paymentType: p.paymentType,
                amount: p.amount,
              ))
          .toList(),
      saleItems: (saleItems ?? [])
          .map((i) => SaleItemDto(
                productId: i.productId,
                productPrice: i.productPrice,
                netUnitPrice: i.netUnitPrice,
                taxType: i.taxType,
                taxValue: i.taxValue,
                taxAmount: i.taxAmount,
                discountType: i.discountType,
                discountValue: i.discountValue,
                discountAmount: i.discountAmount,
                saleUnit: i.saleUnit,
                quantity: i.quantity,
                subTotal: i.subTotal,
                isCustom: i.isCustom,
                customCost: i.customCost,
                customDescription: i.customDescription,
                customName: i.customName,
                customPrice: i.customPrice,
                productName: i.productName,
              ))
          .toList(),
      staffId: staffId,
      staffName: staffName,
      attendantId: attendantId,
      attendantName: attendantName,
      roomDetails: roomDetails,
      isOffline: isOffline,
      offlineCustomerName: offlineCustomerName,
    );
  }

  static Sale fromCreateDto(CreateSaleDto createSaleDto) {
    final receivedAmount = (createSaleDto.payments ?? []).fold<double>(0, (total, p) => total + (p.amount ?? 0));

    final dueAmount = receivedAmount - (createSaleDto.grandTotal ?? 0);

    SaleUnit? saleUnitFromHoldUnit(HoldUnit holdUnit) {
      return SaleUnit(
        id: holdUnit.id,
        name: holdUnit.name,
        shortName: holdUnit.shortName,
        baseUnit: holdUnit.baseUnit,
        createdAt: holdUnit.createdAt,
        updatedAt: holdUnit.updatedAt,
        companyId: holdUnit.companyId,
      );
    }

    return Sale(
      referenceCode: createSaleDto.referenceCode,
      date: createSaleDto.date ?? DateTime.now(),
      customerId: createSaleDto.customerId,
      isOffline: createSaleDto.isOffline ?? true,
      offlineCustomerName: createSaleDto.offlineCustomerName,
      staffName: createSaleDto.staffName,
      warehouseId: createSaleDto.warehouseId,
      taxRate: createSaleDto.taxRate,
      taxAmount: createSaleDto.taxAmount,
      discount: createSaleDto.discount,
      discountAmount: createSaleDto.discountAmount,
      shipping: createSaleDto.shipping,
      grandTotal: createSaleDto.grandTotal,
      receivedAmount: receivedAmount,
      paidAmount: createSaleDto.paidAmount,
      partialAmount: createSaleDto.partialPaymentAmount,
      paymentType: createSaleDto.paymentType,
      note: createSaleDto.note,
      status: createSaleDto.status,
      paymentStatus: createSaleDto.paymentStatus,
      saleItems: createSaleDto.saleItems
          ?.map((i) => SaleItem(
                productId: i.productId,
                productName: i.productName,
                productPrice: i.productPrice,
                netUnitPrice: i.netUnitPrice,
                taxType: i.taxType,
                taxValue: i.taxValue,
                taxAmount: i.taxAmount,
                discountType: i.discountType,
                discountValue: i.discountValue,
                discountAmount: i.discountAmount,
                saleUnit: (i.saleUnit is HoldUnit) ? saleUnitFromHoldUnit(i.saleUnit) : i.saleUnit,
                quantity: i.quantity,
                subTotal: i.subTotal,
                isCustom: i.isCustom,
                customCost: i.customCost,
                customDescription: i.customDescription,
                customName: i.customName,
                customPrice: i.customPrice,
              ))
          .toList(),
      payments: createSaleDto.payments
          ?.map((p) => SalePayment(
                paymentType: p.paymentType,
                amount: p.amount,
              ))
          .toList(),
      paymentMethods: createSaleDto.payments?.map((p) => p.paymentType?.name).whereType<String>().toList(),
      staffId: createSaleDto.staffId,
      attendantName: createSaleDto.staffName,
      dueAmount: dueAmount,
      attendantId: createSaleDto.staffId,
      roomDetails: createSaleDto.roomDetails,
      partialPaymentMethod: createSaleDto.partialPaymentMethod,
      warehouseName: createSaleDto.warehouseName,
      customerName: createSaleDto.customerName ?? SpotstockApiConstants.walkInCustomerName,
    );
  }

  LocalSalesCompanion toDrift() {
    return LocalSalesCompanion(
      remoteId: Value(id),
      type: Value(type),
      links: Value(links),
      date: Value(date),
      isReturn: Value(isReturn),
      customerId: Value(customerId),
      companyId: Value(companyId),
      loggedUser: Value(loggedUser),
      customerName: Value(customerName),
      staffName: Value(staffName),
      warehouseId: Value(warehouseId),
      warehouseName: Value(warehouseName),
      taxRate: Value(taxRate),
      taxAmount: Value(taxAmount),
      discount: Value(discount),
      discountAmount: Value(discountAmount),
      shipping: Value(shipping),
      grandTotal: Value(grandTotal),
      receivedAmount: Value(receivedAmount),
      paidAmount: Value(paidAmount),
      partialAmount: Value(partialAmount),
      dueAmount: Value(dueAmount),
      paymentType: Value(paymentType?.toInt),
      note: Value(note),
      status: Value(status?.index),
      paymentStatus: Value(paymentStatus?.toInt),
      referenceCode: Value(referenceCode),
      saleItems: Value(saleItems),
      payments: Value(payments),
      paymentMethods: Value(paymentMethods),
      createdAt: Value(createdAt),
      barcodeUrl: Value(barcodeUrl),
      isOffline: Value(isOffline ?? false),
      offlineCustomerName: Value(offlineCustomerName),
      staffId: Value(staffId),
      attendantName: Value(attendantName),
      attendantId: Value(attendantId),
      roomDetails: Value(roomDetails),
      partialPaymentMethod: Value(partialPaymentMethod),
      isSynced: const Value(false),
      lastSyncedAt: const Value.absent(),
      createdLocallyAt: Value(DateTime.now()),
    );
  }

  static Sale fromDrift(LocalSale row) {
    return Sale(
      id: row.remoteId,
      referenceCode: row.referenceCode,
      date: row.date,
      customerId: row.customerId,
      companyId: row.companyId,
      loggedUser: row.loggedUser,
      customerName: row.customerName,
      staffName: row.staffName,
      warehouseId: row.warehouseId,
      warehouseName: row.warehouseName,
      taxRate: row.taxRate,
      taxAmount: row.taxAmount,
      discount: row.discount,
      discountAmount: row.discountAmount,
      shipping: row.shipping,
      grandTotal: row.grandTotal,
      receivedAmount: row.receivedAmount,
      paidAmount: row.paidAmount,
      partialAmount: row.partialAmount,
      dueAmount: row.dueAmount,
      paymentType: row.paymentType != null ? PaymentType.values[row.paymentType!] : null,
      note: row.note,
      status: row.status != null ? SaleStatus.values[row.status!] : null,
      paymentStatus: row.paymentStatus != null ? PaymentStatus.values[row.paymentStatus!] : null,
      saleItems: row.saleItems,
      payments: row.payments,
      paymentMethods: row.paymentMethods,
      createdAt: row.createdAt,
      barcodeUrl: row.barcodeUrl,
      isOffline: row.isOffline,
      offlineCustomerName: row.offlineCustomerName,
      staffId: row.staffId,
      attendantName: row.attendantName,
      attendantId: row.attendantId,
      roomDetails: row.roomDetails,
      partialPaymentMethod: row.partialPaymentMethod,
      isReturn: row.isReturn,
      links: row.links,
      type: row.type,
    );
  }

  static Sale fromSaleCreationResponse(
    SpotstockApiResponse<SpotstockApiDataItem> dao, {
    int? attendantId,
    String? attendantName,
    String? partialPaymentMethod,
  }) {
    final attributes = SaleCreationResponseAttributesDao.fromJson(dao.data.attributes ?? {});
    return Sale(
      id: dao.data.id,
      referenceCode: attributes.referenceCode,
      date: attributes.date,
      customerId: attributes.customerId,
      companyId: attributes.companyId,
      loggedUser: SaleLoggedUser(
        id: attributes.loggedUser?.id,
        firstName: attributes.loggedUser?.firstName,
        lastName: attributes.loggedUser?.lastName,
        dob: attributes.loggedUser?.dob,
        salaryDate: attributes.loggedUser?.salaryDate,
        email: attributes.loggedUser?.email,
        phone: attributes.loggedUser?.phone,
        emailVerifiedAt: attributes.loggedUser?.emailVerifiedAt,
        defaultPassword: attributes.loggedUser?.defaultPassword,
        createdAt: attributes.loggedUser?.createdAt,
        updatedAt: attributes.loggedUser?.updatedAt,
        status: attributes.loggedUser?.status,
        language: attributes.loggedUser?.language,
        companyId: attributes.loggedUser?.companyId,
        isAdmin: attributes.loggedUser?.isAdmin,
        isSuper: attributes.loggedUser?.isSuper,
        type: attributes.loggedUser?.type,
        salaryAmount: attributes.loggedUser?.salaryAmount,
        balance: attributes.loggedUser?.balance,
        dateEmployed: attributes.loggedUser?.dateEmployed,
        note: attributes.loggedUser?.note,
        isAttendant: attributes.loggedUser?.isAttendant,
        imageUrl: attributes.loggedUser?.imageUrl,
        media: attributes.loggedUser?.media,
      ),
      customerName: attributes.customerName,
      staffName: attributes.staffName,
      warehouseId: attributes.warehouseId,
      warehouseName: attributes.warehouseName,
      taxRate: attributes.taxRate,
      taxAmount: attributes.taxAmount,
      discount: attributes.discount,
      discountAmount: attributes.discountAmount,
      shipping: attributes.shipping,
      grandTotal: attributes.grandTotal,
      receivedAmount: attributes.receivedAmount,
      paidAmount: attributes.paidAmount,
      partialAmount: attributes.partialAmount,
      dueAmount: attributes.dueAmount,
      paymentType: attributes.paymentType,
      note: attributes.note,
      status: attributes.status,
      paymentStatus: attributes.paymentStatus,
      saleItems: attributes.saleItems
          ?.map((i) => SaleItem(
                productId: i.productId,
                productName: i.productName,
                productPrice: i.productPrice,
                netUnitPrice: i.netUnitPrice,
                taxType: i.taxType,
                taxValue: i.taxValue,
                taxAmount: i.taxAmount,
                discountType: i.discountType,
                discountValue: i.discountValue,
                discountAmount: i.discountAmount,
                saleUnit: SaleUnit(
                  id: i.saleUnit?.id,
                  name: i.saleUnit?.name,
                  shortName: i.saleUnit?.shortName,
                  baseUnit: i.saleUnit?.baseUnit,
                  createdAt: i.saleUnit?.createdAt,
                  updatedAt: i.saleUnit?.updatedAt,
                  companyId: i.saleUnit?.companyId,
                ),
                quantity: i.quantity,
                subTotal: i.subTotal,
                isCustom: i.isCustom,
                customCost: i.customCost,
                customDescription: i.customDescription,
                customName: i.customName,
                customPrice: i.customPrice,
              ))
          .toList(),
      payments: attributes.payments
          ?.map((p) => SalePayment(
                saleId: p.saleId,
                companyId: p.companyId,
                reference: p.reference,
                paymentDate: p.paymentDate,
                paymentType: p.paymentType,
                paymentMethod: p.paymentMethod,
                amount: p.amount,
                receivedAmount: p.receivedAmount,
              ))
          .toList(),
      paymentMethods: attributes.paymentMethods,
      createdAt: attributes.createdAt,
      barcodeUrl: attributes.barcodeUrl,
      isOffline: attributes.isOffline ?? false,
      offlineCustomerName: attributes.offlineCustomerName,
      staffId: attributes.staffId,
      attendantName: attributes.attendantName ?? attendantName,
      attendantId: attendantId,
      roomDetails: attributes.roomDetails,
      partialPaymentMethod: partialPaymentMethod,
      isReturn: attributes.isReturn,
      links: dao.data.links,
      type: dao.data.type,
    );
  }
}

extension LocalSaleMapper on LocalSale {
  CreateSaleDto toCreateSaleDto() {
    return CreateSaleDto(
      referenceCode: referenceCode,
      date: date,
      customerId: customerId,
      warehouseId: warehouseId,
      taxRate: taxRate,
      taxAmount: taxAmount,
      discount: discount,
      discountAmount: discountAmount,
      shipping: shipping,
      grandTotal: grandTotal,
      status: status != null ? SaleStatus.values[status!] : null,
      paymentStatus: paymentStatus != null ? PaymentStatus.values[paymentStatus!] : null,
      paymentType: paymentType != null ? PaymentType.values[paymentType!] : null,
      receivedAmount: receivedAmount,
      paidAmount: paidAmount,
      payments: payments
              ?.map(
                (p) => PaymentDto(
                  paymentType: p.paymentType,
                  amount: p.amount ?? 0,
                ),
              )
              .toList() ??
          [],
      saleItems: saleItems
              ?.map(
                (i) => SaleItemDto(
                  productId: i.productId,
                  productPrice: i.productPrice,
                  netUnitPrice: i.netUnitPrice,
                  taxType: i.taxType,
                  taxValue: i.taxValue,
                  taxAmount: i.taxAmount,
                  discountType: i.discountType,
                  discountValue: i.discountValue,
                  discountAmount: i.discountAmount,
                  saleUnit: i.saleUnit,
                  quantity: i.quantity,
                  subTotal: i.subTotal,
                  isCustom: i.isCustom,
                  customCost: i.customCost,
                  customDescription: i.customDescription,
                  customName: i.customName,
                  customPrice: i.customPrice,
                ),
              )
              .toList() ??
          [],
      staffId: staffId,
      staffName: staffName,
      isOffline: isOffline,
      offlineCustomerName: offlineCustomerName,
      note: note,
      partialPaymentAmount: partialPaymentAmount,
      partialPaymentMethod: partialPaymentMethod,
      attendantId: attendantId,
      attendantName: attendantName,
      roomDetails: roomDetails,
      notes: note,
    );
  }
}

extension CreateSaleDtoMapper on CreateSaleDto {
  LocalSalesCompanion toDrift() {
    return LocalSalesCompanion(
      referenceCode: Value(referenceCode),
      date: Value(date),
      customerId: Value(customerId),
      warehouseId: Value(warehouseId),
      taxRate: Value(taxRate),
      taxAmount: Value(taxAmount),
      discount: Value(discount),
      discountAmount: Value(discountAmount),
      shipping: Value(shipping),
      grandTotal: Value(grandTotal),
      receivedAmount: Value(receivedAmount),
      paidAmount: Value(paidAmount),
      payments: Value(payments
          ?.map((p) => SalePayment(
                paymentType: p.paymentType,
                amount: p.amount,
              ))
          .toList()),
      saleItems: Value(saleItems?.map((i) {
        SaleUnit? saleUnit;
        if (i.saleUnit is HoldUnit) {
          final holdUnit = i.saleUnit as HoldUnit;
          saleUnit = SaleUnit(
            id: holdUnit.id,
            name: holdUnit.name,
            shortName: holdUnit.shortName,
            baseUnit: holdUnit.baseUnit,
            createdAt: holdUnit.createdAt,
            updatedAt: holdUnit.updatedAt,
            companyId: holdUnit.companyId,
          );
        }
        return SaleItem(
          productId: i.productId,
          productPrice: i.productPrice,
          productName: i.productName,
          netUnitPrice: i.netUnitPrice,
          taxType: i.taxType,
          taxValue: i.taxValue,
          taxAmount: i.taxAmount,
          discountType: i.discountType,
          discountValue: i.discountValue,
          discountAmount: i.discountAmount,
          saleUnit: saleUnit,
          quantity: i.quantity,
          subTotal: i.subTotal,
          isCustom: i.isCustom,
          customCost: i.customCost,
          customDescription: i.customDescription,
          customName: i.customName,
          customPrice: i.customPrice,
        );
      }).toList()),
      staffId: Value(staffId),
      staffName: Value(staffName),
      attendantId: Value(attendantId),
      attendantName: Value(attendantName),
      roomDetails: Value(roomDetails),
      partialPaymentAmount: Value(partialPaymentAmount),
      partialPaymentMethod: Value(partialPaymentMethod),
      isOffline: Value(isOffline ?? true),
      offlineCustomerName: Value(offlineCustomerName),
      note: Value(note),
      status: Value(status?.index),
      paymentStatus: Value(paymentStatus?.toInt),
      paymentType: Value(paymentType?.toInt),
      isSynced: const Value(false),
      lastSyncedAt: const Value.absent(),
      createdLocallyAt: Value(DateTime.now()),
      isReturn: const Value(null),
    );
  }

  CreateHoldDto toCreateHoldDto() {
    return CreateHoldDto(
      customerId: customerId,
      date: date,
      discount: discount,
      discountAmount: discountAmount,
      grandTotal: grandTotal,
      holdItems: saleItems
          ?.map(
            (item) => HoldItemDto(
              code: item.productCode,
              customCost: item.customCost,
              customDescription: item.customDescription,
              customName: item.customName,
              customPrice: item.customPrice,
              discountAmount: item.discountAmount,
              discountType: item.discountType,
              discountValue: item.discountValue,
              id: item.productId,
              isCustom: item.isCustom ?? false,
              name: item.productName,
              netUnitCost: item.isCustom == true ? item.customCost : null,
              netUnitPrice: item.netUnitPrice,
              productId: item.productId,
              productPrice: item.productPrice,
              productUnit: item.saleUnit is String ? item.saleUnit : null,
              quantity: item.quantity,
              saleUnit: item.saleUnit,
              subTotal: item.subTotal,
              taxAmount: item.taxAmount,
              taxType: item.taxType,
              taxValue: item.taxValue,
            ),
          )
          .toList(),
      note: note,
      referenceCode: referenceCode,
      shipping: shipping,
      staffId: staffId,
      staffName: staffName,
      subTotal: saleItems?.fold<double>(0, (sum, item) => sum + (item.subTotal ?? 0)),
      taxAmount: taxAmount,
      taxRate: taxRate,
      tableId: saleItems != null && saleItems!.isNotEmpty ? saleItems!.first.tableId?.toString() : null,
      warehouseId: warehouseId,
      type: null,
      links: null,
      userId: null,
      attendant: HoldAttendant(
        id: attendantId,
        firstName: attendantName,
      ),
      customerName: customerName ?? offlineCustomerName,
      warehouseName: warehouseName,
      status: status,
      tableName: null,
      createdAt: date,
      receivedAmount: receivedAmount,
      paidAmount: paidAmount,
    );
  }
}
