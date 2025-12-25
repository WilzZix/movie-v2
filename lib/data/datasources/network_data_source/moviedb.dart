import 'package:injectable/injectable.dart';

import 'package:movie/data/datasources/network_data_source/base_repository.dart';
import 'package:movie/data/models/request_token_model.dart';
import 'package:movie/data/models/session_id_model.dart';
import 'package:movie/data/models/user_model.dart';
import 'package:movie/domain/repositories/i_movie_auth.dart';

import '../../models/result_entity.dart';
import '../../movie_api/movie_api.dart';

@Singleton(as: MovieDBAuth)
class FirebaseAuthRepository extends BaseRepository implements MovieDBAuth {
  final MovieApi _movieApi;

  FirebaseAuthRepository(this._movieApi);

  @override
  Future<ResultEntity<AccountModel>> getAccount({required String sessionId, required String clientId}) {
    return safeCall(() => _movieApi.getAccount(sessionId: sessionId, clientId: clientId));
  }

  @override
  Future<ResultEntity<RequestTokenModel>> getRequestToken({required String clientId}) async {
    return safeCall(() => _movieApi.getRequestToken(clientId: clientId));
  }

  @override
  Future<ResultEntity<SessionIdModel>> getSessionId({required String requestToken, required String clientId}) async {
    return safeCall(() => _movieApi.getSessionId(requestToken: requestToken, clientId: clientId));
  }
}
