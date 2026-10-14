import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  Stream<bool> get hasNetworkConnection => _connectivity.onConnectivityChanged
      .map(_hasNetworkConnection)
      .distinct();

  Future<bool> checkNetworkConnection() async {
    final results = await _connectivity.checkConnectivity();
    return _hasNetworkConnection(results);
  }

  bool _hasNetworkConnection(List<ConnectivityResult> results) {
    return results.any((result) => result != ConnectivityResult.none);
  }
}
