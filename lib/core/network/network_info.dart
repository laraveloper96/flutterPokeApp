import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this.connection);

  final InternetConnection connection;

  @override
  Future<bool> get isConnected => connection.hasInternetAccess;
}
