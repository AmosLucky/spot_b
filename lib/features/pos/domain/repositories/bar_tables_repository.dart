import '../../../../core/shared/result.dart';
import '../../data/models/bar_table.dart';

abstract class BarTablesRepository {
  Stream<Result<List<BarTable>>> getBarTables();
}
