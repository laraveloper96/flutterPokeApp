import 'package:equatable/equatable.dart';

sealed class BaseFailure extends Equatable {
  final String message;
  final String? errorCode;

  const BaseFailure({this.message = '', this.errorCode});

  @override
  List<Object> get props => [message, errorCode ?? ''];
}

class Failure<T> extends BaseFailure {
  const Failure.emptyError({
    super.message = 'Empty Error',
    super.errorCode = 'EMPTY_ERROR',
  });

  const Failure.serverFailure({
    super.message = 'Server Failure',
    super.errorCode = 'SERVER_FAILURE',
  });
  const Failure.networkFailure({
    super.message = 'Network Failure',
    super.errorCode = 'NETWORK_FAILURE',
  });

  const Failure.cacheFailure({
    super.message = 'Cache Failure',
    super.errorCode = 'CACHE_FAILURE',
  });

  const Failure.connectionFailure({
    super.message = 'Connection Failure',
    super.errorCode = 'CONNECTION_FAILURE',
  });

  const Failure.parseFailure({
    super.message = 'Parse Failure',
    super.errorCode = 'PARSE_FAILURE',
  });

  const Failure.offlineFailure({
    super.message = 'Offline Failure',
    super.errorCode = 'OFFLINE_FAILURE',
  });

  const Failure.unknownFailure({
    super.message = 'Unknown Failure',
    super.errorCode = 'UNKNOWN_FAILURE',
  });

  const Failure.noDataFailure({
    super.message = 'No Data Failure',
    super.errorCode = 'NO_DATA_FAILURE',
  });

  const Failure.authorizationFailure({
    super.message = 'Authorization Failure',
    super.errorCode = 'AUTHORIZATION_FAILURE',
  });

  const Failure.customFailure({
    super.message = 'Custom Failure',
    super.errorCode = 'CUSTOM_FAILURE',
  });
}
