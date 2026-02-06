import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

class ConnectivityChecker {
  final Uri _probeUrl = Uri.https('clients3.google.com', '/generate_204');
  final Duration _probeTimeout = const Duration(seconds: 3);

  /// No need to abstract from http client here, as we only need to make
  /// a HEAD request as fast as possible to check for effective internet
  /// connection
  final http.Client _client = http.Client();

  Future<bool> hasRealInternetAccess() async {
    try {
      final response = await _client.head(_probeUrl).timeout(_probeTimeout);

      if (response.statusCode == 204) {
        return true;
      }

      return false;
    } on TimeoutException catch (_) {
      return false;
    } on SocketException catch (_) {
      return false;
    } catch (e) {
      return false;
    }
  }
}
