import 'package:dio/dio.dart';
import 'package:eitherx/eitherx.dart';
import 'package:injectable/injectable.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/framework/network.dart';

///[SafeApi]
///[Implementation]
@injectable
class SafeApi {
  final NetworkInfo networkInfo;

  SafeApi(this.networkInfo);

  Future<Either<Failure, T>> call<T>({
    required Future<T> apiCall,
  }) async {
    final hasConnection = await networkInfo.isConnected;
    if (hasConnection) {
      try {
        final response = await apiCall;
        return Right(response);
      } on DioException catch (error) {
        kPrint(error);
        return Left(Failure(
          error.response?.statusCode ?? 0,
          error.response?.data['message'] ?? '',
        ));
      } catch (error) {
        return Left(Failure(600, error.toString()));
      }
    } else {
      return Left(Failure(500, 'No Internet'));
    }
  }
}
