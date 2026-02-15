import 'package:drift/drift.dart';
import 'package:spotstock_inventory/core/database/database_client.dart';

import '../../domain/entities/payment_entity.dart';

class PaymentLocalDataSource {

  final DatabaseClient db;

  PaymentLocalDataSource(this.db);

  @override
  Future<List<PaymentEntity>> getByBooking(int bookingId) async {
    final result = await (db.select(db.paymentsTable)
          ..where((tbl) => tbl.bookingId.equals(bookingId)))
        .get();

    return result.map((e) => _map(e)).toList();
  }

  @override
  Future<int> insert(PaymentEntity payment) {
    return db.into(db.paymentsTable).insert(PaymentsTableCompanion.insert(
      bookingId: payment.bookingId,
      amount: payment.amount,
      tax:Value( payment.tax!),
      paymentMethod: payment.paymentMethod,
      description: Value(payment.description),
      date: payment.date!,
      userId: payment.userId,
      registerId: payment.registerId,
    ));
  }

  @override
  Future<void> update(PaymentEntity payment) async {
    await (db.update(db.paymentsTable)
          ..where((tbl) => tbl.id.equals(payment.id!)))
        .write(PaymentsTableCompanion(
      amount: Value(payment.amount),
      tax: Value(payment.tax!),
      description: Value(payment.description),
      paymentMethod: Value(payment.paymentMethod),
    ));
  }

  @override
  Future<void> delete(int id) async {
    await (db.delete(db.paymentsTable)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  PaymentEntity _map(PaymentsTableData e) => PaymentEntity(
        id: e.id,
        bookingId: e.bookingId,
        amount: e.amount,
        tax: e.tax,
        paymentMethod: e.paymentMethod,
        description: e.description ?? '',
        date: e.date,
        userId: e.userId,
        registerId: e.registerId,
      );
}
