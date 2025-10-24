import '../../../../core/shared/result.dart';
import '../../data/models/warehouse.dart';
import '../repositories/warehouses_repository.dart';

class GetWarehouses {
  final WarehousesRepository warehousesRepository;

  GetWarehouses(this.warehousesRepository);

  Stream<Result<List<Warehouse>>> call() async* {
    yield* warehousesRepository.getWarehouses();
  }
}
