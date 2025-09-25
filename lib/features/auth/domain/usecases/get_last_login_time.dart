import '../../../../core/shared/result.dart';
import '../repositories/last_login_time_repository.dart';

class GetLastLoginTime {
  final LastLoginTimeRepository lastLoginTimeRepository;

  GetLastLoginTime(this.lastLoginTimeRepository);

  Future<Result<DateTime?>> call() async {
    return await lastLoginTimeRepository.getLastLoginTime();
  }
}
