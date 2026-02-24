import 'package:drift/drift.dart';
import '../../../../../core/database/database_client.dart';
import '../../domain/entities/booking_premium_service_entity.dart';

class BookingPremiumServiceLocalDataSource {
  final DatabaseClient db;

  BookingPremiumServiceLocalDataSource(this.db);

  // GET BY BOOKING
  Future<List<BookingPremiumServiceEntity>> getByBooking(
      int bookingId) async {
    final result = await (db.select(db.bookingPremiumServicesTable)
          ..where((tbl) => tbl.bookingId.equals(bookingId)))
        .get();

    return result.map(_map).toList();
  }

  // INSERT
  Future<int> insert(BookingPremiumServiceEntity entity) {
    return db.into(db.bookingPremiumServicesTable).insert(
          BookingPremiumServicesTableCompanion.insert(
            bookingId: entity.bookingId,
            serviceId: entity.serviceId,
            quantity: Value(entity.quantity),
            unitPriceAtTime: entity.unitPriceAtTime,
            startDate: entity.startDate,
            endDate: entity.endDate,
            numberOfDays: entity.numberOfDays,
            totalPrice: entity.totalPrice,
          ),
        );
  }

  // UPDATE
  Future<void> update(BookingPremiumServiceEntity entity) async {
    await (db.update(db.bookingPremiumServicesTable)
          ..where((tbl) => tbl.id.equals(entity.id!)))
        .write(
      BookingPremiumServicesTableCompanion(
        quantity: Value(entity.quantity),
        unitPriceAtTime: Value(entity.unitPriceAtTime),
        startDate: Value(entity.startDate),
        endDate: Value(entity.endDate),
        numberOfDays: Value(entity.numberOfDays),
        totalPrice: Value(entity.totalPrice),
      ),
    );
  }

  // DELETE
  Future<void> delete(int id) async {
    await (db.delete(db.bookingPremiumServicesTable)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  BookingPremiumServiceEntity _map(
      BookingPremiumServicesTableData e) {
    return BookingPremiumServiceEntity(
      id: e.id,
      bookingId: e.bookingId,
      serviceId: e.serviceId,
      quantity: e.quantity,
      unitPriceAtTime: e.unitPriceAtTime,
      startDate: e.startDate,
      endDate: e.endDate,
      numberOfDays: e.numberOfDays,
      totalPrice: e.totalPrice,
      dateCreated: e.dateCreated,
    );
  }
}
