// import 'package:dio/dio.dart';
// import 'package:pokeapp/core/error/failures.dart';

// class ApiResponseAdapter<T> {
//   Future<(Failure?, T?)> call(Future<T> Function() call) async {
//     try {
//       final result = await call();
//       return (null, result);
//     } on DioException catch (e) {
//       final responseData = e.response?.data;
//       if (responseData is Map<String, dynamic>) {
//         final message =
//             responseData['message'] ??
//             responseData['error'] ??
//             e.message ??
//             'Server Error';
//         return (
//           Failure.serverFailure(
//             message: message.toString(),
//             errorCode: e.response?.statusCode?.toString(),
//           ),
//           null,
//         );
//       }
//       return (
//         Failure.networkFailure(message: e.message ?? 'Network Error'),
//         null,
//       );
//     } catch (e) {
//       return (Failure.unknownFailure(message: e.toString()), null);
//     }
//   }
// }
