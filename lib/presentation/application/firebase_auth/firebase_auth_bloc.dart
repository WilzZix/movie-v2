import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:movie/domain/repositories/i_firebase_auth.dart';

part 'firebase_auth_event.dart';

part 'firebase_auth_state.dart';

class FirebaseAuthBloc extends Bloc<FirebaseAuthEvent, FirebaseAuthState> {
  FirebaseAuthBloc(this.repository) : super(FirebaseAuthInitial()) {
    late final StreamSubscription<User?> _authStateSubscription;
    _authStateSubscription = repository.authStateChanges.listen(
      (user) => add(AuthStateChanged(user)),
    );
    on<LoginWithEmailAndPassword>((event, emit) async {
      try {
        UserCredential userCredential =
            await repository.userLoginWithEmailAndPassword(
                email: event.email, password: event.password);
        emit(UserLoggedInWithEmailAndPassword(userCredential: userCredential));
      } on FirebaseAuthException catch (e) {
        emit(UserLoginError(exception: e));
      }
    });
    on<RegisterWithEmailAndPassword>((event, emit) async {
      try {
        UserCredential userCredential =
            await repository.userRegisterWithEmailAndPassword(
                email: event.email, password: event.password);
        emit(
            UserRegisteredWithEmailAndPassword(userCredential: userCredential));
      } on FirebaseAuthException catch (e) {
        emit(UserLoginError(exception: e));
      }
    });
    on<AuthStateChanged>((event, emit) {
      if (event.user != null) {
        emit(Authenticated(event.user!));
      } else {
        emit(Unauthenticated());
      }
    });
    on<SignOutRequested>((event, emit) {
      repository.signOutRequest();
      emit(Unauthenticated());
    });
  }

  final IFirebaseAuth repository;
}
