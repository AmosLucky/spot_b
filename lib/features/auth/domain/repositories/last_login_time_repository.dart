import '../../../../core/shared/result.dart';

abstract class LastLoginTimeRepository {
  void saveLastLoginTime(DateTime lastLoginTime);
  Future<Result<DateTime?>> getLastLoginTime();
  void clearLastLoginTime();
}
