import 'package:drift/drift.dart';

import '../../../../core/database/database_client.dart';
import '../models/attendant.dart';

extension AttendantMapper on Attendant {
  LocalAttendantsCompanion toDrift() {
    return LocalAttendantsCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      firstName: Value(firstName),
      lastName: Value(lastName),
      email: Value(email),
      phone: Value(phone),
      image: Value(image),
      createdAt: Value(createdAt),
      isAdmin: Value(isAdmin),
      isSuper: Value(isSuper),
      isAttendant: Value(isAttendant),
      setPin: Value(setPin),
      link: Value(link),
    );
  }

  static Attendant fromDrift(LocalAttendant row) {
    return Attendant(
      id: row.id,
      firstName: row.firstName,
      lastName: row.lastName,
      email: row.email,
      phone: row.phone,
      image: row.image,
      createdAt: row.createdAt,
      isAdmin: row.isAdmin,
      isSuper: row.isSuper,
      isAttendant: row.isAttendant,
      setPin: row.setPin,
      link: row.link,
    );
  }
}
