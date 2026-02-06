import 'package:equatable/equatable.dart';
import 'package:pokeapp/core/error/failures.dart';

abstract interface class UseCase<ResultType, Params> {
  Future<(Failure?, ResultType?)> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
