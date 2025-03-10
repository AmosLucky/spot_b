import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class MyConnectivity {
  MyConnectivity._();

  static final _instance = MyConnectivity._();
  static MyConnectivity get instance => _instance;
  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  void initialise() async {
    List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    _checkStatus(result as ConnectivityResult);
    _connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result as ConnectivityResult);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}

class ConnectivityService {
  ConnectivityService._internal();

  static final ConnectivityService _instance = ConnectivityService._internal();
  static ConnectivityService get instance => _instance;

  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  /// Exposes a stream to listen for connectivity changes (online/offline)
  Stream<bool> get connectivityStream => _controller.stream;

  /// Initializes the connectivity check and starts monitoring changes
  void initialize() {
    _checkInitialStatus();
    _connectivity.onConnectivityChanged.listen(
        _handleConnectivityChange as Function(List<ConnectivityResult>)?);
  }

  /// Handles the initial connectivity check
  Future<void> _checkInitialStatus() async {
    final result = await _connectivity.checkConnectivity();
    _checkInternetConnection(result as ConnectivityResult);
  }

  /// Handles connectivity changes
  void _handleConnectivityChange(ConnectivityResult result) {
    _checkInternetConnection(result);
  }

  /// Checks internet connection and emits the result to the stream
  Future<void> _checkInternetConnection(ConnectivityResult result) async {
    bool isOnline = false;

    if (result != ConnectivityResult.none) {
      try {
        final lookupResult = await InternetAddress.lookup('google.com');
        isOnline =
            lookupResult.isNotEmpty && lookupResult[0].rawAddress.isNotEmpty;
      } on SocketException {
        isOnline = false;
      }
    }

    _controller.sink.add(isOnline);
  }

  /// Disposes of the stream controller
  void dispose() {
    _controller.close();
  }
}

class InternetUtils {
  static Future<bool> isConnected() async {
    try {
      // Check network connectivity status
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return false; // No network connection
      }

      // Check actual internet access by performing a DNS lookup
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } catch (e) {
      // Catch and handle errors (e.g., timeout, lookup failure)
      return false;
    }
  }
}
