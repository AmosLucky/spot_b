import '../../../../core/shared/result.dart';
import '../../data/models/attendant.dart';

abstract class AttendantsRepository {
  Stream<Result<List<Attendant>>> getAttendants();
}
