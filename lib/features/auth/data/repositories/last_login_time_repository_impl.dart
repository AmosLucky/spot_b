import '../../../../core/shared/result.dart';
import '../../domain/repositories/last_login_time_repository.dart';
import '../datasources/local/last_login_time_datasource.dart';

class LastLoginTimeRepositoryImpl extends LastLoginTimeRepository {
  final LastLoginTimeDatasource lastLoginTimeDatasource;

  LastLoginTimeRepositoryImpl(this.lastLoginTimeDatasource);

  @override
  void saveLastLoginTime(DateTime lastLoginTime) {
    lastLoginTimeDatasource.saveLastLoginTime(lastLoginTime);
  }

  @override
  Future<Result<DateTime?>> getLastLoginTime() async {
    return await lastLoginTimeDatasource.getLastLoginTime();
  }

  @override
  void clearLastLoginTime() {
    lastLoginTimeDatasource.clearLastLoginTime();
  }
}
