part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignInWithTMDB extends AuthEvent {}

class CheckUserLogInStatus extends AuthEvent {}

class GetRequestTokenEvent extends AuthEvent {}

class RedirectToTMDBEvent extends AuthEvent {}

class GetSessionIdEvent extends AuthEvent {
  final RequestTokenModel requestTokenModel;
  final String clientId;

  GetSessionIdEvent(this.requestTokenModel, this.clientId);
}

class GetAccountIdEvent extends AuthEvent {
  final String clientId;
  final String sessionId;

  GetAccountIdEvent(this.clientId, this.sessionId);
}

///Logout
class LogoutEvent extends AuthEvent {}
