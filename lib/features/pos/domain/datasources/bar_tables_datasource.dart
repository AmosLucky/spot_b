import '../../../../core/shared/result.dart';
import '../../data/models/bar_table.dart';

abstract class BarTablesDatasource {
  Future<Result<List<BarTable>>> getBarTables();
}
