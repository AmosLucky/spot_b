import '../../../../core/shared/result.dart';
import '../../data/models/verify_pin_dto.dart';
import '../repositories/staff_pin_repository.dart';

class VerifyStaffPin {
  final StaffPinRepository staffPinRepository;

  VerifyStaffPin(this.staffPinRepository);

  Future<Result<bool>> call(VerifyPinDto verifyPinDto) async {
    return await staffPinRepository.verifyPin(verifyPinDto);
  }
}
