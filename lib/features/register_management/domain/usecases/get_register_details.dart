import '../../../../core/shared/result.dart';
import '../../data/models/get_register_details_response_dao.dart';
import '../repositories/register_repository.dart';

class GetRegisterDetails {
  final RegisterRepository registerRepository;

  GetRegisterDetails(this.registerRepository);

  Future<Result<GetRegisterDetailsResponseDao>> call(int? registerId) async {
    return await registerRepository.getRegisterDetails(registerId: registerId);
  }
}
