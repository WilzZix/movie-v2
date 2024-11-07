import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movie/core/utils/error_to_user_message.dart';

class DioInterceptor extends Interceptor {
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    log('*** onError ***:');
    log('uri: ${err.requestOptions.method} - ${err.requestOptions.uri.toString()}');
    log('Dio exception: ${err.toString()}');
    log('Exception response: ${err.response.toString()}');
    handler.reject(DioExceptions(
      err,
      requestOptions: err.requestOptions,
    ));
  }
}
