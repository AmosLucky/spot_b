import 'package:drift/drift.dart';
import '../../../../../core/database/database_client.dart';
import '../../domain/entities/discount_entity.dart';

class DiscountLocalDataSource {
  final DatabaseClient db;

  DiscountLocalDataSource(this.db);

  Future<List<DiscountEntity>> getByBooking(int bookingId) async {
    final result = await (db.select(db.discountsTable)
          ..where((tbl) => tbl.bookingId.equals(bookingId)))
        .get();

    return result.map(_map).toList();
  }

  Future<int> insert(DiscountEntity discount) {
    return db.into(db.discountsTable).insert(
          DiscountsTableCompanion.insert(
            bookingId: discount.bookingId,
            amount: discount.amount,
            description: Value(discount.description),
            userId: discount.userId,
            registerId: discount.registerId,
            // dateCreated & status use defaults
          ),
        );
  }

  Future<void> update(DiscountEntity discount) async {
    await (db.update(db.discountsTable)
          ..where((tbl) => tbl.id.equals(discount.id!)))
        .write(
      DiscountsTableCompanion(
        amount: Value(discount.amount),
        description: Value(discount.description),
        status: Value(discount.status),
      ),
    );
  }

  Future<void> delete(int id) async {
    await (db.delete(db.discountsTable)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  DiscountEntity _map(DiscountsTableData e) => DiscountEntity(
        id: e.id,
        bookingId: e.bookingId,
        amount: e.amount,
        description: e.description,
        userId: e.userId,
        registerId: e.registerId,
        dateCreated: e.dateCreated,
        status: e.status,
      );
}
