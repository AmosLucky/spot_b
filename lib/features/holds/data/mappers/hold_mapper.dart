import '../../../../core/networking/api_response/spotstock_api_data_item.dart';
import '../../../../core/networking/api_response/spotstock_api_response.dart';
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
    );
  }

  static Hold fromJson(Map<String, dynamic> json) {
    HoldAttendant? _parseAttendant(dynamic attendantData) {
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

      return null; // Anything else → return null
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
      attendant: _parseAttendant(attributes['attendant']),
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
          ? (attributes['hold_items'] as List)
              .map((item) => HoldItem.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
      createdAt:
          attributes['created_at'] != null ? DateTime.tryParse(attributes['created_at']) : null,
    );
  }
}
