import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

abstract class IFirebaseAuth {
  FutureOr<UserCredential> userRegisterWithEmailAndPassword(
      {required String email, required String password});

  FutureOr<UserCredential> userLoginWithEmailAndPassword(
      {required String email, required String password});

  FutureOr<void> signOutRequest();

  Stream<User?> get authStateChanges;
}
