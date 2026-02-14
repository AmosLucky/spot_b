import '../entities/payment_entity.dart';

abstract class PaymentRepository {

  Future<List<PaymentEntity>> getPaymentsByBooking(int bookingId);

  Future<PaymentEntity?> getPayment(int id);

  Future<void> createPayment(PaymentEntity payment);

  Future<void> updatePayment(PaymentEntity payment);

  Future<void> deletePayment(int id);

}
