import 'package:connectivity_plus/connectivity_plus.dart';
import 'api_client.dart';

/// Interface for network information
abstract class NetworkInfo {
  /// Check if the device is connected to the internet
  Future<bool> get isConnected;

  /// Stream of connectivity changes
  Stream<List<ConnectivityResult>> get onConnectivityChanged;

  /// Check internet availability
  Future<bool> internetAvailable();

  /// Get the current connectivity status
  Future<List<ConnectivityResult>> getConnectivityStatus();
}

/// Implementation of NetworkInfo
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;
  bool _isInternet = false;

  /// API requests that need to be retried when internet is available
  final List<ApiRequest> apiStack = [];

  NetworkInfoImpl({required Connectivity connectivity})
    : _connectivity = connectivity;

  /// Get whether internet is available
  bool get isInternet => _isInternet;

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return result.isNotEmpty &&
        result.any((element) => element != ConnectivityResult.none);
  }

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;

  @override
  Future<bool> internetAvailable() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    _isInternet =
        connectivityResult.isNotEmpty &&
        connectivityResult.any((element) => element != ConnectivityResult.none);
    return _isInternet;
  }

  @override
  Future<List<ConnectivityResult>> getConnectivityStatus() async {
    return await _connectivity.checkConnectivity();
  }
}

/// Class to store API request information for retry
class ApiRequest {
  final String url;
  final HttpMethod method;
  final Map<String, dynamic> variables;
  final dynamic Function(dynamic) onSuccessFunction;
  final Future<dynamic> Function() execute;

  ApiRequest({
    required this.url,
    required this.method,
    required this.variables,
    required this.onSuccessFunction,
    required this.execute,
  });
}