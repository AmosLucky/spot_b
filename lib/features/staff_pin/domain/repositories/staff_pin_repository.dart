import '../../../../core/shared/result.dart';
import '../../data/models/verify_pin_dto.dart';

abstract class StaffPinRepository {
  Future<Result<bool>> verifyPin(VerifyPinDto verifyPinDto);
}
