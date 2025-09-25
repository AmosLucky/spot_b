import '../repositories/last_login_time_repository.dart';

class SaveLastLoginTime {
  final LastLoginTimeRepository lastLoginTimeRepository;

  SaveLastLoginTime(this.lastLoginTimeRepository);

  void call(DateTime lastLoginTime) {
    lastLoginTimeRepository.saveLastLoginTime(lastLoginTime);
  }
}
