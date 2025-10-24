import '../../../../core/shared/result.dart';
import '../../data/models/create_sale_dto.dart';
import '../../data/models/sale.dart';
import '../repositories/sales_repository.dart';

class CreateSale {
  final SalesRepository salesRepository;

  CreateSale(this.salesRepository);

  Future<Result<Sale>> call(CreateSaleDto createSaleDto) async {
    return await salesRepository.createSale(createSaleDto);
  }
}
