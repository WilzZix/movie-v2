part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

///Sign in with TMDB
class SingInProgressState extends AuthState {}

class SingInSuccessState extends AuthState {
  final String apiKay;

  SingInSuccessState(this.apiKay);
}

class SignInFailureState extends AuthState {
  final String msg;

  SignInFailureState(this.msg);
}

///
class UserLoginStatus extends AuthState {
  final bool loggedIn;

  UserLoginStatus(this.loggedIn);
}

///Request token
class RequestTokenTookState extends AuthState {
  final String requestToken;

  RequestTokenTookState(this.requestToken);
}

class RequestTokenInProgress extends AuthState {}

class RequestTokenGettingError extends AuthState {
  final String msg;

  RequestTokenGettingError(this.msg);
}

///Session id
class SessionIdTook extends AuthState {
  final String sessionId;

  SessionIdTook(this.sessionId);
}

class GetSessionIdError extends AuthState {
  final String msg;

  GetSessionIdError(this.msg);
}

///AccountId
class AccountIdTook extends AuthState {
  final String accountId;

  AccountIdTook(this.accountId);
}

class GetAccountIdError extends AuthState {
  final String msg;

  GetAccountIdError(this.msg);
}
