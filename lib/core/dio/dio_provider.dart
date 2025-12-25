import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/data/datasources/local_data_source/shared_preference_service.dart';

const _requestTimeoutInMilliseconds = 45000;

@module
abstract class DioProvider {
  @Named("Host")
  String get host => const String.fromEnvironment(
        'BASE_URL',
        defaultValue: 'https://movie_api.themoviedb.org/3',
      );

  @singleton
  Future<Dio> getAuthorizedDioClient({
    @Named("Host") required String host,
  }) async {
    final baseUrl = _buildBaseUrl(host);
    final authorizedDioClient = _createDioClient(baseUrl);
    authorizedDioClient.interceptors.addAll([
      AuthorizedRequestInterceptor(SharedPreferenceService()),
    ]);
    return authorizedDioClient;
  }

  Dio _createDioClient(
    String baseUrl, {
    int requestTimeoutInMilliseconds = _requestTimeoutInMilliseconds,
  }) {
    final options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(milliseconds: requestTimeoutInMilliseconds),
      receiveTimeout: Duration(milliseconds: requestTimeoutInMilliseconds),
    );
    return Dio(options);
  }

  String _buildBaseUrl(String host) => host;
}

class AuthorizedRequestInterceptor extends QueuedInterceptor {
  AuthorizedRequestInterceptor(this.prefs);

  final SharedPreferenceService prefs;

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      options.headers['Authorization'] =
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNmY2MmM3YmIxNTczNTM0ZjU4MWQwNDdlMjUwNjllOCIsIm5iZiI6MTczMDAxOTk1My4xODgzNjUsInN1YiI6IjVmODA5NzBiMDIxY2VlMDAzNTM5ZjQxOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0jy86fHM-xtnCYl_kuQrh3wth5qmWtSbYHf6wkkeltU";

      return super.onRequest(options, handler);
    } on DioException catch (e) {
      handler.reject(e, true);
    } on Object catch (e) {
      debugPrint(e.toString());
    }
  }
}
