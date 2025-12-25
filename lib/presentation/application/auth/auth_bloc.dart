import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/data/datasources/local_data_source/shared_preference_service.dart';
import 'package:movie/data/models/request_token_model.dart';
import 'package:movie/data/models/result_entity.dart';
import 'package:movie/data/models/session_id_model.dart';
import 'package:movie/data/models/user_model.dart';
import 'package:movie/domain/repositories/i_movie_auth.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.repository) : super(AuthInitial()) {
    on<CheckUserLogInStatus>(_checkUserLoginStatus);
    on<GetRequestTokenEvent>(_getRequestToken);
    on<GetSessionIdEvent>(_getSessionIdEvent);
    on<GetAccountIdEvent>(_getAccountId);
    on<LogoutEvent>(_logout);
  }

  final MovieDBAuth repository;
  SharedPreferenceService sharedPreferenceService = SharedPreferenceService();

  Future<void> _checkUserLoginStatus(CheckUserLogInStatus event, Emitter<AuthState> emit) async {
    emit(UserLoginStatus(SharedPreferenceService.getUserAuthStatus() ?? false));
  }

  Future<void> _getRequestToken(GetRequestTokenEvent event, Emitter<AuthState> emit) async {
    emit(RequestTokenInProgress());
    const apiKey = '26f62c7bb1573534f581d047e25069e8';
    final result = await repository.getRequestToken(clientId: apiKey);
    switch (result) {
      case SuccessEntity<RequestTokenModel>():
        sharedPreferenceService.setUserRequestToken(result.data.requestToken!);
        add(GetSessionIdEvent(result.data, apiKey));

      case FailureEntity<Exception>():
        emit(RequestTokenGettingError(result.toString()));
    }
  }

  Future<void> _getSessionIdEvent(GetSessionIdEvent event, Emitter<AuthState> emit) async {
    final result =
        await repository.getSessionId(requestToken: event.requestTokenModel.requestToken!, clientId: event.clientId);
    switch (result) {
      case SuccessEntity<SessionIdModel>():
        sharedPreferenceService.setSessionId(result.data.sessionId!);
        add(
          GetAccountIdEvent(
            event.clientId,
            result.data.sessionId!,
          ),
        );
      case FailureEntity<Exception>():
        emit(GetSessionIdError(result.toString()));
    }
  }

  Future<void> _getAccountId(GetAccountIdEvent event, Emitter<AuthState> emit) async {
    final result = await repository.getAccount(sessionId: event.sessionId, clientId: event.clientId);
    switch (result) {
      case SuccessEntity<AccountModel>():
        sharedPreferenceService.setUserAuthStatus(true);
        sharedPreferenceService.setAccountId(result.data.id!);
        emit(AccountIdTook(result.data.id!.toString()));

      case FailureEntity<Exception>():
        emit(GetAccountIdError(result.toString()));
    }
  }

  Future<void> _logout(LogoutEvent event, Emitter<AuthState> emit) async {
    await sharedPreferenceService.setUserAuthStatus(false);
    SharedPreferenceService.clear();
    emit(UserLoginStatus(false));
  }
}
