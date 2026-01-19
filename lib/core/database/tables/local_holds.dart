import 'package:drift/drift.dart';
import 'dart:convert';

import '../../../../features/holds/data/models/hold.dart';
import 'local_sales.dart';

class HoldItemListConverter extends TypeConverter<List<HoldItem>, String> {
  const HoldItemListConverter();

  @override
  List<HoldItem> fromSql(String fromDb) {
    if (fromDb.isEmpty) return <HoldItem>[];
    final List decoded = jsonDecode(fromDb) as List;
    return decoded.map((e) => HoldItem.fromJson(Map<String, dynamic>.from(e as Map))).toList();
  }

  @override
  String toSql(List<HoldItem> value) {
    final List mapped = value.map((e) => e.toJson()).toList();
    return jsonEncode(mapped);
  }
}

class HoldAttendantConverter extends TypeConverter<HoldAttendant, String> {
  const HoldAttendantConverter();

  @override
  HoldAttendant fromSql(String fromDb) {
    if (fromDb.isEmpty) return const HoldAttendant();
    final Map<String, dynamic> decoded = Map<String, dynamic>.from(jsonDecode(fromDb) as Map);
    return HoldAttendant.fromJson(decoded);
  }

  @override
  String toSql(HoldAttendant value) {
    return jsonEncode(value.toJson());
  }
}

class LocalHolds extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get remoteId => integer().nullable()();

  TextColumn get type => text().nullable()();
  TextColumn get links => text().map(NullAwareTypeConverter.wrap(const MapStringDynamicConverter())).nullable()();

  DateTimeColumn get date => dateTime().nullable()();

  IntColumn get userId => integer().nullable()();

  TextColumn get attendant => text().map(NullAwareTypeConverter.wrap(const HoldAttendantConverter())).nullable()();

  IntColumn get customerId => integer().nullable()();
  TextColumn get customerName => text().nullable()();

  IntColumn get staffId => integer().nullable()();
  TextColumn get staffName => text().nullable()();

  IntColumn get warehouseId => integer().nullable()();
  TextColumn get warehouseName => text().nullable()();

  RealColumn get taxRate => real().nullable()();
  RealColumn get taxAmount => real().nullable()();

  RealColumn get discount => real().nullable()();

  RealColumn get shipping => real().nullable()();

  RealColumn get grandTotal => real().nullable()();
  RealColumn get receivedAmount => real().nullable()();
  RealColumn get paidAmount => real().nullable()();

  TextColumn get referenceCode => text().nullable()();

  TextColumn get note => text().nullable()();
  TextColumn get status => text().nullable()();

  TextColumn get tableId => text().nullable()();
  TextColumn get holdTableName => text().nullable()();

  TextColumn get holdItems => text().map(NullAwareTypeConverter.wrap(const HoldItemListConverter())).nullable()();

  DateTimeColumn get createdAt => dateTime().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  DateTimeColumn get createdLocallyAt => dateTime().nullable()();
}
