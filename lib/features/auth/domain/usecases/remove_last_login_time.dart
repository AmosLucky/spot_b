import '../repositories/last_login_time_repository.dart';

class RemoveLastLoginTime {
  final LastLoginTimeRepository lastLoginTimeRepository;

  RemoveLastLoginTime(this.lastLoginTimeRepository);

  void call() {
    lastLoginTimeRepository.clearLastLoginTime();
  }
}
