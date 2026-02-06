import 'package:pokeapp/core/error/failures.dart';

abstract interface class HttpClient {
  /// Performs a GET request
  ///
  /// [path] - The endpoint path
  /// [queryParameters] - Optional query parameters
  /// [headers] - Optional request headers
  ///
  /// Returns an [Either] with either a [Failure] or the successful
  /// response data.
  Future<(Failure?, T?)> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic data)? parser,
    Duration maxStale = Duration.zero,
  });

  Future<(Failure?, T?)> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic data)? parser,
  });

  Future<(Failure?, T?)> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic data)? parser,
  });

  Future<(Failure?, T?)> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic data)? parser,
  });

  Future<(Failure?, T?)> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic data)? parser,
  });
}
