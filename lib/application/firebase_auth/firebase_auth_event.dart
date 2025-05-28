part of 'firebase_auth_bloc.dart';

@immutable
sealed class FirebaseAuthEvent {}

class LoginWithEmailAndPassword extends FirebaseAuthEvent {
  final String email;
  final String password;

  LoginWithEmailAndPassword({required this.email, required this.password});
}

class RegisterWithEmailAndPassword extends FirebaseAuthEvent {
  final String email;
  final String password;

  RegisterWithEmailAndPassword({required this.email, required this.password});
}

class AuthStateChanged extends FirebaseAuthEvent {
  final User? user;

  AuthStateChanged(this.user);
}

class SignOutRequested extends FirebaseAuthEvent {}
