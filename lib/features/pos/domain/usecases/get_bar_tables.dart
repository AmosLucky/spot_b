import '../../../../core/shared/result.dart';
import '../../data/models/bar_table.dart';
import '../repositories/bar_tables_repository.dart';

class GetBarTables {
  final BarTablesRepository barTablesRepository;

  GetBarTables(this.barTablesRepository);

  Stream<Result<List<BarTable>>> call() async* {
    yield* barTablesRepository.getBarTables();
  }
}
