import 'package:dio/dio.dart';
import 'package:movie/core/network_provider.dart';
import 'package:movie/data/models/request_token_model.dart';
import 'package:movie/data/models/session_id_model.dart';
import 'package:movie/data/models/user_model.dart';
import 'package:movie/domain/repositories/i_movie_auth.dart';

class FirebaseAuthRepository implements MovieDBAuth {
  @override
  Future<AccountModel> getAccount(
      {required String sessionId, required String clientId}) async {
    final Response response = await NetworkProvider.dio.get(
      '${IRoutes.baseUrl}/account',
      queryParameters: {
        'session_id': sessionId,
        'api_key': clientId,
      },
    );
    return AccountModel.fromJson(response.data);
  }

  @override
  Future<RequestTokenModel> getRequestToken({required String clientId}) async {
    final Response response = await NetworkProvider.dio.get(
      '${IRoutes.baseUrl}/authentication/token/new',
      queryParameters: {
        'api_key': clientId,
      },
    );
    return RequestTokenModel.fromJson(response.data);
  }

  @override
  Future<SessionIdModel> getSessionId(
      {required String requestToken, required String clientId}) async {
    final Response response = await NetworkProvider.dio.post(
      '${IRoutes.baseUrl}/authentication/session/new',
      queryParameters: {
        'request_token': requestToken,
        'api_key': clientId,
      },
    );
    return SessionIdModel.fromJson(response.data);
  }
}
