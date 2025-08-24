import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/data/datasources/local_data_source/shared_preference_service.dart';
import 'package:movie/data/models/request_token_model.dart';
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

  Future<void> _checkUserLoginStatus(
      CheckUserLogInStatus event, Emitter<AuthState> emit) async {
    emit(UserLoginStatus(SharedPreferenceService.getUserAuthStatus() ?? false));
  }

  Future<void> _getRequestToken(
      GetRequestTokenEvent event, Emitter<AuthState> emit) async {
    try {
      emit(RequestTokenInProgress());
      const apiKey = '26f62c7bb1573534f581d047e25069e8';
      RequestTokenModel requestTokenModel =
          await repository.getRequestToken(clientId: apiKey);
      try {
        // await FlutterWebAuth.authenticate(
        //   url:
        //       'https://www.themoviedb.org/authenticate/${requestTokenModel.requestToken}?redirect_to=$redirectUri',
        //   callbackUrlScheme: 'your.app',
        // );
      } catch (e) {
        log(e.toString());
      }
      sharedPreferenceService
          .setUserRequestToken(requestTokenModel.requestToken!);
      add(GetSessionIdEvent(requestTokenModel, apiKey));
    } catch (e) {
      emit(RequestTokenGettingError(e.toString()));
    }
  }

  Future<void> _getSessionIdEvent(
      GetSessionIdEvent event, Emitter<AuthState> emit) async {
    try {
      SessionIdModel sessionIdModel = await repository.getSessionId(
          requestToken: event.requestTokenModel.requestToken!,
          clientId: event.clientId);
      sharedPreferenceService.setSessionId(sessionIdModel.sessionId!);
      add(
        GetAccountIdEvent(
          event.clientId,
          sessionIdModel.sessionId!,
        ),
      );
    } catch (e) {
      emit(GetSessionIdError(e.toString()));
    }
  }

  Future<void> _getAccountId(
      GetAccountIdEvent event, Emitter<AuthState> emit) async {
    try {
      AccountModel accountModel = await repository.getAccount(
          sessionId: event.sessionId, clientId: event.clientId);
      sharedPreferenceService.setUserAuthStatus(true);
      sharedPreferenceService.setAccountId(accountModel.id!);
      emit(AccountIdTook(accountModel.id!.toString()));
    } catch (e) {
      emit(GetAccountIdError(e.toString()));
    }
  }

  Future<void> _logout(LogoutEvent event, Emitter<AuthState> emit) async {
    await sharedPreferenceService.setUserAuthStatus(false);
    SharedPreferenceService.clear();
    emit(UserLoginStatus(false));
  }
}
