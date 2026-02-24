import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../features/auth/data/models/spotstock_user.dart';
import '../database_client.dart';

class SpotstockUserConverter extends TypeConverter<SpotstockUser, String> {
  const SpotstockUserConverter();

  @override
  SpotstockUser fromSql(String fromDb) {
    return SpotstockUser.fromJson(jsonDecode(fromDb));
  }

  @override
  String toSql(SpotstockUser value) {
    return jsonEncode(value.toJson());
  }
}

class LocalRegisters extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get closedAt => dateTime().nullable()();
  RealColumn get openingCashAtHand => real().nullable()();
  RealColumn get cashInHandWhileClosing => real().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get user => text().map(NullAwareTypeConverter.wrap(const SpotstockUserConverter())).nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

extension LocalRegisterExtension on LocalRegister {
  bool get isClosed => closedAt != null;
}
