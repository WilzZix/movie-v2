import 'dart:developer';

import 'package:dio/dio.dart';

import '../../models/base_response.dart';
import '../../models/result_entity.dart';

abstract class BaseRepository {
  const BaseRepository();

  Future<ResultEntity<T>> safeCall<T>(
    Future<BaseResponse<T>> Function() apiCall,
  ) async {
    try {
      final result = await apiCall();
      return SuccessEntity(
        data: result.data,
      );
    } on DioException catch (e) {
      log('Base repo error ${e.toString()}');
      return FailureEntity(exception: e);
    }
  }
}
