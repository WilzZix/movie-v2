import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/core/network_provider.dart';
import 'package:movie/data/api/api.dart';
import 'package:movie/data/datasources/network_data_source/base_repository.dart';
import 'package:movie/data/models/request_token_model.dart';
import 'package:movie/data/models/session_id_model.dart';
import 'package:movie/data/models/user_model.dart';
import 'package:movie/domain/repositories/i_movie_auth.dart';

import '../../models/result_entity.dart';

@Singleton(as: MovieDBAuth)
class FirebaseAuthRepository extends BaseRepository implements MovieDBAuth {
  final MovieApi _movieApi;

  FirebaseAuthRepository(this._movieApi);

  @override
  Future<ResultEntity<AccountModel>> getAccount({required String sessionId, required String clientId}) {
    return safeCall(() => _movieApi.getAccount(sessionId: sessionId, clientId: clientId));
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
  Future<SessionIdModel> getSessionId({required String requestToken, required String clientId}) async {
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
