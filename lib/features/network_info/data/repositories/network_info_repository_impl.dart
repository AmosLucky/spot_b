import '../../domain/repositories/network_info_repository.dart';
import '../../network_info_service.dart';

class NetworkInfoRepositoryImpl implements NetworkInfoRepository {
  NetworkInfoRepositoryImpl(this._networkInfoService);

  final NetworkInfoService _networkInfoService;

  @override
  Future<bool?> get isConnected async => _networkInfoService.isConnected;

  @override
  Stream<bool> get onNetworkChange => _networkInfoService.onNetworkChange;
}
