import '../../../../core/shared/result.dart';
import '../../data/models/customer.dart';

abstract class CustomersRepository {
  Stream<Result<List<Customer>>> getCustomers();
}
