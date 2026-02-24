import '../entities/credit_request_entity.dart';

abstract class CreditRepository {
  Future<List<CreditRequestEntity>> getByBooking(int bookingId);
  Future<int> create(CreditRequestEntity credit);
  Future<void> update(CreditRequestEntity credit);
  Future<void> delete(int id);
  // 🔥 NEW
  Future<List<CreditRequestEntity>> getAllCredits();
}
