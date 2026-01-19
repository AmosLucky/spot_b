import '../../../../core/constants/strings/spotstock_strings.dart';
import '../../../../core/domain/usecases/spotstock_sync_task_usecase.dart';
import '../../../../core/shared/result.dart';
import '../repositories/customers_repository.dart';

class SyncCustomers extends SpotstockSyncTaskUsecase {
  final CustomersRepository customersRepository;

  SyncCustomers(this.customersRepository);

  @override
  String get name => SpotstockStrings.syncCustomers;

  @override
  Future<Result<void>> sync() async {
    return customersRepository.syncCustomers();
  }
}
