import 'package:movie/data/models/request_token_model.dart';
import 'package:movie/data/models/result_entity.dart';
import 'package:movie/data/models/session_id_model.dart';
import 'package:movie/data/models/user_model.dart';

abstract class MovieDBAuth {
  Future<RequestTokenModel> getRequestToken({required String clientId});

  Future<SessionIdModel> getSessionId({required String requestToken, required String clientId});

  Future<ResultEntity<AccountModel>> getAccount({required String sessionId, required String clientId});
}
