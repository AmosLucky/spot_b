import '../../../../core/shared/result.dart';
import '../../data/models/customer.dart';
import '../repositories/customers_repository.dart';

class GetCustomers {
  final CustomersRepository customersRepository;

  GetCustomers(this.customersRepository);

  Stream<Result<List<Customer>>> call() async* {
    yield* customersRepository.getCustomers();
  }
}
