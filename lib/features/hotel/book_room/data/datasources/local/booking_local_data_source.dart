import 'package:drift/drift.dart';

import '../../../../../../core/database/database_client.dart';
import '../../../domain/entities/booking_entity.dart';

class BookingLocalDataSource {
  final DatabaseClient db;

  BookingLocalDataSource(this.db);

  // ================== FETCH ALL ==================
  Future<List<BookingEntity>> getBookings({String? search}) async {
    final query = db.select(db.localBookingsTable);

    if (search != null && search.isNotEmpty) {
      query.where(
        (tbl) =>
            tbl.bookingNumber.like('%$search%') |
            tbl.roomNumbers.like('%$search%'),
      );
    }

    final rows = await query.get();
    return rows.map(_toEntity).toList();
  }

  // ================== ADD ==================
  Future<void> createBooking(BookingEntity booking) async {
    await db.into(db.localBookingsTable).insert(_toCompanion(booking));
  }

  // ================== UPDATE ==================
  Future<void> updateBooking(BookingEntity booking) async {
    await db.update(db.localBookingsTable).replace(_toCompanion(booking));
  }

  // ================== DELETE (OPTIONAL) ==================
  Future<void> deleteBooking(int id) async {
    await (db.delete(db.localBookingsTable)..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  // ================== HELPERS ==================

  BookingEntity _toEntity(LocalBookingsTableData row) {
    return BookingEntity(
        id: row.id,
        bookingNumber: row.bookingNumber,
        customerId: row.customerId,
        roomNumbers: row.roomNumbers,
        dateFrom: row.dateFrom,
        dateTo: row.dateTo,
        status: row.status,
        paymentStatus: row.paymentStatus,
        checkInStatus: row.checkInStatus,
        checkOutStatus: row.checkOutStatus,
        roomKeyStatus: row.roomKeyStatus,
        totalAmount: row.totalAmount,
        createdAt: row.createdAt,
        discount: row.discount,
        guestType: row.guestType,
        updatedAt: row.updatedAt);
  }

  LocalBookingsTableCompanion _toCompanion(BookingEntity entity) {
    return LocalBookingsTableCompanion(
        id: entity.id != null ? Value(entity.id!) : const Value.absent(),
        bookingNumber: Value(entity.bookingNumber),
        customerId: Value(entity.customerId),
        roomNumbers: Value(entity.roomNumbers),
        dateFrom: Value(entity.dateFrom),
        dateTo: Value(entity.dateTo),
        status: Value(entity.status),
        paymentStatus: Value(entity.paymentStatus),
        checkInStatus: Value(entity.checkInStatus),
        checkOutStatus: Value(entity.checkOutStatus),
        roomKeyStatus: Value(entity.roomKeyStatus),
        totalAmount: Value(entity.totalAmount),
        createdAt: Value(entity.createdAt),
        discount: Value(entity.discount),
        guestType: Value(entity.guestType),
        updatedAt: Value(entity.updatedAt));
  }
}
