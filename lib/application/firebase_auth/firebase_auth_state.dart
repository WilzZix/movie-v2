part of 'firebase_auth_bloc.dart';

@immutable
sealed class FirebaseAuthState {}

final class FirebaseAuthInitial extends FirebaseAuthState {}

class UserLoggedInWithEmailAndPassword extends FirebaseAuthState {
  final UserCredential userCredential;

  UserLoggedInWithEmailAndPassword({required this.userCredential});
}

class UserRegisteredWithEmailAndPassword extends FirebaseAuthState {
  final UserCredential userCredential;

  UserRegisteredWithEmailAndPassword({required this.userCredential});
}

class UserLoginError extends FirebaseAuthState {
  final FirebaseAuthException exception;

  UserLoginError({required this.exception});
}

class Authenticated extends FirebaseAuthState {
  final User user;

  Authenticated(this.user);
}

class Unauthenticated extends FirebaseAuthState {}
