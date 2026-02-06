import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pokeapp/core/error/failures.dart';
import 'package:pokeapp/core/network/http_client/http_client.dart';
import 'package:pokeapp/core/utils/constants/app_strings.dart';

class DioHttpClient implements HttpClient {
  DioHttpClient({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Failure<T> _determineFailureType<T>(DioException error) {
    if (error.type == DioExceptionType.cancel &&
        error.error is String &&
        (error.error! as String == AppString.noNetworkToPeripherals ||
            error.error! as String == AppString.noInternetConnection)) {
      return Failure<T>.networkFailure(message: error.error! as String);
    }

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.error is SocketException) {
      return Failure<T>.networkFailure(
        message: error.message ?? AppString.connectionError,
      );
    }

    final statusCode = error.response?.statusCode;
    if (statusCode != null) {
      if (statusCode >= 500) {
        return Failure<T>.serverFailure(
          message: error.response?.statusMessage ?? AppString.serverError,
        );
      }
      if (statusCode >= 400) {
        switch (statusCode) {
          case 401:
          case 403:
            return Failure<T>.authorizationFailure(
              message: AppString.authorizationError,
            );
          case 404:
            return Failure<T>.noDataFailure(message: AppString.noDataError);
          case 422:
            return Failure<T>.parseFailure(
              message: AppString.invalidInputError,
            );
          default:
            return Failure<T>.unknownFailure(
              message: error.response?.statusMessage ?? AppString.requestError,
            );
        }
      }
    }

    return Failure<T>.unknownFailure(
      message:
          error.message ?? error.error?.toString() ?? AppString.unknownError,
    );
  }

  Future<(Failure<T>?, T?)> _handleRequest<T>(
    Future<Response<dynamic>> Function() request, {
    T Function(dynamic data)? parser,
  }) async {
    try {
      final dioResponse = await request();
      final responseData = dioResponse.data;

      if (responseData == null) {
        return (Failure<T>.noDataFailure(message: AppString.noDataError), null);
      }

      if (parser != null) {
        try {
          final parsedData = parser(responseData);
          return (null, parsedData);
        } catch (e) {
          return (
            Failure<T>.parseFailure(message: AppString.failedToParseError),
            null,
          );
        }
      }

      return (null, responseData as T);
    } on DioException catch (e) {
      return (_determineFailureType<T>(e), null);
    } catch (e) {
      return (Failure<T>.unknownFailure(message: e.toString()), null);
    }
  }

  @override
  Future<(Failure<T>?, T?)> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic data)? parser,
    Duration maxStale = Duration.zero,
  }) async {
    return _handleRequest<T>(
      () => _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      ),
      parser: parser,
    );
  }

  @override
  Future<(Failure<T>?, T?)> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic data)? parser,
  }) async {
    return _handleRequest(
      () => _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      ),
      parser: parser,
    );
  }

  @override
  Future<(Failure?, T?)> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic data)? parser,
  }) async {
    return _handleRequest(
      () => _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      ),
      parser: parser,
    );
  }

  @override
  Future<(Failure?, T?)> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic data)? parser,
  }) async {
    return _handleRequest(
      () => _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      ),
      parser: parser,
    );
  }

  @override
  Future<(Failure?, T?)> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic data)? parser,
  }) async {
    return _handleRequest(
      () => _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      ),
      parser: parser,
    );
  }
}
