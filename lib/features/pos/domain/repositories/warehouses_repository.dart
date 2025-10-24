import '../../../../core/shared/result.dart';
import '../../data/models/warehouse.dart';

abstract class WarehousesRepository {
  Stream<Result<List<Warehouse>>> getWarehouses();
}
