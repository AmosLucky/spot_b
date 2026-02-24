import 'package:drift/drift.dart';
import 'package:spotstock_inventory/features/holds/data/models/grouped_hold.dart';

import '../../../../core/database/database_client.dart';
import '../../../../core/networking/api_response/spotstock_api_data_item.dart';
import '../../../../core/networking/api_response/spotstock_api_response.dart';
import '../../../pos/data/models/create_sale_dto.dart';
import '../models/create_hold_dto.dart';
import '../models/hold.dart';
import '../models/hold_creation_response.dart';

extension HoldMapper on Hold {
  static Hold fromHoldCreationResponse(SpotstockApiResponse<SpotstockApiDataItem> dao) {
    final attributes = HoldCreationResponseAttributesDao.fromJson(dao.data.attributes ?? {});
    return Hold(
      id: dao.data.id,
      referenceCode: attributes.referenceCode,
      date: attributes.date,
      userId: attributes.userId,
      attendant: HoldAttendant(
        id: attributes.attendant?.id,
        firstName: attributes.attendant?.firstName,
        lastName: attributes.attendant?.lastName,
        dob: attributes.attendant?.dob,
        salaryDate: attributes.attendant?.salaryDate,
        email: attributes.attendant?.email,
        phone: attributes.attendant?.phone,
        emailVerifiedAt: attributes.attendant?.emailVerifiedAt,
        defaultPassword: attributes.attendant?.defaultPassword,
        createdAt: attributes.attendant?.createdAt,
        updatedAt: attributes.attendant?.updatedAt,
        status: attributes.attendant?.status,
        language: attributes.attendant?.language,
        companyId: attributes.attendant?.companyId,
        isAdmin: attributes.attendant?.isAdmin,
        isSuper: attributes.attendant?.isSuper,
        warehouseId: attributes.attendant?.warehouseId,
        branchId: attributes.attendant?.branchId,
        type: attributes.attendant?.type,
        salaryAmount: attributes.attendant?.salaryAmount,
        balance: attributes.attendant?.balance,
        dateEmployed: attributes.attendant?.dateEmployed,
        note: attributes.attendant?.note,
        isAttendant: attributes.attendant?.isAttendant,
        tableId: attributes.attendant?.tableId,
        imageUrl: attributes.attendant?.imageUrl,
        media: attributes.attendant?.media,
      ),
      customerId: attributes.customerId,
      customerName: attributes.customerName,
      staffId: attributes.staffId,
      staffName: attributes.staffName,
      warehouseId: attributes.warehouseId,
      warehouseName: attributes.warehouseName,
      taxRate: attributes.taxRate,
      taxAmount: attributes.taxAmount,
      discount: attributes.discount,
      shipping: attributes.shipping,
      grandTotal: attributes.grandTotal,
      receivedAmount: attributes.receivedAmount,
      paidAmount: attributes.paidAmount,
      note: attributes.note,
      status: attributes.status,
      tableId: attributes.tableId,
      tableName: attributes.tableName,
      holdItems: attributes.holdItems
          ?.map(
            (e) => HoldItem(
              id: e.id,
              holdId: e.holdId,
              productId: e.productId,
              productName: e.productName,
              productPrice: e.productPrice,
              netUnitPrice: e.netUnitPrice,
              taxType: e.taxType,
              taxValue: e.taxValue,
              taxAmount: e.taxAmount,
              discountType: e.discountType,
              discountValue: e.discountValue,
              discountAmount: e.discountAmount,
              saleUnit: HoldUnit(
                id: e.saleUnit?.id,
                name: e.saleUnit?.name,
                shortName: e.saleUnit?.shortName,
                baseUnit: e.saleUnit?.baseUnit,
                createdAt: e.saleUnit?.createdAt,
                updatedAt: e.saleUnit?.updatedAt,
                companyId: e.saleUnit?.companyId,
              ),
              quantity: e.quantity,
              subTotal: e.subTotal,
              createdAt: e.createdAt,
              updatedAt: e.updatedAt,
            ),
          )
          .toList(),
      createdAt: attributes.createdAt,
      links: dao.data.links,
      isSynced: true,
    );
  }

  static Hold fromJson(Map<String, dynamic> json) {
    HoldAttendant? parseAttendant(dynamic attendantData) {
      if (attendantData == null) return null;

      if (attendantData is Map<String, dynamic>) {
        return HoldAttendant.fromJson(attendantData);
      }

      if (attendantData is List && attendantData.isNotEmpty) {
        final first = attendantData.first;
        if (first is Map<String, dynamic>) {
          return HoldAttendant.fromJson(first);
        }
      }

      return null;
    }

    final attributes = json['attributes'];
    final links = json['links'];

    return Hold(
      id: int.tryParse(json['id'].toString()),
      type: json['type'],
      links: links,
      referenceCode: attributes['reference_code'],
      date: attributes['date'] != null ? DateTime.tryParse(attributes['date']) : null,
      userId: int.tryParse(attributes['user_id'].toString()),
      attendant: parseAttendant(attributes['attendant']),
      customerId: int.tryParse(attributes['customer_id'].toString()),
      customerName: attributes['customer_name'],
      staffId: int.tryParse(attributes['staff_id'].toString()),
      staffName: attributes['staff_name'],
      warehouseId: int.tryParse(attributes['warehouse_id'].toString()),
      warehouseName: attributes['warehouse_name'],
      taxRate: double.tryParse(attributes['tax_rate'].toString()),
      taxAmount: double.tryParse(attributes['tax_amount'].toString()),
      discount: double.tryParse(attributes['discount'].toString()),
      shipping: double.tryParse(attributes['shipping'].toString()),
      grandTotal: double.tryParse(attributes['grand_total'].toString()),
      receivedAmount: double.tryParse(attributes['received_amount'].toString()),
      paidAmount: double.tryParse(attributes['paid_amount'].toString()),
      note: attributes['note'],
      status: attributes['status'],
      tableId: attributes['table_id'],
      tableName: attributes['table_name'],
      holdItems: (attributes['hold_items'] is List)
          ? (attributes['hold_items'] as List).map((item) => HoldItem.fromJson(item as Map<String, dynamic>)).toList()
          : null,
      createdAt: attributes['created_at'] != null ? DateTime.tryParse(attributes['created_at']) : null,
    );
  }

  LocalHoldsCompanion toDrift() {
    return LocalHoldsCompanion(
      remoteId: Value(id),
      type: Value(type),
      links: Value(links),
      date: Value(date),
      userId: Value(userId),
      attendant: Value(attendant),
      customerId: Value(customerId),
      customerName: Value(customerName),
      staffId: Value(staffId),
      staffName: Value(staffName),
      warehouseId: Value(warehouseId),
      warehouseName: Value(warehouseName),
      taxRate: Value(taxRate),
      taxAmount: Value(taxAmount),
      discount: Value(discount),
      shipping: Value(shipping),
      grandTotal: Value(grandTotal),
      receivedAmount: Value(receivedAmount),
      paidAmount: Value(paidAmount),
      referenceCode: Value(referenceCode),
      note: Value(note),
      status: Value(status?.toString()),
      tableId: Value(tableId),
      holdTableName: Value(tableName?.toString()),
      holdItems: Value(holdItems),
      createdAt: Value(createdAt),
      createdLocallyAt: Value(DateTime.now()),
    );
  }

  static Hold fromDrift(LocalHold row) {
    return Hold(
      id: row.remoteId,
      type: row.type,
      links: row.links,
      referenceCode: row.referenceCode,
      date: row.date,
      userId: row.userId,
      attendant: row.attendant,
      customerId: row.customerId,
      customerName: row.customerName,
      staffId: row.staffId,
      staffName: row.staffName,
      warehouseId: row.warehouseId,
      warehouseName: row.warehouseName,
      taxRate: row.taxRate,
      taxAmount: row.taxAmount,
      discount: row.discount,
      shipping: row.shipping,
      grandTotal: row.grandTotal,
      receivedAmount: row.receivedAmount,
      paidAmount: row.paidAmount,
      note: row.note,
      status: row.status,
      tableId: row.tableId,
      tableName: row.holdTableName,
      holdItems: row.holdItems,
      createdAt: row.createdAt,
      isSynced: row.isSynced,
    );
  }

  CreateHoldDto toCreateHoldDto() {
    return CreateHoldDto(
      type: type,
      links: links,
      date: date,
      userId: userId,
      attendant: attendant,
      customerId: customerId,
      customerName: customerName,
      staffId: staffId,
      staffName: staffName,
      warehouseId: warehouseId,
      warehouseName: warehouseName,
      taxRate: taxRate,
      taxAmount: taxAmount,
      discount: discount,
      shipping: shipping,
      grandTotal: grandTotal,
      receivedAmount: receivedAmount,
      paidAmount: paidAmount,
      referenceCode: referenceCode,
      note: note,
      tableId: tableId,
      tableName: tableName,
      holdItems: holdItems
          ?.map(
            (item) => HoldItemDto(
              id: item.id,
              productId: item.productId,
              name: item.productName,
              productPrice: item.productPrice,
              netUnitPrice: item.netUnitPrice,
              taxType: item.taxType,
              taxValue: item.taxValue,
              taxAmount: item.taxAmount,
              discountType: item.discountType,
              discountValue: item.discountValue,
              discountAmount: item.discountAmount,
              saleUnit: item.saleUnit?.toJson(),
              quantity: item.quantity,
              subTotal: item.subTotal,
            ),
          )
          .toList(),
      createdAt: createdAt,
    );
  }
}

extension CreateHoldDtoMapper on CreateHoldDto {
  LocalHoldsCompanion toDrift() {
    final convertedHoldItems = holdItems?.map((dto) {
      return HoldItem(
        id: dto.id,
        holdId: null,
        productId: dto.productId,
        productName: dto.name,
        productPrice: dto.productPrice,
        netUnitPrice: dto.netUnitPrice,
        taxType: dto.taxType,
        taxValue: dto.taxValue,
        taxAmount: dto.taxAmount,
        discountType: dto.discountType,
        discountValue: dto.discountValue,
        discountAmount: dto.discountAmount,
        saleUnit: dto.saleUnit is Map<String, dynamic> ? HoldUnit.fromJson(dto.saleUnit as Map<String, dynamic>) : null,
        quantity: dto.quantity,
        subTotal: dto.subTotal,
        createdAt: null,
        updatedAt: null,
      );
    }).toList();

    return LocalHoldsCompanion(
      remoteId: const Value.absent(),
      type: Value(type),
      links: Value(links),
      date: Value(date ?? DateTime.now()),
      userId: Value(userId),
      attendant: Value(attendant),
      customerId: Value(customerId),
      customerName: Value(customerName),
      staffId: Value(staffId),
      staffName: Value(staffName),
      warehouseId: Value(warehouseId),
      warehouseName: Value(warehouseName),
      taxRate: Value(taxRate),
      taxAmount: Value(taxAmount),
      discount: Value(discount),
      shipping: Value(shipping),
      grandTotal: Value(grandTotal),
      receivedAmount: Value(receivedAmount),
      paidAmount: Value(paidAmount),
      referenceCode: Value(referenceCode),
      note: Value(note),
      // status: Value(status),
      tableId: Value(tableId),
      holdTableName: Value(tableName),
      holdItems: Value(convertedHoldItems),
      createdAt: Value(createdAt),
      isSynced: Value(false),
      lastSyncedAt: const Value.absent(),
      createdLocallyAt: Value(DateTime.now()),
    );
  }

  Hold toDomain() {
    final convertedHoldItems = holdItems?.map((dto) {
      return HoldItem(
        id: dto.id,
        holdId: null,
        productId: dto.productId,
        productName: dto.name,
        productPrice: dto.productPrice,
        netUnitPrice: dto.netUnitPrice,
        taxType: dto.taxType,
        taxValue: dto.taxValue,
        taxAmount: dto.taxAmount,
        discountType: dto.discountType,
        discountValue: dto.discountValue,
        discountAmount: dto.discountAmount,
        saleUnit: dto.saleUnit is Map<String, dynamic> ? HoldUnit.fromJson(dto.saleUnit as Map<String, dynamic>) : null,
        quantity: dto.quantity,
        subTotal: dto.subTotal,
        createdAt: null,
        updatedAt: null,
      );
    }).toList();

    return Hold(
      id: null,
      type: type,
      links: links,
      referenceCode: referenceCode,
      date: date ?? DateTime.now(),
      userId: userId,
      attendant: attendant,
      customerId: customerId,
      customerName: customerName,
      staffId: staffId,
      staffName: staffName,
      warehouseId: warehouseId,
      warehouseName: warehouseName,
      taxRate: taxRate,
      taxAmount: taxAmount,
      discount: discount,
      shipping: shipping,
      grandTotal: grandTotal,
      receivedAmount: receivedAmount,
      paidAmount: paidAmount,
      note: note,
      status: null,
      tableId: tableId,
      tableName: tableName,
      holdItems: convertedHoldItems,
      createdAt: createdAt,
    );
  }

  static CreateSaleDto fromGroupedHold(GroupedHold groupedHold) {
    final first = groupedHold.firstOrNull;

    final saleItems = groupedHold.holds
        .expand((hold) => hold.holdItems ?? <HoldItem>[])
        .map((item) => SaleItemDto(
              productId: item.productId,
              tableId: int.tryParse(first?.tableId ?? ''),
              productPrice: item.productPrice,
              netUnitPrice: item.netUnitPrice,
              taxType: item.taxType,
              taxValue: item.taxValue,
              taxAmount: item.taxAmount,
              discountType: item.discountType,
              discountValue: item.discountValue,
              discountAmount: item.discountAmount,
              saleUnit: item.saleUnit,
              quantity: item.quantity,
              subTotal: item.subTotal,
              productName: item.productName,
              isCustom: item.isCustom,
              customCost: item.customCost,
              customDescription: item.customDescription,
              customName: item.customName,
              customPrice: item.customPrice,
              productCode: item.code,
            ))
        .toList();

    return CreateSaleDto(
      referenceCode: groupedHold.groupedHoldReferenceNo,
      date: first?.date,
      customerId: first?.customerId,
      warehouseId: first?.warehouseId,
      taxRate: first?.taxRate,
      taxAmount: first?.taxAmount,
      discount: first?.discount,
      shipping: first?.shipping,
      grandTotal: groupedHold.grandTotal,
      status: null,
      paymentStatus: null,
      paymentType: null,
      receivedAmount: first?.receivedAmount,
      paidAmount: first?.paidAmount,
      payments: null,
      notes: first?.note,
      saleItems: saleItems,
      partialPaymentAmount: null,
      partialPaymentMethod: null,
      staffId: first?.staffId,
      staffName: first?.staffName,
      attendantId: first?.attendant?.id,
      attendantName: groupedHold.attendantName,
      roomDetails: null,
      isOffline: null,
      offlineCustomerName: null,
      warehouseName: first?.warehouseName,
      customerName: first?.customerName,
    );
  }

  static CreateSaleDto toCreateSaleDto(Hold hold) {
    final saleItems = (hold.holdItems ?? [])
        .map(
          (item) => SaleItemDto(
            productId: item.productId,
            tableId: int.tryParse(hold.tableId ?? ''),
            productPrice: item.productPrice,
            netUnitPrice: item.netUnitPrice,
            taxType: item.taxType,
            taxValue: item.taxValue,
            taxAmount: item.taxAmount,
            discountType: item.discountType,
            discountValue: item.discountValue,
            discountAmount: item.discountAmount,
            saleUnit: item.saleUnit,
            quantity: item.quantity,
            subTotal: item.subTotal,
            productName: item.productName,
            isCustom: item.isCustom,
            customCost: item.customCost,
            customDescription: item.customDescription,
            customName: item.customName,
            customPrice: item.customPrice,
            productCode: item.code,
          ),
        )
        .toList();

    final attendantFullName = () {
      final att = hold.attendant;
      if (att == null) return null;

      final first = att.firstName ?? "";
      final last = att.lastName ?? "";
      final full = "$first $last".trim();

      return full.isEmpty ? null : full;
    }();

    return CreateSaleDto(
      referenceCode: hold.referenceCode,
      date: hold.date,
      customerId: hold.customerId,
      warehouseId: hold.warehouseId,
      taxRate: hold.taxRate,
      taxAmount: hold.taxAmount,
      discount: hold.discount,
      shipping: hold.shipping,
      grandTotal: hold.grandTotal,
      status: null,
      paymentStatus: null,
      paymentType: null,
      receivedAmount: hold.receivedAmount,
      paidAmount: hold.paidAmount,
      payments: null,
      notes: hold.note,
      saleItems: saleItems,
      partialPaymentAmount: null,
      partialPaymentMethod: null,
      staffId: hold.staffId,
      staffName: hold.staffName,
      attendantId: hold.attendant?.id,
      attendantName: attendantFullName,
      roomDetails: null,
      isOffline: null,
      offlineCustomerName: hold.customerId == null ? hold.customerName : null,
      warehouseName: hold.warehouseName,
      customerName: hold.customerName,
    );
  }
}
