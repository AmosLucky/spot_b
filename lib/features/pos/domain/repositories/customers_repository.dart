import 'package:spotstock_inventory/features/pos/data/models/create_customer_dto.dart';

import '../../../../core/shared/result.dart';
import '../../data/models/customer.dart';

abstract class CustomersRepository {
  Stream<Result<List<Customer>>> getCustomers();
  Future<Result<Customer>> createCustomer(CreateCustomerDto createCustomerDto);
  Future<Result<void>> syncCustomers();
}
