import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfoService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _networkChangeController = StreamController<bool>.broadcast();

  bool? _isConnected;
  bool? get isConnected => _isConnected;

  Stream<bool> get onNetworkChange => _networkChangeController.stream;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  Future<void> start() async {
    final initialResult = await _connectivity.checkConnectivity();
    final isOnline = initialResult.any((result) => result != ConnectivityResult.none);
    _isConnected = isOnline;
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateNetworkStatus);
  }

  Future<void> stop() async {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
  }

  void _updateNetworkStatus(List<ConnectivityResult> result) {
    final isOnline = result.any((result) => result != ConnectivityResult.none);
    if (isOnline != _isConnected) {
      _isConnected = isOnline;
      _networkChangeController.add(isOnline);
    } else {}
  }

  void dispose() {
    stop();
    _networkChangeController.close();
  }
}
