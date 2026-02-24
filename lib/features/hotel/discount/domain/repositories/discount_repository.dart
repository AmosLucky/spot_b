import '../entities/discount_entity.dart';

abstract class DiscountRepository {
  Future<List<DiscountEntity>> getByBooking(int bookingId);
  Future<int> create(DiscountEntity discount);
  Future<void> update(DiscountEntity discount);
  Future<void> delete(int id);
  Future<List<DiscountEntity>> getAllDiscountRequests();
}
