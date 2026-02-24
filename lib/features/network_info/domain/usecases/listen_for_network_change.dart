import '../repositories/network_info_repository.dart';

class ListenForNetworkChange {
  final NetworkInfoRepository _networkInfoRepository;

  ListenForNetworkChange(this._networkInfoRepository);

  Stream<bool> call() {
    return _networkInfoRepository.onNetworkChange;
  }
}
