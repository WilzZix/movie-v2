import 'package:dio/dio.dart';

import 'package:injectable/injectable.dart';
import 'package:movie/data/models/base_response.dart';
import 'package:retrofit/retrofit.dart';

import '../models/request_token_model.dart';
import '../models/session_id_model.dart';
import '../models/user_model.dart';

part 'movie_api.g.dart';

@RestApi()
@singleton
abstract class MovieApi {
  @factoryMethod
  factory MovieApi(Dio dio) = _MovieApi;

  @GET('/account')
  Future<BaseResponse<AccountModel>> getAccount({required String sessionId, required String clientId});

  @GET('/authentication/token/new')
  Future<BaseResponse<RequestTokenModel>> getRequestToken({required String clientId});

  @GET('/authentication/session/new')
  Future<BaseResponse<SessionIdModel>> getSessionId({required String requestToken, required String clientId});
}
