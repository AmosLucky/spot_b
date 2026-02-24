abstract class NetworkInfoRepository {
  Future<bool?> get isConnected;
  Stream<bool> get onNetworkChange;
  Future<void> checkAndUpdateNetworkStatus();
}
