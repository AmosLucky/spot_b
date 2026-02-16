import 'package:drift/drift.dart';
import '../../../../../core/database/database_client.dart';
import '../../domain/entities/credit_request_entity.dart';

class CreditLocalDataSource {
  final DatabaseClient db;

  CreditLocalDataSource(this.db);

  // ================== GET BY BOOKING ==================
  Future<List<CreditRequestEntity>> getByBooking(int bookingId) async {
    final result = await (db.select(db.creditRequestsTable)
          ..where((tbl) => tbl.bookingId.equals(bookingId)))
        .get();

    return result.map(_map).toList();
  }

  // ================== INSERT ==================
  Future<int> insert(CreditRequestEntity credit) {
    return db.into(db.creditRequestsTable).insert(
          CreditRequestsTableCompanion.insert(
            bookingId: credit.bookingId,
            amount: credit.amount,
            description: Value(credit.description),
            userId: credit.userId,
            registerId: credit.registerId,
            // status + dateCreated use defaults
          ),
        );
  }

  // ================== UPDATE ==================
  Future<void> update(CreditRequestEntity credit) async {
    await (db.update(db.creditRequestsTable)
          ..where((tbl) => tbl.id.equals(credit.id!)))
        .write(
      CreditRequestsTableCompanion(
        amount: Value(credit.amount),
        description: Value(credit.description),
        status: Value(credit.status),
      ),
    );
  }

  // ================== DELETE ==================
  Future<void> delete(int id) async {
    await (db.delete(db.creditRequestsTable)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  CreditRequestEntity _map(CreditRequestsTableData e) =>
      CreditRequestEntity(
        id: e.id,
        bookingId: e.bookingId,
        amount: e.amount,
        description: e.description,
        status: e.status,
        dateCreated: e.dateCreated,
        userId: e.userId,
        registerId: e.registerId,
      );
}
