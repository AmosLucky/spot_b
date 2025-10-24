import '../../../../core/shared/result.dart';
import '../../data/models/create_sale_dto.dart';
import '../../data/models/sale.dart';

abstract class SalesRepository {
  Future<Result<Sale>> createSale(CreateSaleDto createSaleDto);
}
