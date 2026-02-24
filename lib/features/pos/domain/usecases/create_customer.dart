import 'package:spotstock_inventory/features/pos/data/models/create_customer_dto.dart';
import 'package:spotstock_inventory/features/pos/domain/repositories/customers_repository.dart';

import '../../../../core/shared/result.dart';
import '../../data/models/customer.dart';

class CreateCustomer {
  final CustomersRepository customersRepository;

  CreateCustomer(this.customersRepository);

  Future<Result<Customer>> call(CreateCustomerDto createCustomerDto) async {
    return await customersRepository.createCustomer(createCustomerDto);
  }
}
