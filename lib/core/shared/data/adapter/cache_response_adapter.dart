import 'package:pokeapp/core/error/failures.dart';

class CacheResponseAdapter<T> {
  (Failure?, T?) call(T? Function() action) {
    try {
      final result = action();
      if (result != null) {
        return (null, result);
      }
      return (const Failure.cacheFailure(message: 'No cached data'), null);
    } catch (e) {
      return (Failure.parseFailure(message: e.toString()), null);
    }
  }
}
