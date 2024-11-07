import 'package:dio/dio.dart';

class DioExceptions extends DioException {
  DioExceptions(this.dioException, {required super.requestOptions});

  String get getServerError => _getServerError();

  final DioException dioException;

  String _getServerError() {
    if (dioException.response != null) {
      switch (dioException.response!.statusCode) {
        case 200:
          return 'OK';
        case 201:
          return 'Created';
        case 400:
          return 'Bad Request';
        case 401:
          return 'Unauthorized';
        case 403:
          return 'Forbidden';
        case 404:
          return 'Not Found';
        case 405:
          return 'Method Not Allowed';
        case 408:
          return 'Request Timeout';
        case 500:
          return 'Internal Server Error';
        case 502:
          return 'Bad Gateway';
        case 503:
          return 'Service Unavailable';
        case 504:
          return 'Gateway Timeout';
        default:
          return 'Unexpected Error: ${dioException.response!.statusCode}';
      }
    } else {
      return 'No response from server';
    }
  }
}
