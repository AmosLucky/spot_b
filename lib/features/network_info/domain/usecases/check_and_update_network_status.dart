import '../repositories/network_info_repository.dart';

class CheckAndUpdateNetworkStatus {
  final NetworkInfoRepository networkInfoRepository;

  CheckAndUpdateNetworkStatus(this.networkInfoRepository);

  Future<void> call() async {
    await networkInfoRepository.checkAndUpdateNetworkStatus();
  }
}
