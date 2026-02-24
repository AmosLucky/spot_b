import '../../../../core/shared/result.dart';
import '../../../../features/auth/domain/repositories/user_repository.dart';

class CheckIsAdmin {
  final UserRepository userRepository;

  CheckIsAdmin(this.userRepository);

  Future<Result<bool?>> call() async {
    final userResult = await userRepository.getUser();
    if (userResult is Success) {
      final spotstockUser = userResult.data;
      return Result.success(spotstockUser?.isAdmin);
    }
    if (userResult is Failure) {
      return Result.failure(userResult.error);
    }
    return Result.success(null);
  }
}
