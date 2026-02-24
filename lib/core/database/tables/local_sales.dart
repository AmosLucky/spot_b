import 'package:drift/drift.dart';
import 'dart:convert';

import '../../../../../features/pos/data/models/sale.dart';

class SaleItemListConverter extends TypeConverter<List<SaleItem>, String> {
  const SaleItemListConverter();

  @override
  List<SaleItem> fromSql(String fromDb) {
    if (fromDb.isEmpty) return <SaleItem>[];
    final List decoded = jsonDecode(fromDb) as List;
    return decoded.map((e) => SaleItem.fromJson(Map<String, dynamic>.from(e as Map))).toList();
  }

  @override
  String toSql(List<SaleItem> value) {
    final List mapped = value.map((e) => e.toJson()).toList();
    return jsonEncode(mapped);
  }
}

class PaymentListConverter extends TypeConverter<List<SalePayment>, String> {
  const PaymentListConverter();

  @override
  List<SalePayment> fromSql(String fromDb) {
    if (fromDb.isEmpty) return <SalePayment>[];
    final List decoded = jsonDecode(fromDb) as List;
    return decoded.map((e) => SalePayment.fromJson(Map<String, dynamic>.from(e as Map))).toList();
  }

  @override
  String toSql(List<SalePayment> value) {
    final List mapped = value.map((e) => e.toJson()).toList();
    return jsonEncode(mapped);
  }
}

class PaymentMethodsConverter extends TypeConverter<List<String>, String> {
  const PaymentMethodsConverter();

  @override
  List<String> fromSql(String fromDb) {
    if (fromDb.isEmpty) return <String>[];
    final List decoded = jsonDecode(fromDb) as List;
    return decoded.map((e) => e.toString()).toList();
  }

  @override
  String toSql(List<String> value) => jsonEncode(value);
}

class LoggedUserConverter extends TypeConverter<SaleLoggedUser, String> {
  const LoggedUserConverter();

  @override
  SaleLoggedUser fromSql(String fromDb) {
    final Map<String, dynamic> decoded = Map<String, dynamic>.from(jsonDecode(fromDb) as Map);
    return SaleLoggedUser.fromJson(decoded);
  }

  @override
  String toSql(SaleLoggedUser value) {
    return jsonEncode(value.toJson());
  }
}

class MapStringDynamicConverter extends TypeConverter<Map<String, dynamic>, String> {
  const MapStringDynamicConverter();

  @override
  Map<String, dynamic> fromSql(String fromDb) {
    if (fromDb.isEmpty) return {};
    return Map<String, dynamic>.from(jsonDecode(fromDb) as Map);
  }

  @override
  String toSql(Map<String, dynamic> value) {
    return jsonEncode(value);
  }
}

class LocalSales extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get remoteId => integer().nullable()();

  TextColumn get type => text().nullable()();
  TextColumn get links => text().map(NullAwareTypeConverter.wrap(const MapStringDynamicConverter())).nullable()();

  DateTimeColumn get date => dateTime().nullable()();

  IntColumn get isReturn => integer().nullable()();

  IntColumn get customerId => integer().nullable()();
  IntColumn get companyId => integer().nullable()();

  TextColumn get loggedUser => text().map(NullAwareTypeConverter.wrap(const LoggedUserConverter())).nullable()();

  TextColumn get customerName => text().nullable()();
  TextColumn get staffName => text().nullable()();

  IntColumn get warehouseId => integer().nullable()();
  TextColumn get warehouseName => text().nullable()();

  RealColumn get taxRate => real().nullable()();
  RealColumn get taxAmount => real().nullable()();

  RealColumn get discount => real().nullable()();
  RealColumn get discountAmount => real().nullable()();

  RealColumn get shipping => real().nullable()();

  RealColumn get grandTotal => real().nullable()();
  RealColumn get receivedAmount => real().nullable()();
  RealColumn get paidAmount => real().nullable()();
  RealColumn get partialAmount => real().nullable()();
  RealColumn get dueAmount => real().nullable()();

  IntColumn get paymentType => integer().nullable()();
  TextColumn get note => text().nullable()();

  IntColumn get status => integer().nullable()();
  IntColumn get paymentStatus => integer().nullable()();

  TextColumn get referenceCode => text().nullable()();

  TextColumn get saleItems => text().map(NullAwareTypeConverter.wrap(const SaleItemListConverter())).nullable()();
  TextColumn get payments => text().map(NullAwareTypeConverter.wrap(const PaymentListConverter())).nullable()();

  TextColumn get paymentMethods => text().map(NullAwareTypeConverter.wrap(const PaymentMethodsConverter())).nullable()();

  DateTimeColumn get createdAt => dateTime().nullable()();
  TextColumn get barcodeUrl => text().nullable()();
  BoolColumn get isOffline => boolean().withDefault(const Constant(false))();

  TextColumn get offlineCustomerName => text().nullable()();

  IntColumn get staffId => integer().nullable()();
  TextColumn get attendantName => text().nullable()();
  IntColumn get attendantId => integer().nullable()();

  TextColumn get roomDetails => text().map(NullAwareTypeConverter.wrap(const MapStringDynamicConverter())).nullable()();

  RealColumn get partialPaymentAmount => real().nullable()();
  TextColumn get partialPaymentMethod => text().nullable()();

  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  DateTimeColumn get createdLocallyAt => dateTime().nullable()();
}
