import '../../../../core/shared/result.dart';
import '../../data/models/attendant.dart';
import '../repositories/attendants_repository.dart';

class GetAttendants {
  final AttendantsRepository repository;

  GetAttendants(this.repository);

  Stream<Result<List<Attendant>>> call() async* {
    yield* repository.getAttendants();
  }
}
