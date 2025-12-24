import 'package:dio/dio.dart';

import 'package:injectable/injectable.dart';
import 'package:movie/data/models/base_response.dart';
import 'package:retrofit/retrofit.dart';

import '../models/user_model.dart';

part 'api.g.dart';

@RestApi()
@singleton
abstract class MovieApi {
  @factoryMethod
  factory MovieApi(Dio dio) = _MovieApi;

  @GET('/account')
  Future<BaseResponse<AccountModel>> getAccount({required String sessionId, required String clientId});
}
