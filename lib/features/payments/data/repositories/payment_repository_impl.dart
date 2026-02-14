import '../../domain/entities/payment_entity.dart';
import '../../domain/repositories/payment_repository.dart';
import '../local/payment_local_data_source.dart';

class PaymentRepositoryImpl implements PaymentRepository {

  final PaymentLocalDataSource local;
  //final PaymentRemoteDataSource remote;

  PaymentRepositoryImpl(this.local, 
  //this.remote
  );

  @override
  Future<void> createPayment(PaymentEntity payment) async {
    await local.insert(payment);
   // await remote.createPayment(payment);
  }

  @override
  Future<void> deletePayment(int id) async {
    await local.delete(id);
    //await remote.deletePayment(id);
  }

  @override
  Future<PaymentEntity?> getPayment(int id) async {
    final payments = await local.getByBooking(id);
    return payments.isEmpty ? null : payments.first;
  }

  @override
  Future<List<PaymentEntity>> getPaymentsByBooking(int bookingId) async {
    final localData = await local.getByBooking(bookingId);
    return localData;
  }

  @override
  Future<void> updatePayment(PaymentEntity payment) async {
    await local.update(payment);
    //await remote.updatePayment(payment);
  }
}
